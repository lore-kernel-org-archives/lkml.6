Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2165BC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20B1208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20B1208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933653AbeGITB7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:01:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932834AbeGITB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:01:57 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89C592089D;
        Mon,  9 Jul 2018 19:01:56 +0000 (UTC)
Date:   Mon, 9 Jul 2018 15:01:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     tglx@linutronix.de, Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: cgroup trace events acquire sleeping locks
Message-ID: <20180709150154.66843cba@gandalf.local.home>
In-Reply-To: <20180709163805.ai4ljzaj3i73ypx4@linutronix.de>
References: <20180703140750.1dab75ef@tagon>
        <20180706174745.hwvnwojzfbmp7ma5@linutronix.de>
        <20180708203600.2edf24e2@tagon>
        <20180709163805.ai4ljzaj3i73ypx4@linutronix.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2018 18:38:05 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Clark showed me this:
> 
> | BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:974
> | in_atomic(): 1, irqs_disabled(): 0, pid: 1, name: systemd
> | 5 locks held by systemd/1:
> |  #0:  (sb_writers#7){.+.+}, at: [<        (ptrval)>] mnt_want_write+0x1f/0x50
> |  #1:  (&type->i_mutex_dir_key#3/1){+.+.}, at: [<        (ptrval)>] do_rmdir+0x14d/0x1f0
> |  #2:  (&type->i_mutex_dir_key#5){++++}, at: [<        (ptrval)>] vfs_rmdir+0x50/0x150
> |  #3:  (cgroup_mutex){+.+.}, at: [<        (ptrval)>] cgroup_kn_lock_live+0xfb/0x200
> |  #4:  (kernfs_rename_lock){+.+.}, at: [<        (ptrval)>] kernfs_path_from_node+0x23/0x50
> | Preemption disabled at:
> | [<ffffffff8dc994c5>] migrate_enable+0x95/0x340
> | CPU: 1 PID: 1 Comm: systemd Not tainted 4.16.18-rt9+ #173
> | Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.1-1 04/01/2014
> | Call Trace:
> |  dump_stack+0x70/0xa7
> |  ___might_sleep+0x159/0x240
> |  rt_spin_lock+0x4e/0x60
> |  ? kernfs_path_from_node+0x23/0x50
> |  kernfs_path_from_node+0x23/0x50
> |  trace_event_raw_event_cgroup+0x54/0x110
> |  cgroup_rmdir+0xdb/0x1a0
> |  kernfs_iop_rmdir+0x53/0x80
> |  vfs_rmdir+0x74/0x150
> |  do_rmdir+0x191/0x1f0
> |  SyS_rmdir+0x11/0x20
> |  do_syscall_64+0x73/0x220
> |  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> 
> which is the trace_cgroup_rmdir() trace event in cgroup_rmdir(). The
> trace event invokes cgroup_path() which acquires a spin_lock_t and this
> is invoked within a preempt_disable()ed section. 

Correct. And I wish no trace event took spin locks.

> 
> It says "Preemption disabled at" migrate_enable() but this is not true.
> A printk() just before the lock reports preempt_count() of two and
> sometimes one. I *think*
> - one is from rcu_read_lock_sched_notrace() in __DO_TRACE()
> - the second is from preempt_disable_notrace() in ring_buffer_lock_reserve()
> 
> I would prefer not to turn kernfs_rename_lock into raw_spin_lock_t. We
> had a similar problem with a i915 trace event which eventually vanished
> (and before I just disabled it).
> 
> So how likely are chances that we can use rcu_read_lock() in __DO_TRACE()?

Not very.

> And how likely are chances that the preempt_disable() in
> ring_buffer_lock_reserve() could be avoided while the trace event is
> invoked?

Even less likely. The design of the ring buffer is based on not being
able to be preempted.

> 
> I guess nothing of this is easy peasy. Any suggestions?
> 

One solution, albeit not so pretty, is to move the grabbing of the
path, outside the trace event. But this should work.

-- Steve


diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
index d74722c2ac8b..d149f3a42122 100644
--- a/include/trace/events/cgroup.h
+++ b/include/trace/events/cgroup.h
@@ -53,24 +53,22 @@ DEFINE_EVENT(cgroup_root, cgroup_remount,
 
 DECLARE_EVENT_CLASS(cgroup,
 
-	TP_PROTO(struct cgroup *cgrp),
+	TP_PROTO(struct cgroup *cgrp, const char *path),
 
-	TP_ARGS(cgrp),
+	TP_ARGS(cgrp, path),
 
 	TP_STRUCT__entry(
 		__field(	int,		root			)
 		__field(	int,		id			)
 		__field(	int,		level			)
-		__dynamic_array(char,		path,
-				cgroup_path(cgrp, NULL, 0) + 1)
+		__string(	path,		path			)
 	),
 
 	TP_fast_assign(
 		__entry->root = cgrp->root->hierarchy_id;
 		__entry->id = cgrp->id;
 		__entry->level = cgrp->level;
-		cgroup_path(cgrp, __get_dynamic_array(path),
-				  __get_dynamic_array_len(path));
+		__assign_str(path, path);
 	),
 
 	TP_printk("root=%d id=%d level=%d path=%s",
@@ -79,30 +77,30 @@ DECLARE_EVENT_CLASS(cgroup,
 
 DEFINE_EVENT(cgroup, cgroup_mkdir,
 
-	TP_PROTO(struct cgroup *cgroup),
+	TP_PROTO(struct cgroup *cgrp, const char *path),
 
-	TP_ARGS(cgroup)
+	TP_ARGS(cgrp, path)
 );
 
 DEFINE_EVENT(cgroup, cgroup_rmdir,
 
-	TP_PROTO(struct cgroup *cgroup),
+	TP_PROTO(struct cgroup *cgrp, const char *path),
 
-	TP_ARGS(cgroup)
+	TP_ARGS(cgrp, path)
 );
 
 DEFINE_EVENT(cgroup, cgroup_release,
 
-	TP_PROTO(struct cgroup *cgroup),
+	TP_PROTO(struct cgroup *cgrp, const char *path),
 
-	TP_ARGS(cgroup)
+	TP_ARGS(cgrp, path)
 );
 
 DEFINE_EVENT(cgroup, cgroup_rename,
 
-	TP_PROTO(struct cgroup *cgroup),
+	TP_PROTO(struct cgroup *cgrp, const char *path),
 
-	TP_ARGS(cgroup)
+	TP_ARGS(cgrp, path)
 );
 
 DECLARE_EVENT_CLASS(cgroup_migrate,
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 77ff1cd6a252..d0ad35796ea1 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -8,6 +8,21 @@
 #include <linux/list.h>
 #include <linux/refcount.h>
 
+#define TRACE_CGROUP_PATH_LEN 1024
+extern spinlock_t trace_cgroup_path_lock;
+extern char trace_cgroup_path[TRACE_CGROUP_PATH_LEN];
+
+#define TRACE_CGROUP_PATH(cgrp, type)					\
+	do {								\
+		if (trace_cgroup_##type##_enabled()) {			\
+			spin_lock(&trace_cgroup_path_lock);		\
+			cgroup_path(cgrp, trace_cgroup_path,		\
+				    TRACE_CGROUP_PATH_LEN);		\
+			trace_cgroup_##type(cgrp, trace_cgroup_path);	\
+			spin_unlock(&trace_cgroup_path_lock);		\
+		}							\
+	} while (0)
+
 /*
  * A cgroup can be associated with multiple css_sets as different tasks may
  * belong to different cgroups on different hierarchies.  In the other
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 8b4f0768efd6..4f87670c8e4b 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -865,7 +865,7 @@ static int cgroup1_rename(struct kernfs_node *kn, struct kernfs_node *new_parent
 
 	ret = kernfs_rename(kn, new_parent, new_name_str);
 	if (!ret)
-		trace_cgroup_rename(cgrp);
+		TRACE_CGROUP_PATH(cgrp, rename);
 
 	mutex_unlock(&cgroup_mutex);
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 077370bf8964..a3be1b46693c 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -83,6 +83,9 @@ EXPORT_SYMBOL_GPL(cgroup_mutex);
 EXPORT_SYMBOL_GPL(css_set_lock);
 #endif
 
+DEFINE_SPINLOCK(trace_cgroup_path_lock);
+char trace_cgroup_path[TRACE_CGROUP_PATH_LEN];
+
 /*
  * Protects cgroup_idr and css_idr so that IDs can be released without
  * grabbing cgroup_mutex.
@@ -4634,7 +4637,7 @@ static void css_release_work_fn(struct work_struct *work)
 		struct cgroup *tcgrp;
 
 		/* cgroup release path */
-		trace_cgroup_release(cgrp);
+		TRACE_CGROUP_PATH(cgrp, release);
 
 		if (cgroup_on_dfl(cgrp))
 			cgroup_rstat_flush(cgrp);
@@ -4977,7 +4980,7 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
 	if (ret)
 		goto out_destroy;
 
-	trace_cgroup_mkdir(cgrp);
+	TRACE_CGROUP_PATH(cgrp, mkdir);
 
 	/* let's create and online css's */
 	kernfs_activate(kn);
@@ -5165,9 +5168,8 @@ int cgroup_rmdir(struct kernfs_node *kn)
 		return 0;
 
 	ret = cgroup_destroy_locked(cgrp);
-
 	if (!ret)
-		trace_cgroup_rmdir(cgrp);
+		TRACE_CGROUP_PATH(cgrp, rmdir);
 
 	cgroup_kn_unlock(kn);
 	return ret;

