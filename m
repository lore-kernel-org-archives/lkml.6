Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeBZWCX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 17:02:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34348 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751742AbeBZWCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 17:02:21 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 03/12] rcutorture: Avoid fake-writer use of undefined primitives
Date: Mon, 26 Feb 2018 14:02:32 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226220225.GA32136@linux.vnet.ibm.com>
References: <20180226220225.GA32136@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022622-0008-0000-0000-000002DB9DD3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995533; UDB=6.00506035; IPR=6.00774861;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 22:02:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022622-0009-0000-0000-00003864E98C
Message-Id: <1519682561-510-3-git-send-email-paulmck@linux.vnet.ibm.com>
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

Currently the rcu_torture_fakewriter() function invokes cur_ops->sync()
and cur_ops->exp_sync() without first checking to see if they are in
fact non-NULL.  This results in kernel NULL pointer dereferences when
testing RCU implementations that choose not to provide the full set of
primitives.  Given that it is perfectly reasonable to have specialized
RCU implementations that provide only a subset of the RCU API, this is
a bug in rcutorture.

This commit therefore makes rcu_torture_fakewriter() check function
pointers before invoking them, thus allowing it to test subsetted
RCU implementations.

Reported-by: Lihao Liang <lianglihao@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcutorture.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 0f94025c672a..6c46cd1d8fd7 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1045,13 +1045,13 @@ rcu_torture_fakewriter(void *arg)
 		    torture_random(&rand) % (nfakewriters * 8) == 0) {
 			cur_ops->cb_barrier();
 		} else if (gp_normal == gp_exp) {
-			if (torture_random(&rand) & 0x80)
+			if (cur_ops->sync && torture_random(&rand) & 0x80)
 				cur_ops->sync();
-			else
+			else if (cur_ops->exp_sync)
 				cur_ops->exp_sync();
-		} else if (gp_normal) {
+		} else if (gp_normal && cur_ops->sync) {
 			cur_ops->sync();
-		} else {
+		} else if (cur_ops->exp_sync) {
 			cur_ops->exp_sync();
 		}
 		stutter_wait("rcu_torture_fakewriter");
-- 
2.5.2
