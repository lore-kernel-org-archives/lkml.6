Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D85ECDE2F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 00:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D952088F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 00:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D952088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeJHHqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 03:46:36 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:37360 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725754AbeJHHqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 03:46:36 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23994427AbeJHAhX0GPlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 02:37:23 +0200
Date:   Mon, 8 Oct 2018 01:37:23 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] MIPS: Provide actually relaxed MMIO accessors
In-Reply-To: <alpine.LFD.2.21.1810070229190.7757@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.21.1810070328410.7757@eddie.linux-mips.org>
References: <alpine.LFD.2.21.1810070229190.7757@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve performance for the relevant systems and remove the DMA ordering 
barrier from `readX_relaxed' and `writeX_relaxed' MMIO accessors, where 
it is not needed according to our requirements[1].  For consistency make 
the same arrangement with low-level port I/O accessors, but do not 
actually provide any accessors making use of it.

References:

[1] "LINUX KERNEL MEMORY BARRIERS", Documentation/memory-barriers.txt,
    Section "KERNEL I/O BARRIER EFFECTS"

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 arch/mips/include/asm/io.h |   48 ++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

linux-mips-readx-writex-relaxed.patch
Index: linux-20180930-3maxp/arch/mips/include/asm/io.h
===================================================================
--- linux-20180930-3maxp.orig/arch/mips/include/asm/io.h
+++ linux-20180930-3maxp/arch/mips/include/asm/io.h
@@ -51,6 +51,11 @@
 # define __raw_ioswabq(a, x)	(x)
 # define ____raw_ioswabq(a, x)	(x)
 
+# define __relaxed_ioswabb ioswabb
+# define __relaxed_ioswabw ioswabw
+# define __relaxed_ioswabl ioswabl
+# define __relaxed_ioswabq ioswabq
+
 /* ioswab[bwlq], __mem_ioswab[bwlq] are defined in mangle-port.h */
 
 #define IO_SPACE_LIMIT 0xffff
@@ -337,7 +342,7 @@ static inline void iounmap(const volatil
 #define war_io_reorder_wmb()		barrier()
 #endif
 
-#define __BUILD_MEMORY_SINGLE(pfx, bwlq, type, barrier, irq)		\
+#define __BUILD_MEMORY_SINGLE(pfx, bwlq, type, barrier, relax, irq)	\
 									\
 static inline void pfx##write##bwlq(type val,				\
 				    volatile void __iomem *mem)		\
@@ -411,11 +416,12 @@ static inline type pfx##read##bwlq(const
 	}								\
 									\
 	/* prevent prefetching of coherent DMA data prematurely */	\
-	rmb();								\
+	if (!relax)							\
+		rmb();							\
 	return pfx##ioswab##bwlq(__mem, __val);				\
 }
 
-#define __BUILD_IOPORT_SINGLE(pfx, bwlq, type, barrier, p, slow)		\
+#define __BUILD_IOPORT_SINGLE(pfx, bwlq, type, barrier, relax, p, slow)	\
 									\
 static inline void pfx##out##bwlq##p(type val, unsigned long port)	\
 {									\
@@ -454,19 +460,21 @@ static inline type pfx##in##bwlq##p(unsi
 	slow;								\
 									\
 	/* prevent prefetching of coherent DMA data prematurely */	\
-	rmb();								\
+	if (!relax)							\
+		rmb();							\
 	return pfx##ioswab##bwlq(__addr, __val);			\
 }
 
-#define __BUILD_MEMORY_PFX(bus, bwlq, type)				\
+#define __BUILD_MEMORY_PFX(bus, bwlq, type, relax)			\
 									\
-__BUILD_MEMORY_SINGLE(bus, bwlq, type, 1, 1)
+__BUILD_MEMORY_SINGLE(bus, bwlq, type, 1, relax, 1)
 
 #define BUILDIO_MEM(bwlq, type)						\
 									\
-__BUILD_MEMORY_PFX(__raw_, bwlq, type)					\
-__BUILD_MEMORY_PFX(, bwlq, type)					\
-__BUILD_MEMORY_PFX(__mem_, bwlq, type)					\
+__BUILD_MEMORY_PFX(__raw_, bwlq, type, 0)				\
+__BUILD_MEMORY_PFX(__relaxed_, bwlq, type, 1)				\
+__BUILD_MEMORY_PFX(__mem_, bwlq, type, 0)				\
+__BUILD_MEMORY_PFX(, bwlq, type, 0)
 
 BUILDIO_MEM(b, u8)
 BUILDIO_MEM(w, u16)
@@ -474,8 +482,8 @@ BUILDIO_MEM(l, u32)
 BUILDIO_MEM(q, u64)
 
 #define __BUILD_IOPORT_PFX(bus, bwlq, type)				\
-	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 1, ,)			\
-	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 1, _p, SLOW_DOWN_IO)
+	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 1, 0, ,)			\
+	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 1, 0, _p, SLOW_DOWN_IO)
 
 #define BUILDIO_IOPORT(bwlq, type)					\
 	__BUILD_IOPORT_PFX(, bwlq, type)				\
@@ -490,19 +498,19 @@ BUILDIO_IOPORT(q, u64)
 
 #define __BUILDIO(bwlq, type)						\
 									\
-__BUILD_MEMORY_SINGLE(____raw_, bwlq, type, 1, 0)
+__BUILD_MEMORY_SINGLE(____raw_, bwlq, type, 1, 0, 0)
 
 __BUILDIO(q, u64)
 
-#define readb_relaxed			readb
-#define readw_relaxed			readw
-#define readl_relaxed			readl
-#define readq_relaxed			readq
+#define readb_relaxed			__relaxed_readb
+#define readw_relaxed			__relaxed_readw
+#define readl_relaxed			__relaxed_readl
+#define readq_relaxed			__relaxed_readq
 
-#define writeb_relaxed			writeb
-#define writew_relaxed			writew
-#define writel_relaxed			writel
-#define writeq_relaxed			writeq
+#define writeb_relaxed			__relaxed_writeb
+#define writew_relaxed			__relaxed_writew
+#define writel_relaxed			__relaxed_writel
+#define writeq_relaxed			__relaxed_writeq
 
 #define readb_be(addr)							\
 	__raw_readb((__force unsigned *)(addr))
