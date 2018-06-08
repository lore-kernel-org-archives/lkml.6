Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id bjpRC1/hGltMLwAAmS7hNA
	; Fri, 08 Jun 2018 20:05:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DE928607DC; Fri,  8 Jun 2018 20:05:31 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPk2Jigd"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 18C36605A5;
	Fri,  8 Jun 2018 20:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 18C36605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753099AbeFHUF3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:05:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753028AbeFHUFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:05:24 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E13820874;
        Fri,  8 Jun 2018 20:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528488323;
        bh=jGln+qRysJ3xBNvagJEtvhPStO6uy+94e8WL/+b61LA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nPk2JigdpUAUiz2bq6bCq3t0YNXQ0pvfOevVFksoos82WLROkSoVO0QswHECqR80o
         L02pKnCAG6GOQNRIfliW49jscdoA+zdL4m7REOhZDbxj5y2Y6hVxpP9/LfGoOordRv
         V8xLne5jZxcNllSSGBUkdnOhNjDftATbtBZ4qrIU=
Subject: [PATCH v1 06/13] PCI/AER: Squash ecrc.c into aerdrv.c
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:05:22 -0500
Message-ID: <152848832278.11888.4761786652784923945.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Squash ecrc.c into aerdrv.c.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer/Makefile |    2 -
 drivers/pci/pcie/aer/aerdrv.c |  110 +++++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/aer/ecrc.c   |  117 -----------------------------------------
 3 files changed, 110 insertions(+), 119 deletions(-)
 delete mode 100644 drivers/pci/pcie/aer/ecrc.c

diff --git a/drivers/pci/pcie/aer/Makefile b/drivers/pci/pcie/aer/Makefile
index 80e77c686fb8..af756b6e7e33 100644
--- a/drivers/pci/pcie/aer/Makefile
+++ b/drivers/pci/pcie/aer/Makefile
@@ -5,8 +5,6 @@
 
 obj-$(CONFIG_PCIEAER) += aerdriver.o
 
-obj-$(CONFIG_PCIE_ECRC)	+= ecrc.o
-
 aerdriver-objs := aerdrv.o
 
 obj-$(CONFIG_PCIEAER_INJECT) += aer_inject.o
diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index f77f5df83676..51b66307e68c 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -7,6 +7,9 @@
  * Copyright (C) 2006 Intel Corp.
  *	Tom Long Nguyen (tom.l.nguyen@intel.com)
  *	Zhang Yanmin (yanmin.zhang@intel.com)
+ *
+ * (C) Copyright 2009 Hewlett-Packard Development Company, L.P.
+ *    Andrew Patterson <andrew.patterson@hp.com>
  */
 
 #include <linux/cper.h>
@@ -39,6 +42,111 @@ bool pci_aer_available(void)
 	return !pcie_aer_disable && pci_msi_enabled();
 }
 
+#ifdef CONFIG_PCIE_ECRC
+
+#define ECRC_POLICY_DEFAULT 0		/* ECRC set by BIOS */
+#define ECRC_POLICY_OFF     1		/* ECRC off for performance */
+#define ECRC_POLICY_ON      2		/* ECRC on for data integrity */
+
+static int ecrc_policy = ECRC_POLICY_DEFAULT;
+
+static const char *ecrc_policy_str[] = {
+	[ECRC_POLICY_DEFAULT] = "bios",
+	[ECRC_POLICY_OFF] = "off",
+	[ECRC_POLICY_ON] = "on"
+};
+
+/**
+ * enable_ercr_checking - enable PCIe ECRC checking for a device
+ * @dev: the PCI device
+ *
+ * Returns 0 on success, or negative on failure.
+ */
+static int enable_ecrc_checking(struct pci_dev *dev)
+{
+	int pos;
+	u32 reg32;
+
+	if (!pci_is_pcie(dev))
+		return -ENODEV;
+
+	pos = dev->aer_cap;
+	if (!pos)
+		return -ENODEV;
+
+	pci_read_config_dword(dev, pos + PCI_ERR_CAP, &reg32);
+	if (reg32 & PCI_ERR_CAP_ECRC_GENC)
+		reg32 |= PCI_ERR_CAP_ECRC_GENE;
+	if (reg32 & PCI_ERR_CAP_ECRC_CHKC)
+		reg32 |= PCI_ERR_CAP_ECRC_CHKE;
+	pci_write_config_dword(dev, pos + PCI_ERR_CAP, reg32);
+
+	return 0;
+}
+
+/**
+ * disable_ercr_checking - disables PCIe ECRC checking for a device
+ * @dev: the PCI device
+ *
+ * Returns 0 on success, or negative on failure.
+ */
+static int disable_ecrc_checking(struct pci_dev *dev)
+{
+	int pos;
+	u32 reg32;
+
+	if (!pci_is_pcie(dev))
+		return -ENODEV;
+
+	pos = dev->aer_cap;
+	if (!pos)
+		return -ENODEV;
+
+	pci_read_config_dword(dev, pos + PCI_ERR_CAP, &reg32);
+	reg32 &= ~(PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE);
+	pci_write_config_dword(dev, pos + PCI_ERR_CAP, reg32);
+
+	return 0;
+}
+
+/**
+ * pcie_set_ecrc_checking - set/unset PCIe ECRC checking for a device based on global policy
+ * @dev: the PCI device
+ */
+void pcie_set_ecrc_checking(struct pci_dev *dev)
+{
+	switch (ecrc_policy) {
+	case ECRC_POLICY_DEFAULT:
+		return;
+	case ECRC_POLICY_OFF:
+		disable_ecrc_checking(dev);
+		break;
+	case ECRC_POLICY_ON:
+		enable_ecrc_checking(dev);
+		break;
+	default:
+		return;
+	}
+}
+
+/**
+ * pcie_ecrc_get_policy - parse kernel command-line ecrc option
+ */
+void pcie_ecrc_get_policy(char *str)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ecrc_policy_str); i++)
+		if (!strncmp(str, ecrc_policy_str[i],
+			     strlen(ecrc_policy_str[i])))
+			break;
+	if (i >= ARRAY_SIZE(ecrc_policy_str))
+		return;
+
+	ecrc_policy = i;
+}
+#endif	/* CONFIG_PCIE_ECRC */
+
 #ifdef CONFIG_ACPI_APEI
 static inline int hest_match_pci(struct acpi_hest_aer_common *p,
 				 struct pci_dev *pci)
@@ -137,6 +245,8 @@ int pcie_aer_get_firmware_first(struct pci_dev *dev)
 		aer_set_firmware_first(dev);
 	return dev->__aer_firmware_first;
 }
+#define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
+				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
 
 static bool aer_firmware_first;
 
diff --git a/drivers/pci/pcie/aer/ecrc.c b/drivers/pci/pcie/aer/ecrc.c
deleted file mode 100644
index 039efb606e31..000000000000
--- a/drivers/pci/pcie/aer/ecrc.c
+++ /dev/null
@@ -1,117 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Enable/disable PCIe ECRC checking
- *
- * (C) Copyright 2009 Hewlett-Packard Development Company, L.P.
- *    Andrew Patterson <andrew.patterson@hp.com>
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/pci.h>
-#include <linux/pci_regs.h>
-#include <linux/errno.h>
-#include "../../pci.h"
-
-#define ECRC_POLICY_DEFAULT 0		/* ECRC set by BIOS */
-#define ECRC_POLICY_OFF     1		/* ECRC off for performance */
-#define ECRC_POLICY_ON      2		/* ECRC on for data integrity */
-
-static int ecrc_policy = ECRC_POLICY_DEFAULT;
-
-static const char *ecrc_policy_str[] = {
-	[ECRC_POLICY_DEFAULT] = "bios",
-	[ECRC_POLICY_OFF] = "off",
-	[ECRC_POLICY_ON] = "on"
-};
-
-/**
- * enable_ercr_checking - enable PCIe ECRC checking for a device
- * @dev: the PCI device
- *
- * Returns 0 on success, or negative on failure.
- */
-static int enable_ecrc_checking(struct pci_dev *dev)
-{
-	int pos;
-	u32 reg32;
-
-	if (!pci_is_pcie(dev))
-		return -ENODEV;
-
-	pos = dev->aer_cap;
-	if (!pos)
-		return -ENODEV;
-
-	pci_read_config_dword(dev, pos + PCI_ERR_CAP, &reg32);
-	if (reg32 & PCI_ERR_CAP_ECRC_GENC)
-		reg32 |= PCI_ERR_CAP_ECRC_GENE;
-	if (reg32 & PCI_ERR_CAP_ECRC_CHKC)
-		reg32 |= PCI_ERR_CAP_ECRC_CHKE;
-	pci_write_config_dword(dev, pos + PCI_ERR_CAP, reg32);
-
-	return 0;
-}
-
-/**
- * disable_ercr_checking - disables PCIe ECRC checking for a device
- * @dev: the PCI device
- *
- * Returns 0 on success, or negative on failure.
- */
-static int disable_ecrc_checking(struct pci_dev *dev)
-{
-	int pos;
-	u32 reg32;
-
-	if (!pci_is_pcie(dev))
-		return -ENODEV;
-
-	pos = dev->aer_cap;
-	if (!pos)
-		return -ENODEV;
-
-	pci_read_config_dword(dev, pos + PCI_ERR_CAP, &reg32);
-	reg32 &= ~(PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE);
-	pci_write_config_dword(dev, pos + PCI_ERR_CAP, reg32);
-
-	return 0;
-}
-
-/**
- * pcie_set_ecrc_checking - set/unset PCIe ECRC checking for a device based on global policy
- * @dev: the PCI device
- */
-void pcie_set_ecrc_checking(struct pci_dev *dev)
-{
-	switch (ecrc_policy) {
-	case ECRC_POLICY_DEFAULT:
-		return;
-	case ECRC_POLICY_OFF:
-		disable_ecrc_checking(dev);
-		break;
-	case ECRC_POLICY_ON:
-		enable_ecrc_checking(dev);
-		break;
-	default:
-		return;
-	}
-}
-
-/**
- * pcie_ecrc_get_policy - parse kernel command-line ecrc option
- */
-void pcie_ecrc_get_policy(char *str)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(ecrc_policy_str); i++)
-		if (!strncmp(str, ecrc_policy_str[i],
-			     strlen(ecrc_policy_str[i])))
-			break;
-	if (i >= ARRAY_SIZE(ecrc_policy_str))
-		return;
-
-	ecrc_policy = i;
-}
