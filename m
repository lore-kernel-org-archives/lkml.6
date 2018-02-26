Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752074AbeBZWCb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 17:02:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751454AbeBZWCU (ORCPT
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
Subject: [PATCH tip/core/rcu 01/12] rcutorture: Replace multi-instance kzalloc() with kcalloc()
Date: Mon, 26 Feb 2018 14:02:30 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226220225.GA32136@linux.vnet.ibm.com>
References: <20180226220225.GA32136@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022622-0048-0000-0000-0000023FB489
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995533; UDB=6.00506035; IPR=6.00774861;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 22:02:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022622-0049-0000-0000-000044433AC2
Message-Id: <1519682561-510-1-git-send-email-paulmck@linux.vnet.ibm.com>
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

This commit replaces array-allocation calls to kzalloc() with
equivalent calls to kcalloc().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcutorture.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 308e6fdbced8..b4a201dcbc55 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1557,11 +1557,10 @@ static int rcu_torture_barrier_init(void)
 	atomic_set(&barrier_cbs_count, 0);
 	atomic_set(&barrier_cbs_invoked, 0);
 	barrier_cbs_tasks =
-		kzalloc(n_barrier_cbs * sizeof(barrier_cbs_tasks[0]),
+		kcalloc(n_barrier_cbs, sizeof(barrier_cbs_tasks[0]),
 			GFP_KERNEL);
 	barrier_cbs_wq =
-		kzalloc(n_barrier_cbs * sizeof(barrier_cbs_wq[0]),
-			GFP_KERNEL);
+		kcalloc(n_barrier_cbs, sizeof(barrier_cbs_wq[0]), GFP_KERNEL);
 	if (barrier_cbs_tasks == NULL || !barrier_cbs_wq)
 		return -ENOMEM;
 	for (i = 0; i < n_barrier_cbs; i++) {
@@ -1799,7 +1798,7 @@ rcu_torture_init(void)
 	if (firsterr)
 		goto unwind;
 	if (nfakewriters > 0) {
-		fakewriter_tasks = kzalloc(nfakewriters *
+		fakewriter_tasks = kcalloc(nfakewriters,
 					   sizeof(fakewriter_tasks[0]),
 					   GFP_KERNEL);
 		if (fakewriter_tasks == NULL) {
@@ -1814,7 +1813,7 @@ rcu_torture_init(void)
 		if (firsterr)
 			goto unwind;
 	}
-	reader_tasks = kzalloc(nrealreaders * sizeof(reader_tasks[0]),
+	reader_tasks = kcalloc(nrealreaders, sizeof(reader_tasks[0]),
 			       GFP_KERNEL);
 	if (reader_tasks == NULL) {
 		VERBOSE_TOROUT_ERRSTRING("out of memory");
-- 
2.5.2
