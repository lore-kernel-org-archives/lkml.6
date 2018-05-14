Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753232AbeENM2e (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:28:34 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:57850 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752333AbeENM2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:28:32 -0400
From: <hpreg@vmware.com>
To: <netdev@vger.kernel.org>
CC: Regis Duchesne <hpreg@vmware.com>, Ronak Doshi <doshir@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH net 1/2] vmxnet3: set the DMA mask before the first DMA map operation
Date: Mon, 14 May 2018 08:28:26 -0400
Message-ID: <1526300907-79831-1-git-send-email-hpreg@vmware.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA mask must be set before, not after, the first DMA map operation, or
the first DMA map operation could in theory fail on some systems.

Fixes: b0eb57cb97e78 ("VMXNET3: Add support for virtual IOMMU")
Signed-off-by: Regis Duchesne <hpreg@vmware.com>
Acked-by: Ronak Doshi <doshir@vmware.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 50 +++++++++++++++++++--------------------
 drivers/net/vmxnet3/vmxnet3_int.h |  8 ++++---
 2 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 9ebe2a6..ed58685 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2688,7 +2688,7 @@ vmxnet3_set_mac_addr(struct net_device *netdev, void *p)
 /* ==================== initialization and cleanup routines ============ */
 
 static int
-vmxnet3_alloc_pci_resources(struct vmxnet3_adapter *adapter, bool *dma64)
+vmxnet3_alloc_pci_resources(struct vmxnet3_adapter *adapter)
 {
 	int err;
 	unsigned long mmio_start, mmio_len;
@@ -2700,30 +2700,12 @@ vmxnet3_alloc_pci_resources(struct vmxnet3_adapter *adapter, bool *dma64)
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
@@ -2751,7 +2733,7 @@ vmxnet3_alloc_pci_resources(struct vmxnet3_adapter *adapter, bool *dma64)
 	iounmap(adapter->hw_addr0);
 err_ioremap:
 	pci_release_selected_regions(pdev, (1 << 2) - 1);
-err_set_mask:
+err_enable_device:
 	pci_disable_device(pdev);
 	return err;
 }
@@ -3254,7 +3236,7 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 #endif
 	};
 	int err;
-	bool dma64 = false; /* stupid gcc */
+	bool dma64;
 	u32 ver;
 	struct net_device *netdev;
 	struct vmxnet3_adapter *adapter;
@@ -3300,6 +3282,24 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 	adapter->rx_ring_size = VMXNET3_DEF_RX_RING_SIZE;
 	adapter->rx_ring2_size = VMXNET3_DEF_RX_RING2_SIZE;
 
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
@@ -3307,7 +3307,7 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 	if (dma_mapping_error(&adapter->pdev->dev, adapter->adapter_pa)) {
 		dev_err(&pdev->dev, "Failed to map dma\n");
 		err = -EFAULT;
-		goto err_dma_map;
+		goto err_set_mask;
 	}
 	adapter->shared = dma_alloc_coherent(
 				&adapter->pdev->dev,
@@ -3358,7 +3358,7 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 	}
 #endif /* VMXNET3_RSS */
 
-	err = vmxnet3_alloc_pci_resources(adapter, &dma64);
+	err = vmxnet3_alloc_pci_resources(adapter);
 	if (err < 0)
 		goto err_alloc_pci;
 
@@ -3504,7 +3504,7 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 err_alloc_shared:
 	dma_unmap_single(&adapter->pdev->dev, adapter->adapter_pa,
 			 sizeof(struct vmxnet3_adapter), PCI_DMA_TODEVICE);
-err_dma_map:
+err_set_mask:
 	free_netdev(netdev);
 	return err;
 }
diff --git a/drivers/net/vmxnet3/vmxnet3_int.h b/drivers/net/vmxnet3/vmxnet3_int.h
index a332646..b379bed 100644
--- a/drivers/net/vmxnet3/vmxnet3_int.h
+++ b/drivers/net/vmxnet3/vmxnet3_int.h
@@ -69,10 +69,12 @@
 /*
  * Version numbers
  */
-#define VMXNET3_DRIVER_VERSION_STRING   "1.4.14.0-k"
+#define VMXNET3_DRIVER_VERSION_STRING   "1.4.15.0-k"
 
-/* a 32-bit int, each byte encode a verion number in VMXNET3_DRIVER_VERSION */
-#define VMXNET3_DRIVER_VERSION_NUM      0x01040e00
+/* Each byte of this 32-bit integer encodes a version number in
+ * VMXNET3_DRIVER_VERSION_STRING.
+ */
+#define VMXNET3_DRIVER_VERSION_NUM      0x01040f00
 
 #if defined(CONFIG_PCI_MSI)
 	/* RSS only makes sense if MSI-X is supported. */
-- 
2.7.4
