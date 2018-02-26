Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbeBZVyi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:54:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751505AbeBZVww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:52:52 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 12/20] rcu: Consolidate rcu.h #ifdefs
Date: Mon, 26 Feb 2018 13:53:02 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226215219.GA27379@linux.vnet.ibm.com>
References: <20180226215219.GA27379@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022621-0048-0000-0000-0000023FB3D9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995530; UDB=6.00506033; IPR=6.00774858;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 21:52:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022621-0049-0000-0000-00004443360C
Message-Id: <1519681990-31349-12-git-send-email-paulmck@linux.vnet.ibm.com>
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

The kernel/rcu/rcu.h file has a pair of consecutive #ifdefs on
CONFIG_TINY_RCU, so this commit consolidates them, thus saving a few
lines of code.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcu.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 6334f2c1abd0..c90812673d54 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -356,24 +356,20 @@ static inline bool rcu_gp_is_normal(void) { return true; }
 static inline bool rcu_gp_is_expedited(void) { return false; }
 static inline void rcu_expedite_gp(void) { }
 static inline void rcu_unexpedite_gp(void) { }
+static inline void rcu_request_urgent_qs_task(struct task_struct *t) { }
 #else /* #ifdef CONFIG_TINY_RCU */
 bool rcu_gp_is_normal(void);     /* Internal RCU use. */
 bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
 void rcu_expedite_gp(void);
 void rcu_unexpedite_gp(void);
 void rcupdate_announce_bootup_oddness(void);
+void rcu_request_urgent_qs_task(struct task_struct *t);
 #endif /* #else #ifdef CONFIG_TINY_RCU */
 
 #define RCU_SCHEDULER_INACTIVE	0
 #define RCU_SCHEDULER_INIT	1
 #define RCU_SCHEDULER_RUNNING	2
 
-#ifdef CONFIG_TINY_RCU
-static inline void rcu_request_urgent_qs_task(struct task_struct *t) { }
-#else /* #ifdef CONFIG_TINY_RCU */
-void rcu_request_urgent_qs_task(struct task_struct *t);
-#endif /* #else #ifdef CONFIG_TINY_RCU */
-
 enum rcutorture_type {
 	RCU_FLAVOR,
 	RCU_BH_FLAVOR,
-- 
2.5.2
