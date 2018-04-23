Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754277AbeDWDGB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:06:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753956AbeDWDCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 23:02:39 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        torvalds@linux-foundation.org, npiggin@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 07/21] rcu: Make rcu_future_needs_gp() check all ->need_future_gps[] elements
Date: Sun, 22 Apr 2018 20:03:30 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423030258.GA23370@linux.vnet.ibm.com>
References: <20180423030258.GA23370@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042303-0056-0000-0000-0000044377E0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021898; UDB=6.00521542; IPR=6.00801133;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 03:02:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042303-0057-0000-0000-000008878114
Message-Id: <1524452624-27589-7-git-send-email-paulmck@linux.vnet.ibm.com>
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

Currently, the rcu_future_needs_gp() function checks only the current
element of the ->need_future_gps[] array, which might miss elements that
were offset from the expected element, for example, due to races with
the start or the end of a grace period.  This commit therefore makes
rcu_future_needs_gp() use the need_any_future_gp() macro to check all
of the elements of this array.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 2 +-
 kernel/rcu/tree.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index afc5e32f0da4..b05ab6379562 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -720,7 +720,7 @@ static int rcu_future_needs_gp(struct rcu_state *rsp)
 	struct rcu_node *rnp = rcu_get_root(rsp);
 
 	lockdep_assert_irqs_disabled();
-	return READ_ONCE(need_future_gp_element(rnp, rnp->completed));
+	return need_any_future_gp(rnp);
 }
 
 /*
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 952cd0c223fe..123c30eac8b5 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -169,7 +169,8 @@ struct rcu_node {
 	bool __nonzero = false;						\
 									\
 	for (__i = 0; __i < ARRAY_SIZE((rnp)->need_future_gp); __i++)	\
-		__nonzero = __nonzero || (rnp)->need_future_gp[__i];	\
+		__nonzero = __nonzero ||				\
+			    READ_ONCE((rnp)->need_future_gp[__i]);	\
 	__nonzero;							\
 })
 
-- 
2.5.2
