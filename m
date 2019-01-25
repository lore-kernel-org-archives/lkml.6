Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EA5C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AB02146E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="eXxXjTwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfAYMeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:34:10 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:40792 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfAYMeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:34:08 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43mJNs4NSfz9tyxw;
        Fri, 25 Jan 2019 13:34:05 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=eXxXjTwd; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id KCl2qgSiCOwJ; Fri, 25 Jan 2019 13:34:05 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43mJNs3KzPz9tyxr;
        Fri, 25 Jan 2019 13:34:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1548419645; bh=bmatQtpwO9PQVzJeUZnTW6zoJHmtskpEwihqd2uxsKw=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=eXxXjTwdb+mpjedNH17I56j1ZfdGv3QHmN8GN3PseGMMpEmLK5HgkPvc9keSlqn3y
         zyV9o5v+42vUTbBt0aiciDtiltzQvRMB7a00BG3cjN0xylVrbgkL3TyC9YZaulvWbH
         nI5WbyHuFJPIfXGUkSc/J943aAYZmF6ZxpZdY/Xo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BD60B8B87A;
        Fri, 25 Jan 2019 13:34:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fD1XM7ZXue5T; Fri, 25 Jan 2019 13:34:06 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 68AC68B761;
        Fri, 25 Jan 2019 13:34:06 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5AB1A72DA9; Fri, 25 Jan 2019 12:34:06 +0000 (UTC)
Message-Id: <2edbd69dd9a26431ae7f2568c459569e90a9bcb5.1548419273.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1548419273.git.christophe.leroy@c-s.fr>
References: <cover.1548419273.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 03/10] powerpc/603: use physical address directly in TLB miss
 handlers.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        joakim.tjernlund@infinera.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 25 Jan 2019 12:34:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit c62ce9ef97ba ("powerpc: remove remaining bits from
CONFIG_APUS"), tophys() has become a pure constant operation.
PAGE_OFFSET is known at compile time so the physical address
can be builtin directly.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index dbd15e03952a..53f65124edd5 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -507,9 +507,8 @@ InstructionTLBMiss:
 	bge-	112f
 	mfspr	r2,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
 	rlwimi	r1,r2,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
-	lis	r2,swapper_pg_dir@ha	/* if kernel address, use */
-	addi	r2,r2,swapper_pg_dir@l	/* kernel page table */
-	tophys(r2,r2)
+	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
+	addi	r2, r2, (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
 112:	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
 	lwz	r2,0(r2)		/* get pmd entry */
 	rlwinm.	r2,r2,0,0,19		/* extract address of pte page */
@@ -580,9 +579,8 @@ DataLoadTLBMiss:
 	bge-	112f
 	mfspr	r2,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
 	rlwimi	r1,r2,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
-	lis	r2,swapper_pg_dir@ha	/* if kernel address, use */
-	addi	r2,r2,swapper_pg_dir@l	/* kernel page table */
-	tophys(r2,r2)
+	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
+	addi	r2, r2, (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
 112:	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
 	lwz	r2,0(r2)		/* get pmd entry */
 	rlwinm.	r2,r2,0,0,19		/* extract address of pte page */
@@ -663,9 +661,8 @@ DataStoreTLBMiss:
 	bge-	112f
 	mfspr	r2,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
 	rlwimi	r1,r2,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
-	lis	r2,swapper_pg_dir@ha	/* if kernel address, use */
-	addi	r2,r2,swapper_pg_dir@l	/* kernel page table */
-	tophys(r2,r2)
+	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
+	addi	r2, r2, (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
 112:	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
 	lwz	r2,0(r2)		/* get pmd entry */
 	rlwinm.	r2,r2,0,0,19		/* extract address of pte page */
-- 
2.13.3

