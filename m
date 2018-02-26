Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbeBZWEa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 17:04:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57620 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751898AbeBZWCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 17:02:22 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 05/12] rcutorture: Record which grace-period primitives are tested
Date: Mon, 26 Feb 2018 14:02:34 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226220225.GA32136@linux.vnet.ibm.com>
References: <20180226220225.GA32136@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022622-0024-0000-0000-0000032CF582
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995533; UDB=6.00506035; IPR=6.00774861;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 22:02:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022622-0025-0000-0000-00004728406D
Message-Id: <1519682561-510-5-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260276
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcu_torture_writer() function adapts to requested testing from module
parameters as well as the function pointers in the structure referenced
by cur_ops.  However, as long as the module parameters do not conflict
with the function pointers, this adaptation is silent.  This silence can
result in confusion as to exactly what was tested, which could in turn
result in untested RCU code making its way into mainline.

This commit therefore makes rcu_torture_writer() announce exactly which
portions of RCU's API it ends up testing.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcutorture.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 2964b9236ddc..680c96d8c00f 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -917,22 +917,30 @@ rcu_torture_writer(void *arg)
 	/* Initialize synctype[] array.  If none set, take default. */
 	if (!gp_cond1 && !gp_exp1 && !gp_normal1 && !gp_sync1)
 		gp_cond1 = gp_exp1 = gp_normal1 = gp_sync1 = true;
-	if (gp_cond1 && cur_ops->get_state && cur_ops->cond_sync)
+	if (gp_cond1 && cur_ops->get_state && cur_ops->cond_sync) {
 		synctype[nsynctypes++] = RTWS_COND_GET;
-	else if (gp_cond && (!cur_ops->get_state || !cur_ops->cond_sync))
+		pr_info("%s: Testing conditional GPs.\n", __func__);
+	} else if (gp_cond && (!cur_ops->get_state || !cur_ops->cond_sync)) {
 		pr_alert("%s: gp_cond without primitives.\n", __func__);
-	if (gp_exp1 && cur_ops->exp_sync)
+	}
+	if (gp_exp1 && cur_ops->exp_sync) {
 		synctype[nsynctypes++] = RTWS_EXP_SYNC;
-	else if (gp_exp && !cur_ops->exp_sync)
+		pr_info("%s: Testing expedited GPs.\n", __func__);
+	} else if (gp_exp && !cur_ops->exp_sync) {
 		pr_alert("%s: gp_exp without primitives.\n", __func__);
-	if (gp_normal1 && cur_ops->deferred_free)
+	}
+	if (gp_normal1 && cur_ops->deferred_free) {
 		synctype[nsynctypes++] = RTWS_DEF_FREE;
-	else if (gp_normal && !cur_ops->deferred_free)
+		pr_info("%s: Testing asynchronous GPs.\n", __func__);
+	} else if (gp_normal && !cur_ops->deferred_free) {
 		pr_alert("%s: gp_normal without primitives.\n", __func__);
-	if (gp_sync1 && cur_ops->sync)
+	}
+	if (gp_sync1 && cur_ops->sync) {
 		synctype[nsynctypes++] = RTWS_SYNC;
-	else if (gp_sync && !cur_ops->sync)
+		pr_info("%s: Testing normal GPs.\n", __func__);
+	} else if (gp_sync && !cur_ops->sync) {
 		pr_alert("%s: gp_sync without primitives.\n", __func__);
+	}
 	if (WARN_ONCE(nsynctypes == 0,
 		      "rcu_torture_writer: No update-side primitives.\n")) {
 		/*
-- 
2.5.2
