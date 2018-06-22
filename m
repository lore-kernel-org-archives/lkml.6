Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5167C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9670823FE4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9670823FE4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933429AbeFVJ7A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:59:00 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:39596 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753275AbeFVJ6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:58:21 -0400
X-IronPort-AV: E=Sophos;i="5.51,256,1526367600"; 
   d="scan'208";a="5079205"
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Jun 2018 02:58:21 -0700
Received: from westreach.qualcomm.com ([10.228.196.125])
  by ironmsg01-sd.qualcomm.com with ESMTP; 22 Jun 2018 02:58:19 -0700
Received: by westreach.qualcomm.com (Postfix, from userid 467151)
        id 50A551F33; Fri, 22 Jun 2018 05:58:18 -0400 (EDT)
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
Subject: [PATCH v2 6/6] PCI/PORTDRV: Remove ERR_FATAL handling from pcie_portdrv_slot_reset()
Date:   Fri, 22 Jun 2018 05:58:14 -0400
Message-Id: <1529661494-20936-7-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529661494-20936-1-git-send-email-poza@codeaurora.org>
References: <1529661494-20936-1-git-send-email-poza@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are handling ERR_FATAL by resetting the Link in software,skipping the
driver pci_error_handlers callbacks, removing the devices from the PCI
subsystem, and re-enumerating, because of, no need to handle
pci_channel_io_frozen case anymore.

Besides the walk on the bus is happening on subordinates, inside
broadcast_error_message(), which means that pcie_portdrv_slot_reset()
is never called for RP, and now since the all the devices are removed under
this downstream link, we can safely get rid of ERR_FATAL handling code
in pcie_portdrv_slot_reset().

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 973f1b8..b970a6d 100644
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
@@ -163,13 +152,6 @@ static pci_ers_result_t pcie_portdrv_mmio_enabled(struct pci_dev *dev)
 static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
 {
 	/* If fatal, restore cfg space for possible link reset at upstream */
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

