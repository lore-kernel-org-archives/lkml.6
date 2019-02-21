Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00BDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E92214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="b+Gz4/E0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfBUIFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:05:07 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:18195 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbfBUIFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:05:01 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 444n7v3D5pz9vJgH;
        Thu, 21 Feb 2019 09:04:59 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=b+Gz4/E0; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 5ccK_XVBJf1d; Thu, 21 Feb 2019 09:04:59 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 444n7v28Xnz9vJg1;
        Thu, 21 Feb 2019 09:04:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1550736299; bh=VCE7+cdv3QvptEXKiW07jK1lErjsalasiNnLTVxWl58=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=b+Gz4/E0j6L7G75bk3vW2Mt31LaGlLjfEa00jr2jF/R9GdichbkPqXs4O8v5tBU6D
         jvF8wAypFRLf5Vw+9NITQDmMQ6iJpAmpbO7Z5tdrxFwzPRtQZ1yVlOPq1FAeuLAbsE
         SRz9+0fp3LaXo7rLeMCGdX3cg3nKGmWxeQVZdaEY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2DAC18B78F;
        Thu, 21 Feb 2019 09:05:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id v6AT6uE_GGdF; Thu, 21 Feb 2019 09:05:00 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 067378B75B;
        Thu, 21 Feb 2019 09:05:00 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C59E16E866; Thu, 21 Feb 2019 08:04:59 +0000 (UTC)
Message-Id: <e24d4a3665007b0812723b46150bbef3540b5d30.1550692943.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550692943.git.christophe.leroy@c-s.fr>
References: <cover.1550692943.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 11/16] powerpc/kconfig: define CONFIG_DATA_SHIFT and
 CONFIG_ETEXT_SHIFT
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 21 Feb 2019 08:04:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_STRICT_KERNEL_RWX requires a special alignment
for DATA for some subarches. Today it is just defined
as an #ifdef in vmlinux.lds.S

In order to get more flexibility, this patch moves the
definition of this alignment in Kconfig

On some subarches, CONFIG_STRICT_KERNEL_RWX will
require a special alignment of _etext.

This patch also adds a configuration item for it in Kconfig

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig              | 9 +++++++++
 arch/powerpc/kernel/vmlinux.lds.S | 9 +++------
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 01ac44d5d4b4..79a50276437c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -728,6 +728,15 @@ config THREAD_SHIFT
 	  Used to define the stack size. The default is almost always what you
 	  want. Only change this if you know what you are doing.
 
+config ETEXT_SHIFT
+	int
+	default PPC_PAGE_SHIFT
+
+config DATA_SHIFT
+	int
+	default 24 if STRICT_KERNEL_RWX && PPC64
+	default PPC_PAGE_SHIFT
+
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
 	range 8 9 if PPC64 && PPC_64K_PAGES
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index c3efb972c8c1..060a1acd7c6d 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -12,11 +12,8 @@
 #include <asm/cache.h>
 #include <asm/thread_info.h>
 
-#if defined(CONFIG_STRICT_KERNEL_RWX) && !defined(CONFIG_PPC32)
-#define STRICT_ALIGN_SIZE	(1 << 24)
-#else
-#define STRICT_ALIGN_SIZE	PAGE_SIZE
-#endif
+#define STRICT_ALIGN_SIZE	(1 << CONFIG_DATA_SHIFT)
+#define ETEXT_ALIGN_SIZE	(1 << CONFIG_ETEXT_SHIFT)
 
 ENTRY(_stext)
 
@@ -131,7 +128,7 @@ SECTIONS
 
 	} :kernel
 
-	. = ALIGN(PAGE_SIZE);
+	. = ALIGN(ETEXT_ALIGN_SIZE);
 	_etext = .;
 	PROVIDE32 (etext = .);
 
-- 
2.13.3

