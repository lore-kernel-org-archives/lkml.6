Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbeBZWC2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 17:02:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34198 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751587AbeBZWCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 17:02:20 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 04/12] rcutorture: Re-enable testing of dynamic expediting
Date: Mon, 26 Feb 2018 14:02:33 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226220225.GA32136@linux.vnet.ibm.com>
References: <20180226220225.GA32136@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022622-0036-0000-0000-000002C6D8B2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995533; UDB=6.00506035; IPR=6.00774861;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 22:02:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022622-0037-0000-0000-000043784654
Message-Id: <1519682561-510-4-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260276
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During boot, normal grace periods are processed as expedited.  When
rcutorture is built into the kernel, it starts during boot and thus
detects that normal grace periods are unconditionally expedited.
Therefore, rcutorture concludes that there is no point in trying
to dynamically enable expediting, do it disables this aspect of testing,
which is a bit of an overreaction to the temporary boot-time expediting.

This commit therefore rechecks forced expediting throughout the test,
enabling dynamic expediting if normal grace periods are processed
normally at any point.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcutorture.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 6c46cd1d8fd7..2964b9236ddc 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -909,14 +909,10 @@ rcu_torture_writer(void *arg)
 	int nsynctypes = 0;
 
 	VERBOSE_TOROUT_STRING("rcu_torture_writer task started");
-	if (!can_expedite) {
+	if (!can_expedite)
 		pr_alert("%s" TORTURE_FLAG
-			 " GP expediting controlled from boot/sysfs for %s,\n",
+			 " GP expediting controlled from boot/sysfs for %s.\n",
 			 torture_type, cur_ops->name);
-		pr_alert("%s" TORTURE_FLAG
-			 " Disabled dynamic grace-period expediting.\n",
-			 torture_type);
-	}
 
 	/* Initialize synctype[] array.  If none set, take default. */
 	if (!gp_cond1 && !gp_exp1 && !gp_normal1 && !gp_sync1)
@@ -1011,6 +1007,9 @@ rcu_torture_writer(void *arg)
 				rcu_unexpedite_gp();
 			if (++expediting > 3)
 				expediting = -expediting;
+		} else if (!can_expedite) { /* Disabled during boot, recheck. */
+			can_expedite = !rcu_gp_is_expedited() &&
+				       !rcu_gp_is_normal();
 		}
 		rcu_torture_writer_state = RTWS_STUTTER;
 		stutter_wait("rcu_torture_writer");
@@ -1021,6 +1020,10 @@ rcu_torture_writer(void *arg)
 	while (can_expedite && expediting++ < 0)
 		rcu_unexpedite_gp();
 	WARN_ON_ONCE(can_expedite && rcu_gp_is_expedited());
+	if (!can_expedite)
+		pr_alert("%s" TORTURE_FLAG
+			 " Dynamic grace-period expediting was disabled.\n",
+			 torture_type);
 	rcu_torture_writer_state = RTWS_STOPPING;
 	torture_kthread_stopping("rcu_torture_writer");
 	return 0;
-- 
2.5.2
