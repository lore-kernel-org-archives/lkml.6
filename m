Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 3tI5FQjKGFuMbgAAmS7hNA
	; Thu, 07 Jun 2018 06:00:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E5D72608BA; Thu,  7 Jun 2018 06:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528351257;
	bh=nUNnxqhFeajlK3z0L3ue31jORRm/f3kiORBGmlBKcSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CfyEfreyLViDL5j5F+DjnkOs2FDzZocYfW9kqkExLx1ZeXK+zNhaQ+tspYSo6Koi3
	 l1+hT8Uwp9Cul0e5HdWSjfLlWY+CLUxthCOlWL1PJiujFOSoXGa50VK32PnIcJlfyL
	 8o8D8ittUtoN1+lZJ1EFX6tds8/mEvyDI8aXzKbs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 65C5D605A2;
	Thu,  7 Jun 2018 06:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65C5D605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752986AbeFGGAm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 02:00:42 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:25158 "EHLO
        wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751472AbeFGGAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 02:00:38 -0400
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="343895036"
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by wolverine01.qualcomm.com with ESMTP; 06 Jun 2018 23:00:37 -0700
X-IronPort-AV: E=McAfee;i="5900,7806,8916"; a="103689610"
Received: from westreach.qualcomm.com ([10.228.196.125])
  by ironmsg05-sd.qualcomm.com with ESMTP; 06 Jun 2018 23:00:36 -0700
Received: by westreach.qualcomm.com (Postfix, from userid 467151)
        id E7C641F30; Thu,  7 Jun 2018 02:00:35 -0400 (EDT)
From: Oza Pawandeep <poza@codeaurora.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Cc: Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH NEXT 4/6] PCI/AER: Clear device status error bits during ERR_FATAL and ERR_NONFATAL
Date: Thu,  7 Jun 2018 02:00:32 -0400
Message-Id: <1528351234-26914-4-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528351234-26914-1-git-send-email-poza@codeaurora.org>
References: <1528351234-26914-1-git-send-email-poza@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are handling ERR_FATAL by resetting the Link in software,skipping the
driver pci_error_handlers callbacks, removing the devices from the PCI
subsystem, and re-enumerating, the device status has to be cleared,
which fixes BUG existed before.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 8cbc62b..0d9eaba 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -341,12 +341,8 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
  */
 static void aer_error_resume(struct pci_dev *dev)
 {
-	u16 reg16;
-
 	/* Clean up Root device status */
-	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &reg16);
-	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, reg16);
-
+	pci_cleanup_aer_error_device_status(dev);
 	/* Clean AER Root Error Status */
 	pci_cleanup_aer_uncorrect_error_status(dev);
 }
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 6745e37..95e9828 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -47,6 +47,17 @@ int pci_disable_pcie_error_reporting(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_disable_pcie_error_reporting);
 
+int pci_cleanup_aer_error_device_status(struct pci_dev *dev)
+{
+	u16 reg16;
+
+	/* Clean up Root device status */
+	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &reg16);
+	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, reg16);
+
+	return 0;
+}
+
 int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
 {
 	int pos;
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 3998ed7..e1e642c 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -252,6 +252,7 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 			dev->error_state = state;
 		pci_walk_bus(dev->subordinate, cb, &result_data);
 		if (cb == report_resume) {
+			pci_cleanup_aer_error_device_status(dev);
 			pci_cleanup_aer_uncorrect_error_status(dev);
 			dev->error_state = pci_channel_io_normal;
 		}
@@ -312,6 +313,7 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
 		 * do error recovery on all subordinates of the bridge instead
 		 * of the bridge and clear the error status of the bridge.
 		 */
+		pci_cleanup_aer_error_device_status(dev);
 		pci_cleanup_aer_uncorrect_error_status(dev);
 	}
 
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 514bffa..165a147 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -44,6 +44,7 @@ struct aer_capability_regs {
 /* PCIe port driver needs this function to enable AER */
 int pci_enable_pcie_error_reporting(struct pci_dev *dev);
 int pci_disable_pcie_error_reporting(struct pci_dev *dev);
+int pci_cleanup_aer_error_device_status(struct pci_dev *dev);
 int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);
 int pci_cleanup_aer_error_status_regs(struct pci_dev *dev);
 #else
@@ -55,6 +56,10 @@ static inline int pci_disable_pcie_error_reporting(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
+static inline int pci_cleanup_aer_error_device_status(struct pci_dev *dev)
+{
+	return -EINVAL;
+}
 static inline int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
 {
 	return -EINVAL;
-- 
2.7.4
