Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422866AbeE1LCy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:02:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422848AbeE1LCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:02:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 4.14 472/496] rcu: Call touch_nmi_watchdog() while printing stall warnings
Date: Mon, 28 May 2018 12:04:17 +0200
Message-Id: <20180528100339.800219768@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 3caa973b7a260e7a2a69edc94c300ab9c65148c3 ]

When RCU stall warning triggers, it can print out a lot of messages
while holding spinlocks.  If the console device is slow (e.g. an
actual or IPMI serial console), it may end up triggering NMI hard
lockup watchdog like the following.

---
 kernel/rcu/tree_plugin.h |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -559,8 +559,14 @@ static void rcu_print_detail_task_stall_
 	}
 	t = list_entry(rnp->gp_tasks->prev,
 		       struct task_struct, rcu_node_entry);
-	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry)
+	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
+		/*
+		 * We could be printing a lot while holding a spinlock.
+		 * Avoid triggering hard lockup.
+		 */
+		touch_nmi_watchdog();
 		sched_show_task(t);
+	}
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
 
@@ -1677,6 +1683,12 @@ static void print_cpu_stall_info(struct
 	char *ticks_title;
 	unsigned long ticks_value;
 
+	/*
+	 * We could be printing a lot while holding a spinlock.  Avoid
+	 * triggering hard lockup.
+	 */
+	touch_nmi_watchdog();
+
 	if (rsp->gpnum == rdp->gpnum) {
 		ticks_title = "ticks this GP";
 		ticks_value = rdp->ticks_this_gp;
