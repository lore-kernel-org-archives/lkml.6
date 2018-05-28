Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939284AbeE1NzB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:55:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162759AbeE1Kl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:41:27 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neil@brown.name>,
        Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.14 001/496] MIPS: c-r4k: Fix data corruption related to cache coherence
Date: Mon, 28 May 2018 11:56:26 +0200
Message-Id: <20180528100319.570433678@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neil@brown.name>

commit 55a2aa08b3af519a9693f99cdf7fa6d8b62d9f65 upstream.

When DMA will be performed to a MIPS32 1004K CPS, the L1-cache for the
range needs to be flushed and invalidated first.
The code currently takes one of two approaches.
1/ If the range is less than the size of the dcache, then HIT type
   requests flush/invalidate cache lines for the particular addresses.
   HIT-type requests a globalised by the CPS so this is safe on SMP.

2/ If the range is larger than the size of dcache, then INDEX type
   requests flush/invalidate the whole cache. INDEX type requests affect
   the local cache only. CPS does not propagate them in any way. So this
   invalidation is not safe on SMP CPS systems.

Data corruption due to '2' can quite easily be demonstrated by
repeatedly "echo 3 > /proc/sys/vm/drop_caches" and then sha1sum a file
that is several times the size of available memory. Dropping caches
means that large contiguous extents (large than dcache) are more likely.

This was not a problem before Linux-4.8 because option 2 was never used
if CONFIG_MIPS_CPS was defined. The commit which removed that apparently
didn't appreciate the full consequence of the change.

We could, in theory, globalize the INDEX based flush by sending an IPI
to other cores. These cache invalidation routines can be called with
interrupts disabled and synchronous IPI require interrupts to be
enabled. Asynchronous IPI may not trigger writeback soon enough. So we
cannot use IPI in practice.

We can already test if IPI would be needed for an INDEX operation with
r4k_op_needs_ipi(R4K_INDEX). If this is true then we mustn't try the
INDEX approach as we cannot use IPI. If this is false (e.g. when there
is only one core and hence one L1 cache) then it is safe to use the
INDEX approach without IPI.

This patch avoids options 2 if r4k_op_needs_ipi(R4K_INDEX), and so
eliminates the corruption.

Fixes: c00ab4896ed5 ("MIPS: Remove cpu_has_safe_index_cacheops")
Signed-off-by: NeilBrown <neil@brown.name>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.8+
Patchwork: https://patchwork.linux-mips.org/patch/19259/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/mm/c-r4k.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -851,9 +851,12 @@ static void r4k_dma_cache_wback_inv(unsi
 	/*
 	 * Either no secondary cache or the available caches don't have the
 	 * subset property so we have to flush the primary caches
-	 * explicitly
+	 * explicitly.
+	 * If we would need IPI to perform an INDEX-type operation, then
+	 * we have to use the HIT-type alternative as IPI cannot be used
+	 * here due to interrupts possibly being disabled.
 	 */
-	if (size >= dcache_size) {
+	if (!r4k_op_needs_ipi(R4K_INDEX) && size >= dcache_size) {
 		r4k_blast_dcache();
 	} else {
 		R4600_HIT_CACHEOP_WAR_IMPL;
@@ -890,7 +893,7 @@ static void r4k_dma_cache_inv(unsigned l
 		return;
 	}
 
-	if (size >= dcache_size) {
+	if (!r4k_op_needs_ipi(R4K_INDEX) && size >= dcache_size) {
 		r4k_blast_dcache();
 	} else {
 		R4600_HIT_CACHEOP_WAR_IMPL;
