Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E31C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7EF20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7EF20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932847AbeGIJcF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:32:05 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:45012 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932874AbeGIJao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:30:44 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id 8ZWi1y00G3XaVaC01ZWidW; Mon, 09 Jul 2018 11:30:43 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fcSVG-0002dv-R8; Mon, 09 Jul 2018 11:30:42 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fcSVG-00069g-Pl; Mon, 09 Jul 2018 11:30:42 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Greg Ungerer <gerg@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Helge Deller <deller@gmx.de>
Cc:     linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 5/5] m68k/io: Switch mmu variant to <asm-generic/io.h>
Date:   Mon,  9 Jul 2018 11:30:40 +0200
Message-Id: <20180709093040.23597-6-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180709093040.23597-1-geert@linux-m68k.org>
References: <20180709093040.23597-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dummy functions defined in <asm/io_mm.h> can be provided by
<asm-generic/io.h>.

As nommu already uses <asm-generic/io.h>, move its inclusion to
<asm/io.h>, and add/adjust include guards where appropriate.

This gets rid of lots of "statement with no effect" and "unused
variable" warnings when compile-testing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2:
  - No changes.
---
 arch/m68k/include/asm/io.h    |  7 ++++++
 arch/m68k/include/asm/io_mm.h | 40 +++--------------------------------
 arch/m68k/include/asm/io_no.h |  1 -
 3 files changed, 10 insertions(+), 38 deletions(-)

diff --git a/arch/m68k/include/asm/io.h b/arch/m68k/include/asm/io.h
index ca2849afb0877339..aabe6420ead2a599 100644
--- a/arch/m68k/include/asm/io.h
+++ b/arch/m68k/include/asm/io.h
@@ -1,6 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _M68K_IO_H
+#define _M68K_IO_H
+
 #if defined(__uClinux__) || defined(CONFIG_COLDFIRE)
 #include <asm/io_no.h>
 #else
 #include <asm/io_mm.h>
 #endif
+
+#include <asm-generic/io.h>
+
+#endif /* _M68K_IO_H */
diff --git a/arch/m68k/include/asm/io_mm.h b/arch/m68k/include/asm/io_mm.h
index 7e518303786c2d65..782b78f8a04890b3 100644
--- a/arch/m68k/include/asm/io_mm.h
+++ b/arch/m68k/include/asm/io_mm.h
@@ -16,8 +16,8 @@
  *    isa_readX(),isa_writeX()  are for ISA memory
  */
 
-#ifndef _IO_H
-#define _IO_H
+#ifndef _M68K_IO_MM_H
+#define _M68K_IO_MM_H
 
 #ifdef __KERNEL__
 
@@ -367,40 +367,6 @@ static inline void isa_delay(void)
 #define writew(val, addr)	out_le16((addr), (val))
 #endif /* CONFIG_ATARI_ROM_ISA */
 
-#if !defined(CONFIG_ISA) && !defined(CONFIG_ATARI_ROM_ISA)
-/*
- * We need to define dummy functions for GENERIC_IOMAP support.
- */
-#define inb(port)          0xff
-#define inb_p(port)        0xff
-#define outb(val,port)     ((void)0)
-#define outb_p(val,port)   ((void)0)
-#define inw(port)          0xffff
-#define inw_p(port)        0xffff
-#define outw(val,port)     ((void)0)
-#define outw_p(val,port)   ((void)0)
-#define inl(port)          0xffffffffUL
-#define inl_p(port)        0xffffffffUL
-#define outl(val,port)     ((void)0)
-#define outl_p(val,port)   ((void)0)
-
-#define insb(port,buf,nr)  ((void)0)
-#define outsb(port,buf,nr) ((void)0)
-#define insw(port,buf,nr)  ((void)0)
-#define outsw(port,buf,nr) ((void)0)
-#define insl(port,buf,nr)  ((void)0)
-#define outsl(port,buf,nr) ((void)0)
-
-/*
- * These should be valid on any ioremap()ed region
- */
-#define readb(addr)      in_8(addr)
-#define writeb(val,addr) out_8((addr),(val))
-#define readw(addr)      in_le16(addr)
-#define writew(val,addr) out_le16((addr),(val))
-
-#endif /* !CONFIG_ISA && !CONFIG_ATARI_ROM_ISA */
-
 #define readl(addr)      in_le32(addr)
 #define writel(val,addr) out_le32((addr),(val))
 
@@ -442,4 +408,4 @@ static inline void isa_delay(void)
 #define writew_relaxed(b, addr)	writew(b, addr)
 #define writel_relaxed(b, addr)	writel(b, addr)
 
-#endif /* _IO_H */
+#endif /* _M68K_IO_MM_H */
diff --git a/arch/m68k/include/asm/io_no.h b/arch/m68k/include/asm/io_no.h
index c207428fae5953e7..0498192e1d983292 100644
--- a/arch/m68k/include/asm/io_no.h
+++ b/arch/m68k/include/asm/io_no.h
@@ -133,6 +133,5 @@ static inline void writel(u32 value, volatile void __iomem *addr)
 
 #include <asm/kmap.h>
 #include <asm/virtconvert.h>
-#include <asm-generic/io.h>
 
 #endif /* _M68KNOMMU_IO_H */
-- 
2.17.1

