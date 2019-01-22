Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D15CC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D858921721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="PCFZ27iy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbfAVNxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:53:05 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:20843 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728639AbfAVNxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:53:03 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43kVHJ4HF9z9txr8;
        Tue, 22 Jan 2019 14:53:00 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=PCFZ27iy; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id W-WOnrmmINtg; Tue, 22 Jan 2019 14:53:00 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43kVHJ3CNCz9txqy;
        Tue, 22 Jan 2019 14:53:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1548165180; bh=H2Xhw5jUvQ7FbHsP/DAq1FYdh/6dMlCHVrwr5C10NlQ=;
        h=From:Subject:To:Cc:Date:From;
        b=PCFZ27iyp6jYAWAq4pW5z7rMbeiiAjXVKT2trcayUd8tB2qWJQuC9CV5DwJCyYQEt
         58gMptxIiUxZGoUTDROQK1holUZp/5s8tTI9mdvK8NLth+o5O/SrkaAE+QP0UGQYCI
         mbJQE5Q+w2DGKB85Tq+mPuu/4bnHOsWWRyhLRMfw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C86FC8B7E5;
        Tue, 22 Jan 2019 14:53:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ESMIBtOIA-p5; Tue, 22 Jan 2019 14:53:01 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A2B9F8B7CE;
        Tue, 22 Jan 2019 14:53:01 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 26795717D8; Tue, 22 Jan 2019 13:53:01 +0000 (UTC)
Message-Id: <1d95a15cc39c5bfe5da4f197ab662bb9f1988347.1548165174.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32: Fix CONFIG_VIRT_CPU_ACCOUNTING_NATIVE for
 40x/booke
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 22 Jan 2019 13:53:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

40x/booke have another path to reach 3f from transfer_to_handler,
so ACCOUNT_CPU_USER_ENTRY() have to be moved there.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/entry_32.S | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index c2b66fbbf7f0..0bcec062c4b8 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -185,12 +185,6 @@ transfer_to_handler:
 	addi	r12,r12,-1
 	stw	r12,4(r11)
 #endif
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-	CURRENT_THREAD_INFO(r9, r1)
-	tophys(r9, r9)
-	ACCOUNT_CPU_USER_ENTRY(r9, r11, r12)
-#endif
-
 	b	3f
 
 2:	/* if from kernel, check interrupted DOZE/NAP mode and
@@ -208,9 +202,14 @@ transfer_to_handler:
 	bt-	31-TLF_NAPPING,4f
 	bt-	31-TLF_SLEEPING,7f
 #endif /* CONFIG_PPC_BOOK3S_32 || CONFIG_E500 */
+3:
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
+	CURRENT_THREAD_INFO(r9, r1)
+	tophys(r9, r9)
+	ACCOUNT_CPU_USER_ENTRY(r9, r11, r12)
+#endif
 	.globl transfer_to_handler_cont
 transfer_to_handler_cont:
-3:
 	mflr	r9
 	lwz	r11,0(r9)		/* virtual address of handler */
 	lwz	r9,4(r9)		/* where to go when done */
-- 
2.13.3

