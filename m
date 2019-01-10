Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5248CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB56214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfAJPND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:13:03 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:40327 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729555AbfAJPLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:11:45 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43b8bd5mvmz9v115;
        Thu, 10 Jan 2019 16:11:41 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 1UJEwtcL4gGg; Thu, 10 Jan 2019 16:11:41 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43b8bd54jrz9v113;
        Thu, 10 Jan 2019 16:11:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3249F8B89F;
        Thu, 10 Jan 2019 16:11:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id HNLwrVavCuLu; Thu, 10 Jan 2019 16:11:43 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 00C338B898;
        Thu, 10 Jan 2019 16:11:42 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id CFCC06BF21; Thu, 10 Jan 2019 15:11:42 +0000 (UTC)
Message-Id: <01e24dde7671275d9191cbe7f431a961b6dc95f5.1547132681.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1547132681.git.christophe.leroy@c-s.fr>
References: <cover.1547132681.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 02/15] powerpc/mm/32s: rework mmu_mapin_ram()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 10 Jan 2019 15:11:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reworks mmu_mapin_ram() to be more generic and map as much
blocks as possible. It now supports blocks not starting at address 0.

It scans DBATs array to find free ones instead of forcing the use of
BAT2 and BAT3.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/ppc_mmu_32.c | 61 +++++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index b260ced065b4..b8a8d55f51a6 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -73,39 +73,58 @@ unsigned long p_block_mapped(phys_addr_t pa)
 	return 0;
 }
 
+static int find_free_bat(void)
+{
+	int b;
+
+	if (cpu_has_feature(CPU_FTR_601)) {
+		for (b = 0; b < 4; b++) {
+			struct ppc_bat *bat = BATS[b];
+
+			if (!(bat[0].batl & 0x40))
+				return b;
+		}
+	} else {
+		int n = mmu_has_feature(MMU_FTR_USE_HIGH_BATS) ? 8 : 4;
+
+		for (b = 0; b < n; b++) {
+			struct ppc_bat *bat = BATS[b];
+
+			if (!(bat[1].batu & 3))
+				return b;
+		}
+	}
+	return -1;
+}
+
+static unsigned int block_size(unsigned long base, unsigned long top)
+{
+	unsigned int max_size = (cpu_has_feature(CPU_FTR_601) ? 8 : 256) << 20;
+	unsigned int base_shift = (fls(base) - 1) & 31;
+	unsigned int block_shift = (fls(top - base) - 1) & 31;
+
+	return min3(max_size, 1U << base_shift, 1U << block_shift);
+}
+
 unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 {
-	unsigned long tot, bl, done;
-	unsigned long max_size = (256<<20);
+	int idx;
 
 	if (__map_without_bats) {
 		printk(KERN_DEBUG "RAM mapped without BATs\n");
 		return 0;
 	}
 
-	/* Set up BAT2 and if necessary BAT3 to cover RAM. */
+	while ((idx = find_free_bat()) != -1 && base != top) {
+		unsigned int size = block_size(base, top);
 
-	/* Make sure we don't map a block larger than the
-	   smallest alignment of the physical address. */
-	tot = top;
-	for (bl = 128<<10; bl < max_size; bl <<= 1) {
-		if (bl * 2 > tot)
+		if (size < 128 << 10)
 			break;
+		setbat(idx, PAGE_OFFSET + base, base, size, PAGE_KERNEL_X);
+		base += size;
 	}
 
-	setbat(2, PAGE_OFFSET, 0, bl, PAGE_KERNEL_X);
-	done = (unsigned long)bat_addrs[2].limit - PAGE_OFFSET + 1;
-	if ((done < tot) && !bat_addrs[3].limit) {
-		/* use BAT3 to cover a bit more */
-		tot -= done;
-		for (bl = 128<<10; bl < max_size; bl <<= 1)
-			if (bl * 2 > tot)
-				break;
-		setbat(3, PAGE_OFFSET+done, done, bl, PAGE_KERNEL_X);
-		done = (unsigned long)bat_addrs[3].limit - PAGE_OFFSET + 1;
-	}
-
-	return done;
+	return base;
 }
 
 /*
-- 
2.13.3

