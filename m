Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ABEC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40D22146E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="VwBpXh06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfAYMeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:34:21 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:54112 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728550AbfAYMeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:34:18 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43mJP344dvz9tyxx;
        Fri, 25 Jan 2019 13:34:15 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=VwBpXh06; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id uzLxnJ3v1N3e; Fri, 25 Jan 2019 13:34:15 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43mJP333p9z9tyxr;
        Fri, 25 Jan 2019 13:34:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1548419655; bh=WipMeeEOUJx/FE8w1+6nFDz722YqkfVGCrpdT9quoOU=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=VwBpXh06CeQqLNDY293B3jrpkpSLgNk1H6jlhq1uQNkxdfZVV94jf0QNmZv2LHgVz
         ytPzpg4U5lajQyAQJ1lGr3bBBBHjbZtxyj491GlZm4bcyrAisAzu7d76+ap4uuk9nk
         /x/hGfEaicL0Z8yRuWNGdoIHMvAFk1GseZhW+PBc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B26EA8B87A;
        Fri, 25 Jan 2019 13:34:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NdgGamQGBiNc; Fri, 25 Jan 2019 13:34:16 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 934008B761;
        Fri, 25 Jan 2019 13:34:16 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 759C372DA9; Fri, 25 Jan 2019 12:34:16 +0000 (UTC)
Message-Id: <fc0df0c30a35dab0b97897a9afb76a444728578c.1548419273.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1548419273.git.christophe.leroy@c-s.fr>
References: <cover.1548419273.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 08/10] powerpc/603: Don't worry about _PAGE_USER in TLB miss
 handlers
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        joakim.tjernlund@infinera.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 25 Jan 2019 12:34:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PP bits take user access into account, so no need to check _PAGE_USER
here. A DSI or ISI will be generated if needed.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index abbaf51b6f58..44cc84857520 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -505,11 +505,9 @@ InstructionTLBMiss:
 	cmplw	0,r1,r3
 #endif
 	mfspr	r2, SPRN_SPRG_603_PGDIR
-	li	r1,_PAGE_USER|_PAGE_PRESENT|_PAGE_EXEC /* low addresses tested as user */
+	li	r1,_PAGE_PRESENT | _PAGE_EXEC
 #if defined(CONFIG_MODULES) || defined(CONFIG_DEBUG_PAGEALLOC)
 	bge-	112f
-	mfspr	r2,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
-	rlwimi	r1,r2,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
 	addi	r2, r2, (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
 #endif
@@ -575,10 +573,8 @@ DataLoadTLBMiss:
 	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
 	cmplw	0,r1,r3
 	mfspr	r2, SPRN_SPRG_603_PGDIR
-	li	r1,_PAGE_USER|_PAGE_PRESENT /* low addresses tested as user */
+	li	r1, _PAGE_PRESENT
 	bge-	112f
-	mfspr	r2,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
-	rlwimi	r1,r2,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
 	addi	r2, r2, (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
 112:	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
@@ -655,10 +651,8 @@ DataStoreTLBMiss:
 	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
 	cmplw	0,r1,r3
 	mfspr	r2, SPRN_SPRG_603_PGDIR
-	li	r1,_PAGE_RW|_PAGE_USER|_PAGE_PRESENT /* access flags */
+	li	r1, _PAGE_RW | _PAGE_PRESENT /* access flags */
 	bge-	112f
-	mfspr	r2,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
-	rlwimi	r1,r2,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
 	addi	r2, r2, (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
 112:	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
-- 
2.13.3

