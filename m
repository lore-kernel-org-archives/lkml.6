Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935943AbeEXW6W (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 18:58:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935647AbeEXW6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 18:58:19 -0400
Date: Thu, 24 May 2018 18:58:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] rcu: Add comment to the last sleep in the rcu tasks loop
Message-ID: <20180524185816.66eb08d9@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Steven Rostedt (VMware) <rostedt@goodmis.org>

At the end of rcu_tasks_kthread() there's a lonely
schedule_timeout_uninterruptible() call with no apparent rationale for
its existence. But there is. It is to keep the thread from going into
a tight loop if there's some anomaly. That really needs a comment.

Link: http://lkml.kernel.org/r/20180524223839.GU3803@linux.vnet.ibm.com
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 68fa19a5e7bd..e332ee52805d 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -848,6 +861,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 			list = next;
 			cond_resched();
 		}
+		/* Paranoid sleep to keep this from entering a tight loop */
 		schedule_timeout_uninterruptible(HZ/10);
 	}
 }
