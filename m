Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AB8JxZrTN8/85xirTY2uHKwKHbDjeu1H0tzXHLeoCAMftuRyez9014vTp4XRRLynygXqFutg7vP4
ARC-Seal: i=1; a=rsa-sha256; t=1525725379; cv=none;
        d=google.com; s=arc-20160816;
        b=dCqtE0DUM2aLnxnZ+FG7SPkbhmBG2Ds4WZvYBVEmiMBrr9trJ5uCBA4WyrurCVf5BU
         2QVEl8NQyA2OCzLHHnlupPMfBc1VEXaacP+VV7BLTW1Dq4lEvDdePEJOMUm9VXvLWrzH
         7tVmmHwtpxvCfHMLMJUI64kP8eir1FaBB8Y36YJWWcDCYq37PZrYvADpFT0zfn6x3AGR
         X5i9wrlRNjTmEiHpVJEtlHzFSStgTUOuFBp8CVUp1/8VNAL736orTaSZA/Fw+nJGY99o
         /qlqNFpi6igy7PxlW9sXkyWkgumiXTiqp4gIxVlxOgQYQSP/dfSI9F7KGxgb/b4WDZJg
         6J6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:references:in-reply-to:message-id:date:cc:to:from
         :arc-authentication-results;
        bh=eUesbsohkNyEFifBJRCUCMZbZTpJkONjRjAFIY5PoS4=;
        b=jYov4H3ZMEIRXUmOCEM2avtTxLsVl3My4+LbqL9zHcc/wqshBax7As6FbEmXwFKU0M
         4wxiqh7mJ5HHAlhcLcp7f/Zt7Es7P5wpNAC1E2KuVY0qRKQZ+OrcreaZHUZWAm+O12JX
         tH506mjaVEv0px9sRSrBB3lsrD0QMdHaUBHxQ3zixu32QzkDXYEASf+tSZ0Sc8FeELVA
         x5fUjICPFfpVVB1GZaazwSFSxlHayyf+NMyugd//fyF3ZqLc7DCSTCwdpxzWKcCGWk67
         AqzFKOmnROZBHbCM72PprVch0PwrTJH1HeJECxbBPmL+m62ok390Ln2SVqT8zrVasBxS
         SMSA==
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
Date: Mon,  7 May 2018 14:35:59 -0600
Message-Id: <20180507203605.15865-2-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180507203605.15865-1-logang@deltatee.com>
References: <20180507203605.15865-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, akpm@linux-foundation.org, arnd@arndb.de, andy.shevchenko@gmail.com, horia.geanta@nxp.com, logang@deltatee.com, tglx@linutronix.de, gregkh@linuxfoundation.org, kstewart@linuxfoundation.org, pombredanne@nexb.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v17 1/7] iomap: Use non-raw io functions for io{read|write}XXbe
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599839016114732093?=
X-GMAIL-MSGID: =?utf-8?q?1599839016114732093?=
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
