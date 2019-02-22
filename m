Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94748C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F72A2075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfBVSFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:05:03 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38156 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727628AbfBVSFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:05:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B479165C;
        Fri, 22 Feb 2019 10:05:01 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 008523F5C1;
        Fri, 22 Feb 2019 10:04:59 -0800 (PST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-arch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andrew.murray@arm.com, arnd@arndb.de,
        catalin.marinas@arm.com, geert@linux-m68k.org, palmer@sifive.com,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 1/3] asm-generic/io: Pass result of I/O accessor to __io_[p]ar()
Date:   Fri, 22 Feb 2019 18:04:52 +0000
Message-Id: <20190222180454.5992-2-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190222180454.5992-1-will.deacon@arm.com>
References: <20190222180454.5992-1-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inX() and readX() I/O accessors must enforce ordering against
subsequent calls to the delay() routines, so that a read-back from a
device can be used to postpone a subsequent write to the same device.

On some architectures, including arm64, this ordering can only be
achieved by creating a dependency on the value returned by the I/O
accessor operation, so we need to pass the value we read to the
__io_par() and __io_ar() macros in these cases.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/io.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index d356f802945a..303871651f8a 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -32,9 +32,9 @@
 /* prevent prefetching of coherent DMA data ahead of a dma-complete */
 #ifndef __io_ar
 #ifdef rmb
-#define __io_ar()      rmb()
+#define __io_ar(v)      rmb()
 #else
-#define __io_ar()      barrier()
+#define __io_ar(v)      barrier()
 #endif
 #endif
 
@@ -65,7 +65,7 @@
 #endif
 
 #ifndef __io_par
-#define __io_par()     __io_ar()
+#define __io_par(v)     __io_ar(v)
 #endif
 
 
@@ -158,7 +158,7 @@ static inline u8 readb(const volatile void __iomem *addr)
 
 	__io_br();
 	val = __raw_readb(addr);
-	__io_ar();
+	__io_ar(val);
 	return val;
 }
 #endif
@@ -171,7 +171,7 @@ static inline u16 readw(const volatile void __iomem *addr)
 
 	__io_br();
 	val = __le16_to_cpu(__raw_readw(addr));
-	__io_ar();
+	__io_ar(val);
 	return val;
 }
 #endif
@@ -184,7 +184,7 @@ static inline u32 readl(const volatile void __iomem *addr)
 
 	__io_br();
 	val = __le32_to_cpu(__raw_readl(addr));
-	__io_ar();
+	__io_ar(val);
 	return val;
 }
 #endif
@@ -198,7 +198,7 @@ static inline u64 readq(const volatile void __iomem *addr)
 
 	__io_br();
 	val = __le64_to_cpu(__raw_readq(addr));
-	__io_ar();
+	__io_ar(val);
 	return val;
 }
 #endif
@@ -471,7 +471,7 @@ static inline u8 inb(unsigned long addr)
 
 	__io_pbr();
 	val = __raw_readb(PCI_IOBASE + addr);
-	__io_par();
+	__io_par(val);
 	return val;
 }
 #endif
@@ -484,7 +484,7 @@ static inline u16 inw(unsigned long addr)
 
 	__io_pbr();
 	val = __le16_to_cpu(__raw_readw(PCI_IOBASE + addr));
-	__io_par();
+	__io_par(val);
 	return val;
 }
 #endif
@@ -497,7 +497,7 @@ static inline u32 inl(unsigned long addr)
 
 	__io_pbr();
 	val = __le32_to_cpu(__raw_readl(PCI_IOBASE + addr));
-	__io_par();
+	__io_par(val);
 	return val;
 }
 #endif
-- 
2.11.0

