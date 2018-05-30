Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937138AbeE3DUG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 23:20:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54496 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935420AbeE3DUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 23:20:01 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 87AD360261
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Christoffer Dall <cdall@linaro.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thymo van Beers <thymovanbeers@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Rientjes <rientjes@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PCI: Add pci=safemode option
Date: Tue, 29 May 2018 23:19:41 -0400
Message-Id: <1527650389-31575-1-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding pci=safemode kernel command line parameter to turn off all PCI
Express service driver as well as all optional PCIe features such as LTR,
Extended tags, Relaxed Ordering etc.

Also setting MPS configuration to PCIE_BUS_SAFE so that MPS and MRRS can be
reconfigured with by the kernel in case BIOS hands off a broken
configuration.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 ++
 drivers/pci/pci.c                               | 7 +++++++
 drivers/pci/pci.h                               | 2 ++
 drivers/pci/pcie/portdrv_core.c                 | 2 +-
 drivers/pci/probe.c                             | 6 ++++++
 5 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 641ec9c..247adbb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3153,6 +3153,8 @@
 		noari		do not use PCIe ARI.
 		noats		[PCIE, Intel-IOMMU, AMD-IOMMU]
 				do not use PCIe ATS (and IOMMU device IOTLB).
+		safemode	turns of all optinal PCI features. Useful
+				for bringup/troubleshooting.
 		pcie_scan_all	Scan all possible PCIe devices.  Otherwise we
 				only look for one device below a PCIe downstream
 				port.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d27f771..11f0282 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -115,6 +115,9 @@ static bool pcie_ari_disabled;
 /* If set, the PCIe ATS capability will not be used. */
 static bool pcie_ats_disabled;
 
+/* If set, disables most of the optional PCI features */
+bool pci_safe_mode;
+
 bool pci_ats_disabled(void)
 {
 	return pcie_ats_disabled;
@@ -5845,6 +5848,10 @@ static int __init pci_setup(char *str)
 		if (*str && (str = pcibios_setup(str)) && *str) {
 			if (!strcmp(str, "nomsi")) {
 				pci_no_msi();
+			} else if (!strncmp(str, "safemode", 8)) {
+				pr_info("PCI: safe mode with minimum features\n");
+				pci_safe_mode = true;
+				pcie_bus_config = PCIE_BUS_SAFE;
 			} else if (!strncmp(str, "noats", 5)) {
 				pr_info("PCIe: ATS is disabled\n");
 				pcie_ats_disabled = true;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c358e7a0..4517bcd 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -8,6 +8,8 @@
 
 extern const unsigned char pcie_link_speed[];
 
+extern bool pci_safe_mode;
+
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
 
 /* Functions internal to the PCI core code */
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index a5b3b3a..9fe4ed6 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -311,7 +311,7 @@ int pcie_port_device_register(struct pci_dev *dev)
 
 	/* Get and check PCI Express port services */
 	capabilities = get_port_device_capability(dev);
-	if (!capabilities)
+	if (!capabilities || pci_safe_mode)
 		return 0;
 
 	pci_set_master(dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3840207..295b79c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2047,6 +2047,9 @@ static void pci_configure_device(struct pci_dev *dev)
 	struct hotplug_params hpp;
 	int ret;
 
+	if (pci_safe_mode)
+		return;
+
 	pci_configure_mps(dev);
 	pci_configure_extended_tags(dev, NULL);
 	pci_configure_relaxed_ordering(dev);
@@ -2213,6 +2216,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	/* Setup MSI caps & disable MSI/MSI-X interrupts */
 	pci_msi_setup_pci_dev(dev);
 
+	if (pci_safe_mode)
+		return;
+
 	/* Buffers for saving PCIe and PCI-X capabilities */
 	pci_allocate_cap_save_buffers(dev);
 
-- 
2.7.4
