Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754222AbeDWDEs (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:04:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753966AbeDWDCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 23:02:40 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        torvalds@linux-foundation.org, npiggin@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 18/21] rcu: The rcu_gp_cleanup() function does not need cpu_needs_another_gp()
Date: Sun, 22 Apr 2018 20:03:41 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423030258.GA23370@linux.vnet.ibm.com>
References: <20180423030258.GA23370@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042303-0044-0000-0000-0000040974B6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021898; UDB=6.00521542; IPR=6.00801133;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 03:02:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042303-0045-0000-0000-0000083B7DB3
Message-Id: <1524452624-27589-18-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230032
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the cpu_needs_another_gp() function's checks (except for
newly arrived callbacks) have been subsumed into the rcu_gp_cleanup()
function's scan of the rcu_node tree.  This commit therefore drops the
call to cpu_needs_another_gp().  The check for newly arrived callbacks
is supplied by rcu_accelerate_cbs().  Any needed advancing (as in the
earlier rcu_advance_cbs() call) will be supplied when the corresponding
CPU becomes aware of the end of the now-completed grace period.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 07bccb1f0c87..7776d709e060 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2150,11 +2150,9 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 		needgp = true;
 	}
 	/* Advance CBs to reduce false positives below. */
-	needgp = rcu_advance_cbs(rsp, rnp, rdp) || needgp;
-	if (needgp || cpu_needs_another_gp(rsp, rdp)) {
+	if (!rcu_accelerate_cbs(rsp, rnp, rdp) && needgp) {
 		WRITE_ONCE(rsp->gp_flags, RCU_GP_FLAG_INIT);
-		trace_rcu_grace_period(rsp->name,
-				       READ_ONCE(rsp->gpnum),
+		trace_rcu_grace_period(rsp->name, READ_ONCE(rsp->gpnum),
 				       TPS("newreq"));
 	}
 	WRITE_ONCE(rsp->gp_flags, rsp->gp_flags & RCU_GP_FLAG_INIT);
-- 
2.5.2
