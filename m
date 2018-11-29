Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECD8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553B5214D9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553B5214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbeK3GHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:07:10 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:7553 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbeK3GHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:07:09 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 435RgK3sjhz9ttx9;
        Thu, 29 Nov 2018 20:00:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id S6eRlWP5-wDh; Thu, 29 Nov 2018 20:00:45 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 435RgK1Sz3z9ttx5;
        Thu, 29 Nov 2018 20:00:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2147B8B8C8;
        Thu, 29 Nov 2018 20:00:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id d4y7v3V5i8fT; Thu, 29 Nov 2018 20:00:41 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7EE488B8E7;
        Thu, 29 Nov 2018 20:00:37 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A1A1C69B59; Thu, 29 Nov 2018 19:00:36 +0000 (UTC)
Message-Id: <60e3edb9b745ed6fadf61a6167fe7b0ba1d0f916.1543517818.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1543517818.git.christophe.leroy@c-s.fr>
References: <cover.1543517818.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 13/13] powerpc/kconfig: make _etext and data areas
 alignment configurable on Book3s 32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 29 Nov 2018 19:00:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on the number of available BATs for mapping the different
kernel areas, it might be needed to increase the alignment of _etext
and/or of data areas.

This patchs allows the user to do it via Kconfig.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ffcf4d7a1186..bab9dab815d9 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -728,16 +728,44 @@ config THREAD_SHIFT
 	  Used to define the stack size. The default is almost always what you
 	  want. Only change this if you know what you are doing.
 
+config ETEXT_SHIFT_BOOL
+	bool "Set custom etext alignment" if STRICT_KERNEL_RWX && PPC_BOOK3S_32
+	depends on ADVANCED_OPTIONS
+	help
+	  This option allows you to set the kernel end of text alignment. When
+	  RAM is mapped by blocks, the alignment needs to fit the size and
+	  number of possible blocks. The default should be OK for most configs.
+
+	  Say N here unless you know what you are doing.
+
 config ETEXT_SHIFT
-	int
+	int "_etext shift" if ETEXT_SHIFT_BOOL
+	range 17 28 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
 	default 17 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
 	default PPC_PAGE_SHIFT
+	help
+	  On Book3S 32 (603+), IBATs are used to map kernel text.
+	  Smaller is the alignment, greater is the number of necessary IBATs.
+
+config DATA_SHIFT_BOOL
+	bool "Set custom data alignment" if STRICT_KERNEL_RWX && PPC_BOOK3S_32
+	depends on ADVANCED_OPTIONS
+	help
+	  This option allows you to set the kernel data alignment. When
+	  RAM is mapped by blocks, the alignment needs to fit the size and
+	  number of possible blocks. The default should be OK for most configs.
+
+	  Say N here unless you know what you are doing.
 
 config DATA_SHIFT
-	int
+	int "Data shift" if DATA_SHIFT_BOOL
 	default 24 if STRICT_KERNEL_RWX && PPC64
+	range 17 28 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
 	default 22 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
 	default PPC_PAGE_SHIFT
+	help
+	  On Book3S 32 (603+), DBATs are used to map kernel text and rodata RO.
+	  Smaller is the alignment, greater is the number of necessary DBATs.
 
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
-- 
2.13.3

