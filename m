Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753351AbeDPQW3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:22:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53062 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752776AbeDPQVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:21:51 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tools/memory-model 2/5] tools/memory-model: Add litmus test for multicopy atomicity
Date: Mon, 16 Apr 2018 09:22:48 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180416162228.GA18167@linux.vnet.ibm.com>
References: <20180416162228.GA18167@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041616-0056-0000-0000-0000043EB554
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008863; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01018805; UDB=6.00519705; IPR=6.00798046;
 MB=3.00020599; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-16 16:21:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041616-0057-0000-0000-00000882B8C0
Message-Id: <1523895771-19224-2-git-send-email-paulmck@linux.vnet.ibm.com>
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

This commit adds a litmus test suggested by Alan Stern that is forbidden
on multicopy atomic systems, but allowed on non-multicopy atomic systems.
Note that other-multicopy atomic systems are examples of non-multicopy
atomic systems.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 .../litmus-tests/SB+poonceoncescoh.litmus          | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 tools/memory-model/litmus-tests/SB+poonceoncescoh.litmus

diff --git a/tools/memory-model/litmus-tests/SB+poonceoncescoh.litmus b/tools/memory-model/litmus-tests/SB+poonceoncescoh.litmus
new file mode 100644
index 000000000000..991a2d6dec63
--- /dev/null
+++ b/tools/memory-model/litmus-tests/SB+poonceoncescoh.litmus
@@ -0,0 +1,31 @@
+C SB+poonceoncescoh
+
+(*
+ * Result: Sometimes
+ *
+ * This litmus test demonstrates that LKMM is not multicopy atomic.
+ *)
+
+{}
+
+P0(int *x, int *y)
+{
+	int r1;
+	int r2;
+
+	WRITE_ONCE(*x, 1);
+	r1 = READ_ONCE(*x);
+	r2 = READ_ONCE(*y);
+}
+
+P1(int *x, int *y)
+{
+	int r3;
+	int r4;
+
+	WRITE_ONCE(*y, 1);
+	r3 = READ_ONCE(*y);
+	r4 = READ_ONCE(*x);
+}
+
+exists (0:r2=0 /\ 1:r4=0 /\ 0:r1=1 /\ 1:r3=1)
-- 
2.5.2
