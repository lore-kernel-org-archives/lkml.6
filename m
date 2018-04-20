Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AB8JxZokpov3WP/qxXalvpEBxHDOJpAwiLK3pHuZrcv+Kt2hRmC8UPQcWdU2C4W9YHstgQsS4Mq4
ARC-Seal: i=1; a=rsa-sha256; t=1524248660; cv=none;
        d=google.com; s=arc-20160816;
        b=e96IoOY2kBYAO75N/6KUw0XXSnFErWcig9t5GHfJoHsujqsL3TdlQl0mApclHETCz+
         f2yLuVE0738OJkhvkPSw1isJfQKusszsxqb2BxhuecSRaFZCWom6ny1HKWKV0eqtCC5/
         r3/d7Qgye6PhMv6HALSYEPnTQtqZxPgzCqTRvKAdWaqP7N7D8IxJef4ccXvfjkVFPP40
         GSyR171uLdS+V3b/xFUauqlxPI0U+t2UrTj9UYgM+4uh7YqRF/nu0coKg8PBDVD3odew
         1hbb0ONlEBCDdGT9Qv7RRjav4DCqeG8jYAMNpw+d8EvH53RAsKh3qO3xC5/Yot3pogMG
         oRAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:cc:to:from:arc-authentication-results;
        bh=I0mQAG6uuC+hyAVaFbO7lBUDJGoy/57bE5IwTmzt9Gs=;
        b=YixQMqoDQ6LiXv9XX328lGUQrNIXMdv5Oc96QUfODq1vjxl/nB3qX73mpJhVvAdWX3
         L+4eoTTPuHdpMQJh9NDjN+kEBUwjW03DOquHojIgUjIlTdI8323vpM4iIdA/4ZrRIPut
         NlZTL7NDGHvpjGBgUsAdHaAdu+/WeHRuOclI6m80x8W51KzWQUifty+C+8AnPrsCgQRj
         I1z3i9oC41HQUb6CoMdhL6hBq/kM14ACzD0ipj6MsT+rNWdu9XmXOTQGL7/l2/pAyrBv
         n26BXFiY7e8T9SazLpoKvLGzscC6dMivaGU4Xm4+QxKqsoZLCGWH6FmRvgq+Caf7Tv9r
         3HXg==
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
Date: Fri, 20 Apr 2018 12:24:02 -0600
Message-Id: <20180420182403.9691-7-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180420182403.9691-1-logang@deltatee.com>
References: <20180420182403.9691-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, akpm@linux-foundation.org, arnd@arndb.de, gregkh@linuxfoundation.org, andy.shevchenko@gmail.com, logang@deltatee.com, horia.geanta@nxp.com, dan.douglass@nxp.com, herbert@gondor.apana.org.au, davem@davemloft.net
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v16 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when using io{read|write}64
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598290563171238328?=
X-GMAIL-MSGID: =?utf-8?q?1598290563171238328?=
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
