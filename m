Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kRwWCCXjGluEPAAAmS7hNA
	; Fri, 08 Jun 2018 20:12:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 573F2608BA; Fri,  8 Jun 2018 20:12:33 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdRWSkNL"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C2F08601D2;
	Fri,  8 Jun 2018 20:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2F08601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753113AbeFHUMb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:12:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753061AbeFHUM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:12:27 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83109206B7;
        Fri,  8 Jun 2018 20:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528488746;
        bh=FKUd47oD/8ggZ9rec5l/rQEIGCIEXLBsnjPMZK98vic=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UdRWSkNLyEOrE/qfDtXuypBMjFxf7yeZz40hRsCK544hBZTeMa+Ya7mYPdGfw5Ovb
         8Kel9heTJnW0N9qIQUpQsIREgC97jqRCJHHpsX3m3NkMeDowN49NavGnIDVxCmDWYR
         FAzmY/k2R9oh2ABmqPFDRlNHL2AddCjC7lsNmZTY=
Subject: [PATCH v1 4/9] PCI/portdrv: Squash device removal code into
 portdrv_pci.c
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Oza Pawandeep <poza@codeaurora.org>, linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:12:25 -0500
Message-ID: <152848874571.14051.17371000358965533938.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152848853199.14051.12670957565366345798.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152848853199.14051.12670957565366345798.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Move device removal code next to its caller in portdrv_pci.c.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv.h      |    1 -
 drivers/pci/pcie/portdrv_core.c |   21 ---------------------
 drivers/pci/pcie/portdrv_pci.c  |   21 +++++++++++++++++++++
 3 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index cb2a33ea68a5..ab3631a61347 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -79,7 +79,6 @@ void pcie_port_service_unregister(struct pcie_port_service_driver *new);
 #define get_descriptor_id(type, service) (((type - 4) << 8) | service)
 
 extern struct bus_type pcie_port_bus_type;
-void pcie_port_device_remove(struct pci_dev *dev);
 int __must_check pcie_port_bus_register(void);
 void pcie_port_bus_unregister(void);
 
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 9bcc856738ff..2ef046af08d2 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -25,13 +25,6 @@ struct portdrv_service_data {
 	u32 service;
 };
 
-static int remove_iter(struct device *dev, void *data)
-{
-	if (dev->bus == &pcie_port_bus_type)
-		device_unregister(dev);
-	return 0;
-}
-
 static int find_service_iter(struct device *device, void *data)
 {
 	struct pcie_port_service_driver *service_driver;
@@ -95,20 +88,6 @@ struct device *pcie_port_find_device(struct pci_dev *dev,
 	return device;
 }
 
-/**
- * pcie_port_device_remove - unregister PCI Express port service devices
- * @dev: PCI Express port the service devices to unregister are associated with
- *
- * Remove PCI Express port service devices associated with given port and
- * disable MSI-X or MSI for the port.
- */
-void pcie_port_device_remove(struct pci_dev *dev)
-{
-	device_for_each_child(&dev->dev, NULL, remove_iter);
-	pci_free_irq_vectors(dev);
-	pci_disable_device(dev);
-}
-
 /**
  * pcie_port_probe_service - probe driver for given PCI Express port service
  * @dev: PCI Express port service device to probe against
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 1b7855a062ff..ab5e3a63981b 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -506,6 +506,27 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	return 0;
 }
 
+static int remove_iter(struct device *dev, void *data)
+{
+	if (dev->bus == &pcie_port_bus_type)
+		device_unregister(dev);
+	return 0;
+}
+
+/**
+ * pcie_port_device_remove - unregister PCI Express port service devices
+ * @dev: PCI Express port the service devices to unregister are associated with
+ *
+ * Remove PCI Express port service devices associated with given port and
+ * disable MSI-X or MSI for the port.
+ */
+static void pcie_port_device_remove(struct pci_dev *dev)
+{
+	device_for_each_child(&dev->dev, NULL, remove_iter);
+	pci_free_irq_vectors(dev);
+	pci_disable_device(dev);
+}
+
 static void pcie_portdrv_remove(struct pci_dev *dev)
 {
 	if (pci_bridge_d3_possible(dev)) {
