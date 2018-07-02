Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B652C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E7024823
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="obNYgi+6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RtC4njDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E7024823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753647AbeGBWxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:53:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34944 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753500AbeGBWxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:53:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 062C960B72; Mon,  2 Jul 2018 22:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530572026;
        bh=pYHQTxnahFexmpL0lQMGi2zFFobmcYwl9fUxyeMG0/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=obNYgi+69uFQK8/CA/GVTO9zgspjE6gW3YlRZHFOje6DZoNAJpKUjMkKGb9d3Aa+P
         MwtvhW88bih6XY2AHenyg+kl5LJLQGmhpLQeyJRh9C6wB9gboksmZogVvARuVdw3+M
         ubGEpGtkPxBvU9UeUxqj/9fdZX0VNFbtFijtoAiU=
Received: from drakthul.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7692260B7E;
        Mon,  2 Jul 2018 22:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530572025;
        bh=pYHQTxnahFexmpL0lQMGi2zFFobmcYwl9fUxyeMG0/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RtC4njDKHyVHGvive42vHZS2h2QVXs+5smq5x9HQBtLyvoejuO27wQCn3EB/qolPT
         vG1pf2X5tXL9ArF6sh5s/8zhu/F0cDUbUiXqdNKCG5kwv048YwaAQx5mgQdgzmr60k
         uVQ1KHt28JUBFBQ6iMfhGVYPPDN+M33Bm1XKg17M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7692260B7E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From:   Sinan Kaya <okaya@codeaurora.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during reset
Date:   Mon,  2 Jul 2018 18:52:47 -0400
Message-Id: <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
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

If a bridge is a hotplug capable bridge, mask hotplug interrupts before the
reset and unmask afterwards.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pcie/err.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index ae72f88..5a2d410 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -285,10 +285,12 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
  */
 void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
 {
+	struct pcie_port_service_driver *hpsvc;
 	struct pci_dev *udev;
 	struct pci_bus *parent;
 	struct pci_dev *pdev, *temp;
 	pci_ers_result_t result;
+	struct device *hpdev;
 
 	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
 		udev = dev;
@@ -308,8 +310,17 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
 		pci_dev_put(pdev);
 	}
 
+	hpsvc = pcie_port_find_service(udev, PCIE_PORT_SERVICE_HP);
+	hpdev = pcie_port_find_device(udev, PCIE_PORT_SERVICE_HP);
+
+	if (hpdev && hpsvc)
+		hpsvc->mask_irq(to_pcie_device(hpdev));
+
 	result = reset_link(udev, service);
 
+	if (hpdev && hpsvc)
+		hpsvc->unmask_irq(to_pcie_device(hpdev));
+
 	if ((service == PCIE_PORT_SERVICE_AER) &&
 	    (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)) {
 		/*
-- 
2.7.4

