Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbeAaTmc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 14:42:32 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37476 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751435AbeAaTma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 14:42:30 -0500
X-Google-Smtp-Source: AH8x226btCBo4jq7z4zj0Pfl9wLn4ym2XmO9dZotqLe2CbVbKSRpdtUx9BGjcH3f3gvsKwfYLr5RSw==
From: Ildar Ismagilov <devix84@gmail.com>
Cc: devix84@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] srcu: reduce scans of srcu_data in counter wrap check
Date: Wed, 31 Jan 2018 22:42:21 +0300
Message-Id: <20180131194221.28544-1-devix84@gmail.com>
X-Mailer: git-send-email 2.11.0
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reduce scans of srcu_data in case of a srcu_struct
tree have more than one levels

Signed-off-by: Ildar Ismagilov <devix84@gmail.com>
---
 kernel/rcu/srcutree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index c54617280245..2268381706d2 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -500,6 +500,7 @@ static void srcu_gp_end(struct srcu_struct *sp)
 {
 	unsigned long cbdelay;
 	bool cbs;
+	bool last_lvl;
 	int cpu;
 	unsigned long flags;
 	unsigned long gpseq;
@@ -532,7 +533,8 @@ static void srcu_gp_end(struct srcu_struct *sp)
 	rcu_for_each_node_breadth_first(sp, snp) {
 		raw_spin_lock_irq_rcu_node(snp);
 		cbs = false;
-		if (snp >= sp->level[rcu_num_lvls - 1])
+		last_lvl = snp >= sp->level[rcu_num_lvls - 1];
+		if (last_lvl)
 			cbs = snp->srcu_have_cbs[idx] == gpseq;
 		snp->srcu_have_cbs[idx] = gpseq;
 		rcu_seq_set_state(&snp->srcu_have_cbs[idx], 1);
@@ -545,7 +547,7 @@ static void srcu_gp_end(struct srcu_struct *sp)
 			srcu_schedule_cbs_snp(sp, snp, mask, cbdelay);
 
 		/* Occasionally prevent srcu_data counter wrap. */
-		if (!(gpseq & counter_wrap_check))
+		if (!(gpseq & counter_wrap_check) && last_lvl)
 			for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
 				sdp = per_cpu_ptr(sp->sda, cpu);
 				raw_spin_lock_irqsave_rcu_node(sdp, flags);
-- 
2.11.0
