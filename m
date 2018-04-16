Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753271AbeDPQWY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:22:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751194AbeDPQVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:21:53 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tools/memory-model 3/5] EXP tools/memory-model: Add .cfg and .cat files for s390
Date: Mon, 16 Apr 2018 09:22:49 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180416162228.GA18167@linux.vnet.ibm.com>
References: <20180416162228.GA18167@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041616-0052-0000-0000-000002DBDB6E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008863; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01018805; UDB=6.00519705; IPR=6.00798046;
 MB=3.00020599; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-16 16:21:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041616-0053-0000-0000-00005C59E09C
Message-Id: <1523895771-19224-3-git-send-email-paulmck@linux.vnet.ibm.com>
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

This commit adds s390.cat and s390.cfg files to allow users to check
litmus tests for s390-specific code.  Note that this change only enables
herd7 checking of C-language litmus tests.  Larger changes are required
to enable the litmus7 and klitmus7 tools to check litmus tests on real
hardare.

Suggested-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Suggested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
[ paulmck: Add fixes suggested by Alan Stern. ]
---
 tools/memory-model/s390.cat | 18 ++++++++++++++++++
 tools/memory-model/s390.cfg | 21 +++++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 tools/memory-model/s390.cat
 create mode 100644 tools/memory-model/s390.cfg

diff --git a/tools/memory-model/s390.cat b/tools/memory-model/s390.cat
new file mode 100644
index 000000000000..216bf33d3ffe
--- /dev/null
+++ b/tools/memory-model/s390.cat
@@ -0,0 +1,18 @@
+s390
+
+include "fences.cat"
+include "cos.cat"
+
+(* Fundamental coherence ordering *)
+let com = rf | co | fr
+acyclic po-loc | com as coherence
+
+(* Atomic *)
+empty rmw & (fre;coe) as atom
+
+(* Fences *)
+let mb = [M] ; fencerel(Mb) ; [M]
+
+(* TSO with multicopy atomicity (tso-mca) *)
+let po-ghb = ([R] ; po ; [M]) | ([M] ; po ; [W])
+acyclic mb | po-ghb | fr | rf | co as tso-mca
diff --git a/tools/memory-model/s390.cfg b/tools/memory-model/s390.cfg
new file mode 100644
index 000000000000..d77e05d2395c
--- /dev/null
+++ b/tools/memory-model/s390.cfg
@@ -0,0 +1,21 @@
+macros linux-kernel.def
+bell linux-kernel.bell
+model s390.cat
+graph columns
+squished true
+showevents noregs
+movelabel true
+fontsize 8
+xscale 2.0
+yscale 1.5
+arrowsize 0.8
+showinitrf false
+showfinalrf false
+showinitwrites false
+splines spline
+pad 0.1
+edgeattr hb,color,indigo
+edgeattr co,color,blue
+edgeattr mb,color,darkgreen
+edgeattr wmb,color,darkgreen
+edgeattr rmb,color,darkgreen
-- 
2.5.2
