Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034ADC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51B120876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51B120876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbeJNXLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:11:50 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35831 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727353AbeJNXLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:48 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLb-0004cD-RB; Sun, 14 Oct 2018 16:30:28 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLZ-0000go-BH; Sun, 14 Oct 2018 16:30:25 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ronak Doshi" <doshir@vmware.com>,
        "David S. Miller" <davem@davemloft.net>,
        "hpreg@vmware.com" <hpreg@vmware.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.160160137@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 312/366] vmxnet3: set the DMA mask before the first
 DMA map operation
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "hpreg@vmware.com" <hpreg@vmware.com>

commit 61aeecea40afb2b89933e27cd4adb10fc2e75cfd upstream.

The DMA mask must be set before, not after, the first DMA map operation, or
the first DMA map operation could in theory fail on some systems.

Fixes: b0eb57cb97e78 ("VMXNET3: Add support for virtual IOMMU")
Signed-off-by: Regis Duchesne <hpreg@vmware.com>
Acked-by: Ronak Doshi <doshir@vmware.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: Bump version from 1.2.1.0-k to 1.2.2.0-k, which
 wasn't used in mainline]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 50 +++++++++++++++----------------
 drivers/net/vmxnet3/vmxnet3_int.h |  8 +++--
 2 files changed, 30 insertions(+), 28 deletions(-)

--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2445,7 +2445,7 @@ vmxnet3_set_mac_addr(struct net_device *
 /* ==================== initialization and cleanup routines ============ */
 
 static int
-vmxnet3_alloc_pci_resources(struct vmxnet3_adapter *adapter, bool *dma64)
+vmxnet3_alloc_pci_resources(struct vmxnet3_adapter *adapter)
 {
 	int err;
 	unsigned long mmio_start, mmio_len;
@@ -2457,30 +2457,12 @@ vmxnet3_alloc_pci_resources(struct vmxne
 		return err;
 	}
 
-	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64)) == 0) {
-		if (pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64)) != 0) {
-			dev_err(&pdev->dev,
-				"pci_set_consistent_dma_mask failed\n");
-			err = -EIO;
-			goto err_set_mask;
-		}
-		*dma64 = true;
-	} else {
-		if (pci_set_dma_mask(pdev, DMA_BIT_MASK(32)) != 0) {
-			dev_err(&pdev->dev,
-				"pci_set_dma_mask failed\n");
-			err = -EIO;
-			goto err_set_mask;
-		}
-		*dma64 = false;
-	}
-
 	err = pci_request_selected_regions(pdev, (1 << 2) - 1,
 					   vmxnet3_driver_name);
 	if (err) {
 		dev_err(&pdev->dev,
 			"Failed to request region for adapter: error %d\n", err);
-		goto err_set_mask;
+		goto err_enable_device;
 	}
 
 	pci_set_master(pdev);
@@ -2508,7 +2490,7 @@ err_bar1:
 	iounmap(adapter->hw_addr0);
 err_ioremap:
 	pci_release_selected_regions(pdev, (1 << 2) - 1);
-err_set_mask:
+err_enable_device:
 	pci_disable_device(pdev);
 	return err;
 }
@@ -2973,7 +2955,7 @@ vmxnet3_probe_device(struct pci_dev *pde
 #endif
 	};
 	int err;
-	bool dma64 = false; /* stupid gcc */
+	bool dma64;
 	u32 ver;
 	struct net_device *netdev;
 	struct vmxnet3_adapter *adapter;
@@ -3018,6 +3000,24 @@ vmxnet3_probe_device(struct pci_dev *pde
 	adapter->tx_ring_size = VMXNET3_DEF_TX_RING_SIZE;
 	adapter->rx_ring_size = VMXNET3_DEF_RX_RING_SIZE;
 
+	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64)) == 0) {
+		if (pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64)) != 0) {
+			dev_err(&pdev->dev,
+				"pci_set_consistent_dma_mask failed\n");
+			err = -EIO;
+			goto err_set_mask;
+		}
+		dma64 = true;
+	} else {
+		if (pci_set_dma_mask(pdev, DMA_BIT_MASK(32)) != 0) {
+			dev_err(&pdev->dev,
+				"pci_set_dma_mask failed\n");
+			err = -EIO;
+			goto err_set_mask;
+		}
+		dma64 = false;
+	}
+
 	spin_lock_init(&adapter->cmd_lock);
 	adapter->adapter_pa = dma_map_single(&adapter->pdev->dev, adapter,
 					     sizeof(struct vmxnet3_adapter),
@@ -3025,7 +3025,7 @@ vmxnet3_probe_device(struct pci_dev *pde
 	if (dma_mapping_error(&adapter->pdev->dev, adapter->adapter_pa)) {
 		dev_err(&pdev->dev, "Failed to map dma\n");
 		err = -EFAULT;
-		goto err_dma_map;
+		goto err_set_mask;
 	}
 	adapter->shared = dma_alloc_coherent(
 				&adapter->pdev->dev,
@@ -3076,7 +3076,7 @@ vmxnet3_probe_device(struct pci_dev *pde
 	}
 #endif /* VMXNET3_RSS */
 
-	err = vmxnet3_alloc_pci_resources(adapter, &dma64);
+	err = vmxnet3_alloc_pci_resources(adapter);
 	if (err < 0)
 		goto err_alloc_pci;
 
@@ -3180,7 +3180,7 @@ err_alloc_queue_desc:
 err_alloc_shared:
 	dma_unmap_single(&adapter->pdev->dev, adapter->adapter_pa,
 			 sizeof(struct vmxnet3_adapter), PCI_DMA_TODEVICE);
-err_dma_map:
+err_set_mask:
 	free_netdev(netdev);
 	return err;
 }
--- a/drivers/net/vmxnet3/vmxnet3_int.h
+++ b/drivers/net/vmxnet3/vmxnet3_int.h
@@ -69,10 +69,12 @@
 /*
  * Version numbers
  */
-#define VMXNET3_DRIVER_VERSION_STRING   "1.2.1.0-k"
+#define VMXNET3_DRIVER_VERSION_STRING   "1.2.2.0-k"
 
-/* a 32-bit int, each byte encode a verion number in VMXNET3_DRIVER_VERSION */
-#define VMXNET3_DRIVER_VERSION_NUM      0x01020100
+/* Each byte of this 32-bit integer encodes a version number in
+ * VMXNET3_DRIVER_VERSION_STRING.
+ */
+#define VMXNET3_DRIVER_VERSION_NUM      0x01020200
 
 #if defined(CONFIG_PCI_MSI)
 	/* RSS only makes sense if MSI-X is supported. */

