Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715A6C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3579923FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3579923FCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933274AbeFVJ6W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:58:22 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:39596 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751325AbeFVJ6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:58:20 -0400
X-IronPort-AV: E=Sophos;i="5.51,256,1526367600"; 
   d="scan'208";a="5079190"
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Jun 2018 02:58:19 -0700
Received: from westreach.qualcomm.com ([10.228.196.125])
  by ironmsg02-sd.qualcomm.com with ESMTP; 22 Jun 2018 02:58:18 -0700
Received: by westreach.qualcomm.com (Postfix, from userid 467151)
        id 28F911F27; Fri, 22 Jun 2018 05:58:18 -0400 (EDT)
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
Subject: [PATCH v2 2/6] PCI/AER: Clear uncorrectable fatal error status bits
Date:   Fri, 22 Jun 2018 05:58:10 -0400
Message-Id: <1529661494-20936-3-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529661494-20936-1-git-send-email-poza@codeaurora.org>
References: <1529661494-20936-1-git-send-email-poza@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During ERR_FATAL handling, AER calls pci_cleanup_aer_uncorrect_error_status
which should handle pci_channel_io_frozen case in order to determine if it
has to clear fatal bits.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d6cb1f0..e9c115d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -369,7 +369,12 @@ int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
 	/* Clean AER Root Error Status */
 	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
 	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &mask);
-	status &= ~mask; /* Clear corresponding nonfatal bits */
+
+	if (dev->error_state == pci_channel_io_normal)
+		status &= ~mask; /* Clear corresponding nonfatal bits */
+	else
+		status &= mask; /* Clear corresponding fatal bits */
+
 	if (status)
 		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
 
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index f7ce0cb..00d2875 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -288,6 +288,7 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
 	struct pci_dev *pdev, *temp;
 	pci_ers_result_t result;
 
+	dev->error_state = pci_channel_io_frozen;
 	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
 		udev = dev;
 	else
@@ -323,6 +324,7 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
 		if (pcie_wait_for_link(udev, true))
 			pci_rescan_bus(udev->bus);
 		pci_info(dev, "Device recovery from fatal error successful\n");
+		dev->error_state = pci_channel_io_normal;
 	} else {
 		pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
 		pci_info(dev, "Device recovery from fatal error failed\n");
-- 
2.7.4

