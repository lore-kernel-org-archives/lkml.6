Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A96C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5088420868
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfAPSZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:25:32 -0500
Received: from ale.deltatee.com ([207.54.116.67]:35024 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728195AbfAPSZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:25:31 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gjpsV-0003NF-5D; Wed, 16 Jan 2019 11:25:28 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gjpsU-00054g-9Q; Wed, 16 Jan 2019 11:25:26 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 16 Jan 2019 11:25:22 -0700
Message-Id: <20190116182523.19446-6-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190116182523.19446-1-logang@deltatee.com>
References: <20190116182523.19446-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, arnd@arndb.de, gregkh@linuxfoundation.org, andy.shevchenko@gmail.com, horia.geanta@nxp.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v25 5/6] ntb: ntb_hw_intel: use io-64-nonatomic instead of in-driver hacks
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that ioread64 and iowrite64 are available in io-64-nonatomic,
we can remove the hack at the top of ntb_hw_intel.c and replace it
with an include.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>
Acked-by: Jon Mason <jdmason@kudzu.us>
---
 drivers/ntb/hw/intel/ntb_hw_intel.h | 30 +----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h b/drivers/ntb/hw/intel/ntb_hw_intel.h
index c49ff8970ce3..e071e28bca3f 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.h
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
@@ -53,6 +53,7 @@
 
 #include <linux/ntb.h>
 #include <linux/pci.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 /* PCI device IDs */
 #define PCI_DEVICE_ID_INTEL_NTB_B2B_JSF	0x3725
@@ -218,33 +219,4 @@ static inline int pdev_is_gen3(struct pci_dev *pdev)
 	return 0;
 }
 
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
 #endif
-- 
2.19.0

