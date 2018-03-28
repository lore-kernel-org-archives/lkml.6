Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753107AbeC1Nlu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:41:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47348 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752974AbeC1Nlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:41:47 -0400
Date: Wed, 28 Mar 2018 06:42:32 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: schwidefsky@de.ibm.com, borntraeger@de.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Subject: [PATCH RFC tools/memory-model] Add s390.{cfg,cat}
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18032813-0036-0000-0000-000002D8149A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008758; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01009642; UDB=6.00514347; IPR=6.00788924;
 MB=3.00020289; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-28 13:41:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032813-0037-0000-0000-000043CA7393
Message-Id: <20180328134232.GA29274@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-28_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803280147
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The prototype patch shown below provides files required to allow herd7 to
evaluate C-language litmus tests for the multicopy-atomic TSO ordering
provided by s390.  This patch should be viewed with great suspicion.
It does what I expect it to do on SB (with and without barriers),
IRIW without barriers, and Alan's SB with read-of-write added, but my
expectations are quite likely faulty, and my test cases are very few
in number.

Either way, this is the easy part.  The hard part (which I am happy
to leave to others) is making litmus7 and klitmus7 able to do tests
on actual hardware, as well as enabling herd to handle litmus tests
containing BAL.  ;-)

Note that CPU architectures already supported by herd might well need
only a .cfg file that refers to herd's pre-existing support.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit 2fff0ff161b71215e7f7292b9eff4bc77ba64f29
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Wed Mar 28 06:30:39 2018 -0700

    tools/memory-model: Add .cfg and .cat files for s390
    
    This commit adds s390.cat and s390.cfg files to allow users to check
    litmus tests for s390-specific code.  Note that this change only enables
    herd7 checking of C-language litmus tests.  Larger changes are required
    to enable the litmus7 and klitmus7 tools to check litmus tests on real
    hardare.
    
    Suggested-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
    Suggested-by: Christian Borntraeger <borntraeger@de.ibm.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/tools/memory-model/s390.cat b/tools/memory-model/s390.cat
new file mode 100644
index 000000000000..618e88f50d9a
--- /dev/null
+++ b/tools/memory-model/s390.cat
@@ -0,0 +1,12 @@
+s390
+
+include "fences.cat"
+include "cos.cat"
+
+(* Atomic *)
+empty rmw & (fre;coe) as atom
+
+(* TSO with multicopy atomicity *)
+acyclic (po \ (W * R)) | po-loc | fr | rf | co as sc
+
+(* Fences are somehow handled implicitly, at least for SB+mb... *)
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
