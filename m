Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C609FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892F820663
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892F820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394542AbeKVVuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:50:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:39305 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387933AbeKVVut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:50:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2018 03:11:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,265,1539673200"; 
   d="scan'208";a="91290769"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga007.jf.intel.com with ESMTP; 22 Nov 2018 03:11:52 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next v2 1/7] mei: dma ring buffers allocation
Date:   Thu, 22 Nov 2018 13:11:36 +0200
Message-Id: <20181122111142.18653-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181122111142.18653-1-tomas.winkler@intel.com>
References: <20181122111142.18653-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate DMA ring buffers from managed coherent memory.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/Makefile   |  1 +
 drivers/misc/mei/dma-ring.c | 99 +++++++++++++++++++++++++++++++++++++
 drivers/misc/mei/hw-me.c    |  6 +++
 drivers/misc/mei/mei_dev.h  | 20 ++++++++
 4 files changed, 126 insertions(+)
 create mode 100644 drivers/misc/mei/dma-ring.c

diff --git a/drivers/misc/mei/Makefile b/drivers/misc/mei/Makefile
index cd6825afa8e1..d9215fc4e499 100644
--- a/drivers/misc/mei/Makefile
+++ b/drivers/misc/mei/Makefile
@@ -9,6 +9,7 @@ mei-objs += hbm.o
 mei-objs += interrupt.o
 mei-objs += client.o
 mei-objs += main.o
+mei-objs += dma-ring.o
 mei-objs += bus.o
 mei-objs += bus-fixup.o
 mei-$(CONFIG_DEBUG_FS) += debugfs.o
diff --git a/drivers/misc/mei/dma-ring.c b/drivers/misc/mei/dma-ring.c
new file mode 100644
index 000000000000..56f4c0882a20
--- /dev/null
+++ b/drivers/misc/mei/dma-ring.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright(c) 2016 - 2018 Intel Corporation. All rights reserved.
+ */
+#include <linux/dma-mapping.h>
+#include <linux/mei.h>
+
+#include "mei_dev.h"
+
+/**
+ * mei_dmam_dscr_alloc() - allocate a managed coherent buffer
+ *     for the dma descriptor
+ * @dev: mei_device
+ * @dscr: dma descriptor
+ *
+ * Return:
+ * * 0       - on success or zero allocation request
+ * * -EINVAL - if size is not power of 2
+ * * -ENOMEM - of allocation has failed
+ */
+static int mei_dmam_dscr_alloc(struct mei_device *dev,
+			       struct mei_dma_dscr *dscr)
+{
+	if (!dscr->size)
+		return 0;
+
+	if (WARN_ON(!is_power_of_2(dscr->size)))
+		return -EINVAL;
+
+	if (dscr->vaddr)
+		return 0;
+
+	dscr->vaddr = dmam_alloc_coherent(dev->dev, dscr->size, &dscr->daddr,
+					  GFP_KERNEL);
+	if (!dscr->vaddr)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * mei_dmam_dscr_free() - free a managed coherent buffer
+ *     from the dma descriptor
+ * @dev: mei_device
+ * @dscr: dma descriptor
+ */
+static void mei_dmam_dscr_free(struct mei_device *dev,
+			       struct mei_dma_dscr *dscr)
+{
+	if (!dscr->vaddr)
+		return;
+
+	dmam_free_coherent(dev->dev, dscr->size, dscr->vaddr, dscr->daddr);
+	dscr->vaddr = NULL;
+}
+
+/**
+ * mei_dmam_ring_free() - free dma ring buffers
+ * @dev: mei device
+ */
+void mei_dmam_ring_free(struct mei_device *dev)
+{
+	int i;
+
+	for (i = 0; i < DMA_DSCR_NUM; i++)
+		mei_dmam_dscr_free(dev, &dev->dr_dscr[i]);
+}
+
+/**
+ * mei_dmam_ring_alloc() - allocate dma ring buffers
+ * @dev: mei device
+ *
+ * Return: -ENOMEM on allocation failure 0 otherwise
+ */
+int mei_dmam_ring_alloc(struct mei_device *dev)
+{
+	int i;
+
+	for (i = 0; i < DMA_DSCR_NUM; i++)
+		if (mei_dmam_dscr_alloc(dev, &dev->dr_dscr[i]))
+			goto err;
+
+	return 0;
+
+err:
+	mei_dmam_ring_free(dev);
+	return -ENOMEM;
+}
+
+/**
+ * mei_dma_ring_is_allocated() - check if dma ring is allocated
+ * @dev: mei device
+ *
+ * Return: true if dma ring is allocated
+ */
+bool mei_dma_ring_is_allocated(struct mei_device *dev)
+{
+	return !!dev->dr_dscr[DMA_DSCR_HOST].vaddr;
+}
diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index 0759c3a668de..3fbbadfa2ae1 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -1471,15 +1471,21 @@ struct mei_device *mei_me_dev_init(struct pci_dev *pdev,
 {
 	struct mei_device *dev;
 	struct mei_me_hw *hw;
+	int i;
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(struct mei_device) +
 			   sizeof(struct mei_me_hw), GFP_KERNEL);
 	if (!dev)
 		return NULL;
+
 	hw = to_me_hw(dev);
 
+	for (i = 0; i < DMA_DSCR_NUM; i++)
+		dev->dr_dscr[i].size = cfg->dma_size[i];
+
 	mei_device_init(dev, &pdev->dev, &mei_me_hw_ops);
 	hw->cfg = cfg;
+
 	return dev;
 }
 
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 377397e1b5a5..a6796e3f712b 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -122,6 +122,19 @@ struct mei_msg_data {
 	unsigned char *data;
 };
 
+/**
+ * struct mei_dma_dscr - dma address descriptor
+ *
+ * @vaddr: dma buffer virtual address
+ * @daddr: dma buffer physical address
+ * @size : dma buffer size
+ */
+struct mei_dma_dscr {
+	void *vaddr;
+	dma_addr_t daddr;
+	size_t size;
+};
+
 /* Maximum number of processed FW status registers */
 #define MEI_FW_STATUS_MAX 6
 /* Minimal  buffer for FW status string (8 bytes in dw + space or '\0') */
@@ -409,6 +422,7 @@ struct mei_fw_version {
  * @rd_msg_hdr  : read message header storage
  *
  * @hbuf_is_ready : query if the host host/write buffer is ready
+ * @dr_dscr: DMA ring descriptors: TX, RX, and CTRL
  *
  * @version     : HBM protocol version in use
  * @hbm_f_pg_supported  : hbm feature pgi protocol
@@ -488,6 +502,8 @@ struct mei_device {
 	/* write buffer */
 	bool hbuf_is_ready;
 
+	struct mei_dma_dscr dr_dscr[DMA_DSCR_NUM];
+
 	struct hbm_version version;
 	unsigned int hbm_f_pg_supported:1;
 	unsigned int hbm_f_dc_supported:1;
@@ -578,6 +594,10 @@ int mei_restart(struct mei_device *dev);
 void mei_stop(struct mei_device *dev);
 void mei_cancel_work(struct mei_device *dev);
 
+int mei_dmam_ring_alloc(struct mei_device *dev);
+void mei_dmam_ring_free(struct mei_device *dev);
+bool mei_dma_ring_is_allocated(struct mei_device *dev);
+
 /*
  *  MEI interrupt functions prototype
  */
-- 
2.17.2

