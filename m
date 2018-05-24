Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935903AbeEXWtv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 18:49:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935803AbeEXWtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 18:49:49 -0400
Date: Thu, 24 May 2018 18:49:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v4] rcu: Speed up calling of RCU tasks callbacks
Message-ID: <20180524184946.5fa82d19@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Steven Rostedt (VMware) <rostedt@goodmis.org>

Joel Fernandes found that the synchronize_rcu_tasks() was taking a
significant amount of time. He demonstrated it with the following test:

 # cd /sys/kernel/tracing
 # while [ 1 ]; do x=1; done &
 # echo '__schedule_bug:traceon' > set_ftrace_filter
 # time echo '!__schedule_bug:traceon' > set_ftrace_filter;

real	0m1.064s
user	0m0.000s
sys	0m0.004s

Where it takes a little over a second to perform the synchronize,
because there's a loop that waits 1 second at a time for tasks to get
through their quiescent points when there's a task that must be waited
for.

After discussion we came up with a simple way to wait for holdouts but
increase the time for each iteration of the loop but no more than a
full second.

With the new patch we have:

 # time echo '!__schedule_bug:traceon' > set_ftrace_filter;

real	0m0.131s
user	0m0.000s
sys	0m0.004s

Which drops it down to 13% of what the original wait time was.

Link: http://lkml.kernel.org/r/20180523063815.198302-2-joel@joelfernandes.org
Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Suggested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 68fa19a5e7bd..452e47841a86 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -715,6 +715,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 	struct rcu_head *list;
 	struct rcu_head *next;
 	LIST_HEAD(rcu_tasks_holdouts);
+	int fract;
 
 	/* Run on housekeeping CPUs by default.  Sysadm can move if desired. */
 	housekeeping_affine(current, HK_FLAG_RCU);
@@ -796,13 +797,25 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 		 * holdouts.  When the list is empty, we are done.
 		 */
 		lastreport = jiffies;
-		while (!list_empty(&rcu_tasks_holdouts)) {
+
+		/* Start off with HZ/10 wait and slowly back off to 1 HZ wait*/
+		fract = 10;
+
+		for (;;) {
 			bool firstreport;
 			bool needreport;
 			int rtst;
 			struct task_struct *t1;
 
-			schedule_timeout_interruptible(HZ);
+			if (list_empty(&rcu_tasks_holdouts))
+				break;
+
+			/* Slowly back off waiting for holdouts */
+			schedule_timeout_interruptible(HZ/fract);
+
+			if (fract > 1)
+				fract--;
+
 			rtst = READ_ONCE(rcu_task_stall_timeout);
 			needreport = rtst > 0 &&
 				     time_after(jiffies, lastreport + rtst);
