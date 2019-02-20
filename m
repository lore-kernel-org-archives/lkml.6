Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440E4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D8120859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="XOF0af6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfBTR3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:29:13 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:55813 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbfBTR3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:29:12 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 444PjH3lc4z9v0g3;
        Wed, 20 Feb 2019 18:29:07 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=XOF0af6X; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id TPOJ7ik7PEr8; Wed, 20 Feb 2019 18:29:07 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 444PjH2dBkz9v0g0;
        Wed, 20 Feb 2019 18:29:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1550683747; bh=hO6puhpqDsuc6RO7pim5hG7ZClWiK5qZt97DmQIG6Gc=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=XOF0af6XKVtEtuUSk//+ZqR7jS6a494B5K+xdkstMOGdEOl3BvVqNnBZmTJOSZFxr
         jAvGE3xfLBSmLhZYRJ0QqNoZfieWgH1IVYC5Qh7HwUej3HWVu5TIFAVAzdlF6iNn7Z
         X/enMgCUAicM/Jj0lFmIAVnd1TbTliUyt8kji3uY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 057F88B84F;
        Wed, 20 Feb 2019 18:29:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JkLG-G1c7f0J; Wed, 20 Feb 2019 18:29:08 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D299A8B84A;
        Wed, 20 Feb 2019 18:29:08 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D35196E85E; Wed, 20 Feb 2019 17:29:08 +0000 (UTC)
Message-Id: <17e8849e89d860ee7447563de2b0922c9e435323.1550648295.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550648295.git.christophe.leroy@c-s.fr>
References: <cover.1550648295.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 02/16] powerpc/mm/32: add base address to mmu_mapin_ram()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 20 Feb 2019 17:29:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the time being, mmu_mapin_ram() always maps RAM from the beginning.
But some platforms like the WII have to map a second block of RAM.

This patch adds to mmu_mapin_ram() the base address of the block.
At the moment, only base address 0 is supported.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/40x_mmu.c       | 2 +-
 arch/powerpc/mm/44x_mmu.c       | 2 +-
 arch/powerpc/mm/8xx_mmu.c       | 2 +-
 arch/powerpc/mm/fsl_booke_mmu.c | 2 +-
 arch/powerpc/mm/mmu_decl.h      | 2 +-
 arch/powerpc/mm/pgtable_32.c    | 6 +++---
 arch/powerpc/mm/ppc_mmu_32.c    | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/40x_mmu.c b/arch/powerpc/mm/40x_mmu.c
index 61ac468c87c6..b9cf6f8764b0 100644
--- a/arch/powerpc/mm/40x_mmu.c
+++ b/arch/powerpc/mm/40x_mmu.c
@@ -93,7 +93,7 @@ void __init MMU_init_hw(void)
 #define LARGE_PAGE_SIZE_16M	(1<<24)
 #define LARGE_PAGE_SIZE_4M	(1<<22)
 
-unsigned long __init mmu_mapin_ram(unsigned long top)
+unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 {
 	unsigned long v, s, mapped;
 	phys_addr_t p;
diff --git a/arch/powerpc/mm/44x_mmu.c b/arch/powerpc/mm/44x_mmu.c
index ea2b9af08a48..aad127acdbaa 100644
--- a/arch/powerpc/mm/44x_mmu.c
+++ b/arch/powerpc/mm/44x_mmu.c
@@ -170,7 +170,7 @@ void __init MMU_init_hw(void)
 	flush_instruction_cache();
 }
 
-unsigned long __init mmu_mapin_ram(unsigned long top)
+unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 {
 	unsigned long addr;
 	unsigned long memstart = memstart_addr & ~(PPC_PIN_SIZE - 1);
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index e2c32bdb6023..46bc26ef71e9 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -99,7 +99,7 @@ static void __init mmu_patch_cmp_limit(s32 *site, unsigned long mapped)
 	modify_instruction_site(site, 0xffff, (unsigned long)__va(mapped) >> 16);
 }
 
-unsigned long __init mmu_mapin_ram(unsigned long top)
+unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 {
 	unsigned long mapped;
 
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index 080d49b26c3a..210cbc1faf63 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -221,7 +221,7 @@ unsigned long map_mem_in_cams(unsigned long ram, int max_cam_idx, bool dryrun)
 #error "LOWMEM_CAM_NUM must be less than NUM_TLBCAMS"
 #endif
 
-unsigned long __init mmu_mapin_ram(unsigned long top)
+unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 {
 	return tlbcam_addrs[tlbcam_index - 1].limit - PAGE_OFFSET + 1;
 }
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index c4a717da65eb..61730023dde3 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -130,7 +130,7 @@ extern void wii_memory_fixups(void);
  */
 #ifdef CONFIG_PPC32
 extern void MMU_init_hw(void);
-extern unsigned long mmu_mapin_ram(unsigned long top);
+unsigned long mmu_mapin_ram(unsigned long base, unsigned long top);
 #endif
 
 #ifdef CONFIG_PPC_FSL_BOOK3E
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index ded71126ce4c..b4858818523f 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -258,15 +258,15 @@ void __init mapin_ram(void)
 
 #ifndef CONFIG_WII
 	top = total_lowmem;
-	s = mmu_mapin_ram(top);
+	s = mmu_mapin_ram(0, top);
 	__mapin_ram_chunk(s, top);
 #else
 	if (!wii_hole_size) {
-		s = mmu_mapin_ram(total_lowmem);
+		s = mmu_mapin_ram(0, total_lowmem);
 		__mapin_ram_chunk(s, total_lowmem);
 	} else {
 		top = wii_hole_start;
-		s = mmu_mapin_ram(top);
+		s = mmu_mapin_ram(0, top);
 		__mapin_ram_chunk(s, top);
 
 		top = memblock_end_of_DRAM();
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index 3f4193201ee7..b260ced065b4 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -73,7 +73,7 @@ unsigned long p_block_mapped(phys_addr_t pa)
 	return 0;
 }
 
-unsigned long __init mmu_mapin_ram(unsigned long top)
+unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 {
 	unsigned long tot, bl, done;
 	unsigned long max_size = (256<<20);
-- 
2.13.3

