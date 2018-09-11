Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FA3C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7636820865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7636820865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbeILEqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:46:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:5839 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727841AbeILEql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:46:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 16:45:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,362,1531810800"; 
   d="scan'208";a="72208239"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.116.215])
  by orsmga007.jf.intel.com with ESMTP; 11 Sep 2018 16:45:01 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hong Liu <hong.liu@intel.com>
Subject: [PATCH 8/9] HID: intel-ish-hid: use resource-managed api
Date:   Tue, 11 Sep 2018 16:44:20 -0700
Message-Id: <20180911234421.10691-9-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
References: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hong Liu <hong.liu@intel.com>

Use resource-managed api to simplify error handling in probe and
driver remove logic.

With this patch, we can save ~170 bytes code size in intel-ish-ipc.ko.
before:
   text	   data	    bss	    dec	    hex	filename
  11495	   1568	     72	  13135	   334f	intel-ish-ipc.ko
after:
   text    data     bss     dec     hex filename
  11327    1568      72   12967    32a7 intel-ish-ipc.ko

Signed-off-by: Hong Liu <hong.liu@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 75 ++++++++-----------------
 1 file changed, 24 insertions(+), 51 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index 050f9872f5c0..09d085946db3 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -113,18 +113,19 @@ static const struct pci_device_id ish_invalid_pci_ids[] = {
  */
 static int ish_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
-	struct ishtp_device *dev;
+	int ret;
 	struct ish_hw *hw;
-	int	ret;
+	struct ishtp_device *ishtp;
+	struct device *dev = &pdev->dev;
 
 	/* Check for invalid platforms for ISH support */
 	if (pci_dev_present(ish_invalid_pci_ids))
 		return -ENODEV;
 
 	/* enable pci dev */
-	ret = pci_enable_device(pdev);
+	ret = pcim_enable_device(pdev);
 	if (ret) {
-		dev_err(&pdev->dev, "ISH: Failed to enable PCI device\n");
+		dev_err(dev, "ISH: Failed to enable PCI device\n");
 		return ret;
 	}
 
@@ -132,65 +133,44 @@ static int ish_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_master(pdev);
 
 	/* pci request regions for ISH driver */
-	ret = pci_request_regions(pdev, KBUILD_MODNAME);
+	ret = pcim_iomap_regions(pdev, 1 << 0, KBUILD_MODNAME);
 	if (ret) {
-		dev_err(&pdev->dev, "ISH: Failed to get PCI regions\n");
-		goto disable_device;
+		dev_err(dev, "ISH: Failed to get PCI regions\n");
+		return ret;
 	}
 
 	/* allocates and initializes the ISH dev structure */
-	dev = ish_dev_init(pdev);
-	if (!dev) {
+	ishtp = ish_dev_init(pdev);
+	if (!ishtp) {
 		ret = -ENOMEM;
-		goto release_regions;
+		return ret;
 	}
-	hw = to_ish_hw(dev);
-	dev->print_log = ish_event_tracer;
+	hw = to_ish_hw(ishtp);
+	ishtp->print_log = ish_event_tracer;
 
 	/* mapping IO device memory */
-	hw->mem_addr = pci_iomap(pdev, 0, 0);
-	if (!hw->mem_addr) {
-		dev_err(&pdev->dev, "ISH: mapping I/O range failure\n");
-		ret = -ENOMEM;
-		goto free_device;
-	}
-
-	dev->pdev = pdev;
-
+	hw->mem_addr = pcim_iomap_table(pdev)[0];
+	ishtp->pdev = pdev;
 	pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
 
 	/* request and enable interrupt */
-	ret = request_irq(pdev->irq, ish_irq_handler, IRQF_SHARED,
-			  KBUILD_MODNAME, dev);
+	ret = devm_request_irq(dev, pdev->irq, ish_irq_handler,
+			       IRQF_SHARED, KBUILD_MODNAME, ishtp);
 	if (ret) {
-		dev_err(&pdev->dev, "ISH: request IRQ failure (%d)\n",
-			pdev->irq);
-		goto free_device;
+		dev_err(dev, "ISH: request IRQ %d failed\n", pdev->irq);
+		return ret;
 	}
 
-	dev_set_drvdata(dev->devc, dev);
+	dev_set_drvdata(ishtp->devc, ishtp);
 
-	init_waitqueue_head(&dev->suspend_wait);
-	init_waitqueue_head(&dev->resume_wait);
+	init_waitqueue_head(&ishtp->suspend_wait);
+	init_waitqueue_head(&ishtp->resume_wait);
 
-	ret = ish_init(dev);
+	ret = ish_init(ishtp);
 	if (ret)
-		goto free_irq;
+		return ret;
 
 	return 0;
-
-free_irq:
-	free_irq(pdev->irq, dev);
-free_device:
-	pci_iounmap(pdev, hw->mem_addr);
-release_regions:
-	pci_release_regions(pdev);
-disable_device:
-	pci_clear_master(pdev);
-	pci_disable_device(pdev);
-	dev_err(&pdev->dev, "ISH: PCI driver initialization failed.\n");
-
-	return ret;
 }
 
 /**
@@ -202,16 +182,9 @@ static int ish_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 static void ish_remove(struct pci_dev *pdev)
 {
 	struct ishtp_device *ishtp_dev = pci_get_drvdata(pdev);
-	struct ish_hw *hw = to_ish_hw(ishtp_dev);
 
 	ishtp_bus_remove_all_clients(ishtp_dev, false);
 	ish_device_disable(ishtp_dev);
-
-	free_irq(pdev->irq, ishtp_dev);
-	pci_iounmap(pdev, hw->mem_addr);
-	pci_release_regions(pdev);
-	pci_clear_master(pdev);
-	pci_disable_device(pdev);
 }
 
 static struct device __maybe_unused *ish_resume_device;
-- 
2.17.1

