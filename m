Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15956C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE63B20859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="oVnb10L8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfBTR3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:29:23 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:40285 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbfBTR3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:29:20 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 444PjS658Fz9v0vj;
        Wed, 20 Feb 2019 18:29:16 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=oVnb10L8; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id GN2hB2Mnp6_7; Wed, 20 Feb 2019 18:29:16 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 444PjS52Q7z9v0g0;
        Wed, 20 Feb 2019 18:29:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1550683756; bh=02ljiBkmcqq7HcRxan5DntP8oMfjS88LVnUYOxruHkQ=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=oVnb10L8b/JsRKSOLnBXO+wZq+/UeftjNTjxbi+gBxvuACmljC6ubSjfDGWjX3gCM
         D5zSMXS5UbUnGyXyCzbf0KDqHDnSuRK4zqpTiQ4DNtzchCzOoOgvqdJEGJp5ervqzi
         d6kKIU/U2DS2ILPIaU3OvJBkhBU8uwbgzOLVZ48w=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5C0758B84F;
        Wed, 20 Feb 2019 18:29:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id MiCQfnASt3gM; Wed, 20 Feb 2019 18:29:18 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 43CBE8B84A;
        Wed, 20 Feb 2019 18:29:18 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 37D1F6E85E; Wed, 20 Feb 2019 17:29:18 +0000 (UTC)
Message-Id: <463a85f5e8ace8971d5b3f0772ab611698425880.1550648295.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550648295.git.christophe.leroy@c-s.fr>
References: <cover.1550648295.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 11/16] powerpc/kconfig: define CONFIG_DATA_SHIFT and
 CONFIG_ETEXT_SHIFT
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 20 Feb 2019 17:29:18 +0000 (UTC)
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
index 417e52a27f63..edef40a2b446 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -725,6 +725,15 @@ config THREAD_SHIFT
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

