Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbeETI3U (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 04:29:20 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38001 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751683AbeETI3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 04:29:16 -0400
X-Google-Smtp-Source: AB8JxZoJ6NsnKHCYCW1f3L+ty/mGVuF5RxH5DOFNVUxuSXRjeOyNBchDIRgcn+9ahttg+GtueUJf5Q==
From: Joel Fernandes <joelaf@google.com>
X-Google-Original-From: Joel Fernandes <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>, byungchul.park@lge.com,
        kernel-team@android.com, Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] rcu: Speed up calling of RCU tasks callbacks
Date: Sun, 20 May 2018 01:28:55 -0700
Message-Id: <20180520082856.70676-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

RCU tasks callbacks can take atleast 1 second before the callbacks are
executed. This happens even if the hold-out tasks enter their quiescent states
quickly. I noticed this when I was testing trampoline callback execution.

To test the trampoline freeing, I wrote a simple script:
cd /sys/kernel/debug/tracing/
echo '*:traceon' > set_ftrace_filter;
echo '!*:traceon' > set_ftrace_filter;

With this patch:
real    0m0.256s
user    0m0.000s
sys     0m0.226s

Without this patch:
real    0m1.313s
user    0m0.000s
sys     0m0.222s

That's a great than 5X speed up in performance. In order to accomplish
this, I am waiting very briefly for around 2 scheduler ticks worth of
time before entering the hold-out checking loop. The loop still
preserves its checking of held tasks every 1 second as before, incase
this first test doesn't succeed.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zilstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: byungchul.park@lge.com
Cc: kernel-team@android.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/update.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 5783bdf86e5a..d221db4ab3f4 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -743,6 +743,12 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 		 */
 		synchronize_srcu(&tasks_rcu_exit_srcu);
 
+		/*
+		 * Wait a little bit incase held tasks are released
+		 * during their next timer ticks.
+		 */
+		schedule_timeout_interruptible(2);
+
 		/*
 		 * Each pass through the following loop scans the list
 		 * of holdout tasks, removing any that are no longer
@@ -755,7 +761,6 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 			int rtst;
 			struct task_struct *t1;
 
-			schedule_timeout_interruptible(HZ);
 			rtst = READ_ONCE(rcu_task_stall_timeout);
 			needreport = rtst > 0 &&
 				     time_after(jiffies, lastreport + rtst);
@@ -768,6 +773,11 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 				check_holdout_task(t, needreport, &firstreport);
 				cond_resched();
 			}
+
+			if (list_empty(&rcu_tasks_holdouts))
+				break;
+
+			schedule_timeout_interruptible(HZ);
 		}
 
 		/*
-- 
2.17.0.441.gb46fe60e1d-goog
