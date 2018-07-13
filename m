Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10E5ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55444208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55444208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbeGMNZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:25:26 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:13819 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbeGMNZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:25:25 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41RtTN54l2z9ttmp;
        Fri, 13 Jul 2018 15:10:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id m_GBfCzAQTTg; Fri, 13 Jul 2018 15:10:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41RtTN4cz3z9ttmB;
        Fri, 13 Jul 2018 15:10:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 34FA28B8A6;
        Fri, 13 Jul 2018 15:10:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xCZfC-m1-DxT; Fri, 13 Jul 2018 15:10:48 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0329E8B75A;
        Fri, 13 Jul 2018 15:10:48 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C807871200; Fri, 13 Jul 2018 13:10:47 +0000 (UTC)
Message-Id: <4302f36bd615c179c92f2007a0f3a1215ba96c55.1531439662.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/8xx: fix handling of early NULL pointer dereference
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 13 Jul 2018 13:10:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NULL pointers are pointers to user memory space. So user pagetable
has to be set in order to avoid random behaviour in case of NULL
pointer dereference, otherwise we may encounter random memory
access hence Machine Check Exception from TLB Miss handlers.

Set user pagetable as early as possible in order to properly
catch early kernel NULL pointer dereference.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 6cab07e76732..04501b65040e 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -873,6 +873,10 @@ start_here:
 	li	r0,0
 	stwu	r0,THREAD_SIZE-STACK_FRAME_OVERHEAD(r1)
 
+	lis	r6, swapper_pg_dir@ha
+	tophys(r6,r6)
+	mtspr	SPRN_M_TW, r6
+
 	bl	early_init	/* We have to do this with MMU on */
 
 /*
@@ -893,9 +897,6 @@ start_here:
 	 * init's THREAD like the context switch code does, but this is
 	 * easier......until someone changes init's static structures.
 	 */
-	lis	r6, swapper_pg_dir@ha
-	tophys(r6,r6)
-	mtspr	SPRN_M_TW, r6
 	lis	r4,2f@h
 	ori	r4,r4,2f@l
 	tophys(r4,r4)
-- 
2.13.3

