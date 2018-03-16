Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AG47ELtgfeKdjjkLUKwAOlnSB1jKZCtKeQl581OjbqEBpVYBpx2MklEBHI9OLvbiiA+5KhxoIoh0
ARC-Seal: i=1; a=rsa-sha256; t=1521215346; cv=none;
        d=google.com; s=arc-20160816;
        b=AikGq2Z4KZMAAJQ5IJTJa++znmjliYXUmKYFKPcpgUZeAgp7QT+KR6FPTs6GySR7al
         8goulPstkkSv5LZ11z0pvheHaMazIYasmRfkbCXXKt/KH550jTGO+ldDo7WvbsKuU76J
         xsQolh1qioWHwWvCPiEcOQy76ZlQnbDj3Lnvbw+v/T+7sPxP7CD1gAo/sGV2VE+ogwsG
         uGWwkzvDEsRcJXjaMtXu6y5VfjoiXJwVrkaUa4GYtXZMmxOhIk8mpbZvVOIRbQOFgEeN
         wqc73uRzULNhjVfelFI8ECdpboKzQcJyT6qABrsEO1ErtDhj09CV6QSn0ze1gomUOerg
         MiPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:references:in-reply-to:message-id:date:cc:to:from
         :arc-authentication-results;
        bh=mIvqW3CYz48bXtFSk+DfI2oHdDoLkYDyJgKdiWaI968=;
        b=SHTHhZ+pevunK0tJDF70s7bR18SPVeSWHEVR0ZlvoCv3G/TB0eozxyJkpRqY5Fqci8
         V72kF4HjGqPlhPfls6I1A0WYG/lta7W3hbrOPvw+xLXGVgwiQCAirZCmiiLgFNpNreDm
         alEoSSrBp7Y7i+qBRCPiA8HkQcwNZaE+JmttsOVIncddkvBsRAwQWdhPqQDcDouHtLBx
         GB3Cu1CD5ZOajnN5fTeGIKtaWGXKDM7r+0JwVEEWigbU/Ra6Sr9bY9BI8Wz4mjXjQEDe
         s3RC/XITG3EaA+VlR+nD3QCjYA3rMU0fcklEUyHYZRrBw1yDCleZY92MKnthzrvmE1RA
         l04w==
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
Date: Fri, 16 Mar 2018 09:48:48 -0600
Message-Id: <20180316154852.13206-6-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180316154852.13206-1-logang@deltatee.com>
References: <20180316154852.13206-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, horia.geanta@nxp.com, logang@deltatee.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, warrier@linux.vnet.ibm.com, andy.shevchenko@gmail.com, npiggin@gmail.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v12 5/9] iomap: introduce io{read|write}64_{lo_hi|hi_lo}
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595109903748364076?=
X-GMAIL-MSGID: =?utf-8?q?1595109903748364076?=
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
 lib/iomap.c                   | 133 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 155 insertions(+), 6 deletions(-)

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
index a05d9fa21794..75bb8c9e0980 100644
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
@@ -110,6 +185,8 @@ EXPORT_SYMBOL(ioread32be);
 	__raw_writew((u16 __force)cpu_to_be16(val), port)
 #define mmio_write32be(val, port) \
 	__raw_writel((u32 __force)cpu_to_be32(val), port)
+#define mmio_write64be(val, port) \
+	__raw_writeq((u64 __force)cpu_to_be64(val), port)
 #endif
 
 void iowrite8(u8 val, void __iomem *addr)
@@ -138,6 +215,62 @@ EXPORT_SYMBOL(iowrite16be);
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
