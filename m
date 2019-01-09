Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9098BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6866F206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfAIUaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 15:30:10 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:40019 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfAIUaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 15:30:10 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43ZgjX2QCZz9v1FM;
        Wed,  9 Jan 2019 21:30:08 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id a2BeVWl2OlM7; Wed,  9 Jan 2019 21:30:08 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43ZgjX1v4Nz9v1FL;
        Wed,  9 Jan 2019 21:30:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 59E088B84E;
        Wed,  9 Jan 2019 21:30:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Iw-Xke2CbzRM; Wed,  9 Jan 2019 21:30:08 +0100 (CET)
Received: from PO15451.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 315518B84A;
        Wed,  9 Jan 2019 21:30:08 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id E5F2269A7A; Wed,  9 Jan 2019 20:30:07 +0000 (UTC)
Message-Id: <9b1d38ef4c4d26f9ef9b6a69a37949a4eee722df.1547025153.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/8xx: fix setting of pagetable for Abatron BDI debug
 tool.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  9 Jan 2019 20:30:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8c8c10b90d88 ("powerpc/8xx: fix handling of early NULL pointer
dereference") moved the loading of r6 earlier in the code. As some
functions are called inbetween, r6 needs to be loaded again with the
address of swapper_pg_dir in order to set PTE pointers for
the Abatron BDI.

Fixes: 8c8c10b90d88 ("powerpc/8xx: fix handling of early NULL pointer dereference")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index aea5f367e4fe..ab0e6f1c98b0 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -885,11 +885,12 @@ start_here:
 
 	/* set up the PTE pointers for the Abatron bdiGDB.
 	*/
-	tovirt(r6,r6)
 	lis	r5, abatron_pteptrs@h
 	ori	r5, r5, abatron_pteptrs@l
 	stw	r5, 0xf0(0)	/* Must match your Abatron config file */
 	tophys(r5,r5)
+	lis	r6, swapper_pg_dir@h
+	ori	r6, r6, swapper_pg_dir@l
 	stw	r6, 0(r5)
 
 /* Now turn on the MMU for real! */
-- 
2.13.3

