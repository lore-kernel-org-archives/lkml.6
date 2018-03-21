Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AG47ELtndZHBY0lPxLfLS84z31EeebqvaY7xmkg+6XbJidndH+3r/9Q8lnE+cNxQisDo1yQSz5Cf
ARC-Seal: i=1; a=rsa-sha256; t=1521650277; cv=none;
        d=google.com; s=arc-20160816;
        b=rl+SeIeri2Nu3aqOfg1HsuYGD9/wSTJ2TM8i3d9rC0dtBJWXyvl0cHNmHvTMPciJs4
         3MTHDbo6sYRg203fOns4B6MtaWBuhCWwHpU8pvtehQ7lQ3EjJ5gux/fJU/N+PlMB4sR/
         p1UnxprOuU+27DN8ezYUDJRKU5gBwajiPnl+OroP4OsyOExKI246SXa1l5B37hWpsIf5
         lmEwh2VYy+1DwylbSfNHXAOwefIpvMFEXeDT7TsvfrdpK4tNlROmx8opGX11+KRAeXLO
         Ulnm+HEzvjbpc8wAg3ZlSvl0tLbo+/DDrCDtowgGKw9ZYBIVKQC4Zpms5QKi5ok3CzGZ
         yqng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:references:in-reply-to:message-id:date:cc:to:from
         :arc-authentication-results;
        bh=qDyzAKlu3WJmi+9TYOtTUlJqJbVbNH2HBIbeQuy9ER4=;
        b=fnzXha2Do/Gv9RwsLtZCqEVBAvv/h1Vb0//GYe+W8EmKAnrV84+ToA4XxfGH4O9DXX
         8uZMRDGOER1mj9KJp+qC0Yl8n1SkdqELK34hhqDf2HY5OApUx6Y3/Kz07nB4GBlz98+d
         J2ZU3IwSbSEngA6bBEMdCLCbHLHdmKGSlLXNJyuYHaONJtGYL1mK1bxMSLE8M5/KahnY
         +YhFPEd7f+NsuBxb3UF9AHMBg5d9mNoH8ijDeqzBaQ9QREwFe/vTLa7zo++sn7HcZknz
         D/1h/y/5z7Pr8ZH8AIjgj7l8Ab77D8X2VTs/Y7BjkcU6tXCK+U6evSNrZUG3XjNoZkwK
         qvfQ==
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
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Suresh Warrier <warrier@linux.vnet.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>
Date: Wed, 21 Mar 2018 10:37:41 -0600
Message-Id: <20180321163745.12286-7-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180321163745.12286-1-logang@deltatee.com>
References: <20180321163745.12286-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, horia.geanta@nxp.com, logang@deltatee.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, warrier@linux.vnet.ibm.com, andy.shevchenko@gmail.com, npiggin@gmail.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v13 06/10] iomap: introduce io{read|write}64_{lo_hi|hi_lo}
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595565961345428124?=
X-GMAIL-MSGID: =?utf-8?q?1595565961345428124?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
 include/asm-generic/iomap.h   |  26 +++++++--
 lib/iomap.c                   | 132 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index af074923d598..4cc420cfaa78 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -788,8 +788,10 @@ extern void __iounmap_at(void *ea, unsigned long size);
 
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
index 5b63b94ef6b5..5a4af0199b32 100644
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -31,9 +31,16 @@ extern unsigned int ioread16(void __iomem *);
 extern unsigned int ioread16be(void __iomem *);
 extern unsigned int ioread32(void __iomem *);
 extern unsigned int ioread32be(void __iomem *);
-#ifdef CONFIG_64BIT
-extern u64 ioread64(void __iomem *);
-extern u64 ioread64be(void __iomem *);
+
+#ifdef readq
+#define ioread64_lo_hi ioread64_lo_hi
+#define ioread64_hi_lo ioread64_hi_lo
+#define ioread64be_lo_hi ioread64be_lo_hi
+#define ioread64be_hi_lo ioread64be_hi_lo
+extern u64 ioread64_lo_hi(void __iomem *addr);
+extern u64 ioread64_hi_lo(void __iomem *addr);
+extern u64 ioread64be_lo_hi(void __iomem *addr);
+extern u64 ioread64be_hi_lo(void __iomem *addr);
 #endif
 
 extern void iowrite8(u8, void __iomem *);
@@ -41,9 +48,16 @@ extern void iowrite16(u16, void __iomem *);
 extern void iowrite16be(u16, void __iomem *);
 extern void iowrite32(u32, void __iomem *);
 extern void iowrite32be(u32, void __iomem *);
-#ifdef CONFIG_64BIT
-extern void iowrite64(u64, void __iomem *);
-extern void iowrite64be(u64, void __iomem *);
+
+#ifdef writeq
+#define iowrite64_lo_hi iowrite64_lo_hi
+#define iowrite64_hi_lo iowrite64_hi_lo
+#define iowrite64be_lo_hi iowrite64be_lo_hi
+#define iowrite64be_hi_lo iowrite64be_hi_lo
+extern void iowrite64_lo_hi(u64 val, void __iomem *addr);
+extern void iowrite64_hi_lo(u64 val, void __iomem *addr);
+extern void iowrite64be_lo_hi(u64 val, void __iomem *addr);
+extern void iowrite64be_hi_lo(u64 val, void __iomem *addr);
 #endif
 
 /*
diff --git a/lib/iomap.c b/lib/iomap.c
index 44645c4b516c..f3b7b2e4c625 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -67,6 +67,7 @@ static void bad_io_access(unsigned long port, const char *access)
 #ifndef mmio_read16be
 #define mmio_read16be(addr) be16_to_cpu((__be16 __force)__raw_readw(addr))
 #define mmio_read32be(addr) be32_to_cpu((__be32 __force)__raw_readl(addr))
+#define mmio_read64be(addr) be64_to_cpu((__be64 __force)__raw_readq(addr))
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
 #define mmio_write16be(val,port) __raw_writew((u16 __force)cpu_to_be16(val),port)
 #define mmio_write32be(val,port) __raw_writel((u32 __force)cpu_to_be32(val),port)
+#define mmio_write64be(val,port) __raw_writeq((u64 __force)cpu_to_be64(val),port)
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
2.11.0
