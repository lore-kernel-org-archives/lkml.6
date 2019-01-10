Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A2DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4F8214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbfAJPMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:12:37 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:53603 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729635AbfAJPMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:12:00 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43b8by0q09z9v0fF;
        Thu, 10 Jan 2019 16:11:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id DyrC6OKltPuD; Thu, 10 Jan 2019 16:11:58 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43b8by0Jv2z9v0f8;
        Thu, 10 Jan 2019 16:11:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 81A528B8A0;
        Thu, 10 Jan 2019 16:11:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 2IoUKUxNZvhK; Thu, 10 Jan 2019 16:11:59 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5186D8B89F;
        Thu, 10 Jan 2019 16:11:59 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 127E26BF21; Thu, 10 Jan 2019 15:11:59 +0000 (UTC)
Message-Id: <f9cb8d4b198cf836a4ab15a53649845b336ceb2a.1547132681.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1547132681.git.christophe.leroy@c-s.fr>
References: <cover.1547132681.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 10/15] powerpc/kconfig: define PAGE_SHIFT inside Kconfig
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 10 Jan 2019 15:11:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch defined CONFIG_PPC_PAGE_SHIFT in order
to be able to use PAGE_SHIFT value inside Kconfig.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig            |  7 +++++++
 arch/powerpc/include/asm/page.h | 13 ++-----------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2890d36eb531..d72caed57f2c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -714,6 +714,13 @@ config PPC_256K_PAGES
 
 endchoice
 
+config PPC_PAGE_SHIFT
+	int
+	default 18 if PPC_256K_PAGES
+	default 16 if PPC_64K_PAGES
+	default 14 if PPC_16K_PAGES
+	default 12
+
 config THREAD_SHIFT
 	int "Thread shift" if EXPERT
 	range 13 15
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 5c5ea2413413..bc4bb6c6efce 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -20,20 +20,11 @@
 
 /*
  * On regular PPC32 page size is 4K (but we support 4K/16K/64K/256K pages
- * on PPC44x). For PPC64 we support either 4K or 64K software
+ * on PPC44x and 4K/16K on 8xx). For PPC64 we support either 4K or 64K software
  * page size. When using 64K pages however, whether we are really supporting
  * 64K pages in HW or not is irrelevant to those definitions.
  */
-#if defined(CONFIG_PPC_256K_PAGES)
-#define PAGE_SHIFT		18
-#elif defined(CONFIG_PPC_64K_PAGES)
-#define PAGE_SHIFT		16
-#elif defined(CONFIG_PPC_16K_PAGES)
-#define PAGE_SHIFT		14
-#else
-#define PAGE_SHIFT		12
-#endif
-
+#define PAGE_SHIFT		CONFIG_PPC_PAGE_SHIFT
 #define PAGE_SIZE		(ASM_CONST(1) << PAGE_SHIFT)
 
 #ifndef __ASSEMBLY__
-- 
2.13.3

