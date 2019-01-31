Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E870C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B1B20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="VzPNf6OS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbfAaKKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:10:17 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:12741 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729232AbfAaKIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:08:49 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43qwtQ16QRz9tyxD;
        Thu, 31 Jan 2019 11:08:46 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=VzPNf6OS; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Pd1lwmXEVKIQ; Thu, 31 Jan 2019 11:08:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43qwtQ04kRz9tyx9;
        Thu, 31 Jan 2019 11:08:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1548929326; bh=RKnLzg8KtVsjDsnOtBObMBW8+bwI3rJVtk1LBNKXIkw=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=VzPNf6OS1ys/wV4D+0lu/HG4lGXNQHCIg3GSF1eIhpb0mC7I39C3RPH/c19iorhtB
         5OJlwpqM+l6jQRqazLbdvkJIGuJ2pC5G6v5h049n1ALzmR5ZRPc+k37kRT79cOL9fH
         V+8ekJty9iBr1caiCb6b1pbTGiF04c7rsQLnRwgU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1ED068B814;
        Thu, 31 Jan 2019 11:08:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id aBh9T47M05TU; Thu, 31 Jan 2019 11:08:47 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E09A68B78D;
        Thu, 31 Jan 2019 11:08:46 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 8A5E272E14; Thu, 31 Jan 2019 10:08:46 +0000 (UTC)
Message-Id: <da718ce0da4303de0197b46570680843a188f216.1548852243.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1548852242.git.christophe.leroy@c-s.fr>
References: <cover.1548852242.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v15 02/13] powerpc/32: Fix CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 for 40x/booke
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 31 Jan 2019 10:08:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

40x/booke have another path to reach 3f from transfer_to_handler,
make sure it also calls ACCOUNT_CPU_USER_ENTRY() when
CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is selected.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/entry_32.S | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 0768dfd8a64e..d4c6186aa7e8 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -166,6 +166,13 @@ transfer_to_handler:
 	   internal debug mode bit to do this. */
 	lwz	r12,THREAD_DBCR0(r12)
 	andis.	r12,r12,DBCR0_IDM@h
+#endif
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
+	CURRENT_THREAD_INFO(r9, r1)
+	tophys(r9, r9)
+	ACCOUNT_CPU_USER_ENTRY(r9, r11, r12)
+#endif
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
 	beq+	3f
 	/* From user and task is ptraced - load up global dbcr0 */
 	li	r12,-1			/* clear all pending debug events */
@@ -185,11 +192,6 @@ transfer_to_handler:
 	addi	r12,r12,-1
 	stw	r12,4(r11)
 #endif
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-	CURRENT_THREAD_INFO(r9, r1)
-	tophys(r9, r9)
-	ACCOUNT_CPU_USER_ENTRY(r9, r11, r12)
-#endif
 
 	b	3f
 
-- 
2.13.3

