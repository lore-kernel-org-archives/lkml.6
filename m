Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1C9C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E6120878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E6120878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbeJCF07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:26:59 -0400
Received: from ale.deltatee.com ([207.54.116.67]:38182 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728259AbeJCF06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:26:58 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1g7TLu-0003R6-Jd; Tue, 02 Oct 2018 16:41:18 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1g7TLp-0000sV-Hz; Tue, 02 Oct 2018 16:41:09 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Suresh Warrier <warrier@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>
Date:   Tue,  2 Oct 2018 16:41:05 -0600
Message-Id: <20181002224108.3321-4-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002224108.3321-1-logang@deltatee.com>
References: <20181002224108.3321-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, akpm@linux-foundation.org, arnd@arndb.de, gregkh@linuxfoundation.org, horia.geanta@nxp.com, logang@deltatee.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, warrier@linux.vnet.ibm.com, andy.shevchenko@gmail.com, npiggin@gmail.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v22 3/6] iomap: introduce io{read|write}64_{lo_hi|hi_lo}
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to provide non-atomic functions for io{read|write}64 that will
use readq and writeq when appropriate. We define a number of variants
of these functions in the generic iomap that will do non-atomic
operations on pio but atomic operations on mmio.

These functions are only defined if readq and writeq are defined. If
they are not, then the wrappers that always use non-atomic operations
from include/linux/io-64-nonatomic*.h will be used.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Suresh Warrier <warrier@linux.vnet.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/io.h |   2 +
 include/asm-generic/iomap.h   |  22 ++++++
 lib/iomap.c                   | 132 ++++++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index e0331e754568..20fe5d7515db 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -798,8 +798,10 @@ extern void __iounmap_at(void *ea, unsigned long size);
 
 #define mmio_read16be(addr)		readw_be(addr)
 #define mmio_read32be(addr)		readl_be(addr)
+#define mmio_read64be(addr)		readq_be(addr)
 #define mmio_write16be(val, addr)	writew_be(val, addr)
 #define mmio_write32be(val, addr)	writel_be(val, addr)
+#define mmio_write64be(val, addr)	writeq_be(val, addr)
 #define mmio_insb(addr, dst, count)	readsb(addr, dst, count)
 #define mmio_insw(addr, dst, count)	readsw(addr, dst, count)
 #define mmio_insl(addr, dst, count)	readsl(addr, dst, count)
diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
index 5b63b94ef6b5..a008f504a2d0 100644
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -36,6 +36,17 @@ extern u64 ioread64(void __iomem *);
 extern u64 ioread64be(void __iomem *);
 #endif
 
+#ifdef readq
+#define ioread64_lo_hi ioread64_lo_hi
+#define ioread64_hi_lo ioread64_hi_lo
+#define ioread64be_lo_hi ioread64be_lo_hi
+#define ioread64be_hi_lo ioread64be_hi_lo
+extern u64 ioread64_lo_hi(void __iomem *addr);
+extern u64 ioread64_hi_lo(void __iomem *addr);
+extern u64 ioread64be_lo_hi(void __iomem *addr);
+extern u64 ioread64be_hi_lo(void __iomem *addr);
+#endif
+
 extern void iowrite8(u8, void __iomem *);
 extern void iowrite16(u16, void __iomem *);
 extern void iowrite16be(u16, void __iomem *);
@@ -46,6 +57,17 @@ extern void iowrite64(u64, void __iomem *);
 extern void iowrite64be(u64, void __iomem *);
 #endif
 
+#ifdef writeq
+#define iowrite64_lo_hi iowrite64_lo_hi
+#define iowrite64_hi_lo iowrite64_hi_lo
+#define iowrite64be_lo_hi iowrite64be_lo_hi
+#define iowrite64be_hi_lo iowrite64be_hi_lo
+extern void iowrite64_lo_hi(u64 val, void __iomem *addr);
+extern void iowrite64_hi_lo(u64 val, void __iomem *addr);
+extern void iowrite64be_lo_hi(u64 val, void __iomem *addr);
+extern void iowrite64be_hi_lo(u64 val, void __iomem *addr);
+#endif
+
 /*
  * "string" versions of the above. Note that they
  * use native byte ordering for the accesses (on
diff --git a/lib/iomap.c b/lib/iomap.c
index 2c293b22569f..e909ab71e995 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -67,6 +67,7 @@ static void bad_io_access(unsigned long port, const char *access)
 #ifndef mmio_read16be
 #define mmio_read16be(addr) swab16(readw(addr))
 #define mmio_read32be(addr) swab32(readl(addr))
+#define mmio_read64be(addr) swab64(readq(addr))
 #endif
 
 unsigned int ioread8(void __iomem *addr)
@@ -100,6 +101,80 @@ EXPORT_SYMBOL(ioread16be);
 EXPORT_SYMBOL(ioread32);
 EXPORT_SYMBOL(ioread32be);
 
+#ifdef readq
+static u64 pio_read64_lo_hi(unsigned long port)
+{
+	u64 lo, hi;
+
+	lo = inl(port);
+	hi = inl(port + sizeof(u32));
+
+	return lo | (hi << 32);
+}
+
+static u64 pio_read64_hi_lo(unsigned long port)
+{
+	u64 lo, hi;
+
+	hi = inl(port + sizeof(u32));
+	lo = inl(port);
+
+	return lo | (hi << 32);
+}
+
+static u64 pio_read64be_lo_hi(unsigned long port)
+{
+	u64 lo, hi;
+
+	lo = pio_read32be(port + sizeof(u32));
+	hi = pio_read32be(port);
+
+	return lo | (hi << 32);
+}
+
+static u64 pio_read64be_hi_lo(unsigned long port)
+{
+	u64 lo, hi;
+
+	hi = pio_read32be(port);
+	lo = pio_read32be(port + sizeof(u32));
+
+	return lo | (hi << 32);
+}
+
+u64 ioread64_lo_hi(void __iomem *addr)
+{
+	IO_COND(addr, return pio_read64_lo_hi(port), return readq(addr));
+	return 0xffffffffffffffffULL;
+}
+
+u64 ioread64_hi_lo(void __iomem *addr)
+{
+	IO_COND(addr, return pio_read64_hi_lo(port), return readq(addr));
+	return 0xffffffffffffffffULL;
+}
+
+u64 ioread64be_lo_hi(void __iomem *addr)
+{
+	IO_COND(addr, return pio_read64be_lo_hi(port),
+		return mmio_read64be(addr));
+	return 0xffffffffffffffffULL;
+}
+
+u64 ioread64be_hi_lo(void __iomem *addr)
+{
+	IO_COND(addr, return pio_read64be_hi_lo(port),
+		return mmio_read64be(addr));
+	return 0xffffffffffffffffULL;
+}
+
+EXPORT_SYMBOL(ioread64_lo_hi);
+EXPORT_SYMBOL(ioread64_hi_lo);
+EXPORT_SYMBOL(ioread64be_lo_hi);
+EXPORT_SYMBOL(ioread64be_hi_lo);
+
+#endif /* readq */
+
 #ifndef pio_write16be
 #define pio_write16be(val,port) outw(swab16(val),port)
 #define pio_write32be(val,port) outl(swab32(val),port)
@@ -108,6 +183,7 @@ EXPORT_SYMBOL(ioread32be);
 #ifndef mmio_write16be
 #define mmio_write16be(val,port) writew(swab16(val),port)
 #define mmio_write32be(val,port) writel(swab32(val),port)
+#define mmio_write64be(val,port) writeq(swab64(val),port)
 #endif
 
 void iowrite8(u8 val, void __iomem *addr)
@@ -136,6 +212,62 @@ EXPORT_SYMBOL(iowrite16be);
 EXPORT_SYMBOL(iowrite32);
 EXPORT_SYMBOL(iowrite32be);
 
+#ifdef writeq
+static void pio_write64_lo_hi(u64 val, unsigned long port)
+{
+	outl(val, port);
+	outl(val >> 32, port + sizeof(u32));
+}
+
+static void pio_write64_hi_lo(u64 val, unsigned long port)
+{
+	outl(val >> 32, port + sizeof(u32));
+	outl(val, port);
+}
+
+static void pio_write64be_lo_hi(u64 val, unsigned long port)
+{
+	pio_write32be(val, port + sizeof(u32));
+	pio_write32be(val >> 32, port);
+}
+
+static void pio_write64be_hi_lo(u64 val, unsigned long port)
+{
+	pio_write32be(val >> 32, port);
+	pio_write32be(val, port + sizeof(u32));
+}
+
+void iowrite64_lo_hi(u64 val, void __iomem *addr)
+{
+	IO_COND(addr, pio_write64_lo_hi(val, port),
+		writeq(val, addr));
+}
+
+void iowrite64_hi_lo(u64 val, void __iomem *addr)
+{
+	IO_COND(addr, pio_write64_hi_lo(val, port),
+		writeq(val, addr));
+}
+
+void iowrite64be_lo_hi(u64 val, void __iomem *addr)
+{
+	IO_COND(addr, pio_write64be_lo_hi(val, port),
+		mmio_write64be(val, addr));
+}
+
+void iowrite64be_hi_lo(u64 val, void __iomem *addr)
+{
+	IO_COND(addr, pio_write64be_hi_lo(val, port),
+		mmio_write64be(val, addr));
+}
+
+EXPORT_SYMBOL(iowrite64_lo_hi);
+EXPORT_SYMBOL(iowrite64_hi_lo);
+EXPORT_SYMBOL(iowrite64be_lo_hi);
+EXPORT_SYMBOL(iowrite64be_hi_lo);
+
+#endif /* readq */
+
 /*
  * These are the "repeat MMIO read/write" functions.
  * Note the "__raw" accesses, since we don't want to
-- 
2.19.0

