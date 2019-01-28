Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC187C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7A52147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbfA1QAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:00:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730744AbfA1QAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:00:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D501BC059B9E;
        Mon, 28 Jan 2019 16:00:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.163])
        by smtp.corp.redhat.com (Postfix) with SMTP id 42D876247D;
        Mon, 28 Jan 2019 16:00:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 28 Jan 2019 17:00:15 +0100 (CET)
Date:   Mon, 28 Jan 2019 17:00:13 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>
Cc:     Herton Krzesinski <hkrzesin@redhat.com>,
        Jan Stancek <jstancek@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cgroup/pids: turn cgroup_subsys->free() into
 cgroup_subsys->release() to fix the accounting
Message-ID: <20190128160013.GA21219@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 28 Jan 2019 16:00:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only user of cgroup_subsys->free() callback is pids_cgrp_subsys which
needs pids_free() to uncharge the pid.

However, ->free() is called from __put_task_struct()->cgroup_free() and this
is too late. Even the trivial program which does

	for (;;) {
		int pid = fork();
		assert(pid >= 0);
		if (pid)
			wait(NULL);
		else
			exit(0);
	}

can run out of limits because release_task()->call_rcu(delayed_put_task_struct)
implies an RCU gp after the task/pid goes away and before the final put().

Test-case:

	mkdir -p /tmp/CG
	mount -t cgroup2 none /tmp/CG
	echo '+pids' > /tmp/CG/cgroup.subtree_control

	mkdir /tmp/CG/PID
	echo 2 > /tmp/CG/PID/pids.max

	perl -e 'while ($p = fork) { wait; } $p // die "fork failed: $!\n"' &
	echo $! > /tmp/CG/PID/cgroup.procs

Without this patch the forking process fails soon after migration.

Rename cgroup_subsys->free() to cgroup_subsys->release() and move the callsite
into the new helper, cgroup_release(), called by release_task() which actually
frees the pid(s).

Reported-by: Herton R. Krzesinski <hkrzesin@redhat.com>
Reported-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/cgroup-defs.h |  2 +-
 include/linux/cgroup.h      |  2 ++
 kernel/cgroup/cgroup.c      | 15 +++++++++------
 kernel/cgroup/pids.c        |  4 ++--
 kernel/exit.c               |  1 +
 5 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 8fcbae1..120d1d4 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -602,7 +602,7 @@ struct cgroup_subsys {
 	void (*cancel_fork)(struct task_struct *task);
 	void (*fork)(struct task_struct *task);
 	void (*exit)(struct task_struct *task);
-	void (*free)(struct task_struct *task);
+	void (*release)(struct task_struct *task);
 	void (*bind)(struct cgroup_subsys_state *root_css);
 
 	bool early_init:1;
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 9968332..81f58b4 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -121,6 +121,7 @@ extern int cgroup_can_fork(struct task_struct *p);
 extern void cgroup_cancel_fork(struct task_struct *p);
 extern void cgroup_post_fork(struct task_struct *p);
 void cgroup_exit(struct task_struct *p);
+void cgroup_release(struct task_struct *p);
 void cgroup_free(struct task_struct *p);
 
 int cgroup_init_early(void);
@@ -697,6 +698,7 @@ static inline int cgroup_can_fork(struct task_struct *p) { return 0; }
 static inline void cgroup_cancel_fork(struct task_struct *p) {}
 static inline void cgroup_post_fork(struct task_struct *p) {}
 static inline void cgroup_exit(struct task_struct *p) {}
+static inline void cgroup_release(struct task_struct *p) {}
 static inline void cgroup_free(struct task_struct *p) {}
 
 static inline int cgroup_init_early(void) { return 0; }
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index f31bd61..f441837 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -197,7 +197,7 @@ static u64 css_serial_nr_next = 1;
  */
 static u16 have_fork_callback __read_mostly;
 static u16 have_exit_callback __read_mostly;
-static u16 have_free_callback __read_mostly;
+static u16 have_release_callback __read_mostly;
 static u16 have_canfork_callback __read_mostly;
 
 /* cgroup namespace for init task */
@@ -5313,7 +5313,7 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 
 	have_fork_callback |= (bool)ss->fork << ss->id;
 	have_exit_callback |= (bool)ss->exit << ss->id;
-	have_free_callback |= (bool)ss->free << ss->id;
+	have_release_callback |= (bool)ss->release << ss->id;
 	have_canfork_callback |= (bool)ss->can_fork << ss->id;
 
 	/* At system boot, before all subsystems have been
@@ -5749,16 +5749,19 @@ void cgroup_exit(struct task_struct *tsk)
 	} while_each_subsys_mask();
 }
 
-void cgroup_free(struct task_struct *task)
+void cgroup_release(struct task_struct *task)
 {
-	struct css_set *cset = task_css_set(task);
 	struct cgroup_subsys *ss;
 	int ssid;
 
-	do_each_subsys_mask(ss, ssid, have_free_callback) {
-		ss->free(task);
+	do_each_subsys_mask(ss, ssid, have_release_callback) {
+		ss->release(task);
 	} while_each_subsys_mask();
+}
 
+void cgroup_free(struct task_struct *task)
+{
+	struct css_set *cset = task_css_set(task);
 	put_css_set(cset);
 }
 
diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index 9829c67..c9960baa 100644
--- a/kernel/cgroup/pids.c
+++ b/kernel/cgroup/pids.c
@@ -247,7 +247,7 @@ static void pids_cancel_fork(struct task_struct *task)
 	pids_uncharge(pids, 1);
 }
 
-static void pids_free(struct task_struct *task)
+static void pids_release(struct task_struct *task)
 {
 	struct pids_cgroup *pids = css_pids(task_css(task, pids_cgrp_id));
 
@@ -342,7 +342,7 @@ struct cgroup_subsys pids_cgrp_subsys = {
 	.cancel_attach 	= pids_cancel_attach,
 	.can_fork	= pids_can_fork,
 	.cancel_fork	= pids_cancel_fork,
-	.free		= pids_free,
+	.release	= pids_release,
 	.legacy_cftypes	= pids_files,
 	.dfl_cftypes	= pids_files,
 	.threaded	= true,
diff --git a/kernel/exit.c b/kernel/exit.c
index 3fb7be0..c2b8443 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -219,6 +219,7 @@ void release_task(struct task_struct *p)
 	}
 
 	write_unlock_irq(&tasklist_lock);
+	cgroup_release(p);
 	release_thread(p);
 	call_rcu(&p->rcu, delayed_put_task_struct);
 
-- 
2.5.0


