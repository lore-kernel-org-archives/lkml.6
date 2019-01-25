Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E3DC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323BF2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Y0fUpU5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfAYMeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:34:15 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:54439 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbfAYMeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:34:12 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43mJNx4G5Yz9tyxs;
        Fri, 25 Jan 2019 13:34:09 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Y0fUpU5I; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id sgG4hIpj0rqd; Fri, 25 Jan 2019 13:34:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43mJNx2xNdz9tyxr;
        Fri, 25 Jan 2019 13:34:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1548419649; bh=shxpvL1EpT7PNv9ssXfb555llHD7XkFegIZFp6AerwU=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=Y0fUpU5IfHkU6vEY3/SH+DuqXJZ0shuUB12lDjSHjCUHdyy/8vCMx2VdSmoeAbuDj
         5bpKn6GaS0CHyZGt5ehlR8MV0/tpA3I1nIoy1sKcI6DprEt7EANgDh+vQDTSv0UveI
         6cU7M949kpgsjjQ6zleffVDjyYfRoPr69EYtm7EY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AA0F28B87A;
        Fri, 25 Jan 2019 13:34:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id I2ny5lr9zVz2; Fri, 25 Jan 2019 13:34:10 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7D9CA8B761;
        Fri, 25 Jan 2019 13:34:10 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 65B5172DA9; Fri, 25 Jan 2019 12:34:10 +0000 (UTC)
Message-Id: <e891ad5ef976cf1f2b9bb08a97cdf70ba454ef98.1548419273.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1548419273.git.christophe.leroy@c-s.fr>
References: <cover.1548419273.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 05/10] powerpc/603: Don't handle kernel page TLB misses when
 not need
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        joakim.tjernlund@infinera.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 25 Jan 2019 12:34:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ITLB miss on kernel pages only occur with CONFIG_MODULES and
CONFIG_DEBUG_PAGEALLOC.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 53f65124edd5..3bbf937ad634 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -500,15 +500,19 @@ InstructionTLBMiss:
  */
 	/* Get PTE (linux-style) and check access */
 	mfspr	r3,SPRN_IMISS
+#if defined(CONFIG_MODULES) || defined(CONFIG_DEBUG_PAGEALLOC)
 	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
 	cmplw	0,r1,r3
+#endif
 	mfspr	r2, SPRN_SPRG_603_PGDIR
 	li	r1,_PAGE_USER|_PAGE_PRESENT|_PAGE_EXEC /* low addresses tested as user */
+#if defined(CONFIG_MODULES) || defined(CONFIG_DEBUG_PAGEALLOC)
 	bge-	112f
 	mfspr	r2,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
 	rlwimi	r1,r2,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
 	addi	r2, r2, (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
+#endif
 112:	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
 	lwz	r2,0(r2)		/* get pmd entry */
 	rlwinm.	r2,r2,0,0,19		/* extract address of pte page */
-- 
2.13.3

