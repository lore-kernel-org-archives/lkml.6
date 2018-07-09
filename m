Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DC8C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7007620881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7007620881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933056AbeGIJav (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:30:51 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:59298 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932805AbeGIJao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:30:44 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id 8ZWi1y00f3XaVaC01ZWi2o; Mon, 09 Jul 2018 11:30:43 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fcSVG-0002dq-Q4; Mon, 09 Jul 2018 11:30:42 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fcSVG-00069b-Os; Mon, 09 Jul 2018 11:30:42 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Greg Ungerer <gerg@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Helge Deller <deller@gmx.de>
Cc:     linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 4/5] m68k/io: Move mem*io define guards to <asm/kmap.h>
Date:   Mon,  9 Jul 2018 11:30:39 +0200
Message-Id: <20180709093040.23597-5-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180709093040.23597-1-geert@linux-m68k.org>
References: <20180709093040.23597-1-geert@linux-m68k.org>
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

v2:
  - No changes.
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
index 608e12f058a7cd7d..aac7f045f7f0aa85 100644
--- a/arch/m68k/include/asm/kmap.h
+++ b/arch/m68k/include/asm/kmap.h
@@ -50,18 +50,21 @@ static inline void __iomem *ioremap_fullcache(unsigned long physaddr,
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

