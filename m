Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AG47ELv6TyzNR3YUso4jXv6BCsiZlXmMov+5i7dvetvLYIMdMDJZBlHKS5mwMaLqjWHX5Azft4+z
ARC-Seal: i=1; a=rsa-sha256; t=1521215349; cv=none;
        d=google.com; s=arc-20160816;
        b=Lw0Qt9dc3Tn4lu3uIA3bCy9Bz00EoMqpkOeV1aJV/CTiFXwn9PeHriZ/HhB+Urb4GN
         sxss0bf32bKkcB+VOIQys6AGQ9AELdIg3rDXrhyJ4taVDLNZS18XgoKHRszKgAq8yjYh
         5Dfe94XOxnXdyVYDxs3smfg1qPShTQI/10cRzoyDLeQtaHW6Yum4MWD8tUJdFBWUggQk
         lcd7FED4JKff4L4k3zSVddUl+/2VWNOP6Z4ehHlSpu3S+Vb8VxEMtBitauFegxj6GGFV
         tKtJfPRf5UWh/MmDqPYd+0OSx/qtasRNepYFR+45+RQU0sYswcALXNb6Ktr4joyFxNlu
         oD3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:references:in-reply-to:message-id:date:cc:to:from
         :arc-authentication-results;
        bh=vPIYhx/iapWgjMkks4tmy5yuHZy5fgHBuNRlMj9FX/Y=;
        b=ypNx3OQzoyfKQadRz9PZq+lnCj8fn8LWs0UlmNJ1Wjx94p7NiuR+u6sBcw8t4OaKex
         Lef7FrzWFCcIOFJto9NqoDN+KdEEo0EZ6TOZ/TBKnjxSm5/GySRStFJtNs2mCK9N5X6W
         vy8xv983OqdJNiMbvT0YSc4wVWERfl+WQh6ulFiPma/IYbATMLgr1l5VuwpUwBg2yPMJ
         V2fAYfOwOIZ368c0z5H39RCw9rn12JsxeMXZdjpCLyynuY1y4ZABymbk0Scyw31J10l8
         BZzDoM54EIjze/nobr8ChREnxr/LXFHjSXxwQAyL3laU+jft5xGxnCE28ttS6fANMF42
         92bA==
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
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>
Date: Fri, 16 Mar 2018 09:48:44 -0600
Message-Id: <20180316154852.13206-2-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180316154852.13206-1-logang@deltatee.com>
References: <20180316154852.13206-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, arnd@arndb.de, andy.shevchenko@gmail.com, horia.geanta@nxp.com, logang@deltatee.com, tglx@linutronix.de, pombredanne@nexb.com, gregkh@linuxfoundation.org, kstewart@linuxfoundation.org
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v12 1/9] iomap: Fix sparse endian check warnings
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595109905747636881?=
X-GMAIL-MSGID: =?utf-8?q?1595109905747636881?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Warnings of the form:

lib/iomap.c:84:9: warning: cast to restricted __be16

Are found when running sparse checker with:

make C=2 CF=-D__CHECK_ENDIAN__

This patch casts them with __force to suppress the warnings.

Also, it looks like the wrong conversion function was used in
the mmio_writeXXbe macros: 'val' is a cpu value to be written to
a big endian register. Therefore cpu_to_beXX should have been used
instead of beXX_to_cpu. Both are equivalent, functionally, but have
different meanings. So there was no real bug just confusion
for people reading the code and the sparse endian check.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
---
 lib/iomap.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/iomap.c b/lib/iomap.c
index 541d926da95e..a05d9fa21794 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -65,8 +65,8 @@ static void bad_io_access(unsigned long port, const char *access)
 #endif
 
 #ifndef mmio_read16be
-#define mmio_read16be(addr) be16_to_cpu(__raw_readw(addr))
-#define mmio_read32be(addr) be32_to_cpu(__raw_readl(addr))
+#define mmio_read16be(addr) be16_to_cpu((__be16 __force)__raw_readw(addr))
+#define mmio_read32be(addr) be32_to_cpu((__be32 __force)__raw_readl(addr))
 #endif
 
 unsigned int ioread8(void __iomem *addr)
@@ -106,8 +106,10 @@ EXPORT_SYMBOL(ioread32be);
 #endif
 
 #ifndef mmio_write16be
-#define mmio_write16be(val,port) __raw_writew(be16_to_cpu(val),port)
-#define mmio_write32be(val,port) __raw_writel(be32_to_cpu(val),port)
+#define mmio_write16be(val, port) \
+	__raw_writew((u16 __force)cpu_to_be16(val), port)
+#define mmio_write32be(val, port) \
+	__raw_writel((u32 __force)cpu_to_be32(val), port)
 #endif
 
 void iowrite8(u8 val, void __iomem *addr)
-- 
2.11.0
