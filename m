Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271A8C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FBF2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="r0ZlN6LL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfAYMeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:34:18 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:1318 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728474AbfAYMeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:34:15 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43mJP149sQz9tyxw;
        Fri, 25 Jan 2019 13:34:13 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=r0ZlN6LL; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id gGpcaaAw-Lmj; Fri, 25 Jan 2019 13:34:13 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43mJP136Sxz9tyxr;
        Fri, 25 Jan 2019 13:34:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1548419653; bh=WWcosn2AmZIbM2TP2/OykXNpl8Z/uIsTt/6rdkSevJY=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=r0ZlN6LLYwD4FkkMDWUG4xvESHG5L9WMi9E2iGQLD2rfnPgMghAsZvtXgE0iV7q0P
         4MYk0N4f7g+14d43742VX0T2uQIHbdojLLc2ndzk6mgVRKyR7EsOvyTZM3cHDF25EN
         A86Z2e0CXQmrtd82S26/zOr+DrKpBnzKEqAy9ZJQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ABF1D8B87A;
        Fri, 25 Jan 2019 13:34:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id GNGX1YKLnf5n; Fri, 25 Jan 2019 13:34:14 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8AA398B761;
        Fri, 25 Jan 2019 13:34:14 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 7034472DA9; Fri, 25 Jan 2019 12:34:14 +0000 (UTC)
Message-Id: <12cc5029e44ab3fb54f16bd95992412dde60cd8f.1548419273.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1548419273.git.christophe.leroy@c-s.fr>
References: <cover.1548419273.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 07/10] powerpc/603: let's handle PAGE_DIRTY directly
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        joakim.tjernlund@infinera.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 25 Jan 2019 12:34:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PAGE_DIRTY corresponds to the C bit. If writing on
a page for which the C bit is not set, a DataStoreTLBMiss
is generated. No need to check it in DataLoadTLBMiss.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 2aec3f91c9f5..abbaf51b6f58 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -597,12 +597,10 @@ DataLoadTLBMiss:
 	stw	r0,0(r2)		/* update PTE (accessed bit) */
 	/* Convert linux-style PTE to low word of PPC-style PTE */
 	rlwinm	r1,r0,32-10,31,31	/* _PAGE_RW -> PP lsb */
-	rlwinm	r2,r0,32-7,31,31	/* _PAGE_DIRTY -> PP lsb */
-	and	r1,r1,r2		/* writable if _RW and _DIRTY */
 	rlwimi	r0,r0,32-1,30,30	/* _PAGE_USER -> PP msb */
 	rlwimi	r0,r0,32-1,31,31	/* _PAGE_USER -> PP lsb */
 	ori	r1,r1,0xe04		/* clear out reserved bits */
-	andc	r1,r0,r1		/* PP = user? (rw&dirty? 2: 3): 0 */
+	andc	r1,r0,r1		/* PP = user? rw? 2: 3: 0 */
 BEGIN_FTR_SECTION
 	rlwinm	r1,r1,0,~_PAGE_COHERENT	/* clear M (coherence not required) */
 END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
@@ -671,7 +669,7 @@ DataStoreTLBMiss:
 	lwz	r0,0(r2)		/* get linux-style pte */
 	andc.	r1,r1,r0		/* check access & ~permission */
 	bne-	DataAddressInvalid	/* return if access not permitted */
-	ori	r0,r0,_PAGE_ACCESSED|_PAGE_DIRTY
+	ori	r0,r0,_PAGE_ACCESSED
 	/*
 	 * NOTE! We are assuming this is not an SMP system, otherwise
 	 * we would need to update the pte atomically with lwarx/stwcx.
-- 
2.13.3

