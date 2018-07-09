Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C8CC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5F820881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5F820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933012AbeGIJau (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:30:50 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:48974 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932645AbeGIJao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:30:44 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id 8ZWi1y0173XaVaC06ZWiQ4; Mon, 09 Jul 2018 11:30:43 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fcSVG-0002de-NO; Mon, 09 Jul 2018 11:30:42 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fcSVG-00069S-Lc; Mon, 09 Jul 2018 11:30:42 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Greg Ungerer <gerg@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Helge Deller <deller@gmx.de>
Cc:     linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/5] m68k/io: Add missing ioremap define guards, fix typo
Date:   Mon,  9 Jul 2018 11:30:36 +0200
Message-Id: <20180709093040.23597-2-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180709093040.23597-1-geert@linux-m68k.org>
References: <20180709093040.23597-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Add missing define guard for ioremap_wt(),
  - Move ARCH_HAS_IOREMAP_WT from <asm/io_mm.h> to <asm/kmap.h>, as it
    is applicable to Coldfire with MMU, too,
  - Fix typo s/ioremap_fillcache/ioremap_fullcache/,
  - Add define guard for iounmap() for consistency with other
    architectures.

Fixes: 9746882f547d2f00 ("m68k: group io mapping definitions and functions")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2:
  - Move ARCH_HAS_IOREMAP_WT to fix "ioremap_wt redefined" warnings with
    m5475evb defconfig.
---
 arch/m68k/include/asm/io_mm.h | 2 --
 arch/m68k/include/asm/kmap.h  | 6 +++++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/include/asm/io_mm.h b/arch/m68k/include/asm/io_mm.h
index fe485f4f5fac4d92..7e518303786c2d65 100644
--- a/arch/m68k/include/asm/io_mm.h
+++ b/arch/m68k/include/asm/io_mm.h
@@ -21,8 +21,6 @@
 
 #ifdef __KERNEL__
 
-#define ARCH_HAS_IOREMAP_WT
-
 #include <linux/compiler.h>
 #include <asm/raw_io.h>
 #include <asm/virtconvert.h>
diff --git a/arch/m68k/include/asm/kmap.h b/arch/m68k/include/asm/kmap.h
index 84b8333db8ad1987..608e12f058a7cd7d 100644
--- a/arch/m68k/include/asm/kmap.h
+++ b/arch/m68k/include/asm/kmap.h
@@ -4,6 +4,8 @@
 
 #ifdef CONFIG_MMU
 
+#define ARCH_HAS_IOREMAP_WT
+
 /* Values for nocacheflag and cmode */
 #define IOMAP_FULL_CACHING		0
 #define IOMAP_NOCACHE_SER		1
@@ -16,6 +18,7 @@
  */
 extern void __iomem *__ioremap(unsigned long physaddr, unsigned long size,
 			       int cacheflag);
+#define iounmap iounmap
 extern void iounmap(void __iomem *addr);
 extern void __iounmap(void *addr, unsigned long size);
 
@@ -33,13 +36,14 @@ static inline void __iomem *ioremap_nocache(unsigned long physaddr,
 }
 
 #define ioremap_uc ioremap_nocache
+#define ioremap_wt ioremap_wt
 static inline void __iomem *ioremap_wt(unsigned long physaddr,
 				       unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_WRITETHROUGH);
 }
 
-#define ioremap_fillcache ioremap_fullcache
+#define ioremap_fullcache ioremap_fullcache
 static inline void __iomem *ioremap_fullcache(unsigned long physaddr,
 					      unsigned long size)
 {
-- 
2.17.1

