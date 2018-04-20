Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AIpwx4+NtAQMyX3rMgi1NNHRd0TkpTNIK/dw5jlm7jqft6s5pUZSayCRcaATAy+5arrorlYSGkyY
ARC-Seal: i=1; a=rsa-sha256; t=1524248659; cv=none;
        d=google.com; s=arc-20160816;
        b=N8K3+Mk9Yr846PJTGy6OZu+6vtNApgZBFnlYBnMQPPItlK6vTyVVt6z6cBi9o8mRti
         NylSly9wbFcSRBHRueVtGwop15He7y1hfA5r4g7NtF0sHiHbI6N2sXSZs+Lly72fl1Tp
         Q1M0c+Fafy8R5CqXtaU0jwPjcCsxO0+H6syhLR5aw5Nif3Y8dSh20AEiRzuGWyXNzVuS
         GRzoLDZgDm3yrm90+KlFF1jJPySeca8N4ktrOoLwsxJbmajPZ3Wl9J061z3bR74jTaQG
         97nDZGxTlOO1axN1G3NE1cP+g2P01H48SbnNzhqKCB7ysXXU/B9s+CT6dqurWpetoq7s
         Ucnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:references:in-reply-to:message-id:date:cc:to:from
         :arc-authentication-results;
        bh=5r7BVSMWLPf1poCuDJ+n+Y1NCPOdkr/DoAWOECkhpH0=;
        b=g3OMt9vrrORQsE0x08OeHEoocbacS6n4Hf4HM0B2MT3YbwohL7eGA5fYTO32F2CX6H
         XEA5aPoNKl23FI5yMgPqD3OA6AbZdO/qdYP6oIv+6ylyeNpwdbMTx2PAs8W64czzV/TN
         34m+zkFOPeGr7A4qyyya9C97Y722vM9eCScRpgdLjVYELEaipg+MgTVwb1le7xB2Cp3G
         7xtnrR/tpOGxpl2/KLr7ySRfy/YSGp+9d2qTBiIocGBsr6jynzatfHCpwZiUjTaww5ra
         CvE/3pEcA4cJijp7E+ICzq2FZ2Q7HDqgkLsdfk6W53TjqIP6yhpATOoQTiSUpap7n68z
         OB/Q==
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
	Logan Gunthorpe <logang@deltatee.com>
Date: Fri, 20 Apr 2018 12:24:01 -0600
Message-Id: <20180420182403.9691-6-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180420182403.9691-1-logang@deltatee.com>
References: <20180420182403.9691-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, akpm@linux-foundation.org, arnd@arndb.de, gregkh@linuxfoundation.org, andy.shevchenko@gmail.com, horia.geanta@nxp.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v16 5/7] ntb: ntb_hw_intel: use io-64-nonatomic instead of in-driver hacks
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598290562566969248?=
X-GMAIL-MSGID: =?utf-8?q?1598290562566969248?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now that ioread64 and iowrite64 are available in io-64-nonatomic,
we can remove the hack at the top of ntb_hw_intel.c and replace it
with an include.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>
Acked-by: Jon Mason <jdmason@kudzu.us>
---
 drivers/ntb/hw/intel/ntb_hw_intel.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index 156b45cd4a19..5cf40ab21366 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -59,6 +59,7 @@
 #include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/ntb.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 #include "ntb_hw_intel.h"
 
@@ -149,35 +150,6 @@ MODULE_PARM_DESC(xeon_b2b_dsd_bar5_addr32,
 static inline enum ntb_topo xeon_ppd_topo(struct intel_ntb_dev *ndev, u8 ppd);
 static int xeon_init_isr(struct intel_ntb_dev *ndev);
 
-#ifndef ioread64
-#ifdef readq
-#define ioread64 readq
-#else
-#define ioread64 _ioread64
-static inline u64 _ioread64(void __iomem *mmio)
-{
-	u64 low, high;
-
-	low = ioread32(mmio);
-	high = ioread32(mmio + sizeof(u32));
-	return low | (high << 32);
-}
-#endif
-#endif
-
-#ifndef iowrite64
-#ifdef writeq
-#define iowrite64 writeq
-#else
-#define iowrite64 _iowrite64
-static inline void _iowrite64(u64 val, void __iomem *mmio)
-{
-	iowrite32(val, mmio);
-	iowrite32(val >> 32, mmio + sizeof(u32));
-}
-#endif
-#endif
-
 static inline int pdev_is_xeon(struct pci_dev *pdev)
 {
 	switch (pdev->device) {
-- 
2.11.0
