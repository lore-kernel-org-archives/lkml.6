Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D91DC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250F6277C2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nPdNqIX6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bPJa63y0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250F6277C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030523AbeF1Sae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:30:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37002 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030505AbeF1Sa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:30:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C097D60C6C; Thu, 28 Jun 2018 18:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530210628;
        bh=7amJamHHqQHBPl05nOR2fU2RCC8Buu+5v5PZz+VwP4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nPdNqIX6eHbeBKPxkPKuhkMkgiA532RBZtOl+bALtGdSWkWi83CgEvgjxFl5WfVLh
         x7cWj1/SbwoH8FO0taaNDfZAcQ1nJVbXf743F1h2c8hZFDgjO7zKwwLa3MkIZFloy7
         n05GQOiQToko19I1Dhx6OxBt6jSztPDI9Ez3gIPs=
Received: from drakthul.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7968660BDF;
        Thu, 28 Jun 2018 18:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530210597;
        bh=7amJamHHqQHBPl05nOR2fU2RCC8Buu+5v5PZz+VwP4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bPJa63y0fIMoOh8Ulcg3TAj1eM9HwMli2q/SOB6ofJpZjlujl2bpjPqu/VLu89ZVZ
         97CGfL3Rde++q2sNKFPs2hMd08+Fbpviy4KwZhbXRYIZTJne6JGKE+RxjrDXGnFaMy
         3u6R/eetFjZJKGLkirFSgBsnT3KJN80fpGbvtNQg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7968660BDF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From:   Sinan Kaya <okaya@codeaurora.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V3 6/6] PCI: Handle link reset via hotplug if supported
Date:   Thu, 28 Jun 2018 14:28:26 -0400
Message-Id: <1530210507-9287-6-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530210507-9287-1-git-send-email-okaya@codeaurora.org>
References: <1530210507-9287-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a bridge supports hotplug and observes a PCIe fatal error, the following
events happen:

1. AER driver removes the devices from PCI tree on fatal error
2. AER driver brings down the link by issuing a secondary bus reset waits
for the link to come up.
3. Hotplug driver observes a link down interrupt
4. Hotplug driver tries to remove the devices waiting for the rescan lock
but devices are already removed by the AER driver and AER driver is waiting
for the link to come back up.
5. AER driver tries to re-enumerate devices after polling for the link
state to go up.
6. Hotplug driver obtains the lock and tries to remove the devices again.

If a bridge is a hotplug capable bridge, bounce the error handling to the
hotplug driver so that hotplug driver can mask link up/down interrupts
while performing a secondary bus reset.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/hotplug/pciehp_core.c | 20 ++++++++++++++++++++
 drivers/pci/pcie/err.c            |  5 +++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 44a6a63..43a49cc 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -299,6 +299,24 @@ static int pciehp_resume(struct pcie_device *dev)
 }
 #endif /* PM */
 
+static pci_ers_result_t pciehp_reset_link(struct pci_dev *pdev)
+{
+	struct pcie_device *pciedev;
+	struct controller *ctrl;
+	struct device *devhp;
+	struct slot *slot;
+	int rc;
+
+	devhp = pcie_port_find_device(pdev, PCIE_PORT_SERVICE_HP);
+	pciedev = to_pcie_device(devhp);
+	ctrl = get_service_data(pciedev);
+	slot = ctrl->slot;
+
+	rc = reset_slot(slot->hotplug_slot, 0);
+
+	return !rc ? PCI_ERS_RESULT_RECOVERED : PCI_ERS_RESULT_DISCONNECT;
+}
+
 static struct pcie_port_service_driver hpdriver_portdrv = {
 	.name		= PCIE_MODULE_NAME,
 	.port_type	= PCIE_ANY_PORT,
@@ -311,6 +329,8 @@ static struct pcie_port_service_driver hpdriver_portdrv = {
 	.suspend	= pciehp_suspend,
 	.resume		= pciehp_resume,
 #endif	/* PM */
+
+	.reset_link	= pciehp_reset_link,
 };
 
 static int __init pcied_init(void)
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index a3a26f1..0b66779 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -308,6 +308,11 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
 		pci_dev_put(pdev);
 	}
 
+	/* handle link reset via hotplug driver if supported */
+	if (dev->is_hotplug_bridge &&
+		pcie_port_find_device(dev, PCIE_PORT_SERVICE_HP))
+		service = PCIE_PORT_SERVICE_HP;
+
 	result = reset_link(udev, service);
 
 	if ((service == PCIE_PORT_SERVICE_AER) &&
-- 
2.7.4

