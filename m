Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5805FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2912B20880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="E0RBcd+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfBUKh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:37:56 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:36010 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbfBUKhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:37:55 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 444rXJ4dXPz9tylS;
        Thu, 21 Feb 2019 11:37:52 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=E0RBcd+n; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id eDasdFhiwP0w; Thu, 21 Feb 2019 11:37:52 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 444rXJ3VMCz9tylQ;
        Thu, 21 Feb 2019 11:37:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1550745472; bh=QrYrjIQnTPUvQEUcWBAQvuPqK6UEVmEutaBMFS/WwKI=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=E0RBcd+nKQFV+Iajm5Tzw39PncjbaTyRQGmi7lBUWQeGzzxFcoBQtWSLASeA5dg2S
         vl6neSmSunRXCZBEcUOMAXNavsAkQECfpsfsQBvy/mWOPkppGf0dne5Jct0o5+bqox
         WSfJOXlx8hBQnsGXMlY4fQiFpeG54ioVKdP2h5QQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A2F088B859;
        Thu, 21 Feb 2019 11:37:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4N9szPUDZB6C; Thu, 21 Feb 2019 11:37:53 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6E65D8B852;
        Thu, 21 Feb 2019 11:37:53 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 4A0FB6E856; Thu, 21 Feb 2019 10:37:53 +0000 (UTC)
Message-Id: <2fac63e1eb595870a990da51f81ba97c11903c0e.1550745320.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550745320.git.christophe.leroy@c-s.fr>
References: <cover.1550745320.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 01/10] powerpc: simplify BDI switch
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 21 Feb 2019 10:37:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to re-read each time the pointer at
location 0xf0 as it is fixed and known.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/mmu.h | 2 ++
 arch/powerpc/kernel/head_32.S  | 5 ++---
 arch/powerpc/kernel/head_40x.S | 5 ++---
 arch/powerpc/kernel/head_8xx.S | 1 +
 arch/powerpc/mm/8xx_mmu.c      | 7 ++-----
 5 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 25607604a7a5..6d22a8e78fe2 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -356,6 +356,8 @@ extern void early_init_mmu_secondary(void);
 extern void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 				       phys_addr_t first_memblock_size);
 static inline void mmu_early_init_devtree(void) { }
+
+extern void *abatron_pteptrs[2];
 #endif /* __ASSEMBLY__ */
 #endif
 
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 05b08db3901d..c2f564690778 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -1027,9 +1027,8 @@ _ENTRY(switch_mmu_context)
 	 * The PGDIR is passed as second argument.
 	 */
 	lwz	r4,MM_PGD(r4)
-	lis	r5, KERNELBASE@h
-	lwz	r5, 0xf0(r5)
-	stw	r4, 0x4(r5)
+	lis	r5, abatron_pteptrs@ha
+	stw	r4, abatron_pteptrs@l + 0x4(r5)
 #endif
 	li	r4,0
 	isync
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index b19d78410511..11dd09d0ce1a 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -953,9 +953,8 @@ _GLOBAL(set_context)
 	/* Context switch the PTE pointer for the Abatron BDI2000.
 	 * The PGDIR is the second parameter.
 	 */
-	lis	r5, KERNELBASE@h
-	lwz	r5, 0xf0(r5)
-	stw	r4, 0x4(r5)
+	lis	r5, abatron_pteptrs@ha
+	stw	r4, abatron_pteptrs@l + 0x4(r5)
 #endif
 	sync
 	mtspr	SPRN_PID,r3
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 20cc816b3508..ec12abc2a8ce 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -989,5 +989,6 @@ swapper_pg_dir:
 /* Room for two PTE table poiners, usually the kernel and current user
  * pointer to their respective root page table (pgdir).
  */
+	.globl	abatron_pteptrs
 abatron_pteptrs:
 	.space	8
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index bfa503cff351..f12ec85e965c 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -162,14 +162,11 @@ void set_context(unsigned long id, pgd_t *pgd)
 {
 	s16 offset = (s16)(__pa(swapper_pg_dir));
 
-#ifdef CONFIG_BDI_SWITCH
-	pgd_t	**ptr = *(pgd_t ***)(KERNELBASE + 0xf0);
-
 	/* Context switch the PTE pointer for the Abatron BDI2000.
 	 * The PGDIR is passed as second argument.
 	 */
-	*(ptr + 1) = pgd;
-#endif
+	if (IS_ENABLED(CONFIG_BDI_SWITCH))
+		abatron_pteptrs[1] = pgd;
 
 	/* Register M_TWB will contain base address of level 1 table minus the
 	 * lower part of the kernel PGDIR base address, so that all accesses to
-- 
2.13.3

