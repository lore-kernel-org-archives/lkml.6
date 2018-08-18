Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67543C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 23:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFD2206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 23:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeG2iHxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFD2206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbeHTCcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 22:32:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbeHTCck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 22:32:40 -0400
Received: from localhost.localdomain (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2A0C20C51;
        Sun, 19 Aug 2018 23:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534720769;
        bh=44y+9eoZ90iQR+zBtghnOOSlPhHHwCSUKtXKQt94PbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jeG2iHxoUOcD5d7Id3mTuI5Tnoz0Akfeq/gyq3kk9WbB75MkTOmQPdNLAWzWtduRU
         cUZ+87gPMKVAJDiEaPXNszLixyUweFWQIrOkyT6o5wkKVSp9rrIZO9txIzNAkKiTCi
         pC2mmypc7mbrLvaGpiv/cKvBKhdjDr3VR2hHScSg=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 2/2] PCI: pciehp: Mask AER surprise link down error if hotplug is enabled
Date:   Fri, 17 Aug 2018 23:51:10 -0700
Message-Id: <20180818065126.77912-2-okaya@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180818065126.77912-1-okaya@kernel.org>
References: <20180818065126.77912-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCIe Spec 3.0. 7.10.2. Uncorrectable Error Status Register (Offset 04h)
defines link down errors as an AER error as bit 5 Surprise Down Error
Status.

If hotplug is supported by a particular port, we want hotplug driver
to handle the link down/up conditions via Data Link Layer Active
interrupt rather than the AER error interrupt. Mask the Surprise Down
Error during hotplug driver and re-enable it during remove.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/pci/hotplug/pciehp_core.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ec48c9433ae5..8322db8f369a 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -229,6 +229,29 @@ static void pciehp_check_presence(struct controller *ctrl)
 	up_read(&ctrl->reset_lock);
 }
 
+static int pciehp_control_surprise_error(struct controller *ctrl, bool enable)
+{
+	struct pci_dev *pdev = ctrl->pcie->port;
+	u32 reg32;
+	int pos;
+
+	if (!pci_is_pcie(pdev))
+		return -ENODEV;
+
+	pos = pdev->aer_cap;
+	if (!pos)
+		return -ENODEV;
+
+	pci_read_config_dword(pdev, pos + PCI_ERR_UNCOR_MASK, &reg32);
+	if (enable)
+		reg32 &= ~PCI_ERR_UNC_SURPDN;
+	else
+		reg32 |= PCI_ERR_UNC_SURPDN;
+	pci_write_config_dword(pdev, pos + PCI_ERR_UNCOR_MASK, reg32);
+
+	return 0;
+}
+
 static int pciehp_probe(struct pcie_device *dev)
 {
 	int rc;
@@ -280,6 +303,9 @@ static int pciehp_probe(struct pcie_device *dev)
 
 	pciehp_check_presence(ctrl);
 
+	/* We want exclusive control of link down events in hotplug driver */
+	pciehp_control_surprise_error(ctrl, false);
+
 	return 0;
 
 err_out_shutdown_notification:
@@ -298,6 +324,7 @@ static void pciehp_remove(struct pcie_device *dev)
 	pci_hp_del(ctrl->slot->hotplug_slot);
 	pcie_shutdown_notification(ctrl);
 	cleanup_slot(ctrl);
+	pciehp_control_surprise_error(ctrl, true);
 	pciehp_release_ctrl(ctrl);
 }
 
-- 
2.17.1

