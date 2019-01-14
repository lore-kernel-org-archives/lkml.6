Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870B2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE6620656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VSc1nxR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfANLYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:24:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38574 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfANLYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qs0Wt/vtsahTKQl6GXCP+v4YOJy8sonRA2AI/tUvugQ=; b=VSc1nxR4bEBizFRH2KYQJvoxRF
        /+g2LaR5Np1AmREr/+nugNs2x5iSmQDUDOlBDYt8tOjh4K61adVmuoPWHjfbAp9UjxsYglxY389Ym
        A/qA3gDD/ii/JCCWzbYrk9CmMxU95nw7m9RcNBZAWYuEW01k1RIu7ugxDF2ApPOW0tEwvMYklznfB
        Sj74zGwEbrk7Igq9omHLMRW+P0+eDpu/LoUw06NEW/14x/Im2G3SQsUGbJN9+q+FY0KVT/S+x3f4O
        VdWfMZsEbAvlbY+XmIGb6U298sh5YuaOvWXhtLSFSR+LSFhwZ1BoUBkjd6sGP03PJ7uhQqQElz901
        YDSBsm9A==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gj0LZ-0006od-KL; Mon, 14 Jan 2019 11:24:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] parisc: move internal implementation details out of <asm/dma-mapping.h>
Date:   Mon, 14 Jan 2019 12:23:47 +0100
Message-Id: <20190114112353.30616-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114112353.30616-1-hch@lst.de>
References: <20190114112353.30616-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move everything that is not required for the public facing DMA API out
of <asm/dma-mapping.h> and into a new drivers/parisc/iommu.h header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/parisc/include/asm/dma-mapping.h | 44 ------------------------
 drivers/parisc/ccio-dma.c             |  2 ++
 drivers/parisc/dino.c                 |  1 +
 drivers/parisc/eisa.c                 |  2 ++
 drivers/parisc/hppb.c                 |  2 ++
 drivers/parisc/iommu.h                | 49 +++++++++++++++++++++++++++
 drivers/parisc/lba_pci.c              |  2 ++
 drivers/parisc/sba_iommu.c            |  2 ++
 8 files changed, 60 insertions(+), 44 deletions(-)
 create mode 100644 drivers/parisc/iommu.h

diff --git a/arch/parisc/include/asm/dma-mapping.h b/arch/parisc/include/asm/dma-mapping.h
index f1bf5e297f1c..d5bd94247371 100644
--- a/arch/parisc/include/asm/dma-mapping.h
+++ b/arch/parisc/include/asm/dma-mapping.h
@@ -26,48 +26,4 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return hppa_dma_ops;
 }
 
-static inline void *
-parisc_walk_tree(struct device *dev)
-{
-	struct device *otherdev;
-	if(likely(dev->platform_data != NULL))
-		return dev->platform_data;
-	/* OK, just traverse the bus to find it */
-	for(otherdev = dev->parent; otherdev;
-	    otherdev = otherdev->parent) {
-		if(otherdev->platform_data) {
-			dev->platform_data = otherdev->platform_data;
-			break;
-		}
-	}
-	return dev->platform_data;
-}
-
-#define GET_IOC(dev) ({					\
-	void *__pdata = parisc_walk_tree(dev);		\
-	__pdata ? HBA_DATA(__pdata)->iommu : NULL;	\
-})
-
-#ifdef CONFIG_IOMMU_CCIO
-struct parisc_device;
-struct ioc;
-void * ccio_get_iommu(const struct parisc_device *dev);
-int ccio_request_resource(const struct parisc_device *dev,
-		struct resource *res);
-int ccio_allocate_resource(const struct parisc_device *dev,
-		struct resource *res, unsigned long size,
-		unsigned long min, unsigned long max, unsigned long align);
-#else /* !CONFIG_IOMMU_CCIO */
-#define ccio_get_iommu(dev) NULL
-#define ccio_request_resource(dev, res) insert_resource(&iomem_resource, res)
-#define ccio_allocate_resource(dev, res, size, min, max, align) \
-		allocate_resource(&iomem_resource, res, size, min, max, \
-				align, NULL, NULL)
-#endif /* !CONFIG_IOMMU_CCIO */
-
-#ifdef CONFIG_IOMMU_SBA
-struct parisc_device;
-void * sba_get_iommu(struct parisc_device *dev);
-#endif
-
 #endif
diff --git a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
index 8d2fc84119c6..b17e81cf77d5 100644
--- a/drivers/parisc/ccio-dma.c
+++ b/drivers/parisc/ccio-dma.c
@@ -55,6 +55,8 @@
 #include <asm/hardware.h>       /* for register_module() */
 #include <asm/parisc-device.h>
 
+#include "iommu.h"
+
 /* 
 ** Choose "ccio" since that's what HP-UX calls it.
 ** Make it easier for folks to migrate from one to the other :^)
diff --git a/drivers/parisc/dino.c b/drivers/parisc/dino.c
index dfeea458a789..6f348c75687c 100644
--- a/drivers/parisc/dino.c
+++ b/drivers/parisc/dino.c
@@ -59,6 +59,7 @@
 #include <asm/hardware.h>
 
 #include "gsc.h"
+#include "iommu.h"
 
 #undef DINO_DEBUG
 
diff --git a/drivers/parisc/eisa.c b/drivers/parisc/eisa.c
index 9ff434f354bd..5657a1d3eb2b 100644
--- a/drivers/parisc/eisa.c
+++ b/drivers/parisc/eisa.c
@@ -45,6 +45,8 @@
 #include <asm/eisa_bus.h>
 #include <asm/eisa_eeprom.h>
 
+#include "iommu.h"
+
 #if 0
 #define EISA_DBG(msg, arg...) printk(KERN_DEBUG "eisa: " msg, ## arg)
 #else
diff --git a/drivers/parisc/hppb.c b/drivers/parisc/hppb.c
index ebc7b617e5d0..3b3481c0d81d 100644
--- a/drivers/parisc/hppb.c
+++ b/drivers/parisc/hppb.c
@@ -23,6 +23,8 @@
 #include <asm/hardware.h>
 #include <asm/parisc-device.h>
 
+#include "iommu.h"
+
 struct hppb_card {
 	unsigned long hpa;
 	struct resource mmio_region;
diff --git a/drivers/parisc/iommu.h b/drivers/parisc/iommu.h
new file mode 100644
index 000000000000..c72c4fe51a3a
--- /dev/null
+++ b/drivers/parisc/iommu.h
@@ -0,0 +1,49 @@
+#ifndef _IOMMU_H
+#define _IOMMU_H 1
+
+struct parisc_device;
+struct ioc;
+
+static inline void *parisc_walk_tree(struct device *dev)
+{
+	struct device *otherdev;
+
+	if (likely(dev->platform_data))
+		return dev->platform_data;
+
+	/* OK, just traverse the bus to find it */
+	for (otherdev = dev->parent;
+	     otherdev;
+	     otherdev = otherdev->parent) {
+		if (otherdev->platform_data) {
+			dev->platform_data = otherdev->platform_data;
+			break;
+		}
+	}
+
+	return dev->platform_data;
+}
+
+#define GET_IOC(dev) ({					\
+	void *__pdata = parisc_walk_tree(dev);		\
+	__pdata ? HBA_DATA(__pdata)->iommu : NULL;	\
+})
+
+#ifdef CONFIG_IOMMU_CCIO
+void *ccio_get_iommu(const struct parisc_device *dev);
+int ccio_request_resource(const struct parisc_device *dev,
+		struct resource *res);
+int ccio_allocate_resource(const struct parisc_device *dev,
+		struct resource *res, unsigned long size,
+		unsigned long min, unsigned long max, unsigned long align);
+#else /* !CONFIG_IOMMU_CCIO */
+#define ccio_get_iommu(dev) NULL
+#define ccio_request_resource(dev, res) insert_resource(&iomem_resource, res)
+#define ccio_allocate_resource(dev, res, size, min, max, align) \
+		allocate_resource(&iomem_resource, res, size, min, max, \
+				align, NULL, NULL)
+#endif /* !CONFIG_IOMMU_CCIO */
+
+void *sba_get_iommu(struct parisc_device *dev);
+
+#endif /* _IOMMU_H */
diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
index 69bd98421eb1..63e9bc6d18de 100644
--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -49,6 +49,8 @@
 #include <asm/parisc-device.h>
 #include <asm/io.h>		/* read/write stuff */
 
+#include "iommu.h"
+
 #undef DEBUG_LBA	/* general stuff */
 #undef DEBUG_LBA_PORT	/* debug I/O Port access */
 #undef DEBUG_LBA_CFG	/* debug Config Space Access (ie PCI Bus walk) */
diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
index 42172eb32235..afaf8e6aefe6 100644
--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -49,6 +49,8 @@
 #include <asm/pdcpat.h>		/* for is_pdc_pat() */
 #include <asm/parisc-device.h>
 
+#include "iommu.h"
+
 #define MODULE_NAME "SBA"
 
 /*
-- 
2.20.1

