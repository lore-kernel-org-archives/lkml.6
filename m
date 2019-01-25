Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56A3C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731B82146E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="gcecgJr3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfAYMem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:34:42 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:55568 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728395AbfAYMeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:34:13 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43mJNz3Q7Jz9tyxt;
        Fri, 25 Jan 2019 13:34:11 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=gcecgJr3; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id kF64ZoLVMcch; Fri, 25 Jan 2019 13:34:11 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43mJNz2Mf7z9tyxr;
        Fri, 25 Jan 2019 13:34:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1548419651; bh=ajm+6igy7mNtNRmP4xd/IL/tTtpCnUGfid61kOVt4TE=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=gcecgJr3ajMeX8QcFgy6EIHao6BCy3UTf6j7ZCMJkU74vAaykNuUAzDxUQ0GyUuwd
         gUk975/DHVBhV7QkrcTlUPsWcEKlwvkviq5irqj7nQ9qUcp03mb7lD7i/8Y0POfcm+
         MN4eTugnkrr3yMy/gxk47djylzUJfP7NRapyj54s=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9F49D8B87A;
        Fri, 25 Jan 2019 13:34:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Xl1uWjjj9fGe; Fri, 25 Jan 2019 13:34:12 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 821F68B761;
        Fri, 25 Jan 2019 13:34:12 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6AF0E72DA9; Fri, 25 Jan 2019 12:34:12 +0000 (UTC)
Message-Id: <3a0cff1b1fe66c1834b508cfdecd3f3b6ccebcff.1548419273.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1548419273.git.christophe.leroy@c-s.fr>
References: <cover.1548419273.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 06/10] powerpc/603: Don't handle _PAGE_RW and _PAGE_DIRTY on
 ITLB misses
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        joakim.tjernlund@infinera.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 25 Jan 2019 12:34:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_PAGE_RW and _PAGE_DIRTY do not matter for ITLB misses.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 3bbf937ad634..2aec3f91c9f5 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -528,13 +528,9 @@ InstructionTLBMiss:
 	 */
 	stw	r0,0(r2)		/* update PTE (accessed bit) */
 	/* Convert linux-style PTE to low word of PPC-style PTE */
-	rlwinm	r1,r0,32-10,31,31	/* _PAGE_RW -> PP lsb */
-	rlwinm	r2,r0,32-7,31,31	/* _PAGE_DIRTY -> PP lsb */
-	and	r1,r1,r2		/* writable if _RW and _DIRTY */
 	rlwimi	r0,r0,32-1,30,30	/* _PAGE_USER -> PP msb */
-	rlwimi	r0,r0,32-1,31,31	/* _PAGE_USER -> PP lsb */
-	ori	r1,r1,0xe04		/* clear out reserved bits */
-	andc	r1,r0,r1		/* PP = user? (rw&dirty? 2: 3): 0 */
+	ori	r1, r1, 0xe05		/* clear out reserved bits */
+	andc	r1, r0, r1		/* PP = user? 2 : 0 */
 BEGIN_FTR_SECTION
 	rlwinm	r1,r1,0,~_PAGE_COHERENT	/* clear M (coherence not required) */
 END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
-- 
2.13.3

