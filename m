Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752441AbeEOGWb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:22:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40021 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752305AbeEOGW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:22:29 -0400
Date: Mon, 14 May 2018 23:21:46 -0700
From: tip-bot for Will Deacon <tipbot@zytor.com>
Message-ID: <tip-5846581e35637771952602eecc1e20ece5ced011@git.kernel.org>
Cc: hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, corbet@lwn.net, arnd@arndb.de,
        okaya@codeaurora.org, benh@kernel.crashing.org, peterz@infradead.org,
        paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org,
        jgg@ziepe.ca, will.deacon@arm.com, tglx@linutronix.de
Reply-To: akpm@linux-foundation.org, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, corbet@lwn.net,
        peterz@infradead.org, benh@kernel.crashing.org, okaya@codeaurora.org,
        paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org,
        will.deacon@arm.com, tglx@linutronix.de, jgg@ziepe.ca
In-Reply-To: <1526338533-6044-1-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1526338533-6044-1-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/memory-barriers.txt: Fix broken DMA vs.
 MMIO ordering example
Git-Commit-ID: 5846581e35637771952602eecc1e20ece5ced011
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5846581e35637771952602eecc1e20ece5ced011
Gitweb:     https://git.kernel.org/tip/5846581e35637771952602eecc1e20ece5ced011
Author:     Will Deacon <will.deacon@arm.com>
AuthorDate: Mon, 14 May 2018 15:55:26 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 15 May 2018 08:11:13 +0200

locking/memory-barriers.txt: Fix broken DMA vs. MMIO ordering example

The section of memory-barriers.txt that describes the dma_Xmb() barriers
has an incorrect example claiming that a wmb() is required after writing
to coherent memory in order for those writes to be visible to a device
before a subsequent MMIO access using writel() can reach the device.

In fact, this ordering guarantee is provided (at significant cost on some
architectures such as arm and power) by writel, so the wmb() is not
necessary. writel_relaxed exists for cases where this ordering is not
required.

Fix the example and update the text to make this clearer.

Reported-by: Sinan Kaya <okaya@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Cc: stern@rowland.harvard.edu
Link: http://lkml.kernel.org/r/1526338533-6044-1-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
