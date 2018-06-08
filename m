Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ZxovITvjGlt9PAAAmS7hNA
	; Fri, 08 Jun 2018 20:12:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6E959608BF; Fri,  8 Jun 2018 20:12:43 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLVlI2EK"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 25FC66089E;
	Fri,  8 Jun 2018 20:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 25FC66089E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932086AbeFHUMg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:12:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753115AbeFHUMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:12:33 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4883206B7;
        Fri,  8 Jun 2018 20:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528488752;
        bh=/79RUPsUPmX/JEhrn52CHxbCa+WggclOBN9rJRnnvYk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TLVlI2EK3raVbEvBEaNPdUgcG0g1uHWhMQdUKIOHKqimdIP0Phl+QxepUSeKB0UH2
         rAuxIJSFv80ATraHJ+jQ9astAySFeSuirk9DkALlTzcxJ0vaP/bMlRVbDy2GuzXzqx
         L9AKVDMBVBoMlHO3khX6hCRVYx+oeleN1nmJdsuY=
Subject: [PATCH v1 5/9] PCI/portdrv: Squash lookup interfaces into
 portdrv_pci.c
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Oza Pawandeep <poza@codeaurora.org>, linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:12:31 -0500
Message-ID: <152848875188.14051.2166609505666979991.stgit@bhelgaas-glaptop.roam.corp.google.com>
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

Squash lookup interfaces into portdrv_pci.c.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv_core.c |   69 ---------------------------------------
 drivers/pci/pcie/portdrv_pci.c  |   68 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 69 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 2ef046af08d2..77b1c1ea8885 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -19,75 +19,6 @@
 #include "../pci.h"
 #include "portdrv.h"
 
-struct portdrv_service_data {
-	struct pcie_port_service_driver *drv;
-	struct device *dev;
-	u32 service;
-};
-
-static int find_service_iter(struct device *device, void *data)
-{
-	struct pcie_port_service_driver *service_driver;
-	struct portdrv_service_data *pdrvs;
-	u32 service;
-
-	pdrvs = (struct portdrv_service_data *) data;
-	service = pdrvs->service;
-
-	if (device->bus == &pcie_port_bus_type && device->driver) {
-		service_driver = to_service_driver(device->driver);
-		if (service_driver->service == service) {
-			pdrvs->drv = service_driver;
-			pdrvs->dev = device;
-			return 1;
-		}
-	}
-
-	return 0;
-}
-
-/**
- * pcie_port_find_service - find the service driver
- * @dev: PCI Express port the service is associated with
- * @service: Service to find
- *
- * Find PCI Express port service driver associated with given service
- */
-struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
-							u32 service)
-{
-	struct pcie_port_service_driver *drv;
-	struct portdrv_service_data pdrvs;
-
-	pdrvs.drv = NULL;
-	pdrvs.service = service;
-	device_for_each_child(&dev->dev, &pdrvs, find_service_iter);
-
-	drv = pdrvs.drv;
-	return drv;
-}
-
-/**
- * pcie_port_find_device - find the struct device
- * @dev: PCI Express port the service is associated with
- * @service: For the service to find
- *
- * Find the struct device associated with given service on a pci_dev
- */
-struct device *pcie_port_find_device(struct pci_dev *dev,
-				      u32 service)
-{
-	struct device *device;
-	struct portdrv_service_data pdrvs;
-
-	pdrvs.dev = NULL;
-	pdrvs.service = service;
-	device_for_each_child(&dev->dev, &pdrvs, find_service_iter);
-
-	device = pdrvs.dev;
-	return device;
-}
-
 /**
  * pcie_port_probe_service - probe driver for given PCI Express port service
  * @dev: PCI Express port service device to probe against
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index ab5e3a63981b..b019af97f14e 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -42,6 +42,74 @@ __setup("pcie_ports=", pcie_port_setup);
 
 /* global data */
 
+struct portdrv_service_data {
+	struct pcie_port_service_driver *drv;
+	struct device *dev;
+	u32 service;
+};
+
+static int find_service_iter(struct device *device, void *data)
+{
+	struct pcie_port_service_driver *service_driver;
+	struct portdrv_service_data *pdrvs;
+	u32 service;
+
+	pdrvs = (struct portdrv_service_data *) data;
+	service = pdrvs->service;
+
+	if (device->bus == &pcie_port_bus_type && device->driver) {
+		service_driver = to_service_driver(device->driver);
+		if (service_driver->service == service) {
+			pdrvs->drv = service_driver;
+			pdrvs->dev = device;
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * pcie_port_find_service - find the service driver
+ * @dev: PCI Express port the service is associated with
+ * @service: Service to find
+ *
+ * Find PCI Express port service driver associated with given service
+ */
+struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
+							u32 service)
+{
+	struct pcie_port_service_driver *drv;
+	struct portdrv_service_data pdrvs;
+
+	pdrvs.drv = NULL;
+	pdrvs.service = service;
+	device_for_each_child(&dev->dev, &pdrvs, find_service_iter);
+
+	drv = pdrvs.drv;
+	return drv;
+}
+
+/**
+ * pcie_port_find_device - find the struct device
+ * @dev: PCI Express port the service is associated with
+ * @service: For the service to find
+ *
+ * Find the struct device associated with given service on a pci_dev
+ */
+struct device *pcie_port_find_device(struct pci_dev *dev, u32 service)
+{
+	struct device *device;
+	struct portdrv_service_data pdrvs;
+
+	pdrvs.dev = NULL;
+	pdrvs.service = service;
+	device_for_each_child(&dev->dev, &pdrvs, find_service_iter);
+
+	device = pdrvs.dev;
+	return device;
+}
+
 static int pcie_portdrv_restore_config(struct pci_dev *dev)
 {
 	int retval;
