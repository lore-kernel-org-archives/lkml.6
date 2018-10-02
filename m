Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73356C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3625C20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3625C20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeJCF05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:26:57 -0400
Received: from ale.deltatee.com ([207.54.116.67]:38156 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbeJCF04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:26:56 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1g7TLu-0003R5-8a; Tue, 02 Oct 2018 16:41:16 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1g7TLp-0000sS-Dd; Tue, 02 Oct 2018 16:41:09 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Tue,  2 Oct 2018 16:41:04 -0600
Message-Id: <20181002224108.3321-3-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002224108.3321-1-logang@deltatee.com>
References: <20181002224108.3321-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, akpm@linux-foundation.org, arnd@arndb.de, andy.shevchenko@gmail.com, horia.geanta@nxp.com, logang@deltatee.com, jejb@parisc-linux.org, pombredanne@nexb.com, gregkh@linuxfoundation.org, kstewart@linuxfoundation.org, tglx@linutronix.de
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v22 2/6] parisc: iomap: introduce io{read|write}64
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for io{read|write}64() functions in parisc architecture.
These are pretty straightforward copies of similar functions which
make use of readq and writeq.

Also, indicate that the lo_hi and hi_lo variants of these functions
are not provided by this architecture.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Helge Deller <deller@gmx.de>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/parisc/include/asm/io.h |  9 +++++
 arch/parisc/lib/iomap.c      | 64 ++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index afe493b23d04..30a8315d5c07 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -311,6 +311,15 @@ extern void outsl (unsigned long port, const void *src, unsigned long count);
  * value for either 32 or 64 bit mode */
 #define F_EXTEND(x) ((unsigned long)((x) | (0xffffffff00000000ULL)))
 
+#define ioread64 ioread64
+#define ioread64be ioread64be
+#define iowrite64 iowrite64
+#define iowrite64be iowrite64be
+extern u64 ioread64(void __iomem *addr);
+extern u64 ioread64be(void __iomem *addr);
+extern void iowrite64(u64 val, void __iomem *addr);
+extern void iowrite64be(u64 val, void __iomem *addr);
+
 #include <asm-generic/iomap.h>
 
 /*
diff --git a/arch/parisc/lib/iomap.c b/arch/parisc/lib/iomap.c
index 4b19e6e64fb7..0195aec657e2 100644
--- a/arch/parisc/lib/iomap.c
+++ b/arch/parisc/lib/iomap.c
@@ -48,11 +48,15 @@ struct iomap_ops {
 	unsigned int (*read16be)(void __iomem *);
 	unsigned int (*read32)(void __iomem *);
 	unsigned int (*read32be)(void __iomem *);
+	u64 (*read64)(void __iomem *);
+	u64 (*read64be)(void __iomem *);
 	void (*write8)(u8, void __iomem *);
 	void (*write16)(u16, void __iomem *);
 	void (*write16be)(u16, void __iomem *);
 	void (*write32)(u32, void __iomem *);
 	void (*write32be)(u32, void __iomem *);
+	void (*write64)(u64, void __iomem *);
+	void (*write64be)(u64, void __iomem *);
 	void (*read8r)(void __iomem *, void *, unsigned long);
 	void (*read16r)(void __iomem *, void *, unsigned long);
 	void (*read32r)(void __iomem *, void *, unsigned long);
@@ -171,6 +175,16 @@ static unsigned int iomem_read32be(void __iomem *addr)
 	return __raw_readl(addr);
 }
 
+static u64 iomem_read64(void __iomem *addr)
+{
+	return readq(addr);
+}
+
+static u64 iomem_read64be(void __iomem *addr)
+{
+	return __raw_readq(addr);
+}
+
 static void iomem_write8(u8 datum, void __iomem *addr)
 {
 	writeb(datum, addr);
@@ -196,6 +210,16 @@ static void iomem_write32be(u32 datum, void __iomem *addr)
 	__raw_writel(datum, addr);
 }
 
+static void iomem_write64(u64 datum, void __iomem *addr)
+{
+	writel(datum, addr);
+}
+
+static void iomem_write64be(u64 datum, void __iomem *addr)
+{
+	__raw_writel(datum, addr);
+}
+
 static void iomem_read8r(void __iomem *addr, void *dst, unsigned long count)
 {
 	while (count--) {
@@ -250,11 +274,15 @@ static const struct iomap_ops iomem_ops = {
 	.read16be = iomem_read16be,
 	.read32 = iomem_read32,
 	.read32be = iomem_read32be,
+	.read64 = iomem_read64,
+	.read64be = iomem_read64be,
 	.write8 = iomem_write8,
 	.write16 = iomem_write16,
 	.write16be = iomem_write16be,
 	.write32 = iomem_write32,
 	.write32be = iomem_write32be,
+	.write64 = iomem_write64,
+	.write64be = iomem_write64be,
 	.read8r = iomem_read8r,
 	.read16r = iomem_read16r,
 	.read32r = iomem_read32r,
@@ -304,6 +332,20 @@ unsigned int ioread32be(void __iomem *addr)
 	return *((u32 *)addr);
 }
 
+u64 ioread64(void __iomem *addr)
+{
+	if (unlikely(INDIRECT_ADDR(addr)))
+		return iomap_ops[ADDR_TO_REGION(addr)]->read64(addr);
+	return le64_to_cpup((u64 *)addr);
+}
+
+u64 ioread64be(void __iomem *addr)
+{
+	if (unlikely(INDIRECT_ADDR(addr)))
+		return iomap_ops[ADDR_TO_REGION(addr)]->read64be(addr);
+	return *((u64 *)addr);
+}
+
 void iowrite8(u8 datum, void __iomem *addr)
 {
 	if (unlikely(INDIRECT_ADDR(addr))) {
@@ -349,6 +391,24 @@ void iowrite32be(u32 datum, void __iomem *addr)
 	}
 }
 
+void iowrite64(u64 datum, void __iomem *addr)
+{
+	if (unlikely(INDIRECT_ADDR(addr))) {
+		iomap_ops[ADDR_TO_REGION(addr)]->write64(datum, addr);
+	} else {
+		*((u64 *)addr) = cpu_to_le64(datum);
+	}
+}
+
+void iowrite64be(u64 datum, void __iomem *addr)
+{
+	if (unlikely(INDIRECT_ADDR(addr))) {
+		iomap_ops[ADDR_TO_REGION(addr)]->write64be(datum, addr);
+	} else {
+		*((u64 *)addr) = datum;
+	}
+}
+
 /* Repeating interfaces */
 
 void ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
@@ -449,11 +509,15 @@ EXPORT_SYMBOL(ioread16);
 EXPORT_SYMBOL(ioread16be);
 EXPORT_SYMBOL(ioread32);
 EXPORT_SYMBOL(ioread32be);
+EXPORT_SYMBOL(ioread64);
+EXPORT_SYMBOL(ioread64be);
 EXPORT_SYMBOL(iowrite8);
 EXPORT_SYMBOL(iowrite16);
 EXPORT_SYMBOL(iowrite16be);
 EXPORT_SYMBOL(iowrite32);
 EXPORT_SYMBOL(iowrite32be);
+EXPORT_SYMBOL(iowrite64);
+EXPORT_SYMBOL(iowrite64be);
 EXPORT_SYMBOL(ioread8_rep);
 EXPORT_SYMBOL(ioread16_rep);
 EXPORT_SYMBOL(ioread32_rep);
-- 
2.19.0

