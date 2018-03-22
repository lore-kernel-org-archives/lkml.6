Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AG47ELv7gfAqk9H2ITKZU7wfY0Z+gU8umxblE0e0uExCNe3R+gVGM9N1lVQiLdPMbVe+rlqWa1gj
ARC-Seal: i=1; a=rsa-sha256; t=1521739043; cv=none;
        d=google.com; s=arc-20160816;
        b=YoOs5t1FU6f17sxZiIFatcEDzGEpIZ4trS8hHJ0frbMv7w5JqenmEAj/YEQxWc300+
         VJEHCVmR6U+t6ir4rj/ry9SexsBpSk/p525F+M6dKJ8JujkFQ5ikqyG4HB6V5wvTcISs
         71/gcKAFpFGzo/NSx7bq4UHdeSEQQWhj7V7LSgEhni9JunsM5kYb7VbwnHHTM5Q4hW5K
         iF9PvDvzKCZgM2doRnsoKF8b+mVquYJTDyQTbKW3f+X5aG4GAETpizKfCjQT7k2kD0L4
         nKjy63JnpAaU1kFKnDoGhlf4uN1QCziKTaNrPtW5VXCIz0MxsSEwDINUnzdPcYJnvT8o
         V6nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:references:in-reply-to:message-id:date:cc:to:from
         :arc-authentication-results;
        bh=MpUIUUYzk3Gx2lrMkQ5H44tPcxcFgXxyzvaVC6cQa0A=;
        b=N862+gUG3U5oiL3+i3U+yNsaTTHRQiFrQGZhE/itH2l/bpvlxK9e8hxU5kCpx++kXP
         lyKqE3b1S5bRAAWVi0WCnagARoHjCtyLFYoE+jzaotfiZLpQJPXOFZTv9jmuUQUX58Sc
         bzO5fJqeglHF6rplWXIawpZf+N/YGv/DVb7UHZzx4wUOJEaczEYoGSsC7kn15mpuYTFi
         kCcTl3FdDFOJElj2frcZByFq6z9YyMgC0WJu0P460ammLgu4MsfuxpUhWCMgF2qhNrxs
         O9zWLeOo/ffFTDzpfm4pOqQB0qCgUZaYjq0JBtqfh/wAO5dBn+6fvITbeLBJhQZ2ycAr
         OmzQ==
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
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kate Stewart <kstewart@linuxfoundation.org>
Date: Thu, 22 Mar 2018 11:16:54 -0600
Message-Id: <20180322171703.4300-2-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322171703.4300-1-logang@deltatee.com>
References: <20180322171703.4300-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, arnd@arndb.de, andy.shevchenko@gmail.com, horia.geanta@nxp.com, logang@deltatee.com, pombredanne@nexb.com, tglx@linutronix.de, gregkh@linuxfoundation.org, kstewart@linuxfoundation.org
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v14 01/10] iomap: Use correct endian conversion function in mmio_writeXXbe
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595659039151998005?=
X-GMAIL-MSGID: =?utf-8?q?1595659039151998005?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The semantics of the iowriteXXbe() functions are to write a
value in CPU endianess to an IO register that is known by the
caller to be in Big Endian. The mmio_writeXXbe() macro, which
is called by iowriteXXbe(), should therefore use cpu_to_beXX()
instead of beXX_to_cpu().

Seeing both beXX_to_cpu() and cpu_to_beXX() are both functionally
implemented as either null operations or swabXX operations there
was no noticable bug here. But it is confusing for both developers
and code analysis tools alike.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/iomap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/iomap.c b/lib/iomap.c
index 541d926da95e..be120c13d6cc 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -106,8 +106,8 @@ EXPORT_SYMBOL(ioread32be);
 #endif
 
 #ifndef mmio_write16be
-#define mmio_write16be(val,port) __raw_writew(be16_to_cpu(val),port)
-#define mmio_write32be(val,port) __raw_writel(be32_to_cpu(val),port)
+#define mmio_write16be(val,port) __raw_writew(cpu_to_be16(val),port)
+#define mmio_write32be(val,port) __raw_writel(cpu_to_be32(val),port)
 #endif
 
 void iowrite8(u8 val, void __iomem *addr)
-- 
2.11.0
