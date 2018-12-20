Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C98C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0F52177B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297701;
	bh=1dS13HZUWetKkp9ROyo/Mh64t/RVMRwlQ0PzimDx4Nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nvngK0w6ADedW9p/xLwAqawsutjd0h7yQEIXRmRpLHlCBhXRFyshlddpSlpTjt3Z4
	 j0h7PjI6wXesLP/WAUC+36ddK+dgJNapJ1gEzwN5W1hI1iEF3FwPw+d0Za2YvLE4zR
	 ZaaxYhMJpe0TEVNo/XPFxhWJkaDcsM+5Kx1U6Yiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbeLTJVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:21:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:35692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731089AbeLTJVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:21:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41CD92177E;
        Thu, 20 Dec 2018 09:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297696;
        bh=1dS13HZUWetKkp9ROyo/Mh64t/RVMRwlQ0PzimDx4Nc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rghZRBJkeu1UeZkUO9Ev82HQa05vb5du/mnzJNsMathlsKJI01do1A6V21KvV/b3D
         P7Nv9ACinKp82sRT33qIvhSXUl3TWul9Xm8gI69tChFjUDMlNK4Oxkaf2fnAcaeVFw
         R7i+Wf7Pa0KMAI7bnbSge4LSTtzLXGrbJIOXVGhc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Vitor Soares <soares@synopsys.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 23/40] ARC: io.h: Implement reads{x}()/writes{x}()
Date:   Thu, 20 Dec 2018 10:18:35 +0100
Message-Id: <20181220085827.392017746@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
References: <20181220085826.212663515@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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



