Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D090C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD41F20849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675867;
	bh=UvaFHo+6Kpl14ZS36XmaHRf1R+6LY0g7uri8Q/+EvNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TFhXF/erJck47Kft5ozXUY5DmnUIaEJB/wzPIhJsW/AJUTAsXVq/vPHCYBF3qjkYc
	 xbeHUE5x3Fzt9qYpOL2wfOHGJe4GsThd7wY63CFZHmO8zd+Rpc3oXTxp8q5oqzmo5V
	 X+tpHjhV+bV4t+lUl+GD6e32JLdrM9OuQXMnmGkM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD41F20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbeLMEhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:37:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:46012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728075AbeLMEdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:33:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFD5720672;
        Thu, 13 Dec 2018 04:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675589;
        bh=UvaFHo+6Kpl14ZS36XmaHRf1R+6LY0g7uri8Q/+EvNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WkQDwVC+L6M1cijpd7Fywix4zDjf/OSbfLIh+AuWyN2Cvcba7r3in7fKUdMv64tcB
         lrdmcSzH+YHcjmyaav+e+oL/+qiebRlzR+qCkojOuVwAFlZuFzzSAo1gN89eeQpenI
         nCoc496Fog1wQc8x569MXB7mPl61KHfKCuO4W6v8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jose Abreu <joabreu@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH AUTOSEL 4.4 06/23] ARC: io.h: Implement reads{x}()/writes{x}()
Date:   Wed, 12 Dec 2018 23:32:42 -0500
Message-Id: <20181213043259.76643-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043259.76643-1-sashal@kernel.org>
References: <20181213043259.76643-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <joabreu@synopsys.com>

[ Upstream commit 10d443431dc2bb733cf7add99b453e3fb9047a2e ]

Some ARC CPU's do not support unaligned loads/stores. Currently, generic
implementation of reads{b/w/l}()/writes{b/w/l}() is being used with ARC.
This can lead to misfunction of some drivers as generic functions do a
plain dereference of a pointer that can be unaligned.

Let's use {get/put}_unaligned() helpers instead of plain dereference of
pointer in order to fix. The helpers allow to get and store data from an
unaligned address whilst preserving the CPU internal alignment.
According to [1], the use of these helpers are costly in terms of
performance so we added an initial check for a buffer already aligned so
that the usage of the helpers can be avoided, when possible.

[1] Documentation/unaligned-memory-access.txt

Cc: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David Laight <David.Laight@ACULAB.COM>
Tested-by: Vitor Soares <soares@synopsys.com>
Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/include/asm/io.h | 72 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arc/include/asm/io.h b/arch/arc/include/asm/io.h
index cb69299a492e..f120d823e8c2 100644
--- a/arch/arc/include/asm/io.h
+++ b/arch/arc/include/asm/io.h
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <asm/byteorder.h>
 #include <asm/page.h>
+#include <asm/unaligned.h>
 
 #ifdef CONFIG_ISA_ARCV2
 #include <asm/barrier.h>
@@ -85,6 +86,42 @@ static inline u32 __raw_readl(const volatile void __iomem *addr)
 	return w;
 }
 
+/*
+ * {read,write}s{b,w,l}() repeatedly access the same IO address in
+ * native endianness in 8-, 16-, 32-bit chunks {into,from} memory,
+ * @count times
+ */
+#define __raw_readsx(t,f) \
+static inline void __raw_reads##f(const volatile void __iomem *addr,	\
+				  void *ptr, unsigned int count)	\
+{									\
+	bool is_aligned = ((unsigned long)ptr % ((t) / 8)) == 0;	\
+	u##t *buf = ptr;						\
+									\
+	if (!count)							\
+		return;							\
+									\
+	/* Some ARC CPU's don't support unaligned accesses */		\
+	if (is_aligned) {						\
+		do {							\
+			u##t x = __raw_read##f(addr);			\
+			*buf++ = x;					\
+		} while (--count);					\
+	} else {							\
+		do {							\
+			u##t x = __raw_read##f(addr);			\
+			put_unaligned(x, buf++);			\
+		} while (--count);					\
+	}								\
+}
+
+#define __raw_readsb __raw_readsb
+__raw_readsx(8, b)
+#define __raw_readsw __raw_readsw
+__raw_readsx(16, w)
+#define __raw_readsl __raw_readsl
+__raw_readsx(32, l)
+
 #define __raw_writeb __raw_writeb
 static inline void __raw_writeb(u8 b, volatile void __iomem *addr)
 {
@@ -117,6 +154,35 @@ static inline void __raw_writel(u32 w, volatile void __iomem *addr)
 
 }
 
+#define __raw_writesx(t,f)						\
+static inline void __raw_writes##f(volatile void __iomem *addr, 	\
+				   const void *ptr, unsigned int count)	\
+{									\
+	bool is_aligned = ((unsigned long)ptr % ((t) / 8)) == 0;	\
+	const u##t *buf = ptr;						\
+									\
+	if (!count)							\
+		return;							\
+									\
+	/* Some ARC CPU's don't support unaligned accesses */		\
+	if (is_aligned) {						\
+		do {							\
+			__raw_write##f(*buf++, addr);			\
+		} while (--count);					\
+	} else {							\
+		do {							\
+			__raw_write##f(get_unaligned(buf++), addr);	\
+		} while (--count);					\
+	}								\
+}
+
+#define __raw_writesb __raw_writesb
+__raw_writesx(8, b)
+#define __raw_writesw __raw_writesw
+__raw_writesx(16, w)
+#define __raw_writesl __raw_writesl
+__raw_writesx(32, l)
+
 /*
  * MMIO can also get buffered/optimized in micro-arch, so barriers needed
  * Based on ARM model for the typical use case
@@ -132,10 +198,16 @@ static inline void __raw_writel(u32 w, volatile void __iomem *addr)
 #define readb(c)		({ u8  __v = readb_relaxed(c); __iormb(); __v; })
 #define readw(c)		({ u16 __v = readw_relaxed(c); __iormb(); __v; })
 #define readl(c)		({ u32 __v = readl_relaxed(c); __iormb(); __v; })
+#define readsb(p,d,l)		({ __raw_readsb(p,d,l); __iormb(); })
+#define readsw(p,d,l)		({ __raw_readsw(p,d,l); __iormb(); })
+#define readsl(p,d,l)		({ __raw_readsl(p,d,l); __iormb(); })
 
 #define writeb(v,c)		({ __iowmb(); writeb_relaxed(v,c); })
 #define writew(v,c)		({ __iowmb(); writew_relaxed(v,c); })
 #define writel(v,c)		({ __iowmb(); writel_relaxed(v,c); })
+#define writesb(p,d,l)		({ __iowmb(); __raw_writesb(p,d,l); })
+#define writesw(p,d,l)		({ __iowmb(); __raw_writesw(p,d,l); })
+#define writesl(p,d,l)		({ __iowmb(); __raw_writesl(p,d,l); })
 
 /*
  * Relaxed API for drivers which can handle barrier ordering themselves
-- 
2.19.1

