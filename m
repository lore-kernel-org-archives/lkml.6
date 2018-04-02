Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx49JGPs/73kzRrI+ped9a07GhqiDLOE5U5cVcsslb8A8+ZsGd+i/en4xF7qQPndzgcfP2FDU
ARC-Seal: i=1; a=rsa-sha256; t=1522691290; cv=none;
        d=google.com; s=arc-20160816;
        b=s1qodIUCYBtccVG/Su3DFoW/yB5oYm1TIlscClimh7+5vZatV3XP2ho37iBDVlSbfy
         dFqdJcKYlZ+lgBmOdq7keOCOY/F9yWeMIjypAqJ07Ld8hhxyrmXQYcWpdSDvShJgCFZ9
         EvveXVX3bIwQW2Y0C4/94ggljHrFMtulA2PSzHONZ1vZVQyi/+TyaaiJ+Q9lOdZMfQDN
         z1i86fWFcQQy4WxIi5NmgJPgEaANP57ysx2h+71UtShCvaUS5cMjJQEunQrx65v/Xvha
         A3TEOkwXCmnPe/oEuE4mQ4bY+xJZVZRGStKNJEhc9BF3ZYvKXcPmV0QZFPmxL4q2ttQ1
         ISuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=34kAcYJzRY/wIrDYMzrZHi3W9plDjqXMRfN8FQl+Whc=;
        b=r6Avrz8JG/ISCZQ/PrIFjukhJrp8FqtuQkzL70P4hVytaFCCNs5yiu7VWSse0XOO1z
         aErFfZspYN8FmsaLRMEfA4uVLP8P4dX0Diyii7OFlStYx0ZxcJwzp8KbpockBopXWFyz
         uTu92Gc1KpfpnyJOudsey5SeeG+1Fi5P2silLgSx2X7culkiB9uUd4ROoAUgtP3oCyee
         BaTqChWjwj5wwdNVIJdB9xNxqvfb88AKW5xRb6o2yonzZnsPDAbsYP0PkSjFQOTYeEjC
         fIIdBqlCQu4IEGrj2KEwJ1yLLnbXhsL60rDYdn4oqV9qr9dFOEchUZvejXDxzcmdXrqL
         Tszw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ONJGzm0U;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=nVKbJih6;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ONJGzm0U;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=nVKbJih6;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F4E6601D3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-alpha@vger.kernel.org,
	timur@codeaurora.org,
	sulrich@codeaurora.org
Cc: arnd@arndb.de,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sinan Kaya <okaya@codeaurora.org>,
	Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] alpha: io: reorder barriers to guarantee writeX() and iowriteX() ordering
Date: Mon,  2 Apr 2018 13:48:00 -0400
Message-Id: <1522691281-21593-1-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596657541952033644?=
X-GMAIL-MSGID: =?utf-8?q?1596657541952033644?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

memory-barriers.txt has been updated with the following requirement.

"When using writel(), a prior wmb() is not needed to guarantee that the
cache coherent memory writes have completed before writing to the MMIO
region."

Current writeX() and iowriteX() implementations on alpha are not
satisfying this requirement as the barrier is after the register write.

Move mb() in writeX() and iowriteX() functions to guarantee that HW
observes memory changes before performing register operations.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Reported-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/asm/io.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index d123ff9..4c533fc 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -341,14 +341,14 @@ extern inline unsigned int ioread16(void __iomem *addr)
 
 extern inline void iowrite8(u8 b, void __iomem *addr)
 {
-	IO_CONCAT(__IO_PREFIX,iowrite8)(b, addr);
 	mb();
+	IO_CONCAT(__IO_PREFIX, iowrite8)(b, addr);
 }
 
 extern inline void iowrite16(u16 b, void __iomem *addr)
 {
-	IO_CONCAT(__IO_PREFIX,iowrite16)(b, addr);
 	mb();
+	IO_CONCAT(__IO_PREFIX, iowrite16)(b, addr);
 }
 
 extern inline u8 inb(unsigned long port)
@@ -382,8 +382,8 @@ extern inline unsigned int ioread32(void __iomem *addr)
 
 extern inline void iowrite32(u32 b, void __iomem *addr)
 {
-	IO_CONCAT(__IO_PREFIX,iowrite32)(b, addr);
 	mb();
+	IO_CONCAT(__IO_PREFIX, iowrite32)(b, addr);
 }
 
 extern inline u32 inl(unsigned long port)
@@ -434,14 +434,14 @@ extern inline u16 readw(const volatile void __iomem *addr)
 
 extern inline void writeb(u8 b, volatile void __iomem *addr)
 {
-	__raw_writeb(b, addr);
 	mb();
+	__raw_writeb(b, addr);
 }
 
 extern inline void writew(u16 b, volatile void __iomem *addr)
 {
-	__raw_writew(b, addr);
 	mb();
+	__raw_writew(b, addr);
 }
 #endif
 
@@ -482,14 +482,14 @@ extern inline u64 readq(const volatile void __iomem *addr)
 
 extern inline void writel(u32 b, volatile void __iomem *addr)
 {
-	__raw_writel(b, addr);
 	mb();
+	__raw_writel(b, addr);
 }
 
 extern inline void writeq(u64 b, volatile void __iomem *addr)
 {
-	__raw_writeq(b, addr);
 	mb();
+	__raw_writeq(b, addr);
 }
 #endif
 
-- 
2.7.4
