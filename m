Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9KpnK4AaG1vVWwAAmS7hNA
	; Sat, 09 Jun 2018 00:08:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 942756089E; Sat,  9 Jun 2018 00:08:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 32DE7607A4;
	Sat,  9 Jun 2018 00:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 32DE7607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753214AbeFIAI2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 20:08:28 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60556 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752779AbeFIAI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 20:08:27 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1fRRQd-00043o-2Q; Fri, 08 Jun 2018 18:08:26 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1fRRQb-0003cq-Mp; Fri, 08 Jun 2018 18:08:21 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Shuah Khan <shuah@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Date: Fri,  8 Jun 2018 18:08:12 -0600
Message-Id: <20180609000819.13883-3-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180609000819.13883-1-logang@deltatee.com>
References: <20180609000819.13883-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, fancer.lancer@gmail.com, Shyam-sundar.S-k@amd.com, shuah@kernel.org, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 2/8] NTB: Setup the DMA mask globally for all drivers
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit  417cf39cfea9 ("NTB: Set dma mask and dma coherent mask to NTB
devices") added code to set the DMA mask for the NTB device
to each driver individually. However, it neglected to set it for the
Switchtec driver. So when the monolithic commit 7f46c8b3a552 ("NTB:
ntb_tool: Add full multi-port NTB API support") started allocating
DMA memory against the NTB device it broke the Switchtec driver.

Seeing this is setting up a property of the NTB device, it should be
done by the common NTB code (inside ntb_register_device()) so we can be
sure it's done properly for all drivers. This avoids each driver needing
to duplicate the code and helps prevent us from inadvertently breaking
one of the drivers in the future if we have to make changes in this area.

Fixes: 7f46c8b3a552 ("NTB: ntb_tool: Add full multi-port NTB API support")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c     |  4 ----
 drivers/ntb/hw/idt/ntb_hw_idt.c     |  6 ------
 drivers/ntb/hw/intel/ntb_hw_intel.c |  4 ----
 drivers/ntb/ntb.c                   | 13 ++++++++++++-
 4 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 3cfa46876239..f0788aae05c9 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1020,10 +1020,6 @@ static int amd_ntb_init_pci(struct amd_ntb_dev *ndev,
 			goto err_dma_mask;
 		dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
 	}
-	rc = dma_coerce_mask_and_coherent(&ndev->ntb.dev,
-					  dma_get_mask(&pdev->dev));
-	if (rc)
-		goto err_dma_mask;
 
 	ndev->self_mmio = pci_iomap(pdev, 0, 0);
 	if (!ndev->self_mmio) {
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 8d98872d0983..1918a2db1c43 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2447,12 +2447,6 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
 		dev_warn(&pdev->dev,
 			"Cannot set consistent DMA highmem bit mask\n");
 	}
-	ret = dma_coerce_mask_and_coherent(&ndev->ntb.dev,
-					   dma_get_mask(&pdev->dev));
-	if (ret != 0) {
-		dev_err(&pdev->dev, "Failed to set NTB device DMA bit mask\n");
-		return ret;
-	}
 
 	/*
 	 * Enable the device advanced error reporting. It's not critical to
diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index 156b45cd4a19..341a3d5baa3f 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -2334,10 +2334,6 @@ static int intel_ntb_init_pci(struct intel_ntb_dev *ndev, struct pci_dev *pdev)
 			goto err_dma_mask;
 		dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
 	}
-	rc = dma_coerce_mask_and_coherent(&ndev->ntb.dev,
-					  dma_get_mask(&pdev->dev));
-	if (rc)
-		goto err_dma_mask;
 
 	ndev->self_mmio = pci_iomap(pdev, 0, 0);
 	if (!ndev->self_mmio) {
diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
index 2581ab724c34..93f24440d11d 100644
--- a/drivers/ntb/ntb.c
+++ b/drivers/ntb/ntb.c
@@ -100,6 +100,8 @@ EXPORT_SYMBOL(ntb_unregister_client);
 
 int ntb_register_device(struct ntb_dev *ntb)
 {
+	int ret;
+
 	if (!ntb)
 		return -EINVAL;
 	if (!ntb->pdev)
@@ -120,7 +122,16 @@ int ntb_register_device(struct ntb_dev *ntb)
 	ntb->ctx_ops = NULL;
 	spin_lock_init(&ntb->ctx_lock);
 
-	return device_register(&ntb->dev);
+	device_initialize(&ntb->dev);
+
+	ret = dma_coerce_mask_and_coherent(&ntb->dev,
+					   dma_get_mask(&ntb->pdev->dev));
+	if (ret != 0) {
+		dev_err(&ntb->dev, "Failed to set NTB device DMA bit mask\n");
+		return ret;
+	}
+
+	return device_add(&ntb->dev);
 }
 EXPORT_SYMBOL(ntb_register_device);
 
-- 
2.11.0
