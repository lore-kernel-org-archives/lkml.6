Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeEVRFe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:05:34 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42402 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751655AbeEVRF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:05:28 -0400
X-Google-Smtp-Source: AB8JxZp2igxos+FydE0Hfb1JCH4CDTdYtryqDQHjZGABvvv/X1wAoFX0ErC2KGySs8D6YSXGUxzKFQ==
From: Ray Jui <ray.jui@broadcom.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 1/2] PCI: iproc: Reject unconfigured physical functions from PAXC
Date: Tue, 22 May 2018 10:05:08 -0700
Message-Id: <1527008709-20786-2-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1527008709-20786-1-git-send-email-ray.jui@broadcom.com>
References: <1527008709-20786-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PAXC is an emulated PCIe root complex internally in various Broadcom
based SoCs. PAXC internally connects to the embedded network processor
within these SoCs, with the embedeed network processor exposed as an
endpoint device

The number of physical functions from the embedded network processor
that can be accessed depend on the firmware configuration.
Unfortunately, due to an ASIC bug, unconfigured physical functions cannot
be properly hidden from the root complex during enumerattion. As a
result, config write access to these unconfigured physical functions
during enumeration will cause a bus lock up on the embedded network
processor

Fortunately, these unconfigured physical functions contain a very
specific, staled PCIe device ID 0x168e. By making use of this device ID,
one is able to terminate the enumeration early in the vendor/device ID
config read

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/pci/host/pcie-iproc.c | 26 +++++++++++++++++++++++++-
 drivers/pci/host/pcie-iproc.h |  5 +++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index b906d80..b1d8c60 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -529,6 +529,25 @@ static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
 	if (size <= 2)
 		*val = (data >> (8 * (where & 3))) & ((1 << (size * 8)) - 1);
 
+	/*
+	 * For PAXC and PAXCv2, the total number of PFs that one can enumerate
+	 * depends on the firmware configuration. Unfortunately, due to an ASIC
+	 * bug, unconfigured PFs cannot be properly hidden from the root
+	 * complex. As a result, write access to these PFs will cause bus lock
+	 * up on the embedded processor
+	 *
+	 * Since all unconfigured PFs are left with an incorrect, staled device
+	 * ID of 0x168e (PCI_DEVICE_ID_NX2_57810), we try to catch those access
+	 * early here and reject them all
+	 */
+#define DEVICE_ID_MASK     0xffff0000
+#define DEVICE_ID_SHIFT    16
+	if (pcie->rej_unconfig_pf &&
+	    (where & CFG_ADDR_REG_NUM_MASK) == PCI_VENDOR_ID)
+		if ((*val & DEVICE_ID_MASK) ==
+		    (PCI_DEVICE_ID_NX2_57810 << DEVICE_ID_SHIFT))
+			return PCIBIOS_FUNC_NOT_SUPPORTED;
+
 	return PCIBIOS_SUCCESSFUL;
 }
 
@@ -628,7 +647,7 @@ static int iproc_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
 	struct iproc_pcie *pcie = iproc_data(bus);
 
 	iproc_pcie_apb_err_disable(bus, true);
-	if (pcie->type == IPROC_PCIE_PAXB_V2)
+	if (pcie->iproc_cfg_read)
 		ret = iproc_pcie_config_read(bus, devfn, where, size, val);
 	else
 		ret = pci_generic_config_read32(bus, devfn, where, size, val);
@@ -1283,6 +1302,7 @@ static int iproc_pcie_rev_init(struct iproc_pcie *pcie)
 		break;
 	case IPROC_PCIE_PAXB:
 		regs = iproc_pcie_reg_paxb;
+		pcie->iproc_cfg_read = true;
 		pcie->has_apb_err_disable = true;
 		if (pcie->need_ob_cfg) {
 			pcie->ob_map = paxb_ob_map;
@@ -1305,10 +1325,14 @@ static int iproc_pcie_rev_init(struct iproc_pcie *pcie)
 	case IPROC_PCIE_PAXC:
 		regs = iproc_pcie_reg_paxc;
 		pcie->ep_is_internal = true;
+		pcie->iproc_cfg_read = true;
+		pcie->rej_unconfig_pf = true;
 		break;
 	case IPROC_PCIE_PAXC_V2:
 		regs = iproc_pcie_reg_paxc_v2;
 		pcie->ep_is_internal = true;
+		pcie->iproc_cfg_read = true;
+		pcie->rej_unconfig_pf = true;
 		pcie->need_msi_steer = true;
 		break;
 	default:
diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
index 814b600..67081cb 100644
--- a/drivers/pci/host/pcie-iproc.h
+++ b/drivers/pci/host/pcie-iproc.h
@@ -58,6 +58,9 @@ struct iproc_msi;
  * @phy: optional PHY device that controls the Serdes
  * @map_irq: function callback to map interrupts
  * @ep_is_internal: indicates an internal emulated endpoint device is connected
+ * @iproc_cfg_read: indicates the iProc config read function should be used
+ * @rej_unconfig_pf: indicates the root complex needs to detect and reject
+ * enumeration against unconfigured physical functions emulated in the ASIC
  * @has_apb_err_disable: indicates the controller can be configured to prevent
  * unsupported request from being forwarded as an APB bus error
  *
@@ -84,6 +87,8 @@ struct iproc_pcie {
 	struct phy *phy;
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	bool ep_is_internal;
+	bool iproc_cfg_read;
+	bool rej_unconfig_pf;
 	bool has_apb_err_disable;
 
 	bool need_ob_cfg;
-- 
2.1.4
