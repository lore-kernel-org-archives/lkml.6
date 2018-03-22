Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AIpwx49Ac0papMTD+OmigxbM2zlALSwooTIxn4LIVshdCtTlRbP/pR8yWhPGuduuCcp5ormGq7OB
ARC-Seal: i=1; a=rsa-sha256; t=1521739034; cv=none;
        d=google.com; s=arc-20160816;
        b=xjLPh32ZloKkniyxXq3L9j/bIzYa0WibnPu1ILRKFGd5tGTT2y9Nyb37vJcPPDzdnb
         Ac41a26q75B4H6Gic+uwvwqbk8QfUobU5lTaVAILcmjORW0iTa5pS2iL3lkj4qRcqQ28
         2Heafn68cpfV+nJTZAN7CcZ+ooH83BjT53z97qasZ7IOxZse5BzAR6MN/i2gbhM6Xsk1
         djS/pvpN1KNy4T0znHCCz92eh0dGo9J97YtLkFxpr6lG5tYo40qtUj6ITQfCrHu/xoXE
         SaoqefcOteKti+4tgVL5Vy6JuQ0FgpLq6IYUEevwVhd1Dtf5NTeU8EbKpVSTuw+TlX8i
         2ZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:references:in-reply-to:message-id:date:cc:to:from
         :arc-authentication-results;
        bh=5r7BVSMWLPf1poCuDJ+n+Y1NCPOdkr/DoAWOECkhpH0=;
        b=zqNrOCzTAR91IFl9Nu3KqCVZjoiwdREphKj8etGj9ahuVp28H0pgFbIkbj2iWA6jkb
         Pcj2BHiO9PS5QakJkZjU9FiKQQ5zhoA7wG59Ty3S4IahUmuVM2V6El7rMZFp6K4nwdhN
         3L2WwanNekiQ9jJc6ex6wCkfh+Qv6zH0/kup1NeDfjNCXJvogvog3wEN8W5+aKlkxXct
         +1SUfvVgNQiDFsw/eM/guUNdBCZCDN8QSqa69vlJHNXYOjryrY8NEgOYXUDq0x1vpBNh
         WEiW1Hdbef/z4Gv6OmmXUUQolMWO9M2m6zr/sNCf4p0O7I76exRDYoFP0Z0FYT06UOo7
         2oJw==
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
	Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 22 Mar 2018 11:17:01 -0600
Message-Id: <20180322171703.4300-9-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322171703.4300-1-logang@deltatee.com>
References: <20180322171703.4300-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, andy.shevchenko@gmail.com, horia.geanta@nxp.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v14 08/10] ntb: ntb_hw_intel: use io-64-nonatomic instead of in-driver hacks
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595659029235170172?=
X-GMAIL-MSGID: =?utf-8?q?1595659029235170172?=
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
