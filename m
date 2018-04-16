Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753305AbeDPQV5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:21:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51870 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752795AbeDPQVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:21:54 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tools/memory-model 5/5] EXP tools/memory-model: Flag "cumulativity" and "propagation" tests
Date: Mon, 16 Apr 2018 09:22:51 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180416162228.GA18167@linux.vnet.ibm.com>
References: <20180416162228.GA18167@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041616-0040-0000-0000-0000041BB585
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008863; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01018804; UDB=6.00519705; IPR=6.00798046;
 MB=3.00020599; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-16 16:21:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041616-0041-0000-0000-00000821B91A
Message-Id: <1523895771-19224-5-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-16_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804160148
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit flags WRC+pooncerelease+rmbonceonce+Once.litmus as being
forbidden by LKMM cumulativity and IRIW+mbonceonces+OnceOnce.litmus as
being forbidden by LKMM propagation.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
[ paulmck: Updated wording as suggested by Alan Stern. ]
---
 tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus | 2 +-
 tools/memory-model/litmus-tests/README                           | 9 ++++++---
 .../litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus       | 4 +++-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus b/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
index 50d5db9ea983..98a3716efa37 100644
--- a/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
+++ b/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
@@ -7,7 +7,7 @@ C IRIW+mbonceonces+OnceOnce
  * between each pairs of reads.  In other words, is smp_mb() sufficient to
  * cause two different reading processes to agree on the order of a pair
  * of writes, where each write is to a different variable by a different
- * process?
+ * process?  This litmus test exercises LKMM's "propagation" rule.
  *)
 
 {}
diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 6919909bbd0f..17eb9a8c222d 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -23,7 +23,8 @@ IRIW+mbonceonces+OnceOnce.litmus
 	between each pairs of reads.  In other words, is smp_mb()
 	sufficient to cause two different reading processes to agree on
 	the order of a pair of writes, where each write is to a different
-	variable by a different process?
+	variable by a different process?  This litmus test is forbidden
+	by LKMM's propagation rule.
 
 IRIW+poonceonces+OnceOnce.litmus
 	Test of independent reads from independent writes with nothing
@@ -119,8 +120,10 @@ S+wmbonceonce+poacquireonce.litmus
 
 WRC+poonceonces+Once.litmus
 WRC+pooncerelease+rmbonceonce+Once.litmus
-	These two are members of an extension of the MP litmus-test class
-	in which the first write is moved to a separate process.
+	These two are members of an extension of the MP litmus-test
+	class in which the first write is moved to a separate process.
+	The second is forbidden because smp_store_release() is
+	A-cumulative in LKMM.
 
 Z6.0+pooncelock+pooncelock+pombonce.litmus
 	Is the ordering provided by a spin_unlock() and a subsequent
diff --git a/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus b/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
index 97fcbffde9a0..ad3448b941e6 100644
--- a/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
@@ -5,7 +5,9 @@ C WRC+pooncerelease+rmbonceonce+Once
  *
  * This litmus test is an extension of the message-passing pattern, where
  * the first write is moved to a separate process.  Because it features
- * a release and a read memory barrier, it should be forbidden.
+ * a release and a read memory barrier, it should be forbidden.  More
+ * specifically, this litmus test is forbidden because smp_store_release()
+ * is A-cumulative in LKMM.
  *)
 
 {}
-- 
2.5.2
