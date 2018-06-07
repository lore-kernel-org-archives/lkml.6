Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fruHCAnKGFuobgAAmS7hNA
	; Thu, 07 Jun 2018 06:01:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B25136089E; Thu,  7 Jun 2018 06:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528351290;
	bh=yHYqUxKdpVHbAUbpRxrf8jB+HoU7SrV9NMo9El4+2Ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f7cK/wSQzvykkaj6OEC+slirMm4X8D7dR3KYarGv+ooZfxFpkw4B2KMZNlSpxax3o
	 Xj4q+Os89BjkTZ7E3+fkcaJ2+ucbcI41AENm6dgu27OI2WKw1CcZ65odLbjlAI14vG
	 az1W4L1eA3mVAEeVdHtUXH19xN9991vlVOwEkolA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 48C61605A2;
	Thu,  7 Jun 2018 06:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 48C61605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753118AbeFGGB3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 02:01:29 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:20187 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752561AbeFGGAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 02:00:39 -0400
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="4326793"
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Jun 2018 23:00:38 -0700
Received: from westreach.qualcomm.com ([10.228.196.125])
  by ironmsg02-sd.qualcomm.com with ESMTP; 06 Jun 2018 23:00:36 -0700
Received: by westreach.qualcomm.com (Postfix, from userid 467151)
        id CDC2E1F06; Thu,  7 Jun 2018 02:00:35 -0400 (EDT)
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
Subject: [PATCH NEXT 2/6] PCI/AER: Clear uncorrectable fatal error status bits
Date: Thu,  7 Jun 2018 02:00:30 -0400
Message-Id: <1528351234-26914-2-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528351234-26914-1-git-send-email-poza@codeaurora.org>
References: <1528351234-26914-1-git-send-email-poza@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During ERR_FATAL handling, AER calls pci_cleanup_aer_uncorrect_error_status
which should handle pci_channel_io_frozen case in order to determine if it
has to clear fatal bits or nonfatal bits.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 309f3f5..6745e37 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -60,7 +60,12 @@ int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
 	pos = dev->aer_cap;
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
