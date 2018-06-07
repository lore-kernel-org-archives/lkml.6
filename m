Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id oDfOGizKGFuUbgAAmS7hNA
	; Thu, 07 Jun 2018 06:01:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 50C8C608B8; Thu,  7 Jun 2018 06:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528351276;
	bh=pRUAw7VHiKX9BWzDacLGocxsXsJ0O9pJ5mtcpFI0XTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oh/KBlJEvF2e7jlW3+qiUFR49cr3jtOm2fddnmDeo9/bLopSHh6efyuO0cnQuFBFk
	 6+7yU74wKhNw9QwFw2mAyorC5HG1iOBHC71ZB1OiC2DfI3lzSX3w8iGkfjW0OGDHCv
	 dja8pfRpzwDAWtfkrMeD8NGeNDF/DlB9mgmfIgD0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DB33A607F7;
	Thu,  7 Jun 2018 06:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB33A607F7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753082AbeFGGBO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 02:01:14 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:20156 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752583AbeFGGAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 02:00:40 -0400
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="4326802"
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Jun 2018 23:00:38 -0700
Received: from westreach.qualcomm.com ([10.228.196.125])
  by ironmsg01-sd.qualcomm.com with ESMTP; 06 Jun 2018 23:00:37 -0700
Received: by westreach.qualcomm.com (Postfix, from userid 467151)
        id 143681F32; Thu,  7 Jun 2018 02:00:36 -0400 (EDT)
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
Subject: [PATCH NEXT 6/6] PCI/PORTDRV: Remove ERR_FATAL handling from pcie_portdrv_slot_reset()
Date: Thu,  7 Jun 2018 02:00:34 -0400
Message-Id: <1528351234-26914-6-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528351234-26914-1-git-send-email-poza@codeaurora.org>
References: <1528351234-26914-1-git-send-email-poza@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are handling ERR_FATAL by resetting the Link in software,skipping the
driver pci_error_handlers callbacks, removing the devices from the PCI
subsystem, and re-enumerating, as a result of that, no more calling
pcie_portdrv_slot_reset in ERR_FATAL case.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 973f1b8..92f5d330 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -42,17 +42,6 @@ __setup("pcie_ports=", pcie_port_setup);
 
 /* global data */
 
-static int pcie_portdrv_restore_config(struct pci_dev *dev)
-{
-	int retval;
-
-	retval = pci_enable_device(dev);
-	if (retval)
-		return retval;
-	pci_set_master(dev);
-	return 0;
-}
-
 #ifdef CONFIG_PM
 static int pcie_port_runtime_suspend(struct device *dev)
 {
@@ -162,14 +151,6 @@ static pci_ers_result_t pcie_portdrv_mmio_enabled(struct pci_dev *dev)
 
 static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
 {
-	/* If fatal, restore cfg space for possible link reset at upstream */
-	if (dev->error_state == pci_channel_io_frozen) {
-		dev->state_saved = true;
-		pci_restore_state(dev);
-		pcie_portdrv_restore_config(dev);
-		pci_enable_pcie_error_reporting(dev);
-	}
-
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-- 
2.7.4
