Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx49R4PQWQFA/ePs+r8f04DPPIw9HlA0Fd72fd7hOoEk1DjxmjJI6VIPnlqd+qEHNM5runRXH
ARC-Seal: i=1; a=rsa-sha256; t=1523916089; cv=none;
        d=google.com; s=arc-20160816;
        b=fyv9HavWFQZdX4kWSiMegJdZM9+8EYLCHVfhN8LhFD+5FnMkQV6NQbyjn9TJq3PIW0
         5/OcFdY6YA2Cvdxi4qSBolT/B0ag9fEVtb8JYO+9MZfIRTpbEVj9eaRiDUiqnszsKYvV
         dSg8SML41AHICNit6lPubCVUUQrp1YrKRUsbjGjHI+JqLOWk5b/Cd/IzpY++KjGXAG5b
         qeFtkgvu9DbmSv3FU5MBwLPU5CskJ1AxVVCAEeo7Ur2hDYJP2dpmjgo7u1hUuzwp3ulC
         fAreWtitqW6gqN42D1NQ0/ijRg0OtmXy1+CAvYJZN7mI+dGJR76s56PX8qzABzdLJ1ef
         4VFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dmarc-filter:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=nDi+NWAPlINGlkczFX4Ko6ds+3yrx/Eazg9HRaJO+wg=;
        b=QBEqNAFxVWAQDRk2LexRv1B9xNu4T5iDxcvll3/ZlgfeH1jf/VJ1d4n70/7wSP7RGs
         lMX/Je2f+I56BGQlsvVARGoMQ9xL9FgVsxwiFGtFSZewWuBxNl4Ow229CYwmwo0fzB+B
         jBodI2vYjOcIOqs/EUmT0y+qgsWAUmizMpxV4BfnCeNKzLvU0vFdPlNHekZ7FZbFI63t
         wDkUsqvBjRroPtcFCCjRPIvfeNNfsz4nlYs10yihqcPfBBSci1oE2HSegIgXGsYC8ZXW
         DjxDGbHHYGNNvT2Tpal1WUD6ozajmWWwNkWfc2osRw2xyhevN8fZ7z0TrLd24OO/1EGP
         bNZg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=n0uOyPcz;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=n0uOyPcz;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=n0uOyPcz;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=n0uOyPcz;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A1F816081C
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
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] parisc: use the asm-generic version for readX()
Date: Mon, 16 Apr 2018 18:01:16 -0400
Message-Id: <1523916078-23049-2-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523916078-23049-1-git-send-email-okaya@codeaurora.org>
References: <1523916078-23049-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597941837482719474?=
X-GMAIL-MSGID: =?utf-8?q?1597941837482719474?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

parisc architecture seems to be mapping readX() and readX_relaxed() APIs
to __raw_readX() API.

__raw_readX() API doesn't provide any kind of ordering guarantees.
commit 032d59e1cde9 ("io: define stronger ordering for the default readX()
implementation") changed asm-generic implementation to use a more
conservative approach towards the readX() API.

Drop the arch specific version and rely on the asm-generic version for
parisc since it doesn't seem to do anything special with these macros.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/parisc/include/asm/io.h | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index ef04864..7e60642 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -177,31 +177,6 @@ static inline void __raw_writeq(unsigned long long b, volatile void __iomem *add
 	*(volatile unsigned long long __force *) addr = b;
 }
 
-static inline unsigned char readb(const volatile void __iomem *addr)
-{
-	return __raw_readb(addr);
-}
-static inline unsigned short readw(const volatile void __iomem *addr)
-{
-	return le16_to_cpu((__le16 __force) __raw_readw(addr));
-}
-static inline unsigned int readl(const volatile void __iomem *addr)
-{
-	return le32_to_cpu((__le32 __force) __raw_readl(addr));
-}
-static inline unsigned long long readq(const volatile void __iomem *addr)
-{
-	return le64_to_cpu((__le64 __force) __raw_readq(addr));
-}
-
-#define	readb	readb
-#define	readw	readw
-#define	readl	readl
-#define readq	readq
-#define readb_relaxed(addr)	readb(addr)
-#define readw_relaxed(addr)	readw(addr)
-#define readl_relaxed(addr)	readl(addr)
-#define readq_relaxed(addr)	readq(addr)
 #define mmiowb() do { } while (0)
 
 void memset_io(volatile void __iomem *addr, unsigned char val, int count);
-- 
2.7.4
