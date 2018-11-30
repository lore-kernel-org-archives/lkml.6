Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC4BC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34802145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="F+2n0I19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34802145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeK3U41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:56:27 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:46192 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeK3U41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:56:27 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id ED84124E204D;
        Fri, 30 Nov 2018 01:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543571263; bh=AQQ/BgUgp5GV5MOoT50HibXrL1H3upummjpjFm9Swx4=;
        h=From:To:Cc:Subject:Date:From;
        b=F+2n0I19lkhCBlZ3HYF1wnrP7E+OBLMZqU6VjN3L33sCtxd+Wo7CTchtBXt2f6BTo
         tY3LctAcEWYBa7XLJDSmnwPmr6VQH2eiewUIvmTr0a51ESxY7ZD8ojrPJOKpdyLQur
         A/cyi3i35KsnV5C2CT+kIkuprJ76l9eoYtPx7QIIyXLi58Is3JRdzXcKkezOuyElsJ
         XQYEgVXMqKVYfYX2246GG288bCVNDzLIpdJ7g+EeXXkBQ0itveR6AFNdC4Zp9qZUYl
         MQJvmNh6df3OqYMpYJIQM11pUd6LTxfYJoRsuvtChVYZ7a0391Pgm7TjRvvigu0AfQ
         zoYEG+CcLhcIQ==
Received: from joabreu-VirtualBox.internal.synopsys.com (joabreu-e7440.internal.synopsys.com [10.107.19.26])
        by mailhost.synopsys.com (Postfix) with ESMTP id D5A2C5DF1;
        Fri, 30 Nov 2018 01:47:41 -0800 (PST)
From:   Jose Abreu <jose.abreu@synopsys.com>
To:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jose Abreu <jose.abreu@synopsys.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH v3] ARC: io.h: Implement reads{x}()/writes{x}()
Date:   Fri, 30 Nov 2018 09:47:31 +0000
Message-Id: <244eba764469e8493f2d0c85a6d965aad6cd8128.1543571088.git.joabreu@synopsys.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Changes from v2:
- Rework commit msg (Vineet)
- Check if count is 0 and return (Vineet)
- Use two different loops (Vineet)

Changes from v1:
- Check if buffer is already aligned (David)
- Remove 64 bit mention (Alexey)

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Tested-by: Vitor Soares <soares@synopsys.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Vitor Soares <soares@synopsys.com>
Cc: David Laight <David.Laight@ACULAB.COM>
---
 arch/arc/include/asm/io.h | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arc/include/asm/io.h b/arch/arc/include/asm/io.h
index c22b181e8206..6c89c31fbe15 100644
--- a/arch/arc/include/asm/io.h
+++ b/arch/arc/include/asm/io.h
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <asm/byteorder.h>
 #include <asm/page.h>
+#include <asm/unaligned.h>
 
 #ifdef CONFIG_ISA_ARCV2
 #include <asm/barrier.h>
@@ -94,6 +95,37 @@ static inline u32 __raw_readl(const volatile void __iomem *addr)
 	return w;
 }
 
+#define __raw_readsx(t,f) \
+static inline void __raw_reads##f(const volatile void __iomem *addr, \
+				  void *buffer, unsigned int count) \
+{ \
+	bool is_aligned = ((unsigned long)buffer % ((t) / 8)) == 0; \
+	u##t *buf = buffer; \
+\
+	if (!count) \
+		return; \
+\
+	/* Some ARC CPU's don't support unaligned accesses */ \
+	if (is_aligned) { \
+		do { \
+			u##t x = __raw_read##f(addr); \
+			*buf++ = x; \
+		} while (--count); \
+	} else { \
+		do { \
+			u##t x = __raw_read##f(addr); \
+			put_unaligned(x, buf++); \
+		} while (--count); \
+	} \
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
@@ -126,6 +158,35 @@ static inline void __raw_writel(u32 w, volatile void __iomem *addr)
 
 }
 
+#define __raw_writesx(t,f) \
+static inline void __raw_writes##f(volatile void __iomem *addr, \
+				   const void *buffer, unsigned int count) \
+{ \
+	bool is_aligned = ((unsigned long)buffer % ((t) / 8)) == 0; \
+	const u##t *buf = buffer; \
+\
+	if (!count) \
+		return; \
+\
+	/* Some ARC CPU's don't support unaligned accesses */ \
+	if (is_aligned) { \
+		do { \
+			__raw_write##f(*buf++, addr); \
+		} while (--count); \
+	} else { \
+		do { \
+			__raw_write##f(get_unaligned(buf++), addr); \
+		} while (--count); \
+	} \
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
@@ -141,10 +202,16 @@ static inline void __raw_writel(u32 w, volatile void __iomem *addr)
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
2.7.4


