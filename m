Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Il5BMADjGltxOgAAmS7hNA
	; Fri, 08 Jun 2018 20:12:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B2AA2607DC; Fri,  8 Jun 2018 20:12:23 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYHOBJhp"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 42D43605A5;
	Fri,  8 Jun 2018 20:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 42D43605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753000AbeFHUMS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:12:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752938AbeFHUMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:12:15 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20A1B206B7;
        Fri,  8 Jun 2018 20:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528488734;
        bh=q9iJ7k4yiXDJX0pkBdKs/dMn2KFsuo3ZfrvIOqBygEw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IYHOBJhp54cv6LL0sZ7psdr8WWu9ZQllzX1FLvHTfQS7Lhj4/3r9lfTbeGL8S8sU9
         Vlwulrl2GJkhmk5mHBrFSQKF/8BA6Wy7MD7AuBojHqGymcWc4imP5srnyFnTLug8Pc
         J4hkcvylCZBk82sBx8r8SVo5mYuKki6xMpu3ktg4=
Subject: [PATCH v1 2/9] PCI/portdrv: Squash pieces of portdrv_core.c into
 portdrv_pci.c
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Oza Pawandeep <poza@codeaurora.org>, linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:12:13 -0500
Message-ID: <152848873329.14051.1617906507777653814.stgit@bhelgaas-glaptop.roam.corp.google.com>
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

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv.h      |    1 
 drivers/pci/pcie/portdrv_core.c |  327 ---------------------------------------
 drivers/pci/pcie/portdrv_pci.c  |  328 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 327 insertions(+), 329 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 2bb5db7b53e6..7a2e5f0dfb53 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -79,7 +79,6 @@ void pcie_port_service_unregister(struct pcie_port_service_driver *new);
 #define get_descriptor_id(type, service) (((type - 4) << 8) | service)
 
 extern struct bus_type pcie_port_bus_type;
-int pcie_port_device_register(struct pci_dev *dev);
 #ifdef CONFIG_PM
 int pcie_port_device_suspend(struct device *dev);
 int pcie_port_device_resume(struct device *dev);
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index e0261ad4bcdd..747a58d6aaf4 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -25,333 +25,6 @@ struct portdrv_service_data {
 	u32 service;
 };
 
-/**
- * release_pcie_device - free PCI Express port service device structure
- * @dev: Port service device to release
- *
- * Invoked automatically when device is being removed in response to
- * device_unregister(dev).  Release all resources being claimed.
- */
-static void release_pcie_device(struct device *dev)
-{
-	kfree(to_pcie_device(dev));
-}
-
-/*
- * Fill in *pme, *aer, *dpc with the relevant Interrupt Message Numbers if
- * services are enabled in "mask".  Return the number of MSI/MSI-X vectors
- * required to accommodate the largest Message Number.
- */
-static int pcie_message_numbers(struct pci_dev *dev, int mask,
-				u32 *pme, u32 *aer, u32 *dpc)
-{
-	u32 nvec = 0, pos;
-	u16 reg16;
-
-	/*
-	 * The Interrupt Message Number indicates which vector is used, i.e.,
-	 * the MSI-X table entry or the MSI offset between the base Message
-	 * Data and the generated interrupt message.  See PCIe r3.1, sec
-	 * 7.8.2, 7.10.10, 7.31.2.
-	 */
-
-	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
-		pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
-		*pme = (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
-		nvec = *pme + 1;
-	}
-
-#ifdef CONFIG_PCIEAER
-	if (mask & PCIE_PORT_SERVICE_AER) {
-		u32 reg32;
-
-		pos = dev->aer_cap;
-		if (pos) {
-			pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS,
-					      &reg32);
-			*aer = (reg32 & PCI_ERR_ROOT_AER_IRQ) >> 27;
-			nvec = max(nvec, *aer + 1);
-		}
-	}
-#endif
-
-	if (mask & PCIE_PORT_SERVICE_DPC) {
-		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC);
-		if (pos) {
-			pci_read_config_word(dev, pos + PCI_EXP_DPC_CAP,
-					     &reg16);
-			*dpc = reg16 & PCI_EXP_DPC_IRQ;
-			nvec = max(nvec, *dpc + 1);
-		}
-	}
-
-	return nvec;
-}
-
-/**
- * pcie_port_enable_irq_vec - try to set up MSI-X or MSI as interrupt mode
- * for given port
- * @dev: PCI Express port to handle
- * @irqs: Array of interrupt vectors to populate
- * @mask: Bitmask of port capabilities returned by get_port_device_capability()
- *
- * Return value: 0 on success, error code on failure
- */
-static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
-{
-	int nr_entries, nvec;
-	u32 pme = 0, aer = 0, dpc = 0;
-
-	/* Allocate the maximum possible number of MSI/MSI-X vectors */
-	nr_entries = pci_alloc_irq_vectors(dev, 1, PCIE_PORT_MAX_MSI_ENTRIES,
-			PCI_IRQ_MSIX | PCI_IRQ_MSI);
-	if (nr_entries < 0)
-		return nr_entries;
-
-	/* See how many and which Interrupt Message Numbers we actually use */
-	nvec = pcie_message_numbers(dev, mask, &pme, &aer, &dpc);
-	if (nvec > nr_entries) {
-		pci_free_irq_vectors(dev);
-		return -EIO;
-	}
-
-	/*
-	 * If we allocated more than we need, free them and reallocate fewer.
-	 *
-	 * Reallocating may change the specific vectors we get, so
-	 * pci_irq_vector() must be done *after* the reallocation.
-	 *
-	 * If we're using MSI, hardware is *allowed* to change the Interrupt
-	 * Message Numbers when we free and reallocate the vectors, but we
-	 * assume it won't because we allocate enough vectors for the
-	 * biggest Message Number we found.
-	 */
-	if (nvec != nr_entries) {
-		pci_free_irq_vectors(dev);
-
-		nr_entries = pci_alloc_irq_vectors(dev, nvec, nvec,
-				PCI_IRQ_MSIX | PCI_IRQ_MSI);
-		if (nr_entries < 0)
-			return nr_entries;
-	}
-
-	/* PME and hotplug share an MSI/MSI-X vector */
-	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
-		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pci_irq_vector(dev, pme);
-		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pci_irq_vector(dev, pme);
-	}
-
-	if (mask & PCIE_PORT_SERVICE_AER)
-		irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pci_irq_vector(dev, aer);
-
-	if (mask & PCIE_PORT_SERVICE_DPC)
-		irqs[PCIE_PORT_SERVICE_DPC_SHIFT] = pci_irq_vector(dev, dpc);
-
-	return 0;
-}
-
-/**
- * pcie_init_service_irqs - initialize irqs for PCI Express port services
- * @dev: PCI Express port to handle
- * @irqs: Array of irqs to populate
- * @mask: Bitmask of port capabilities returned by get_port_device_capability()
- *
- * Return value: Interrupt mode associated with the port
- */
-static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
-{
-	int ret, i;
-
-	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
-		irqs[i] = -1;
-
-	/*
-	 * If we support PME but can't use MSI/MSI-X for it, we have to
-	 * fall back to INTx or other interrupts, e.g., a system shared
-	 * interrupt.
-	 */
-	if ((mask & PCIE_PORT_SERVICE_PME) && pcie_pme_no_msi())
-		goto legacy_irq;
-
-	/* Try to use MSI-X or MSI if supported */
-	if (pcie_port_enable_irq_vec(dev, irqs, mask) == 0)
-		return 0;
-
-legacy_irq:
-	/* fall back to legacy IRQ */
-	ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_LEGACY);
-	if (ret < 0)
-		return -ENODEV;
-
-	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
-		irqs[i] = pci_irq_vector(dev, 0);
-
-	return 0;
-}
-
-/**
- * get_port_device_capability - discover capabilities of a PCI Express port
- * @dev: PCI Express port to examine
- *
- * The capabilities are read from the port's PCI Express configuration registers
- * as described in PCI Express Base Specification 1.0a sections 7.8.2, 7.8.9 and
- * 7.9 - 7.11.
- *
- * Return value: Bitmask of discovered port capabilities
- */
-static int get_port_device_capability(struct pci_dev *dev)
-{
-	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
-	int services = 0;
-
-	if (dev->is_hotplug_bridge &&
-	    (pcie_ports_native || host->native_pcie_hotplug)) {
-		services |= PCIE_PORT_SERVICE_HP;
-
-		/*
-		 * Disable hot-plug interrupts in case they have been enabled
-		 * by the BIOS and the hot-plug service driver is not loaded.
-		 */
-		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
-			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
-	}
-
-#ifdef CONFIG_PCIEAER
-	if (dev->aer_cap && pci_aer_available() &&
-	    (pcie_ports_native || host->native_aer)) {
-		services |= PCIE_PORT_SERVICE_AER;
-
-		/*
-		 * Disable AER on this port in case it's been enabled by the
-		 * BIOS (the AER service driver will enable it when necessary).
-		 */
-		pci_disable_pcie_error_reporting(dev);
-	}
-#endif
-
-	/*
-	 * Root ports are capable of generating PME too.  Root Complex
-	 * Event Collectors can also generate PMEs, but we don't handle
-	 * those yet.
-	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
-	    (pcie_ports_native || host->native_pme)) {
-		services |= PCIE_PORT_SERVICE_PME;
-
-		/*
-		 * Disable PME interrupt on this port in case it's been enabled
-		 * by the BIOS (the PME service driver will enable it when
-		 * necessary).
-		 */
-		pcie_pme_interrupt_enable(dev, false);
-	}
-
-	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
-	    pci_aer_available() && services & PCIE_PORT_SERVICE_AER)
-		services |= PCIE_PORT_SERVICE_DPC;
-
-	return services;
-}
-
-/**
- * pcie_device_init - allocate and initialize PCI Express port service device
- * @pdev: PCI Express port to associate the service device with
- * @service: Type of service to associate with the service device
- * @irq: Interrupt vector to associate with the service device
- */
-static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
-{
-	int retval;
-	struct pcie_device *pcie;
-	struct device *device;
-
-	pcie = kzalloc(sizeof(*pcie), GFP_KERNEL);
-	if (!pcie)
-		return -ENOMEM;
-	pcie->port = pdev;
-	pcie->irq = irq;
-	pcie->service = service;
-
-	/* Initialize generic device interface */
-	device = &pcie->device;
-	device->bus = &pcie_port_bus_type;
-	device->release = release_pcie_device;	/* callback to free pcie dev */
-	dev_set_name(device, "%s:pcie%03x",
-		     pci_name(pdev),
-		     get_descriptor_id(pci_pcie_type(pdev), service));
-	device->parent = &pdev->dev;
-	device_enable_async_suspend(device);
-
-	retval = device_register(device);
-	if (retval) {
-		put_device(device);
-		return retval;
-	}
-
-	pm_runtime_no_callbacks(device);
-
-	return 0;
-}
-
-/**
- * pcie_port_device_register - register PCI Express port
- * @dev: PCI Express port to register
- *
- * Allocate the port extension structure and register services associated with
- * the port.
- */
-int pcie_port_device_register(struct pci_dev *dev)
-{
-	int status, capabilities, i, nr_service;
-	int irqs[PCIE_PORT_DEVICE_MAXSERVICES];
-
-	/* Enable PCI Express port device */
-	status = pci_enable_device(dev);
-	if (status)
-		return status;
-
-	/* Get and check PCI Express port services */
-	capabilities = get_port_device_capability(dev);
-	if (!capabilities)
-		return 0;
-
-	pci_set_master(dev);
-	/*
-	 * Initialize service irqs. Don't use service devices that
-	 * require interrupts if there is no way to generate them.
-	 * However, some drivers may have a polling mode (e.g. pciehp_poll_mode)
-	 * that can be used in the absence of irqs.  Allow them to determine
-	 * if that is to be used.
-	 */
-	status = pcie_init_service_irqs(dev, irqs, capabilities);
-	if (status) {
-		capabilities &= PCIE_PORT_SERVICE_HP;
-		if (!capabilities)
-			goto error_disable;
-	}
-
-	/* Allocate child services if any */
-	status = -ENODEV;
-	nr_service = 0;
-	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
-		int service = 1 << i;
-		if (!(capabilities & service))
-			continue;
-		if (!pcie_device_init(dev, service, irqs[i]))
-			nr_service++;
-	}
-	if (!nr_service)
-		goto error_cleanup_irqs;
-
-	return 0;
-
-error_cleanup_irqs:
-	pci_free_irq_vectors(dev);
-error_disable:
-	pci_disable_device(dev);
-	return status;
-}
-
 #ifdef CONFIG_PM
 static int suspend_iter(struct device *dev, void *data)
 {
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index b8b99dd07c0c..08c605734d98 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -93,13 +93,339 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops = {
 #define PCIE_PORTDRV_PM_OPS	NULL
 #endif /* !PM */
 
+/**
+ * release_pcie_device - free PCI Express port service device structure
+ * @dev: Port service device to release
+ *
+ * Invoked automatically when device is being removed in response to
+ * device_unregister(dev).  Release all resources being claimed.
+ */
+static void release_pcie_device(struct device *dev)
+{
+	kfree(to_pcie_device(dev));
+}
+
+/*
+ * Fill in *pme, *aer, *dpc with the relevant Interrupt Message Numbers if
+ * services are enabled in "mask".  Return the number of MSI/MSI-X vectors
+ * required to accommodate the largest Message Number.
+ */
+static int pcie_message_numbers(struct pci_dev *dev, int mask,
+				u32 *pme, u32 *aer, u32 *dpc)
+{
+	u32 nvec = 0, pos;
+	u16 reg16;
+
+	/*
+	 * The Interrupt Message Number indicates which vector is used, i.e.,
+	 * the MSI-X table entry or the MSI offset between the base Message
+	 * Data and the generated interrupt message.  See PCIe r3.1, sec
+	 * 7.8.2, 7.10.10, 7.31.2.
+	 */
+
+	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
+		pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
+		*pme = (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
+		nvec = *pme + 1;
+	}
+
+#ifdef CONFIG_PCIEAER
+	if (mask & PCIE_PORT_SERVICE_AER) {
+		u32 reg32;
+
+		pos = dev->aer_cap;
+		if (pos) {
+			pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS,
+					      &reg32);
+			*aer = (reg32 & PCI_ERR_ROOT_AER_IRQ) >> 27;
+			nvec = max(nvec, *aer + 1);
+		}
+	}
+#endif
+
+	if (mask & PCIE_PORT_SERVICE_DPC) {
+		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC);
+		if (pos) {
+			pci_read_config_word(dev, pos + PCI_EXP_DPC_CAP,
+					     &reg16);
+			*dpc = reg16 & PCI_EXP_DPC_IRQ;
+			nvec = max(nvec, *dpc + 1);
+		}
+	}
+
+	return nvec;
+}
+
+/**
+ * pcie_port_enable_irq_vec - try to set up MSI-X or MSI as interrupt mode
+ * for given port
+ * @dev: PCI Express port to handle
+ * @irqs: Array of interrupt vectors to populate
+ * @mask: Bitmask of port capabilities returned by get_port_device_capability()
+ *
+ * Return value: 0 on success, error code on failure
+ */
+static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
+{
+	int nr_entries, nvec;
+	u32 pme = 0, aer = 0, dpc = 0;
+
+	/* Allocate the maximum possible number of MSI/MSI-X vectors */
+	nr_entries = pci_alloc_irq_vectors(dev, 1, PCIE_PORT_MAX_MSI_ENTRIES,
+			PCI_IRQ_MSIX | PCI_IRQ_MSI);
+	if (nr_entries < 0)
+		return nr_entries;
+
+	/* See how many and which Interrupt Message Numbers we actually use */
+	nvec = pcie_message_numbers(dev, mask, &pme, &aer, &dpc);
+	if (nvec > nr_entries) {
+		pci_free_irq_vectors(dev);
+		return -EIO;
+	}
+
+	/*
+	 * If we allocated more than we need, free them and reallocate fewer.
+	 *
+	 * Reallocating may change the specific vectors we get, so
+	 * pci_irq_vector() must be done *after* the reallocation.
+	 *
+	 * If we're using MSI, hardware is *allowed* to change the Interrupt
+	 * Message Numbers when we free and reallocate the vectors, but we
+	 * assume it won't because we allocate enough vectors for the
+	 * biggest Message Number we found.
+	 */
+	if (nvec != nr_entries) {
+		pci_free_irq_vectors(dev);
+
+		nr_entries = pci_alloc_irq_vectors(dev, nvec, nvec,
+				PCI_IRQ_MSIX | PCI_IRQ_MSI);
+		if (nr_entries < 0)
+			return nr_entries;
+	}
+
+	/* PME and hotplug share an MSI/MSI-X vector */
+	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
+		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pci_irq_vector(dev, pme);
+		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pci_irq_vector(dev, pme);
+	}
+
+	if (mask & PCIE_PORT_SERVICE_AER)
+		irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pci_irq_vector(dev, aer);
+
+	if (mask & PCIE_PORT_SERVICE_DPC)
+		irqs[PCIE_PORT_SERVICE_DPC_SHIFT] = pci_irq_vector(dev, dpc);
+
+	return 0;
+}
+
+/**
+ * pcie_init_service_irqs - initialize irqs for PCI Express port services
+ * @dev: PCI Express port to handle
+ * @irqs: Array of irqs to populate
+ * @mask: Bitmask of port capabilities returned by get_port_device_capability()
+ *
+ * Return value: Interrupt mode associated with the port
+ */
+static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
+{
+	int ret, i;
+
+	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
+		irqs[i] = -1;
+
+	/*
+	 * If we support PME but can't use MSI/MSI-X for it, we have to
+	 * fall back to INTx or other interrupts, e.g., a system shared
+	 * interrupt.
+	 */
+	if ((mask & PCIE_PORT_SERVICE_PME) && pcie_pme_no_msi())
+		goto legacy_irq;
+
+	/* Try to use MSI-X or MSI if supported */
+	if (pcie_port_enable_irq_vec(dev, irqs, mask) == 0)
+		return 0;
+
+legacy_irq:
+	/* fall back to legacy IRQ */
+	ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_LEGACY);
+	if (ret < 0)
+		return -ENODEV;
+
+	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
+		irqs[i] = pci_irq_vector(dev, 0);
+
+	return 0;
+}
+
+/**
+ * get_port_device_capability - discover capabilities of a PCI Express port
+ * @dev: PCI Express port to examine
+ *
+ * The capabilities are read from the port's PCI Express configuration registers
+ * as described in PCI Express Base Specification 1.0a sections 7.8.2, 7.8.9 and
+ * 7.9 - 7.11.
+ *
+ * Return value: Bitmask of discovered port capabilities
+ */
+static int get_port_device_capability(struct pci_dev *dev)
+{
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+	int services = 0;
+
+	if (dev->is_hotplug_bridge &&
+	    (pcie_ports_native || host->native_pcie_hotplug)) {
+		services |= PCIE_PORT_SERVICE_HP;
+
+		/*
+		 * Disable hot-plug interrupts in case they have been enabled
+		 * by the BIOS and the hot-plug service driver is not loaded.
+		 */
+		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
+			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
+	}
+
+#ifdef CONFIG_PCIEAER
+	if (dev->aer_cap && pci_aer_available() &&
+	    (pcie_ports_native || host->native_aer)) {
+		services |= PCIE_PORT_SERVICE_AER;
+
+		/*
+		 * Disable AER on this port in case it's been enabled by the
+		 * BIOS (the AER service driver will enable it when necessary).
+		 */
+		pci_disable_pcie_error_reporting(dev);
+	}
+#endif
+
+	/*
+	 * Root ports are capable of generating PME too.  Root Complex
+	 * Event Collectors can also generate PMEs, but we don't handle
+	 * those yet.
+	 */
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
+	    (pcie_ports_native || host->native_pme)) {
+		services |= PCIE_PORT_SERVICE_PME;
+
+		/*
+		 * Disable PME interrupt on this port in case it's been enabled
+		 * by the BIOS (the PME service driver will enable it when
+		 * necessary).
+		 */
+		pcie_pme_interrupt_enable(dev, false);
+	}
+
+	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
+	    pci_aer_available() && services & PCIE_PORT_SERVICE_AER)
+		services |= PCIE_PORT_SERVICE_DPC;
+
+	return services;
+}
+
+/**
+ * pcie_device_init - allocate and initialize PCI Express port service device
+ * @pdev: PCI Express port to associate the service device with
+ * @service: Type of service to associate with the service device
+ * @irq: Interrupt vector to associate with the service device
+ */
+static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
+{
+	int retval;
+	struct pcie_device *pcie;
+	struct device *device;
+
+	pcie = kzalloc(sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+	pcie->port = pdev;
+	pcie->irq = irq;
+	pcie->service = service;
+
+	/* Initialize generic device interface */
+	device = &pcie->device;
+	device->bus = &pcie_port_bus_type;
+	device->release = release_pcie_device;	/* callback to free pcie dev */
+	dev_set_name(device, "%s:pcie%03x",
+		     pci_name(pdev),
+		     get_descriptor_id(pci_pcie_type(pdev), service));
+	device->parent = &pdev->dev;
+	device_enable_async_suspend(device);
+
+	retval = device_register(device);
+	if (retval) {
+		put_device(device);
+		return retval;
+	}
+
+	pm_runtime_no_callbacks(device);
+
+	return 0;
+}
+
+/**
+ * pcie_port_device_register - register PCI Express port
+ * @dev: PCI Express port to register
+ *
+ * Allocate the port extension structure and register services associated with
+ * the port.
+ */
+int pcie_port_device_register(struct pci_dev *dev)
+{
+	int status, capabilities, i, nr_service;
+	int irqs[PCIE_PORT_DEVICE_MAXSERVICES];
+
+	/* Enable PCI Express port device */
+	status = pci_enable_device(dev);
+	if (status)
+		return status;
+
+	/* Get and check PCI Express port services */
+	capabilities = get_port_device_capability(dev);
+	if (!capabilities)
+		return 0;
+
+	pci_set_master(dev);
+	/*
+	 * Initialize service irqs. Don't use service devices that
+	 * require interrupts if there is no way to generate them.
+	 * However, some drivers may have a polling mode (e.g. pciehp_poll_mode)
+	 * that can be used in the absence of irqs.  Allow them to determine
+	 * if that is to be used.
+	 */
+	status = pcie_init_service_irqs(dev, irqs, capabilities);
+	if (status) {
+		capabilities &= PCIE_PORT_SERVICE_HP;
+		if (!capabilities)
+			goto error_disable;
+	}
+
+	/* Allocate child services if any */
+	status = -ENODEV;
+	nr_service = 0;
+	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
+		int service = 1 << i;
+		if (!(capabilities & service))
+			continue;
+		if (!pcie_device_init(dev, service, irqs[i]))
+			nr_service++;
+	}
+	if (!nr_service)
+		goto error_cleanup_irqs;
+
+	return 0;
+
+error_cleanup_irqs:
+	pci_free_irq_vectors(dev);
+error_disable:
+	pci_disable_device(dev);
+	return status;
+}
+
 /*
  * pcie_portdrv_probe - Probe PCI-Express port devices
  * @dev: PCI-Express port device being probed
  *
  * If detected invokes the pcie_port_device_register() method for
  * this port device.
- *
  */
 static int pcie_portdrv_probe(struct pci_dev *dev,
 					const struct pci_device_id *id)
