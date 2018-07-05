Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE4FC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931C524072
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931C524072
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbeGEIyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 04:54:06 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:28536 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753497AbeGEIyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 04:54:02 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41Ls941xnBz9ttgB;
        Thu,  5 Jul 2018 10:54:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 5Rgt97u9hCVl; Thu,  5 Jul 2018 10:54:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41Ls941QLMz9ttg7;
        Thu,  5 Jul 2018 10:54:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 774AF8B7C3;
        Thu,  5 Jul 2018 10:54:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id P-hKQElSeU0i; Thu,  5 Jul 2018 10:54:01 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 46F0C8B7BC;
        Thu,  5 Jul 2018 10:54:01 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3ED0D6FFC6; Thu,  5 Jul 2018 08:54:01 +0000 (UTC)
Message-Id: <a7b89147bd6ee3ffa34669b97624ff4261ec4a22.1530780629.git.christophe.leroy@c-s.fr>
In-Reply-To: <a272622d3444a1787a0fc4bf61e9192fb0c3cd64.1530780629.git.christophe.leroy@c-s.fr>
References: <a272622d3444a1787a0fc4bf61e9192fb0c3cd64.1530780629.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH 3/3] powerpc/lib: Optimised strlen() for POWER6+
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, wei.guo.simon@gmail.com,
        segher@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  5 Jul 2018 08:54:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 Untested

 arch/powerpc/lib/strlen_64.S | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/strlen_64.S b/arch/powerpc/lib/strlen_64.S
index c9704f2b697d..3f756902653c 100644
--- a/arch/powerpc/lib/strlen_64.S
+++ b/arch/powerpc/lib/strlen_64.S
@@ -45,8 +45,12 @@
 
 _GLOBAL(strlen)
 	andi.   r0, r3, 7
-	lis	r7, 0x0101
 	addi	r10, r3, -8
+BEGIN_FTR_SECTION
+	lis	r7, 0x0101
+FTR_SECTION_ELSE
+	b	strlen_power6
+ALT_FTR_SECTION_END_IFCLR(CPU_FTR_CFAR) /* power6++ */
 	addic	r7, r7, 0x0101	/* r7 = 0x01010101 (lomagic) & clear XER[CA] */
 	rldimi	r7, r7, 32, 0	/* r7 = 0x0101010101010101 (lomagic) */
 	rotldi	r6, r7, 31 	/* r6 = 0x8080808080808080 (himagic) */
@@ -84,5 +88,32 @@ _GLOBAL(strlen)
 	slwi	r0, r0, 3
 	srw	r8, r8, r0
 	orc	r9, r9, r8
+BEGIN_FTR_SECTION
 	b	2b
-EXPORT_SYMBOL(strlen)
+FTR_SECTION_ELSE
+	b	12f
+ALT_FTR_SECTION_END_IFCLR(CPU_FTR_CFAR) /* power6++ */
+
+strlen_power6:
+	li	r7, 0
+	bne-	3b
+	.balign IFETCH_ALIGN_BYTES
+11:	ldu	r9, 8(r10)
+12:	cmpb	r8, r9, r7
+	cmpld	r8, r7
+	beq+	11b
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	cntlzd	r8, r8
+	subf	r3, r3, r10
+	srdi	r8, r8, 3
+	add	r3, r3, r8
+#else
+	addi	r9, r8, -1
+	addi	r10, r10, 7
+	andc	r8, r9, r8
+	cntlzd	r8, r8
+	subf	r3, r3, r10
+	srdi	r8, r8, 3
+	subf	r3, r8, r3
+#endif
+	blr
-- 
2.13.3

