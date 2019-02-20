Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3775DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062FE2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="BagKyvbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfBTR3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:29:14 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:19652 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbfBTR3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:29:12 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 444PjK47Sxz9v0g7;
        Wed, 20 Feb 2019 18:29:09 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=BagKyvbl; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 90F8ix-U7-tD; Wed, 20 Feb 2019 18:29:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 444PjK31G3z9v0g0;
        Wed, 20 Feb 2019 18:29:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1550683749; bh=ZHUKudDrrrsVvvpp99Q9yOTfS6jJuUqw8dzPq7U71mU=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=BagKyvblA5Hn24SdcEtEnT43Nbqi9xVKjLMaTB1mjkjUVUA+A3IGRTlx621FK3y4v
         qVWXHnEEwJxyvgsRFmk9YDZY/4n5lFpmNairbt56eoIvJ7v/P3cF4gbegSWc3JVqY5
         oa0jTv90N3tNxWYUEaENfdQnmWsnurSmvpbqOTfg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1634D8B84F;
        Wed, 20 Feb 2019 18:29:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qwb08ZiMB0IW; Wed, 20 Feb 2019 18:29:11 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E851C8B84A;
        Wed, 20 Feb 2019 18:29:10 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E14D46E85E; Wed, 20 Feb 2019 17:29:10 +0000 (UTC)
Message-Id: <4c6d31d6b73122b52403c3f92bd0aca342990f2a.1550648295.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550648295.git.christophe.leroy@c-s.fr>
References: <cover.1550648295.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 04/16] powerpc/mm/32s: use generic mmu_mapin_ram() for all
 blocks.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 20 Feb 2019 17:29:10 +0000 (UTC)
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

