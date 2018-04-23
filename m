Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754084AbeDWDNQ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:13:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34510 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753982AbeDWDNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 23:13:00 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 3/6] rcutorture: Print end-of-test state
Date: Sun, 22 Apr 2018 20:14:02 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423031346.GA28371@linux.vnet.ibm.com>
References: <20180423031346.GA28371@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042303-0044-0000-0000-000004097538
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021902; UDB=6.00521544; IPR=6.00801137;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 03:12:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042303-0045-0000-0000-0000083B7E3A
Message-Id: <1524453245-29299-3-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230033
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds end-of-test state printout to help check whether RCU
shut down nicely.  Note that this printout only helps for flavors of
RCU that are not used much by the kernel.  In particular, for normal
RCU having a grace period in progress is expected behavior.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcutorture.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 680c96d8c00f..fd86965b33a7 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1609,6 +1609,9 @@ static enum cpuhp_state rcutor_hp;
 static void
 rcu_torture_cleanup(void)
 {
+	int flags = 0;
+	unsigned long gpnum = 0;
+	unsigned long completed = 0;
 	int i;
 
 	rcutorture_record_test_transition();
@@ -1639,6 +1642,11 @@ rcu_torture_cleanup(void)
 		fakewriter_tasks = NULL;
 	}
 
+	rcutorture_get_gp_data(cur_ops->ttype, &flags, &gpnum, &completed);
+	srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp,
+				&flags, &gpnum, &completed);
+	pr_alert("%s:  End-test grace-period state: g%lu c%lu f%#x\n",
+		 cur_ops->name, gpnum, completed, flags);
 	torture_stop_kthread(rcu_torture_stats, stats_task);
 	torture_stop_kthread(rcu_torture_fqs, fqs_task);
 	for (i = 0; i < ncbflooders; i++)
-- 
2.5.2
