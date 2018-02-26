Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752188AbeBZV4j (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:56:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41320 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750877AbeBZV4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:56:13 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        Ildar Ismagilov <devix84@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 3/5] srcu: Reduce scans of srcu_data in counter wrap check
Date: Mon, 26 Feb 2018 13:56:30 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226215614.GA31616@linux.vnet.ibm.com>
References: <20180226215614.GA31616@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022621-0044-0000-0000-000003EA6168
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995531; UDB=6.00506033; IPR=6.00774859;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 21:56:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022621-0045-0000-0000-0000081A6B39
Message-Id: <1519682192-31987-3-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260275
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ildar Ismagilov <devix84@gmail.com>

Currently, given a multi-level srcu_node tree, SRCU can scan the full
set of srcu_data structures at each level when cleaning up after a grace
period.  This, though harmless otherwise, represents pointless overhead.
This commit therefore eliminates this overhead by scanning the srcu_data
structures only when traversing the leaf srcu_node structures.

Signed-off-by: Ildar Ismagilov <devix84@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/srcutree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index bb9607baad9b..d582a2352cdb 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -527,6 +527,7 @@ static void srcu_gp_end(struct srcu_struct *sp)
 {
 	unsigned long cbdelay;
 	bool cbs;
+	bool last_lvl;
 	int cpu;
 	unsigned long flags;
 	unsigned long gpseq;
@@ -559,7 +560,8 @@ static void srcu_gp_end(struct srcu_struct *sp)
 	rcu_for_each_node_breadth_first(sp, snp) {
 		spin_lock_irq_rcu_node(snp);
 		cbs = false;
-		if (snp >= sp->level[rcu_num_lvls - 1])
+		last_lvl = snp >= sp->level[rcu_num_lvls - 1];
+		if (last_lvl)
 			cbs = snp->srcu_have_cbs[idx] == gpseq;
 		snp->srcu_have_cbs[idx] = gpseq;
 		rcu_seq_set_state(&snp->srcu_have_cbs[idx], 1);
@@ -572,7 +574,7 @@ static void srcu_gp_end(struct srcu_struct *sp)
 			srcu_schedule_cbs_snp(sp, snp, mask, cbdelay);
 
 		/* Occasionally prevent srcu_data counter wrap. */
-		if (!(gpseq & counter_wrap_check))
+		if (!(gpseq & counter_wrap_check) && last_lvl)
 			for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
 				sdp = per_cpu_ptr(sp->sda, cpu);
 				spin_lock_irqsave_rcu_node(sdp, flags);
-- 
2.5.2
