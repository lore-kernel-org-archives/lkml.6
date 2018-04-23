Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754260AbeDWCdk (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 22:33:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753946AbeDWCbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 22:31:23 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 04/22] rcu: Call wake_nocb_leader_defer() with 'FORCE' when nocb_q_count is high
Date: Sun, 22 Apr 2018 19:32:09 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423023150.GA21533@linux.vnet.ibm.com>
References: <20180423023150.GA21533@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042302-0008-0000-0000-000002FC9183
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021888; UDB=6.00521536; IPR=6.00801123;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 02:31:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042302-0009-0000-0000-000038FF59C8
Message-Id: <1524450747-22778-4-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230025
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Byungchul Park <byungchul.park@lge.com>

If an excessive number of callbacks have been queued, but the NOCB
leader kthread's wakeup must be deferred, then we should wake up the
leader unconditionally once it is safe to do so.

This was handled correctly in commit fbce7497ee ("rcu: Parallelize and
economize NOCB kthread wakeups"), but then commit 8be6e1b15c ("rcu:
Use timer as backstop for NOCB deferred wakeups") passed RCU_NOCB_WAKE
instead of the correct RCU_NOCB_WAKE_FORCE to wake_nocb_leader_defer().
As an interesting aside, RCU_NOCB_WAKE_FORCE is never passed to anything,
which should have been taken as a hint.  ;-)

This commit therefore passes RCU_NOCB_WAKE_FORCE instead of RCU_NOCB_WAKE
to wake_nocb_leader_defer() when a callback is queued onto a NOCB CPU
that already has an excessive number of callbacks pending.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3566e4f6dfcc..12774c4fb546 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1957,7 +1957,7 @@ static void __call_rcu_nocb_enqueue(struct rcu_data *rdp,
 			trace_rcu_nocb_wake(rdp->rsp->name, rdp->cpu,
 					    TPS("WakeOvf"));
 		} else {
-			wake_nocb_leader_defer(rdp, RCU_NOCB_WAKE,
+			wake_nocb_leader_defer(rdp, RCU_NOCB_WAKE_FORCE,
 					       TPS("WakeOvfIsDeferred"));
 		}
 		rdp->qlen_last_fqs_check = LONG_MAX / 2;
-- 
2.5.2
