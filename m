Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C7EC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E857220833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E857220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbeILVse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:48:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38368 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726854AbeILVse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:48:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 771FA40241C5;
        Wed, 12 Sep 2018 16:33:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7173F2026D76;
        Wed, 12 Sep 2018 16:33:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 12 Sep 2018 18:33:37 +0200 (CEST)
Date:   Wed, 12 Sep 2018 18:33:35 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] introduce for_each_process_thread_break() and
 for_each_process_thread_continue()
Message-ID: <20180912163335.GA18748@redhat.com>
References: <20180912163312.GA18739@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912163312.GA18739@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 12 Sep 2018 16:33:37 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 12 Sep 2018 16:33:37 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usage:

	rcu_read_lock();
	for_each_process_thread(p, t) {
		do_something_slow(p, t);

		if (SPENT_TOO_MUCH_TIME) {
			for_each_process_thread_break(p, t);
			rcu_read_unlock();
			schedule();
			rcu_read_lock();
			for_each_process_thread_continue(&p, &t);
		}
	}
	rcu_read_unlock();

This looks similar to rcu_lock_break(), but much better and the next patch
changes check_hung_uninterruptible_tasks() to use these new helpers. But my
real target is show_state_filter() which can trivially lead to lockup.

Compared to rcu_lock_break(), for_each_process_thread_continue() never gives
up, it relies on fact that both process and thread lists are sorted by the
task->start_time key. So, for example, even if both leader/thread are already
dead we can find the next alive process and continue.

Strictly speaking, the for_each_process/for_each_thread loops in _continue()
could be "SPEND_TOO_MUCH_TIME" by themselves, so perhaps we will add another
"max_scan" argument later or do something else. But at least they can not
livelock under heavy fork/exit loads, they are bounded by PID_MAX_DEFAULT in
the worst case.

NOTE: it seems that, contrary to the comment, task_struct->start_time is not
really monotonic, and this should be probably fixed. Until then  _continue()
might skip more threads with the same ->start_time than necessary.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/sched/signal.h | 10 ++++++++++
 kernel/exit.c                | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 1be3572..1c957d4 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -565,6 +565,16 @@ extern bool current_is_single_threaded(void);
 #define for_each_process_thread(p, t)	\
 	for_each_process(p) for_each_thread(p, t)
 
+static inline void
+for_each_process_thread_break(struct task_struct *p, struct task_struct *t)
+{
+	get_task_struct(p);
+	get_task_struct(t);
+}
+
+extern void
+for_each_process_thread_continue(struct task_struct **, struct task_struct **);
+
 typedef int (*proc_visitor)(struct task_struct *p, void *data);
 void walk_process_tree(struct task_struct *top, proc_visitor, void *);
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 0e21e6d..71380c7 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -319,6 +319,48 @@ void rcuwait_wake_up(struct rcuwait *w)
 	rcu_read_unlock();
 }
 
+void for_each_process_thread_continue(struct task_struct **p_leader,
+				      struct task_struct **p_thread)
+{
+	struct task_struct *leader = *p_leader, *thread = *p_thread;
+	struct task_struct *prev, *next;
+	u64 start_time;
+
+	if (pid_alive(thread)) {
+		/* mt exec could change the leader */
+		*p_leader = thread->group_leader;
+	} else if (pid_alive(leader)) {
+		start_time = thread->start_time;
+		prev = leader;
+
+		for_each_thread(leader, next) {
+			if (next->start_time > start_time)
+				break;
+			prev = next;
+		}
+
+		*p_thread = prev;
+	} else {
+		start_time = leader->start_time;
+		prev = &init_task;
+
+		for_each_process(next) {
+			if (next->start_time > start_time)
+				break;
+			prev = next;
+		}
+
+		*p_leader = prev;
+		/* a new thread can come after that, but this is fine */
+		*p_thread = list_last_entry(&prev->signal->thread_head,
+						struct task_struct,
+						thread_node);
+	}
+
+	put_task_struct(leader);
+	put_task_struct(thread);
+}
+
 /*
  * Determine if a process group is "orphaned", according to the POSIX
  * definition in 2.2.2.52.  Orphaned process groups are not to be affected
-- 
2.5.0


