Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9161C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C82C20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sCndE0Tb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C82C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394866AbeKVWTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:19:02 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50436 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436532AbeKVWS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:18:59 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAMBdt1M075858;
        Thu, 22 Nov 2018 05:39:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542886795;
        bh=L1g+cFlZbK2jqch2VzZJr2MhbexCzsfb03CSRdvV3hI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=sCndE0TbRh5Su6X70iJvaFz6E7tyNNpNDqWHA3Lz/TcaHOcB1ECElYImB27t0wgvP
         ILHJQMUw5BaGD2MONhVRO3NfERMyTCeDx382yKcEjcW/cTWwp1ze4Zpv7hIa6aHGBu
         RD5xopx89K1NHNhB61PRd773jQpVXUPU3QgVmfFU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAMBdteB076979
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Nov 2018 05:39:55 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 22
 Nov 2018 05:39:55 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 22 Nov 2018 05:39:54 -0600
Received: from dlelxv97.itg.ti.com (dlelxv97.itg.ti.com [172.17.2.193])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAMBdsV1017780;
        Thu, 22 Nov 2018 05:39:54 -0600
Received: from localhost.localdomain (vboxa0400828d.dhcp.ti.com [172.22.239.63])
        by dlelxv97.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAMBdDf8013203;
        Thu, 22 Nov 2018 05:39:51 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>
CC:     <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>
Subject: [PATCH 09/17] soc: ti: pruss: add pruss_{request,release}_mem_region() API
Date:   Thu, 22 Nov 2018 13:39:05 +0200
Message-ID: <1542886753-17625-10-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542886753-17625-1-git-send-email-rogerq@ti.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Andrew F. Davis" <afd@ti.com>

Add two new API - pruss_request_mem_region() & pruss_release_mem_region(),
to the PRUSS platform driver to allow client drivers to acquire and release
the common memory resources present within a PRU-ICSS subsystem. This
allows the client drivers to directly manipulate the respective memories,
as per their design contract with the associated firmware.

Signed-off-by: Andrew F. Davis <afd@ti.com>
[s-anna@ti.com: rename functions, add error checking, comments]
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/soc/ti/pruss.c      | 81 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/soc/ti/pruss.h      | 26 +++------------
 drivers/soc/ti/pruss_intc.c |  1 +
 include/linux/pruss.h       | 61 ++++++++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+), 22 deletions(-)
 create mode 100644 include/linux/pruss.h

diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index 0840b59..c2271c4 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -12,9 +12,89 @@
 #include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/pruss.h>
 
 #include "pruss.h"
 
+/**
+ * pruss_request_mem_region() - request a memory resource
+ * @pruss: the pruss instance
+ * @mem_id: the memory resource id
+ * @region: pointer to memory region structure to be filled in
+ *
+ * This function allows a client driver to request a memory resource,
+ * and if successful, will let the client driver own the particular
+ * memory region until released using the pruss_release_mem_region()
+ * API.
+ *
+ * Returns the memory region if requested resource is available, an
+ * error otherwise
+ */
+int pruss_request_mem_region(struct pruss *pruss, enum pruss_mem mem_id,
+			     struct pruss_mem_region *region)
+{
+	if (!pruss || !region)
+		return -EINVAL;
+
+	if (mem_id >= PRUSS_MEM_MAX)
+		return -EINVAL;
+
+	mutex_lock(&pruss->lock);
+
+	if (pruss->mem_in_use[mem_id]) {
+		mutex_unlock(&pruss->lock);
+		return -EBUSY;
+	}
+
+	*region = pruss->mem_regions[mem_id];
+	pruss->mem_in_use[mem_id] = region;
+
+	mutex_unlock(&pruss->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pruss_request_mem_region);
+
+/**
+ * pruss_release_mem_region() - release a memory resource
+ * @pruss: the pruss instance
+ * @region: the memory region to release
+ *
+ * This function is the complimentary function to
+ * pruss_request_mem_region(), and allows the client drivers to
+ * release back a memory resource.
+ *
+ * Returns 0 on success, an error code otherwise
+ */
+int pruss_release_mem_region(struct pruss *pruss,
+			     struct pruss_mem_region *region)
+{
+	int id;
+
+	if (!pruss || !region)
+		return -EINVAL;
+
+	mutex_lock(&pruss->lock);
+
+	/* find out the memory region being released */
+	for (id = 0; id < PRUSS_MEM_MAX; id++) {
+		if (pruss->mem_in_use[id] == region)
+			break;
+	}
+
+	if (id == PRUSS_MEM_MAX) {
+		mutex_unlock(&pruss->lock);
+		return -EINVAL;
+	}
+
+	pruss->mem_in_use[id] = NULL;
+
+	mutex_unlock(&pruss->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pruss_release_mem_region);
+
 static int pruss_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -41,6 +121,7 @@ static int pruss_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pruss->dev = dev;
+	mutex_init(&pruss->lock);
 
 	np = of_get_child_by_name(node, "memories");
 	if (!np)
diff --git a/drivers/soc/ti/pruss.h b/drivers/soc/ti/pruss.h
index a5a0667..f8878c2 100644
--- a/drivers/soc/ti/pruss.h
+++ b/drivers/soc/ti/pruss.h
@@ -22,28 +22,6 @@
 #define MAX_PRU_HOST_INT	10
 
 /**
- * enum pruss_mem - PRUSS memory range identifiers
- */
-enum pruss_mem {
-	PRUSS_MEM_DRAM0 = 0,
-	PRUSS_MEM_DRAM1,
-	PRUSS_MEM_SHRD_RAM2,
-	PRUSS_MEM_MAX,
-};
-
-/**
- * struct pruss_mem_region - PRUSS memory region structure
- * @va: kernel virtual address of the PRUSS memory region
- * @pa: physical (bus) address of the PRUSS memory region
- * @size: size of the PRUSS memory region
- */
-struct pruss_mem_region {
-	void __iomem *va;
-	phys_addr_t pa;
-	size_t size;
-};
-
-/**
  * struct pruss_intc_config - INTC configuration info
  * @sysev_to_ch: system events to channel mapping information
  * @ch_to_host: interrupt channel to host interrupt information
@@ -57,12 +35,16 @@ struct pruss_intc_config {
  * struct pruss - PRUSS parent structure
  * @dev: pruss device pointer
  * @mem_regions: data for each of the PRUSS memory regions
+ * @mem_in_use: to indicate if memory resource is in use
  * @host_mask: indicate which HOST IRQs are enabled
+ * @lock: mutex to serialize access to resources
  */
 struct pruss {
 	struct device *dev;
 	struct pruss_mem_region mem_regions[PRUSS_MEM_MAX];
+	struct pruss_mem_region *mem_in_use[PRUSS_MEM_MAX];
 	u32 host_mask;
+	struct mutex lock; /* PRU resource lock */
 };
 
 int pruss_intc_configure(struct pruss *pruss,
diff --git a/drivers/soc/ti/pruss_intc.c b/drivers/soc/ti/pruss_intc.c
index dde054b..df6b83b 100644
--- a/drivers/soc/ti/pruss_intc.c
+++ b/drivers/soc/ti/pruss_intc.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pruss.h>
 
 #include "pruss.h"
 
diff --git a/include/linux/pruss.h b/include/linux/pruss.h
new file mode 100644
index 0000000..198ae25
--- /dev/null
+++ b/include/linux/pruss.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/**
+ * PRU-ICSS Subsystem user interfaces
+ *
+ * Copyright (C) 2015-2018 Texas Instruments Incorporated - http://www.ti.com
+ *	Suman Anna <s-anna@ti.com>
+ *	Tero Kristo <t-kristo@ti.com>
+ */
+
+#ifndef __LINUX_PRUSS_H
+#define __LINUX_PRUSS_H
+
+/**
+ * enum pruss_mem - PRUSS memory range identifiers
+ */
+enum pruss_mem {
+	PRUSS_MEM_DRAM0 = 0,
+	PRUSS_MEM_DRAM1,
+	PRUSS_MEM_SHRD_RAM2,
+	PRUSS_MEM_MAX,
+};
+
+/**
+ * struct pruss_mem_region - PRUSS memory region structure
+ * @va: kernel virtual address of the PRUSS memory region
+ * @pa: physical (bus) address of the PRUSS memory region
+ * @size: size of the PRUSS memory region
+ */
+struct pruss_mem_region {
+	void __iomem *va;
+	phys_addr_t pa;
+	size_t size;
+};
+
+struct pruss;
+
+#if IS_ENABLED(CONFIG_TI_PRUSS)
+
+int pruss_request_mem_region(struct pruss *pruss, enum pruss_mem mem_id,
+			     struct pruss_mem_region *region);
+int pruss_release_mem_region(struct pruss *pruss,
+			     struct pruss_mem_region *region);
+
+#else
+
+static inline int pruss_request_mem_region(struct pruss *pruss,
+					   enum pruss_mem mem_id,
+					   struct pruss_mem_region *region)
+{
+	return -ENOTSUPP;
+}
+
+static inline int pruss_release_mem_region(struct pruss *pruss,
+					   struct pruss_mem_region *region)
+{
+	return -ENOTSUPP;
+}
+
+#endif /* CONFIG_TI_PRUSS */
+
+#endif /* __LINUX_PRUSS_H */
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

