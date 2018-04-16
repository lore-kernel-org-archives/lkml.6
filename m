Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx48Pt9Qin7Ogsf58uhYVQO1ngXlbl6UBoR21C0c89NdbLlMeuJ3eSgh5O5LewG2cn/mvI+pY
ARC-Seal: i=1; a=rsa-sha256; t=1523917023; cv=none;
        d=google.com; s=arc-20160816;
        b=qCwTMN9Q7BPCsLw7TqgfXVZs3Kf0drV5VB3xV633QTDj19RF5fmIGBfT3yj7SC52Pb
         2a6+PvJyKVULkjwMGGPQ9FCi+2sHSpwFi/QkMPNzugur0hCdrbSX7OCaLoludMTbfRcp
         MwLDyBBWHW4cKfU7lgZSwuQ3MECptuujgKVq6OU1J4B3HqYBUwxHm4/mUTj9czefNLsQ
         2Jo2VYMkNmP0tw7R3RrE0EmcwbphuiNvdmUVCA3BLX3S3XqHlu62RgrvxOY4RgkQNJMu
         gYtuAg2pBLI6HjgsgMzeDwIV7f8CYG9/A7QCFliNgws44zcMniHINVF82a+74Brujm1P
         0Srg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=le9XOdlYV61pwyVko1iH39gTe+TuOZ6TtzrIbBaDaKo=;
        b=PH6vBKaEjC4Gc4dlwoyOWvUIjMDigNAQeCJvqI9k68PAExZSPrTs1SmtGHFL7Sns+L
         6RfjTT+Ea25lbs/wlgK58sn7FckAGqEgzel6Mmzg9BsNanQb12/NtkAwWWU9R8L6OCX/
         r/GiZliyxPGFgBxZI8s34aRhovWKeL0fv3zYtN/CNU6u07+w+eez4RWSQR5Mvfz+q0X5
         2SJuJSSzjp6mdIUlcc0BygdJWanHEZcQ9eonW6DdxOZdKlUDMpI2/JKTfCEQYP4KdpDV
         nk7cq3+htI0eLvGllXe9f0S+nuOe26hgToq921cEfIBeeFFsv8EjjZoGavE6ZPSmLldk
         D5aQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=HgpPul9D;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Ukak19d3;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=HgpPul9D;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Ukak19d3;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0E25760117
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-alpha@vger.kernel.org,
	arnd@arndb.de,
	timur@codeaurora.org,
	sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sinan Kaya <okaya@codeaurora.org>,
	Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] alpha: io: reorder barriers to guarantee writeX() and iowriteX() ordering #2
Date: Mon, 16 Apr 2018 18:16:56 -0400
Message-Id: <1523917017-28084-1-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597942817277668063?=
X-GMAIL-MSGID: =?utf-8?q?1597942817277668063?=
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
 arch/alpha/kernel/io.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/alpha/kernel/io.c b/arch/alpha/kernel/io.c
index 3e3d49c..c025a3e 100644
--- a/arch/alpha/kernel/io.c
+++ b/arch/alpha/kernel/io.c
@@ -37,20 +37,20 @@ unsigned int ioread32(void __iomem *addr)
 
 void iowrite8(u8 b, void __iomem *addr)
 {
-	IO_CONCAT(__IO_PREFIX,iowrite8)(b, addr);
 	mb();
+	IO_CONCAT(__IO_PREFIX,iowrite8)(b, addr);
 }
 
 void iowrite16(u16 b, void __iomem *addr)
 {
-	IO_CONCAT(__IO_PREFIX,iowrite16)(b, addr);
 	mb();
+	IO_CONCAT(__IO_PREFIX,iowrite16)(b, addr);
 }
 
 void iowrite32(u32 b, void __iomem *addr)
 {
-	IO_CONCAT(__IO_PREFIX,iowrite32)(b, addr);
 	mb();
+	IO_CONCAT(__IO_PREFIX,iowrite32)(b, addr);
 }
 
 EXPORT_SYMBOL(ioread8);
@@ -176,26 +176,26 @@ u64 readq(const volatile void __iomem *addr)
 
 void writeb(u8 b, volatile void __iomem *addr)
 {
-	__raw_writeb(b, addr);
 	mb();
+	__raw_writeb(b, addr);
 }
 
 void writew(u16 b, volatile void __iomem *addr)
 {
-	__raw_writew(b, addr);
 	mb();
+	__raw_writew(b, addr);
 }
 
 void writel(u32 b, volatile void __iomem *addr)
 {
-	__raw_writel(b, addr);
 	mb();
+	__raw_writel(b, addr);
 }
 
 void writeq(u64 b, volatile void __iomem *addr)
 {
-	__raw_writeq(b, addr);
 	mb();
+	__raw_writeq(b, addr);
 }
 
 EXPORT_SYMBOL(readb);
-- 
2.7.4
