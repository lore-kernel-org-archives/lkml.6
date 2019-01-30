Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7276BC282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49FF620882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbfA3H4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 02:56:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:25882 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbfA3H4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 02:56:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 23:56:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; 
   d="scan'208";a="142623893"
Received: from cvg-ubt08.iil.intel.com (HELO [143.185.152.136]) ([143.185.152.136])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jan 2019 23:56:43 -0800
Subject: Re: [PATCH] lib: 64bit IO
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20190129154102.17655-1-vladimir.kondratiev@linux.intel.com>
 <20190129160130.GA19439@kroah.com>
From:   Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
Message-ID: <da950dbf-1e07-6cdf-7b25-626d77e6c6c3@linux.intel.com>
Date:   Wed, 30 Jan 2019 09:56:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129160130.GA19439@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/29/19 6:01 PM, Greg Kroah-Hartman wrote:
> On Tue, Jan 29, 2019 at 05:41:02PM +0200, Vladimir Kondratiev wrote:
>> implement missing io{read|write}64
>>
>> For 64-bit platforms, these 64-bit io functions are defined in
>> include/asm-generic/iomap.h,
>> but actual implementation missing. Provide it.
> 
> What is in include/asm-generic/io.h?
> 
> $ git grep iowrite64be | grep generic
> include/asm-generic/io.h:#ifndef iowrite64be
> include/asm-generic/io.h:#define iowrite64be iowrite64be
> include/asm-generic/io.h:static inline void iowrite64be(u64 value, volatile void __iomem *addr)
> include/asm-generic/iomap.h:extern void iowrite64be(u64, void __iomem *);
> 
> so are you sure this is needed?
> 
> What code is failing to build for you?

The code you mentioned is under
#ifndef CONFIG_GENERIC_IOMAP

i.e. it works for platforms that does not define CONFIG_GENERIC_IOMAP
This currently defined for quite a lot of platforms, all these should 
not use these inlines and use lib/iomap.c - it selected by the same 
symbol, from lib/Makefile:

obj-$(CONFIG_GENERIC_IOMAP) += iomap.o


linux$ git grep GENERIC_IOMAP | grep Kconfig
arch/hexagon/Kconfig:	select GENERIC_IOMAP
arch/ia64/Kconfig:	select GENERIC_IOMAP
arch/m68k/Kconfig:	select GENERIC_IOMAP
arch/mips/Kconfig:	select GENERIC_IOMAP
arch/openrisc/Kconfig:	select GENERIC_IOMAP
arch/powerpc/platforms/Kconfig:	select GENERIC_IOMAP
arch/unicore32/Kconfig:	select GENERIC_IOMAP
arch/x86/Kconfig:	select GENERIC_IOMAP
lib/Kconfig:config GENERIC_IOMAP

Actually, I am using 64-bit MIPS platform for now, and some pieces of 
code was not compiling without this patch; but this looks like code all 
platforms above need in order to use 64-bit transactions in 
"io{redd|write}xx" style

Also, I figured out most platforms does not bother providing PIO in 
64-bit quantities, so see below version 2 with MMIO-only implementation.

> 
> thanks,
> 
> greg k-h
> 


 From 7f0d31a7cdcc535e0248cb4c4cf8f1d16dc0133d Mon Sep 17 00:00:00 2001
From: Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
Date: Thu, 24 Jan 2019 16:59:20 +0200
Subject: [PATCH v2] lib: 64bit IO

implement missing io{read|write}64

For 64-bit platforms, these 64-bit io functions are defined in
include/asm-generic/iomap.h,
but actual implementation missing. Provide it.
Most platforms does not provide 64-bit PIO functions, thus
implement 64-bit transactions as MMIO only

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
---
  lib/iomap.c | 38 ++++++++++++++++++++++++++++++++++++++
  1 file changed, 38 insertions(+)

diff --git a/lib/iomap.c b/lib/iomap.c
index 541d926da95e..86501bccdf72 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -67,6 +67,9 @@ static void bad_io_access(unsigned long port, const 
char *access)
  #ifndef mmio_read16be
  #define mmio_read16be(addr) be16_to_cpu(__raw_readw(addr))
  #define mmio_read32be(addr) be32_to_cpu(__raw_readl(addr))
+#ifdef CONFIG_64BIT
+#define mmio_read64be(addr) be64_to_cpu(__raw_readq(addr))
+#endif
  #endif

  unsigned int ioread8(void __iomem *addr)
@@ -100,6 +103,22 @@ EXPORT_SYMBOL(ioread16be);
  EXPORT_SYMBOL(ioread32);
  EXPORT_SYMBOL(ioread32be);

+#ifdef CONFIG_64BIT
+
+u64 ioread64(void __iomem *addr)
+{
+	return readq(addr);
+}
+EXPORT_SYMBOL(ioread64);
+
+u64 ioread64be(void __iomem *addr)
+{
+	return mmio_read64be(addr);
+}
+EXPORT_SYMBOL(ioread64be);
+
+#endif /* CONFIG_64BIT */
+
  #ifndef pio_write16be
  #define pio_write16be(val,port) outw(swab16(val),port)
  #define pio_write32be(val,port) outl(swab32(val),port)
@@ -108,6 +127,9 @@ EXPORT_SYMBOL(ioread32be);
  #ifndef mmio_write16be
  #define mmio_write16be(val,port) __raw_writew(be16_to_cpu(val),port)
  #define mmio_write32be(val,port) __raw_writel(be32_to_cpu(val),port)
+#ifdef CONFIG_64BIT
+#define mmio_write64be(val, port) __raw_writeq(be64_to_cpu(val), port)
+#endif
  #endif

  void iowrite8(u8 val, void __iomem *addr)
@@ -136,6 +158,22 @@ EXPORT_SYMBOL(iowrite16be);
  EXPORT_SYMBOL(iowrite32);
  EXPORT_SYMBOL(iowrite32be);

+#ifdef CONFIG_64BIT
+
+void iowrite64(u64 val, void __iomem *addr)
+{
+	writeq(val, addr);
+}
+EXPORT_SYMBOL(iowrite64);
+
+void iowrite64be(u64 val, void __iomem *addr)
+{
+	mmio_write64be(val, addr);
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
