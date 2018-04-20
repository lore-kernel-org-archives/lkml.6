Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AB8JxZoSGd9UoaMuh1GnIJ1i1d3HgWbsCqN4NBZzlLmHGuxczOPjyKocNBfEhL/UP+wh6VhruZtI
ARC-Seal: i=1; a=rsa-sha256; t=1524248660; cv=none;
        d=google.com; s=arc-20160816;
        b=utxIDeK8AmyJ6I7eUpJ3WunyK5DQFiX1ce66mW92yo4qmHEWsYI8u05+C6Z68Vr5hd
         HwTV6KR+m1CNZSfNpGkGaC9j7dUgPkjbW0qxri+e8ElYx2HtURqKl7VNhja6EfUyDxcl
         4e7aWMOE/3KaxeakZ+m/YxC4xfhZNr/+xcqQfrjjZF66G7BfeGwUiXFVxFqTmvGpWvCz
         qmTq/ZotGHzyX/PuJ1EEH89dip26TAr1OG4EO3Gso0UvRrjU89nCyUmRjrFejNhEWx2e
         UIaPpMvVSEYowGTDeQVOMfIc0H6XXBpbxMYYajZHAJ+t0zt6Mm3qWMWwdjFtlAGsHDS9
         n6RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:references:in-reply-to:message-id:date:cc:to:from
         :arc-authentication-results;
        bh=eUesbsohkNyEFifBJRCUCMZbZTpJkONjRjAFIY5PoS4=;
        b=XaMUMD8sy5KgX5IYZlyVz9l+AGnCwHYXwz5+O/pAUNHaAzO3Wm1fCouxD7RtLls6kV
         U+RvDJKgIv090Pl/Kbtc93RBNhXaJnUAGd9yTsJXbalK9i4mOendkichvFAyxLSYuu44
         nPbb0KqPB16ODa+mslcaGM6HDbbXVE8VAkzL4AGF015ryC4w81RfNSOKZtNhjeBFfHVc
         KjliksROs5SJNUSK7htc308h5liLKxPJwECDcS4zh/A99mIzy/J1IpMjBZ5sapmrocv5
         ZYxV5i13pDUrfPM6hA+bywm9/R5gQGTo1xpkAtZNfiwrS/yrQplyy8vphztSRS/Yijty
         BBBA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gunthorp@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=gunthorp@deltatee.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gunthorp@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=gunthorp@deltatee.com
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-ntb@googlegroups.com,
	linux-crypto@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	=?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>
Date: Fri, 20 Apr 2018 12:23:57 -0600
Message-Id: <20180420182403.9691-2-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180420182403.9691-1-logang@deltatee.com>
References: <20180420182403.9691-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, akpm@linux-foundation.org, arnd@arndb.de, andy.shevchenko@gmail.com, horia.geanta@nxp.com, logang@deltatee.com, tglx@linutronix.de, gregkh@linuxfoundation.org, kstewart@linuxfoundation.org, pombredanne@nexb.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v16 1/7] iomap: Use non-raw io functions for io{read|write}XXbe
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598290563402982006?=
X-GMAIL-MSGID: =?utf-8?q?1598290563402982006?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix an asymmetry in the io{read|write}XXbe functions in that the
big-endian variants make use of the raw io accessors while the
little-endian variants use the regular accessors. Some architectures
implement barriers to order against both spinlocks and DMA accesses
and for these case, the big-endian variant of the API would not be
protected.

Thus, change the mmio_XXXXbe macros to use the appropriate swab() function
wrapping the regular accessor. This is similar to what was done for PIO.

When this code was originally written, barriers in the IO accessors were
not common and the accessors simply wrapped the raw functions in a
conversion to CPU endianness. Since then, barriers have been added in
some architectures and are now missing in the big endian variant of the
API.

This also manages to silence a few sparse warnings that check
for using the correct endian types which the original code did
not annotate correctly.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Link: http://lkml.kernel.org/r/CAK8P3a25zQDxyaY3iVv+JmSSzs7F6ssGc+HdBkGs54ZfViX+Fg@mail.gmail.com
---
 lib/iomap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/iomap.c b/lib/iomap.c
index 541d926da95e..2c293b22569f 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -65,8 +65,8 @@ static void bad_io_access(unsigned long port, const char *access)
 #endif
 
 #ifndef mmio_read16be
-#define mmio_read16be(addr) be16_to_cpu(__raw_readw(addr))
-#define mmio_read32be(addr) be32_to_cpu(__raw_readl(addr))
+#define mmio_read16be(addr) swab16(readw(addr))
+#define mmio_read32be(addr) swab32(readl(addr))
 #endif
 
 unsigned int ioread8(void __iomem *addr)
@@ -106,8 +106,8 @@ EXPORT_SYMBOL(ioread32be);
 #endif
 
 #ifndef mmio_write16be
-#define mmio_write16be(val,port) __raw_writew(be16_to_cpu(val),port)
-#define mmio_write32be(val,port) __raw_writel(be32_to_cpu(val),port)
+#define mmio_write16be(val,port) writew(swab16(val),port)
+#define mmio_write32be(val,port) writel(swab32(val),port)
 #endif
 
 void iowrite8(u8 val, void __iomem *addr)
-- 
2.11.0
