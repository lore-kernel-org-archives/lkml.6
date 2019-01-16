Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F67C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0448F206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbfAPS0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:26:25 -0500
Received: from ale.deltatee.com ([207.54.116.67]:35078 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbfAPSZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:25:34 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gjpsW-0003NE-NA; Wed, 16 Jan 2019 11:25:33 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gjpsU-00054d-64; Wed, 16 Jan 2019 11:25:26 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Date:   Wed, 16 Jan 2019 11:25:21 -0700
Message-Id: <20190116182523.19446-5-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190116182523.19446-1-logang@deltatee.com>
References: <20190116182523.19446-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, arnd@arndb.de, gregkh@linuxfoundation.org, andy.shevchenko@gmail.com, horia.geanta@nxp.com, logang@deltatee.com, hch@lst.de, gnomes@lxorguk.ukuu.org.uk
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v25 4/6] io-64-nonatomic: add io{read|write}64[be]{_lo_hi|_hi_lo} macros
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds generic io{read|write}64[be]{_lo_hi|_hi_lo} macros if
they are not already defined by the architecture. (As they are provided
by the generic iomap library).

The patch also points io{read|write}64[be] to the variant specified by the
header name.

This is because new drivers are encouraged to use ioreadXX, et al instead
of readX[1], et al -- and mixing ioreadXX with readq is pretty ugly.

[1] LDD3: section 9.4.2

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/io-64-nonatomic-hi-lo.h | 64 +++++++++++++++++++++++++++
 include/linux/io-64-nonatomic-lo-hi.h | 64 +++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)

diff --git a/include/linux/io-64-nonatomic-hi-lo.h b/include/linux/io-64-nonatomic-hi-lo.h
index 862d786a904f..ae21b72cce85 100644
--- a/include/linux/io-64-nonatomic-hi-lo.h
+++ b/include/linux/io-64-nonatomic-hi-lo.h
@@ -55,4 +55,68 @@ static inline void hi_lo_writeq_relaxed(__u64 val, volatile void __iomem *addr)
 #define writeq_relaxed hi_lo_writeq_relaxed
 #endif
 
+#ifndef ioread64_hi_lo
+#define ioread64_hi_lo ioread64_hi_lo
+static inline u64 ioread64_hi_lo(void __iomem *addr)
+{
+	u32 low, high;
+
+	high = ioread32(addr + sizeof(u32));
+	low = ioread32(addr);
+
+	return low + ((u64)high << 32);
+}
+#endif
+
+#ifndef iowrite64_hi_lo
+#define iowrite64_hi_lo iowrite64_hi_lo
+static inline void iowrite64_hi_lo(u64 val, void __iomem *addr)
+{
+	iowrite32(val >> 32, addr + sizeof(u32));
+	iowrite32(val, addr);
+}
+#endif
+
+#ifndef ioread64be_hi_lo
+#define ioread64be_hi_lo ioread64be_hi_lo
+static inline u64 ioread64be_hi_lo(void __iomem *addr)
+{
+	u32 low, high;
+
+	high = ioread32be(addr);
+	low = ioread32be(addr + sizeof(u32));
+
+	return low + ((u64)high << 32);
+}
+#endif
+
+#ifndef iowrite64be_hi_lo
+#define iowrite64be_hi_lo iowrite64be_hi_lo
+static inline void iowrite64be_hi_lo(u64 val, void __iomem *addr)
+{
+	iowrite32be(val >> 32, addr);
+	iowrite32be(val, addr + sizeof(u32));
+}
+#endif
+
+#ifndef ioread64
+#define ioread64_is_nonatomic
+#define ioread64 ioread64_hi_lo
+#endif
+
+#ifndef iowrite64
+#define iowrite64_is_nonatomic
+#define iowrite64 iowrite64_hi_lo
+#endif
+
+#ifndef ioread64be
+#define ioread64be_is_nonatomic
+#define ioread64be ioread64be_hi_lo
+#endif
+
+#ifndef iowrite64be
+#define iowrite64be_is_nonatomic
+#define iowrite64be iowrite64be_hi_lo
+#endif
+
 #endif	/* _LINUX_IO_64_NONATOMIC_HI_LO_H_ */
diff --git a/include/linux/io-64-nonatomic-lo-hi.h b/include/linux/io-64-nonatomic-lo-hi.h
index d042e7bb5adb..faaa842dbdb9 100644
--- a/include/linux/io-64-nonatomic-lo-hi.h
+++ b/include/linux/io-64-nonatomic-lo-hi.h
@@ -55,4 +55,68 @@ static inline void lo_hi_writeq_relaxed(__u64 val, volatile void __iomem *addr)
 #define writeq_relaxed lo_hi_writeq_relaxed
 #endif
 
+#ifndef ioread64_lo_hi
+#define ioread64_lo_hi ioread64_lo_hi
+static inline u64 ioread64_lo_hi(void __iomem *addr)
+{
+	u32 low, high;
+
+	low = ioread32(addr);
+	high = ioread32(addr + sizeof(u32));
+
+	return low + ((u64)high << 32);
+}
+#endif
+
+#ifndef iowrite64_lo_hi
+#define iowrite64_lo_hi iowrite64_lo_hi
+static inline void iowrite64_lo_hi(u64 val, void __iomem *addr)
+{
+	iowrite32(val, addr);
+	iowrite32(val >> 32, addr + sizeof(u32));
+}
+#endif
+
+#ifndef ioread64be_lo_hi
+#define ioread64be_lo_hi ioread64be_lo_hi
+static inline u64 ioread64be_lo_hi(void __iomem *addr)
+{
+	u32 low, high;
+
+	low = ioread32be(addr + sizeof(u32));
+	high = ioread32be(addr);
+
+	return low + ((u64)high << 32);
+}
+#endif
+
+#ifndef iowrite64be_lo_hi
+#define iowrite64be_lo_hi iowrite64be_lo_hi
+static inline void iowrite64be_lo_hi(u64 val, void __iomem *addr)
+{
+	iowrite32be(val, addr + sizeof(u32));
+	iowrite32be(val >> 32, addr);
+}
+#endif
+
+#ifndef ioread64
+#define ioread64_is_nonatomic
+#define ioread64 ioread64_lo_hi
+#endif
+
+#ifndef iowrite64
+#define iowrite64_is_nonatomic
+#define iowrite64 iowrite64_lo_hi
+#endif
+
+#ifndef ioread64be
+#define ioread64be_is_nonatomic
+#define ioread64be ioread64be_lo_hi
+#endif
+
+#ifndef iowrite64be
+#define iowrite64be_is_nonatomic
+#define iowrite64be iowrite64be_lo_hi
+#endif
+
 #endif	/* _LINUX_IO_64_NONATOMIC_LO_HI_H_ */
-- 
2.19.0

