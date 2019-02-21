Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFA7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC68214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ZuAaRWKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfBUIFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:05:48 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:1753 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbfBUIE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:04:56 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 444n7q0h8nz9vJgC;
        Thu, 21 Feb 2019 09:04:55 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=ZuAaRWKM; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id PGO-WPvlZ_gS; Thu, 21 Feb 2019 09:04:55 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 444n7p6mSTz9vJg1;
        Thu, 21 Feb 2019 09:04:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1550736294; bh=m7cl8nf8mJr4FjpRgz0inRmJAla/TfF+bsPmaGRTCVM=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=ZuAaRWKMZ67NnjMWISup7+Kx4rKc2NGCmPAzX3rURV9OoX+6naYnTK0Wn8CpP22qp
         U29LkzlSPGV1Z43XzkeSwUf2dtxbJNI150i5vQpQNgMYPhyxTLr6dN2CsBG1jgz9TO
         AZhiizSk3qiVpcF9QKygQsWi8o9J8elNPLCNiZSQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E3D748B78F;
        Thu, 21 Feb 2019 09:04:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 1Q_L_6_m7g7a; Thu, 21 Feb 2019 09:04:55 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BF8A68B75B;
        Thu, 21 Feb 2019 09:04:55 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 961466E866; Thu, 21 Feb 2019 08:04:55 +0000 (UTC)
Message-Id: <353c00af4a1eeb5d3616cb8ff0f413b7e638b20c.1550692943.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550692943.git.christophe.leroy@c-s.fr>
References: <cover.1550692943.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 07/16] powerpc/mm/32s: use _PAGE_EXEC in setbat()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 21 Feb 2019 08:04:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not set IBAT when setbat() is called without _PAGE_EXEC

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/ppc_mmu_32.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index 5fc59b195fef..ff8580c6ab11 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -131,6 +131,7 @@ unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
  * Set up one of the I/D BAT (block address translation) register pairs.
  * The parameters are not checked; in particular size must be a power
  * of 2 between 128k and 256M.
+ * On 603+, only set IBAT when _PAGE_EXEC is set
  */
 void __init setbat(int index, unsigned long virt, phys_addr_t phys,
 		   unsigned int size, pgprot_t prot)
@@ -157,11 +158,12 @@ void __init setbat(int index, unsigned long virt, phys_addr_t phys,
 			bat[1].batu |= 1; 	/* Vp = 1 */
 		if (flags & _PAGE_GUARDED) {
 			/* G bit must be zero in IBATs */
-			bat[0].batu = bat[0].batl = 0;
-		} else {
-			/* make IBAT same as DBAT */
-			bat[0] = bat[1];
+			flags &= ~_PAGE_EXEC;
 		}
+		if (flags & _PAGE_EXEC)
+			bat[0] = bat[1];
+		else
+			bat[0].batu = bat[0].batl = 0;
 	} else {
 		/* 601 cpu */
 		if (bl > BL_8M)
-- 
2.13.3

