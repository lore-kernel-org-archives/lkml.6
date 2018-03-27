Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeC0NLV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:11:21 -0400
Received: from foss.arm.com ([217.140.101.70]:54806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752060AbeC0NLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:11:18 -0400
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: okaya@codeaurora.org, Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] docs/memory-barriers.txt: Fix broken DMA vs MMIO ordering example
Date: Tue, 27 Mar 2018 14:11:27 +0100
Message-Id: <1522156287-15169-1-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 Documentation/memory-barriers.txt | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index a863009849a3..3247547d1c36 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1909,9 +1909,6 @@ There are some more advanced barrier functions:
 		/* assign ownership */
 		desc->status = DEVICE_OWN;
 
-		/* force memory to sync before notifying device via MMIO */
-		wmb();
-
 		/* notify device of new descriptors */
 		writel(DESC_NOTIFY, doorbell);
 	}
@@ -1919,11 +1916,15 @@ There are some more advanced barrier functions:
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
2.1.4
