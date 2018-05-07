Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AB8JxZqZiMMEdmNLqAc+t+vsE/p73oPP+nctdF+krJXyt5KW3MHgv6ss2/06VC7RRduiNVQu0veq
ARC-Seal: i=1; a=rsa-sha256; t=1525725375; cv=none;
        d=google.com; s=arc-20160816;
        b=v5avWM1IHWJtxaocblbIwDrw7OdZecfATfJlPSALAVq2Ezyl97AxhYaSHlIm2Of9Ml
         +t9qJ2dJ617Xz2oFaoPXrWFEgBGMMpfYdB4veww0iTsMvkJ2XgFp3jBCrrkdz2D0G9MC
         A6ZviyZgO4YYKt1qrpwata2M0zOWNRKxaYaeWlGg74NhMi9il0YVCK3mBU+isxVMY0pF
         n/y/vCS4OYshAbA10yGbzSq5gDwy/ooEnxRUtBfT2Gomo+1TfMhYVtpLTVS3Iz4vYsr2
         TzCkYCM6CYh5PGH4rByp4ixSzcSmrQQ7HGfdDDw+1HjV0IKi2CpRqBU4ee+XvIjqtZBU
         cxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:references:in-reply-to:message-id:date:cc:to:from
         :arc-authentication-results;
        bh=5r7BVSMWLPf1poCuDJ+n+Y1NCPOdkr/DoAWOECkhpH0=;
        b=JKvtgKhTUFn2/tgjbKAzGwKr9w5FHSwNFwPvYxGIumcxP2b+SBDNAsvNwdW30F938Y
         dGFwqgdFLeToeAuR4XJiah25E3xflJG+/FRt+uyf9Te9R3SHx4HoUiAijKdoPaGrU2Gs
         fDECPivxiZ0KGJLIgUQF9hHjRDDEt1vKVA8K69djvrmtruhhROVgqIHnHU0hWuEiG6E3
         DT1mX4BZbPGbWfIYY3oiWoC9N0ir4voOtBB+nT4X1ejL+KYlMhc4gdP6iWLgQMQ599ls
         8S4FxFAs/Xqn2WqEkxVCi4od/5nWwWTccVeKYUu3xZ6BxudyZvnbJ8RuEzhTuPrIxMZ8
         59cw==
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
Date: Mon,  7 May 2018 14:36:03 -0600
Message-Id: <20180507203605.15865-6-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180507203605.15865-1-logang@deltatee.com>
References: <20180507203605.15865-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, akpm@linux-foundation.org, arnd@arndb.de, gregkh@linuxfoundation.org, andy.shevchenko@gmail.com, horia.geanta@nxp.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v17 5/7] ntb: ntb_hw_intel: use io-64-nonatomic instead of in-driver hacks
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599839011574953916?=
X-GMAIL-MSGID: =?utf-8?q?1599839011574953916?=
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
