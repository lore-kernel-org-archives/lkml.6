Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163170AbeBOPZV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:25:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33951 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162134AbeBOPZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:25:17 -0500
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] nvme-pci: do a PCI reset after S3 on Samsung 960 EVO/PM961/SM961 + Razer Blade Stealth
Date: Thu, 15 Feb 2018 23:24:56 +0800
Message-Id: <20180215152456.21795-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit 8427bbc22486 ("nvme-pci: disable APST on Samsung SSD
960 EVO + ASUS PRIME B350M-A"), the NVMe drops off the PCIe bus after
S3.

We managed to find that a PCI reset after resume can workaround the
issue.

If we have more reports for Samsung 960 EVO/PM961/SM961, we should make
this quirk mandatory.

BugLink: https://bugs.launchpad.net/bugs/1746340
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8e4550fa08f8..e970423b7944 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -83,6 +83,11 @@ enum nvme_quirks {
 	 * Supports the LighNVM command set if indicated in vs[1].
 	 */
 	NVME_QUIRK_LIGHTNVM			= (1 << 6),
+
+	/*
+	 * The controller needs to do a PCI reset after resume.
+	 */
+	NVME_QUIRK_PCI_RESET_RESUME		= (1 << 7),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6fe7af00a1f4..e96dc301a4e7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2084,6 +2084,9 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	int result = -ENOMEM;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
+	if (dev->ctrl.quirks & NVME_QUIRK_PCI_RESET_RESUME)
+		pci_reset_function(pdev);
+
 	if (pci_enable_device_mem(pdev))
 		return result;
 
@@ -2455,6 +2458,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 		if (dmi_match(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC.") &&
 		    dmi_match(DMI_BOARD_NAME, "PRIME B350M-A"))
 			return NVME_QUIRK_NO_APST;
+		/*
+		 * Samsung SSD 960 EVO and SM961/PM961 drop off the PCIe bus
+		 * after system suspend on Razer Blade Stealth.
+		 */
+		else if (dmi_match(DMI_SYS_VENDOR, "Razer") &&
+			 dmi_match(DMI_PRODUCT_NAME, "Blade Stealth"))
+			return NVME_QUIRK_PCI_RESET_RESUME;
 	}
 
 	return 0;
-- 
2.15.1
