Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbeBTX0p (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 18:26:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44972 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751925AbeBTXZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 18:25:04 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tools/lkmm 10/12] tools/memory-model: Add a S lock-based external-view litmus test
Date: Tue, 20 Feb 2018 15:25:10 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180220232405.GA19274@linux.vnet.ibm.com>
References: <20180220232405.GA19274@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022023-0044-0000-0000-000003E72FDE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008566; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00992685; UDB=6.00504342; IPR=6.00772031;
 MB=3.00019661; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-20 23:25:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022023-0045-0000-0000-00000817350B
Message-Id: <1519169112-20593-10-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802200276
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

This commit adds a litmus test in which P0() and P1() form a lock-based S
litmus test, with the addition of P2(), which observes P0()'s and P1()'s
accesses with a full memory barrier but without the lock.  This litmus
test asks whether writes carried out by two different processes under the
same lock will be seen in order by a third process not holding that lock.
The answer to this question is "yes" for all architectures supporting
the Linux kernel, but is "no" according to the current version of LKMM.

A patch to LKMM is under development.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 .../ISA2+pooncelock+pooncelock+pombonce.litmus     | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus

diff --git a/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
new file mode 100644
index 000000000000..7a39a0aaa976
--- /dev/null
+++ b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
@@ -0,0 +1,41 @@
+C ISA2+pooncelock+pooncelock+pombonce.litmus
+
+(*
+ * Result: Sometimes
+ *
+ * This test shows that the ordering provided by a lock-protected S
+ * litmus test (P0() and P1()) are not visible to external process P2().
+ * This is likely to change soon.
+ *)
+
+{}
+
+P0(int *x, int *y, spinlock_t *mylock)
+{
+	spin_lock(mylock);
+	WRITE_ONCE(*x, 1);
+	WRITE_ONCE(*y, 1);
+	spin_unlock(mylock);
+}
+
+P1(int *y, int *z, spinlock_t *mylock)
+{
+	int r0;
+
+	spin_lock(mylock);
+	r0 = READ_ONCE(*y);
+	WRITE_ONCE(*z, 1);
+	spin_unlock(mylock);
+}
+
+P2(int *x, int *z)
+{
+	int r1;
+	int r2;
+
+	r2 = READ_ONCE(*z);
+	smp_mb();
+	r1 = READ_ONCE(*x);
+}
+
+exists (1:r0=1 /\ 2:r2=1 /\ 2:r1=0)
-- 
2.5.2
