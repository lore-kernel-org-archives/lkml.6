Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18CDC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B89223FF3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B89223FF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754345AbeFVJ67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:58:59 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:37799 "EHLO
        wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752029AbeFVJ6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:58:21 -0400
X-IronPort-AV: E=Sophos;i="5.51,256,1526367600"; 
   d="scan'208";a="346278395"
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by wolverine01.qualcomm.com with ESMTP; 22 Jun 2018 02:58:20 -0700
X-IronPort-AV: E=McAfee;i="5900,7806,8931"; a="222664697"
Received: from westreach.qualcomm.com ([10.228.196.125])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 22 Jun 2018 02:58:18 -0700
Received: by westreach.qualcomm.com (Postfix, from userid 467151)
        id 129C41EE2; Fri, 22 Jun 2018 05:58:17 -0400 (EDT)
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
Subject: [PATCH v2 1/6] PCI/AER: Take severity mask into account while clearing error bits
Date:   Fri, 22 Jun 2018 05:58:09 -0400
Message-Id: <1529661494-20936-2-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529661494-20936-1-git-send-email-poza@codeaurora.org>
References: <1529661494-20936-1-git-send-email-poza@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_cleanup_aer_uncorrect_error_status() is called by different slot_reset
callbacks in case of ERR_NONFATAL.

AER uncorrectable error status should take severity into account in order
to clear the bits, so that ERR_NONFATAL path does not clear the bit which
are marked with severity fatal.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2e8838..d6cb1f0 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -360,13 +360,16 @@ EXPORT_SYMBOL_GPL(pci_disable_pcie_error_reporting);
 int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
 {
 	int pos;
-	u32 status;
+	u32 status, mask;
 
 	pos = dev->aer_cap;
 	if (!pos)
 		return -EIO;
 
+	/* Clean AER Root Error Status */
 	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
+	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &mask);
+	status &= ~mask; /* Clear corresponding nonfatal bits */
 	if (status)
 		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
 
@@ -1336,8 +1339,6 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
  */
 static void aer_error_resume(struct pci_dev *dev)
 {
-	int pos;
-	u32 status, mask;
 	u16 reg16;
 
 	/* Clean up Root device status */
@@ -1345,11 +1346,7 @@ static void aer_error_resume(struct pci_dev *dev)
 	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, reg16);
 
 	/* Clean AER Root Error Status */
-	pos = dev->aer_cap;
-	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
-	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &mask);
-	status &= ~mask; /* Clear corresponding nonfatal bits */
-	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
+	pci_cleanup_aer_uncorrect_error_status(dev);
 }
 
 static struct pcie_port_service_driver aerdriver = {
-- 
2.7.4

