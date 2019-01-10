Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00399C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D181F214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbfAJPLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:11:49 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:4948 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729591AbfAJPLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:11:46 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43b8bg5X9Tz9v116;
        Thu, 10 Jan 2019 16:11:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id KqRje4jByLiv; Thu, 10 Jan 2019 16:11:43 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43b8bg53VHz9v113;
        Thu, 10 Jan 2019 16:11:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3458C8B89F;
        Thu, 10 Jan 2019 16:11:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Y6ct-_nqi-ky; Thu, 10 Jan 2019 16:11:45 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 116B38B898;
        Thu, 10 Jan 2019 16:11:45 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D56476BF21; Thu, 10 Jan 2019 15:11:44 +0000 (UTC)
Message-Id: <1947e35e0c95f1b8746b5f710deef11b9e66a98c.1547132681.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1547132681.git.christophe.leroy@c-s.fr>
References: <cover.1547132681.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 03/15] powerpc/mm/32s: use generic mmu_mapin_ram() for all
 blocks.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 10 Jan 2019 15:11:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that mmu_mapin_ram() is able to handle other blocks
than the one starting at 0, the WII can use it for all
its blocks.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/pgtable_32.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index b4858818523f..fd665c32a1f7 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -254,26 +254,15 @@ static void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
 
 void __init mapin_ram(void)
 {
-	unsigned long s, top;
-
-#ifndef CONFIG_WII
-	top = total_lowmem;
-	s = mmu_mapin_ram(0, top);
-	__mapin_ram_chunk(s, top);
-#else
-	if (!wii_hole_size) {
-		s = mmu_mapin_ram(0, total_lowmem);
-		__mapin_ram_chunk(s, total_lowmem);
-	} else {
-		top = wii_hole_start;
-		s = mmu_mapin_ram(0, top);
-		__mapin_ram_chunk(s, top);
+	struct memblock_region *reg;
+
+	for_each_memblock(memory, reg) {
+		unsigned long base = reg->base;
+		unsigned long top = base + reg->size;
 
-		top = memblock_end_of_DRAM();
-		s = wii_mmu_mapin_mem2(top);
-		__mapin_ram_chunk(s, top);
+		base = mmu_mapin_ram(base, top);
+		__mapin_ram_chunk(base, top);
 	}
-#endif
 }
 
 /* Scan the real Linux page tables and return a PTE pointer for
-- 
2.13.3

