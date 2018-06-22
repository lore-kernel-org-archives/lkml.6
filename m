Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF3DC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49AF23FDD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49AF23FDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933370AbeFVJ6Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:58:25 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:39596 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751369AbeFVJ6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:58:21 -0400
X-IronPort-AV: E=Sophos;i="5.51,256,1526367600"; 
   d="scan'208";a="5079194"
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Jun 2018 02:58:20 -0700
Received: from westreach.qualcomm.com ([10.228.196.125])
  by ironmsg02-sd.qualcomm.com with ESMTP; 22 Jun 2018 02:58:18 -0700
Received: by westreach.qualcomm.com (Postfix, from userid 467151)
        id 317C41F30; Fri, 22 Jun 2018 05:58:18 -0400 (EDT)
From:   Oza Pawandeep <poza@codeaurora.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Cc:     Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH v2 4/6] PCI/AER: Clear device error status bits during ERR_FATAL and ERR_NONFATAL
Date:   Fri, 22 Jun 2018 05:58:12 -0400
Message-Id: <1529661494-20936-5-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529661494-20936-1-git-send-email-poza@codeaurora.org>
References: <1529661494-20936-1-git-send-email-poza@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In both ERR_FATAL and ERR_NONFATA cases the device error status
bits needs to be cleared.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e9c115d..d2d6868 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -357,6 +357,17 @@ int pci_disable_pcie_error_reporting(struct pci_dev *dev)
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
@@ -1344,11 +1355,8 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
  */
 static void aer_error_resume(struct pci_dev *dev)
 {
-	u16 reg16;
-
 	/* Clean up Root device status */
-	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &reg16);
-	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, reg16);
+	pci_cleanup_aer_error_device_status(dev);
 
 	/* Clean AER Root Error Status */
 	pci_cleanup_aer_uncorrect_error_status(dev);
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 404bb69..410c35c 100644
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

