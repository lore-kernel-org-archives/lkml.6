Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5359C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1EB218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfA2Pne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:43:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:43986 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfA2Pne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:43:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 07:43:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="270859494"
Received: from cvg-ubt08.iil.intel.com ([143.185.152.136])
  by orsmga004.jf.intel.com with ESMTP; 29 Jan 2019 07:43:32 -0800
From:   Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
Subject: [PATCH] lib: 64bit IO
Date:   Tue, 29 Jan 2019 17:41:02 +0200
Message-Id: <20190129154102.17655-1-vladimir.kondratiev@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

implement missing io{read|write}64

For 64-bit platforms, these 64-bit io functions are defined in
include/asm-generic/iomap.h,
but actual implementation missing. Provide it.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
---
 lib/iomap.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/lib/iomap.c b/lib/iomap.c
index 541d926da95e..5e2b0bcc5561 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -62,11 +62,17 @@ static void bad_io_access(unsigned long port, const char *access)
 #ifndef pio_read16be
 #define pio_read16be(port) swab16(inw(port))
 #define pio_read32be(port) swab32(inl(port))
+#ifdef CONFIG_64BIT
+#define pio_read64be(port) swab64(inq(port))
+#endif
 #endif
 
 #ifndef mmio_read16be
 #define mmio_read16be(addr) be16_to_cpu(__raw_readw(addr))
 #define mmio_read32be(addr) be32_to_cpu(__raw_readl(addr))
+#ifdef CONFIG_64BIT
+#define mmio_read64be(addr) be64_to_cpu(__raw_readq(addr))
+#endif
 #endif
 
 unsigned int ioread8(void __iomem *addr)
@@ -100,14 +106,38 @@ EXPORT_SYMBOL(ioread16be);
 EXPORT_SYMBOL(ioread32);
 EXPORT_SYMBOL(ioread32be);
 
+#ifdef CONFIG_64BIT
+
+u64 ioread64(void __iomem *addr)
+{
+	IO_COND(addr, return inq(port), return readq(addr));
+	return 0xffffffffffffffffULL;
+}
+EXPORT_SYMBOL(ioread64);
+
+u64 ioread64be(void __iomem *addr)
+{
+	IO_COND(addr, return pio_read64be(port), return mmio_read64be(addr));
+	return 0xffffffffffffffffULL;
+}
+EXPORT_SYMBOL(ioread64be);
+
+#endif /* CONFIG_64BIT */
+
 #ifndef pio_write16be
 #define pio_write16be(val,port) outw(swab16(val),port)
 #define pio_write32be(val,port) outl(swab32(val),port)
+#ifdef CONFIG_64BIT
+#define pio_write64be(val, port) outq(swab64(val), port)
+#endif
 #endif
 
 #ifndef mmio_write16be
 #define mmio_write16be(val,port) __raw_writew(be16_to_cpu(val),port)
 #define mmio_write32be(val,port) __raw_writel(be32_to_cpu(val),port)
+#ifdef CONFIG_64BIT
+#define mmio_write64be(val, port) __raw_writeq(be64_to_cpu(val), port)
+#endif
 #endif
 
 void iowrite8(u8 val, void __iomem *addr)
@@ -136,6 +166,22 @@ EXPORT_SYMBOL(iowrite16be);
 EXPORT_SYMBOL(iowrite32);
 EXPORT_SYMBOL(iowrite32be);
 
+#ifdef CONFIG_64BIT
+
+void iowrite64(u64 val, void __iomem *addr)
+{
+	IO_COND(addr, outq(val, port), writeq(val, addr));
+}
+EXPORT_SYMBOL(iowrite64);
+
+void iowrite64be(u64 val, void __iomem *addr)
+{
+	IO_COND(addr, pio_write64be(val, port), mmio_write64be(val, addr));
+}
+EXPORT_SYMBOL(iowrite64be);
+
+#endif /* CONFIG_64BIT */
+
 /*
  * These are the "repeat MMIO read/write" functions.
  * Note the "__raw" accesses, since we don't want to
-- 
2.19.1

