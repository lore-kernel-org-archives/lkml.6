Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4+EXxS+LGuJcGQ5knTCUYwdeE6/vahSmRgWNdVhI6dbvHG5bab1k7TAvcp6c+xcjxsffolr
ARC-Seal: i=1; a=rsa-sha256; t=1523916085; cv=none;
        d=google.com; s=arc-20160816;
        b=B6UZNnMJLcATVFypMNUBVbgkEpDhn1XF4HVule8lorVl4obV3GyxPeuYRaH+xWF5Bm
         5Tmz6BEeoEN2v0fRdUT3GFeWoWHKrC2sVU0uzWjW+I4Lbubz5QDc96DF8DdpIl5n/GHU
         7oeyjrTtulCJHLUpAg6W0LuAKN2nh4U55fV/Y0OzMR6elaMrRBpdPtPaCLOhspblmpI1
         0Zjz4bW7VvyjaU75Vemu5EzIXQg6A7t1LPQkXq9J7GI8+yqiUstXPGwegzJwkNkMeWob
         CG0XVjOupIeesgqSEomgTnOafjkS1cvjDV4w/Py30N3UwQCwheNkTG4+Yo+9wpKDUXh7
         0vDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=NXduwFytSCIvYs2wb29jaECuSwkO+181SiO1k61bbqo=;
        b=qH3nYo6m/QbLnnATu89Ljp+XPnVbvzpcDwDUO0hugfnoFN0izygKy2yzBW3Dui9VcZ
         lYK5LSLpUF4UbGPuAFd1ppJ6erskB91kMDxBKJm0w96Cxp4vp5amdPR4u1AS9m3V2uIy
         Rofn7JbBtSEYqc3gsG2CPNG4SiAaIAj21BtEm5ly+N4GBUs0ejUNtp2OtRjFByGozev1
         o173wF4huTEJhR2FYC5f3xHTFBdFsSAOV3xPyD8FKrTuYbl0fi684tF0faKmn+zDkYrJ
         XsUx8qqT8fFpduERR2FGONZhd6q9vH9ACF/8j2AXWYazieHfCQ6XyXpl1/1jOnZeVCaq
         Jmaw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Fnc/eYqF;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=UQQyP1li;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Fnc/eYqF;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=UQQyP1li;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5CF34600ED
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-parisc@linux-mips.org,
	arnd@arndb.de,
	timur@codeaurora.org,
	sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sinan Kaya <okaya@codeaurora.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Helge Deller <deller@gmx.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] parisc: use the asm-generic version for writeX()
Date: Mon, 16 Apr 2018 18:01:15 -0400
Message-Id: <1523916078-23049-1-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597941834039295294?=
X-GMAIL-MSGID: =?utf-8?q?1597941834039295294?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

parisc architecture seems to be mapping writeX() and writeX_relaxed() APIs
to __raw_writeX() API.

__raw_writeX() API doesn't provide any kind of ordering guarantees.
commit 755bd04aaf4b ("io: define stronger ordering for the default writeX()
implementation") changed asm-generic implementation to use a more
conservative approach towards the writeX() API.

Drop the arch specific version and rely on the asm-generic version for
parisc since parisc version doesn't seem to do anything special with these
macros.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/parisc/include/asm/io.h | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index afe493b..ef04864 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -194,41 +194,14 @@ static inline unsigned long long readq(const volatile void __iomem *addr)
 	return le64_to_cpu((__le64 __force) __raw_readq(addr));
 }
 
-static inline void writeb(unsigned char b, volatile void __iomem *addr)
-{
-	__raw_writeb(b, addr);
-}
-static inline void writew(unsigned short w, volatile void __iomem *addr)
-{
-	__raw_writew((__u16 __force) cpu_to_le16(w), addr);
-}
-static inline void writel(unsigned int l, volatile void __iomem *addr)
-{
-	__raw_writel((__u32 __force) cpu_to_le32(l), addr);
-}
-static inline void writeq(unsigned long long q, volatile void __iomem *addr)
-{
-	__raw_writeq((__u64 __force) cpu_to_le64(q), addr);
-}
-
 #define	readb	readb
 #define	readw	readw
 #define	readl	readl
 #define readq	readq
-#define writeb	writeb
-#define writew	writew
-#define writel	writel
-#define writeq	writeq
-
 #define readb_relaxed(addr)	readb(addr)
 #define readw_relaxed(addr)	readw(addr)
 #define readl_relaxed(addr)	readl(addr)
 #define readq_relaxed(addr)	readq(addr)
-#define writeb_relaxed(b, addr)	writeb(b, addr)
-#define writew_relaxed(w, addr)	writew(w, addr)
-#define writel_relaxed(l, addr)	writel(l, addr)
-#define writeq_relaxed(q, addr)	writeq(q, addr)
-
 #define mmiowb() do { } while (0)
 
 void memset_io(volatile void __iomem *addr, unsigned char val, int count);
-- 
2.7.4
