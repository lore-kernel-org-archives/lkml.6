Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AIpwx4+zE1uZD70G3QMlk2MsIoWl/vFRaW7HFLrAHu/9Z66cUaGBpJrWqrCzvhiAmuWRfTZ+QXE4
ARC-Seal: i=1; a=rsa-sha256; t=1521650283; cv=none;
        d=google.com; s=arc-20160816;
        b=H4cLSDVjwDJ06dZ4kfq/aX9RwkqwhCkQwH/XpNkamwHS7Jk31pPM6wcaw64Erm/vbC
         6KVw/kUoed0I219liYxfgyJA8XpOIV5AtTNADGNHPv7UGNbd04yu9xcuH7yYn8CbywcT
         CeF48EyES/UtKa0zR/a/qi5r8kGxdcFU7PBZEd/1Yk1qBNdLCiZ2IEDrEIMEe9YE2ZlL
         RXNCD71X+S7MgEj3j3DL7NcLA/uBbFMERw4Xu74+peYxUTV4WuOonyUi0+KF+ftA3Wxf
         5ddvYRB2miEwURh6mygnG9W2yWg9saLOrvOgACK9Rz2lZSAIhB41WOT5DJ7p1ZW8t8Dd
         HuLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:references:in-reply-to:message-id:date:cc:to:from
         :arc-authentication-results;
        bh=zDd0dHsxvzmOzIsed0VBOVMeur4YS3i3EI50exLRTlY=;
        b=kVFnwglWYGcOJcGffbiRhPHt2jmxFDPw8GWIy14+fxEogDbNZ+CGVgv91bCerJPyuO
         70ykDRFGbtbRp72PUB/vZ4NwhzVSiID0rIP/Mh/mCGHAiMx0/hmxUVJcc8QeW5z5si/6
         lzgrcxonHDgLgPdNGn1BxaNmSh9EmiObLocbmcdlBwsjXtOkGwwmqBPjqHITqR9yBenq
         AtukJcfn9qaqxp1+ncChcvoYFq49tvJ6YzCNZHvVVR3aAziMgEMicAV6njS8zQp8YWkJ
         PA2MnBOFMICueiycWW+PZ/6HxXZpEKe8AJPinBpbFeAgtAgQi3e+g1mwTtw8Bo/ve85G
         8f1w==
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
	Kate Stewart <kstewart@linuxfoundation.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Wed, 21 Mar 2018 10:37:36 -0600
Message-Id: <20180321163745.12286-2-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180321163745.12286-1-logang@deltatee.com>
References: <20180321163745.12286-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, arnd@arndb.de, horia.geanta@nxp.com, logang@deltatee.com, pombredanne@nexb.com, tglx@linutronix.de, gregkh@linuxfoundation.org, kstewart@linuxfoundation.org, andy.shevchenko@gmail.com, luc.vanoostenryck@gmail.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v13 01/10] iomap: Use correct endian conversion function in mmio_writeXXbe
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595565968042571455?=
X-GMAIL-MSGID: =?utf-8?q?1595565968042571455?=
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
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
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
