Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753450AbeDPQQi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:16:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751135AbeDPQLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:11:46 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH tools/memory-model 03/17] docs/memory-barriers.txt: Fix broken DMA vs MMIO ordering example
Date: Mon, 16 Apr 2018 09:12:31 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180416161209.GA6895@linux.vnet.ibm.com>
References: <20180416161209.GA6895@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041616-0040-0000-0000-0000041BB4AB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008863; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01018801; UDB=6.00519703; IPR=6.00798043;
 MB=3.00020599; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-16 16:11:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041616-0041-0000-0000-00000821B83A
Message-Id: <1523895165-17576-3-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-16_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804160146
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

The section of memory-barriers.txt that describes the dma_Xmb() barriers
has an incorrect example claiming that a wmb() is required after writing
to coherent memory in order for those writes to be visible to a device
before a subsequent MMIO access using writel() can reach the device.

In fact, this ordering guarantee is provided (at significant cost on some
architectures such as arm and power) by writel, so the wmb() is not
necessary. writel_relaxed exists for cases where this ordering is not
required.

Fix the example and update the text to make this clearer.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Reported-by: Sinan Kaya <okaya@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 Documentation/memory-barriers.txt | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 6dafc8085acc..34c1970908a5 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1920,9 +1920,6 @@ There are some more advanced barrier functions:
 		/* assign ownership */
 		desc->status = DEVICE_OWN;
 
-		/* force memory to sync before notifying device via MMIO */
-		wmb();
-
 		/* notify device of new descriptors */
 		writel(DESC_NOTIFY, doorbell);
 	}
@@ -1930,11 +1927,15 @@ There are some more advanced barrier functions:
      The dma_rmb() allows us guarantee the device has released ownership
      before we read the data from the descriptor, and the dma_wmb() allows
      us to guarantee the data is written to the descriptor before the device
-     can see it now has ownership.  The wmb() is needed to guarantee that the
-     cache coherent memory writes have completed before attempting a write to
-     the cache incoherent MMIO region.
-
-     See Documentation/DMA-API.txt for more information on consistent memory.
+     can see it now has ownership.  Note that, when using writel(), a prior
+     wmb() is not needed to guarantee that the cache coherent memory writes
+     have completed before writing to the MMIO region.  The cheaper
+     writel_relaxed() does not provide this guarantee and must not be used
+     here.
+
+     See the subsection "Kernel I/O barrier effects" for more information on
+     relaxed I/O accessors and the Documentation/DMA-API.txt file for more
+     information on consistent memory.
 
 
 MMIO WRITE BARRIER
-- 
2.5.2
