Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AB8JxZpNpGmlmHBKfbhqemTbvv2bQy3sMSSo4arM+ZqG2My7BvPL9mAEzPs3UejvkN43jZXKr5Wr
ARC-Seal: i=1; a=rsa-sha256; t=1525725376; cv=none;
        d=google.com; s=arc-20160816;
        b=muiBy3e52r1mYBGCMiEO2IAQsa7l9nrl94JOizFXhT0HU3pcZU3c4Z96EYdLQYVyHk
         RlT56xJIr53Ha74669hLtfi7roMqr8CEQlQbR/0QZJL6o8yaHTgC64+RMtptFQyNnHDU
         WWdiiFASP4/j77dwvy7Q+hpxusZ3wwi6sY07AHtH9DpeuyswNZvoFdE8bcklgn7pyCww
         tWOeumgfPN6jVvXl77ZOFSQh06Gx7sVt2rtjNuOEJ1J2DDkmGO0cHU6SIhyNIagZBMvI
         xosHkO8I1Rgr7n4+CSxQD7vH/DQKxVJYLG59Oi/spy5Havxq54pLWkYu8c5ycxpoW4PB
         BpTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:cc:to:from:arc-authentication-results;
        bh=I0mQAG6uuC+hyAVaFbO7lBUDJGoy/57bE5IwTmzt9Gs=;
        b=vD6A1j6jwDGiPn08vPhM5yorKDImXfGrAvTGiks83f13U2/HaQ4NwKFQvw8xKG+1wX
         cElhese5Hxe/XSgUlDacaf9GYQeW/N5JeRk/NdQByQd/pjnqxPV+xzSb+35oByEbJaQw
         H82VgvX1H4FU2qpzDkIo4ys8gSTfR2LgF7kT27cCIHJjNjGAQoPkedjDKaGKRXGK3prI
         ucVE74oU9dDKi3bdhWYHRTGHlMQqp+bj2jDR0wanZqua1IRThH7beTtTGj/LD4U18EQu
         SgjuJlz7m7jywhiis/JPQhexyW/4XRIZLSBcfbsVIXTu1FRZ4/L80EByMXh+mQKvZL0e
         Q+Lw==
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
	Dan Douglass <dan.douglass@nxp.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Date: Mon,  7 May 2018 14:36:04 -0600
Message-Id: <20180507203605.15865-7-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180507203605.15865-1-logang@deltatee.com>
References: <20180507203605.15865-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, akpm@linux-foundation.org, arnd@arndb.de, gregkh@linuxfoundation.org, andy.shevchenko@gmail.com, logang@deltatee.com, horia.geanta@nxp.com, dan.douglass@nxp.com, herbert@gondor.apana.org.au, davem@davemloft.net
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v17 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when using io{read|write}64
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599839012870759384?=
X-GMAIL-MSGID: =?utf-8?q?1599839012870759384?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Clean up the extra ifdefs which defined the wr_reg64 and rd_reg64
functions in non-64bit cases in favour of the new common
io-64-nonatomic-lo-hi header.

To be consistent with CAAM engine HW spec: in case of 64-bit registers,
irrespective of device endianness, the lower address should be read from
/ written to first, followed by the upper address. Indeed the I/O
accessors in CAAM driver currently don't follow the spec, however this
is a good opportunity to fix the code.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Horia Geantă <horia.geanta@nxp.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Dan Douglass <dan.douglass@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
---
 drivers/crypto/caam/regs.h | 30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
index fee363865d88..f887b371040f 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -10,7 +10,7 @@
 
 #include <linux/types.h>
 #include <linux/bitops.h>
-#include <linux/io.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 /*
  * Architecture-specific register access methods
@@ -136,10 +136,9 @@ static inline void clrsetbits_32(void __iomem *reg, u32 clear, u32 set)
  *    base + 0x0000 : least-significant 32 bits
  *    base + 0x0004 : most-significant 32 bits
  */
-#ifdef CONFIG_64BIT
 static inline void wr_reg64(void __iomem *reg, u64 data)
 {
-	if (caam_little_end)
+	if (!caam_imx && caam_little_end)
 		iowrite64(data, reg);
 	else
 		iowrite64be(data, reg);
@@ -147,35 +146,12 @@ static inline void wr_reg64(void __iomem *reg, u64 data)
 
 static inline u64 rd_reg64(void __iomem *reg)
 {
-	if (caam_little_end)
+	if (!caam_imx && caam_little_end)
 		return ioread64(reg);
 	else
 		return ioread64be(reg);
 }
 
-#else /* CONFIG_64BIT */
-static inline void wr_reg64(void __iomem *reg, u64 data)
-{
-	if (!caam_imx && caam_little_end) {
-		wr_reg32((u32 __iomem *)(reg) + 1, data >> 32);
-		wr_reg32((u32 __iomem *)(reg), data);
-	} else {
-		wr_reg32((u32 __iomem *)(reg), data >> 32);
-		wr_reg32((u32 __iomem *)(reg) + 1, data);
-	}
-}
-
-static inline u64 rd_reg64(void __iomem *reg)
-{
-	if (!caam_imx && caam_little_end)
-		return ((u64)rd_reg32((u32 __iomem *)(reg) + 1) << 32 |
-			(u64)rd_reg32((u32 __iomem *)(reg)));
-
-	return ((u64)rd_reg32((u32 __iomem *)(reg)) << 32 |
-		(u64)rd_reg32((u32 __iomem *)(reg) + 1));
-}
-#endif /* CONFIG_64BIT  */
-
 static inline u64 cpu_to_caam_dma64(dma_addr_t value)
 {
 	if (caam_imx)
-- 
2.11.0
