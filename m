Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbeBZVyb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:54:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751851AbeBZVwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:52:53 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 18/20] rcu: Trace expedited GP delays due to transitioning CPUs
Date: Mon, 26 Feb 2018 13:53:08 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226215219.GA27379@linux.vnet.ibm.com>
References: <20180226215219.GA27379@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022621-2213-0000-0000-000002764559
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995530; UDB=6.00506033; IPR=6.00774858;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 21:52:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022621-2214-0000-0000-0000593F37D4
Message-Id: <1519681990-31349-18-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260274
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a CPU is transitioning to or from offline state, an expedited
grace period may undergo a timed wait.  This timed wait can unduly
delay grace periods, so this commit adds a trace statement to make
it visible.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/trace/events/rcu.h | 1 +
 kernel/rcu/tree_exp.h      | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index e56a618f2a59..d8c33298c153 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -181,6 +181,7 @@ TRACE_EVENT(rcu_grace_period_init,
  *	"start": Started a real expedited grace period.
  *	"reset": Started resetting the tree
  *	"select": Started selecting the CPUs to wait on.
+ *	"selectofl": Selected CPU partially offline.
  *	"startwait": Started waiting on selected CPUs.
  *	"end": Ended a real expedited grace period.
  *	"endwake": Woke piggybackers up.
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 70ad12abde36..fecb6b6ab452 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -32,7 +32,7 @@ static void rcu_exp_gp_seq_start(struct rcu_state *rsp)
  * Return then value that expedited-grace-period counter will have
  * at the end of the current grace period.
  */
-static unsigned long rcu_exp_gp_seq_endval(struct rcu_state *rsp)
+static __maybe_unused unsigned long rcu_exp_gp_seq_endval(struct rcu_state *rsp)
 {
 	return rcu_seq_endval(&rsp->expedited_sequence);
 }
@@ -428,6 +428,7 @@ static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
 			    (rnp->expmask & mask)) {
 				/* Online, so delay for a bit and try again. */
 				raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+				trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("selectofl"));
 				schedule_timeout_uninterruptible(1);
 				goto retry_ipi;
 			}
-- 
2.5.2
