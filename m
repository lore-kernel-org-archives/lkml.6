Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +4bnAgnKGFuCbgAAmS7hNA
	; Thu, 07 Jun 2018 06:01:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0D0D86089E; Thu,  7 Jun 2018 06:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528351268;
	bh=7znXL8/kh+8THLv9Fm7aX1ruEhIj6hr/O08BHoYhIGw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=aDJaCDXG1axtuUd160T0hN9D+SmNZ5qTZ9JAgjj0oQ09+2wP9VrzgrMY9lk1yakDd
	 sRERPS6gCwuo7FEeAtaWSoaRnwGGj+mhHJNfeHIms4AVy+327yKRb/GUuNF9EdkvON
	 F4OKDtJgdygQ7FkkzOr0PV9uA+bCPLzl4cxdZsVk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8C0A0602FC;
	Thu,  7 Jun 2018 06:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8C0A0602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752880AbeFGGAk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 02:00:40 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:20156 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751410AbeFGGAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 02:00:38 -0400
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="4326788"
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Jun 2018 23:00:37 -0700
Received: from westreach.qualcomm.com ([10.228.196.125])
  by ironmsg01-sd.qualcomm.com with ESMTP; 06 Jun 2018 23:00:36 -0700
Received: by westreach.qualcomm.com (Postfix, from userid 467151)
        id C50481F22; Thu,  7 Jun 2018 02:00:35 -0400 (EDT)
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
Subject: [PATCH NEXT 1/6] PCI/AER: Take mask into account while clearing error bits
Date: Thu,  7 Jun 2018 02:00:29 -0400
Message-Id: <1528351234-26914-1-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCIe ERR_NONFATAL and ERR_FATAL are uncorrectable errors, and clearing
uncorrectable error bits should take error mask into account.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 377e576..8cbc62b 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -341,8 +341,6 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
  */
 static void aer_error_resume(struct pci_dev *dev)
 {
-	int pos;
-	u32 status, mask;
 	u16 reg16;
 
 	/* Clean up Root device status */
@@ -350,11 +348,7 @@ static void aer_error_resume(struct pci_dev *dev)
 	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, reg16);
 
 	/* Clean AER Root Error Status */
-	pos = dev->aer_cap;
-	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
-	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &mask);
-	status &= ~mask; /* Clear corresponding nonfatal bits */
-	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
+	pci_cleanup_aer_uncorrect_error_status(dev);
 }
 
 /**
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 946f3f6..309f3f5 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -50,13 +50,17 @@ EXPORT_SYMBOL_GPL(pci_disable_pcie_error_reporting);
 int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
 {
 	int pos;
-	u32 status;
+	u32 status, mask;
 
 	pos = dev->aer_cap;
 	if (!pos)
 		return -EIO;
 
+	/* Clean AER Root Error Status */
+	pos = dev->aer_cap;
 	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
+	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &mask);
+	status &= ~mask; /* Clear corresponding nonfatal bits */
 	if (status)
 		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
 
-- 
2.7.4
