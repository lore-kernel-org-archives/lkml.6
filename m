Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F7DC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB2E25DDD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB2E25DDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752772AbeGBNfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:35:43 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:39386 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752736AbeGBNff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:35:35 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id 5pbZ1y0133XaVaC06pbZYl; Mon, 02 Jul 2018 15:35:34 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fZyzN-0001ZB-RG; Mon, 02 Jul 2018 15:35:33 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fZyzN-0001QZ-QG; Mon, 02 Jul 2018 15:35:33 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Greg Ungerer <gerg@linux-m68k.org>,
        "David S . Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Helge Deller <deller@gmx.de>
Cc:     linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 4/5] m68k/io: Move mem*io define guards to <asm/kmap.h>
Date:   Mon,  2 Jul 2018 15:35:31 +0200
Message-Id: <20180702133532.5412-5-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180702133532.5412-1-geert@linux-m68k.org>
References: <20180702133532.5412-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mem*io define guards are applicable to all users of <asm/kmap.h>.
Hence move them, and drop the #ifdef.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To avoid redefined warnings, this depends on "net: mac8390: Use standard
memcpy_{from,to}io()".
---
 arch/m68k/include/asm/io_no.h | 11 -----------
 arch/m68k/include/asm/kmap.h  |  3 +++
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/m68k/include/asm/io_no.h b/arch/m68k/include/asm/io_no.h
index 83a0a6d449f44bdd..c207428fae5953e7 100644
--- a/arch/m68k/include/asm/io_no.h
+++ b/arch/m68k/include/asm/io_no.h
@@ -131,17 +131,6 @@ static inline void writel(u32 value, volatile void __iomem *addr)
 #define PCI_SPACE_LIMIT	PCI_IO_MASK
 #endif /* CONFIG_PCI */
 
-/*
- * These are defined in kmap.h as static inline functions. To maintain
- * previous behavior we put these define guards here so io_mm.h doesn't
- * see them.
- */
-#ifdef CONFIG_MMU
-#define memset_io memset_io
-#define memcpy_fromio memcpy_fromio
-#define memcpy_toio memcpy_toio
-#endif
-
 #include <asm/kmap.h>
 #include <asm/virtconvert.h>
 #include <asm-generic/io.h>
diff --git a/arch/m68k/include/asm/kmap.h b/arch/m68k/include/asm/kmap.h
index bf1026def698f21f..dd4a365bf463d3cf 100644
--- a/arch/m68k/include/asm/kmap.h
+++ b/arch/m68k/include/asm/kmap.h
@@ -48,18 +48,21 @@ static inline void __iomem *ioremap_fullcache(unsigned long physaddr,
 	return __ioremap(physaddr, size, IOMAP_FULL_CACHING);
 }
 
+#define memset_io memset_io
 static inline void memset_io(volatile void __iomem *addr, unsigned char val,
 			     int count)
 {
 	__builtin_memset((void __force *) addr, val, count);
 }
 
+#define memcpy_fromio memcpy_fromio
 static inline void memcpy_fromio(void *dst, const volatile void __iomem *src,
 				 int count)
 {
 	__builtin_memcpy(dst, (void __force *) src, count);
 }
 
+#define memcpy_toio memcpy_toio
 static inline void memcpy_toio(volatile void __iomem *dst, const void *src,
 			       int count)
 {
-- 
2.17.1

