Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AIpwx48+FnbQ2x2tKfgGkI7I8AYyvnWC5BF3S7Fwy1bMP7Y45QTbVmDeZXJ6qJREsYPRMwUzZCqM
ARC-Seal: i=1; a=rsa-sha256; t=1522192128; cv=none;
        d=google.com; s=arc-20160816;
        b=g8xal3NeUIH/ZdNit5DFr4dnSIrwkTg3R3LOycFZwq6rqIXjx5kQALVwalyJKauZoN
         dcSLBbTFM7SbGPSA/qoUxvtNKG/s4bIMJFBIVS0uFN7bWnM6/9mEXRrJp5VmI3m9eaOb
         ZKqtYS/iXTscQ+JB/8fzsal18TwvzW8YwX8DIAD9G5woB/aUYbaVyo5Vxeui2o194E0Y
         YzMcp29t7RwzktPlwX0EqODwntMcAiXEAsA1jDLXsLcyObo5oy7vkpWcZnCUa6QCXYRn
         ks+L3lbxHKRS9KTkeb0YTZlmrlyy1yXUS74Bdo9DbNz9HQc5MfCyvFNeq3NFmC+o4w4A
         XMAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:references:in-reply-to:message-id:date:cc:to:from
         :arc-authentication-results;
        bh=RLdGUMLKpu6r8zQJf0H5Dr0BYHcxSWwJxV8ioOO48Wc=;
        b=UiemvELq9mR7A4qze0401aMJG06Fmb/jWXYn7nK2l5TLU6B9NkdgAEO2bmuTepkOEr
         Efcf+vQ2pafbDQe8NDPmL5DjkAkqw/Rn3ulIghAWc3aW6crpAk6xOoctmAhsfORzi0ra
         qIO7vVAzbP5RHKHnSvvBAbLHe5REFHKJgctv52MhQjtEMWzgWtaweWbpDJGaynsfYS5h
         6Exoux2DFQtERVeXkbur5vpZvFBwWOpspr0UnvCYB6xwGDqr4+GBlWs+yXES4tpB7teD
         x9vLPvfQRhyyJxe7nEt1oeXrxMytfdyI3siwLkwvuP7p5TsQD8iUdhgZhmfBQo79/XFa
         E8AQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gunthorp@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=gunthorp@deltatee.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gunthorp@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=gunthorp@deltatee.com
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-ntb@googlegroups.com,
	linux-crypto@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	=?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Christoph Hellwig <hch@lst.de>,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Date: Tue, 27 Mar 2018 17:08:31 -0600
Message-Id: <20180327230834.5931-7-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180327230834.5931-1-logang@deltatee.com>
References: <20180327230834.5931-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, andy.shevchenko@gmail.com, horia.geanta@nxp.com, logang@deltatee.com, hch@lst.de, gnomes@lxorguk.ukuu.org.uk
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v15 6/9] io-64-nonatomic: add io{read|write}64[be]{_lo_hi|_hi_lo} macros
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596134133226549126?=
X-GMAIL-MSGID: =?utf-8?q?1596134133226549126?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
 include/linux/io-64-nonatomic-hi-lo.h | 64 +++++++++++++++++++++++++++++++++++
 include/linux/io-64-nonatomic-lo-hi.h | 64 +++++++++++++++++++++++++++++++++++
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
2.11.0
