Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbeCWVM3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 17:12:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42371 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751504AbeCWVM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 17:12:28 -0400
Date: Fri, 23 Mar 2018 22:12:24 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Subject: rcu: Add might_sleep() check to synchronize_rcu()
Message-ID: <alpine.DEB.2.21.1803232210110.1481@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: rcu: Add might_sleep() check to synchronize_rcu()
From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 23 Mar 2018 22:02:18 +0100

Joel reported a debugobjects warning which is triggered by a RCU callback
invoking synchronize_rcu(). RCU callbacks run in softirq context, so
calling synchronize_rcu() is a bad idea as it might sleep.

debugobjects triggers because __wait_rcu_gp() uses on stack objects and
invokes debug_object_init_on_stack(). That function checks the object
address against current's task stack, which fails because the code runs on
the softirq stack.

synchronize_rcu() lacks a might_sleep() check which would have caught that
issue way earlier because it would trigger with the minimal debug options
enabled.

Add a might_sleep() check to catch such cases.

Reported-by: Joel Fernandes <joelaf@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
 kernel/rcu/tree_plugin.h |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -753,6 +753,7 @@ void synchronize_rcu(void)
 			 "Illegal synchronize_rcu() in RCU read-side critical section");
 	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
 		return;
+	might_sleep();
 	if (rcu_gp_is_expedited())
 		synchronize_rcu_expedited();
 	else
