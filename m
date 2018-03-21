Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AG47ELutpUBI07FXmL1oh//gz2ufo4R3oHNndrDeRyTETbn3tonBGH51zZcMGfDnScZYGo5p1yPq
ARC-Seal: i=1; a=rsa-sha256; t=1521650287; cv=none;
        d=google.com; s=arc-20160816;
        b=YU1V5U52o1+tQrEZ+OUkSJf4ylxhm59ZOcDaitVGtpoVJIkSsoJYa1kKCaktwbqV5M
         hhve9ITJr20QikgPx9dAiBieJBqqL+tfcBAJ8JVLXoOM/OsuT1uKru73Bsi0nQ/XBg6q
         iY6vkA+83lT9xPkIzK1Yl951QvScou/zOaP/qrZFcFUhUbFXt1Y/1xoNHefUlsC7fX4Y
         TI47XJoxU0AfRf7RKdUImq6St3vpt0ocoDKzCajYcWJx6dXkkhr0sxyVbVvMkZ6ZOoFD
         nSSjcmrxtC3k/nmlBtZf+YVYhWY2DK5RCt1yEL5y4hJeZe/5V8/QvXHedH5q02jIVzya
         QOvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:references:in-reply-to:message-id:date:cc:to:from
         :arc-authentication-results;
        bh=FbLv3yzRDWK0P8UoILoPWTpMAlXcsa9tn/ZRapLmFiU=;
        b=Ca500X0eGZw9mX5YOv+fXQN2f9CTjFwAwv4vcvjQy8tzhO7RhIShd2JpRe50738bhu
         26mCQq3zszacohDnXvrbjN6a7CoDpmPgyJolYCmjSQP1F1P12d/f9YvkxTkg0aDOrI7I
         O1Z+X4PwINSQJq3PdE6w/K1DT2H1oOMQDeX11++od0Jeq75FRqEgmhpPKlM6VQ1/iPA9
         Lw8H8In7wdVp5dZw+eghB/w3asJtvgmp0zdoTZKDYM4aE2xugVClqePMJjCLlKhnxpsB
         OReRbBqtPNpdQ6s66/kGBK4Ag36TaQGUrgUe6TdSYnIwiSyOYGPCbPbHeK44Ccuwe1ll
         M7Vg==
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
	Kate Stewart <kstewart@linuxfoundation.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Wed, 21 Mar 2018 10:37:37 -0600
Message-Id: <20180321163745.12286-3-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180321163745.12286-1-logang@deltatee.com>
References: <20180321163745.12286-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, arnd@arndb.de, horia.geanta@nxp.com, logang@deltatee.com, tglx@linutronix.de, pombredanne@nexb.com, gregkh@linuxfoundation.org, kstewart@linuxfoundation.org, andy.shevchenko@gmail.com, luc.vanoostenryck@gmail.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v13 02/10] iomap: Fix sparse endian check warnings
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595565972198859637?=
X-GMAIL-MSGID: =?utf-8?q?1595565972198859637?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Newer version of sparse produce a few warnings of the form:

lib/iomap.c:84:9: warning: cast to restricted __be16

when run with:

make C=2 CF=-D__CHECK_ENDIAN__

(The kbuild robot has recently started running such checks)

The warning is not valid because the __raw_readX() and __raw_writeX()
functions have an endianess determined by the semantics of whichever
register they are operating on (which is intern dependant on the address
passed to the function).

In the iomap case, the register being operated on is known,
semantically, to be Big Endian when an ioXXbe() function is used
by the caller. These functions wrap a raw read or write function
in an endianness conversion function.

Sparse enforces that all values that aren't in CPU endianness
be marked with types like __be16 and similar and said types cannot
be mixed with other types. However, per above, the raw functions
cannot be marked as such seeing the endianness is indeterminate.
Thus, the output of __raw_readX() and the input of __raw_writeX()
must be cast with the __force keyword to supress the invalid warning.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib/iomap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/iomap.c b/lib/iomap.c
index be120c13d6cc..44645c4b516c 100644
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
@@ -106,8 +106,8 @@ EXPORT_SYMBOL(ioread32be);
 #endif
 
 #ifndef mmio_write16be
-#define mmio_write16be(val,port) __raw_writew(cpu_to_be16(val),port)
-#define mmio_write32be(val,port) __raw_writel(cpu_to_be32(val),port)
+#define mmio_write16be(val,port) __raw_writew((u16 __force)cpu_to_be16(val),port)
+#define mmio_write32be(val,port) __raw_writel((u32 __force)cpu_to_be32(val),port)
 #endif
 
 void iowrite8(u8 val, void __iomem *addr)
-- 
2.11.0
