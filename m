Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E003C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F3520875
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YiTbUBQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F3520875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbeGKH7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:59:34 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:52758 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbeGKH7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:59:33 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id D00F424E2595;
        Wed, 11 Jul 2018 00:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531295793; bh=BE1KhGikEIWXaUopGDw/dayvFU6yv5hFYPKBuxEsbJ8=;
        h=From:To:Cc:Subject:Date:From;
        b=YiTbUBQjgfAMLgXpUJJDkxmnxvaAUgZMxPDcMD4anvZODg/3JM/P0um1w583f0Yvx
         1Q/5k60SkRFgSmkpIVQVHt6+WrRUDLmqayHt+6y7Zqi33WhdlfvmzlhIKr2XtWlBFb
         lCJijFcDew62ytidUXhElWG/Ls9PTehbrwG3fZKAGEhlNFdTMqEPFNYzCXPtoQ0+Lp
         mtWPFXymTlgk6QatPT04qBFgHQSZo/QQGvK6939JqdbqsL71jbmaLUkKZpbWkwJXgf
         pJtWSTymhmBjl8AQSPPW3qhaf+0/4MF6mP2H8p9pCKMIiU7OOTkmp/W+pqK/ILBF2Y
         jN5qxcEAWa5+g==
Received: from sglab-ubuntu.internal.synopsys.com (unknown [10.144.153.11])
        by mailhost.synopsys.com (Postfix) with ESMTP id 8047F55CD;
        Wed, 11 Jul 2018 00:56:31 -0700 (PDT)
From:   Prabu Thangamuthu <prabu.t@synopsys.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Manjunath M B <Manjunath.MB@synopsys.com>,
        Prabu T <prabuchml@gmail.com>,
        Prabu Thangamuthu <prabu.t@synopsys.com>
Subject: [PATCH v3 1/1] mmc: sdhci-pci-dwc-mshc: synopsys dwc mshc support
Date:   Wed, 11 Jul 2018 13:26:17 +0530
Message-Id: <1531295777-9515-1-git-send-email-prabu.t@synopsys.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synopsys has DWC MSHC controller on HPAS-DX platform connected using PCIe
interface with SD card slot and eMMC device slots. This patch is to
enable SD cards connected on this platform. As Clock generation logic
is implemented using MMCM module of HAPS-DX platform, we have separate
functions to control the MMCM to generate required clocks with respect
to speed mode.

Signed-off-by: Prabu Thangamuthu <prabu.t@synopsys.com>
---
V3 - Updated License.
Re-sending the patch using git send-email.
V2 - Removed sdhci-pci-dwc-mshc.h and moved into sdhci-pci-dwc-mshc.c
Fixed the coding style issue.
Removed sdhci_snps_set_power and new approach to support eMMC device
voltages will be submitted after completeing validations.
V1 - Initial Patch.

 MAINTAINERS                           |  7 +++
 drivers/mmc/host/Makefile             |  3 +-
 drivers/mmc/host/sdhci-pci-core.c     |  1 +
 drivers/mmc/host/sdhci-pci-dwc-mshc.c | 84 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h          |  3 ++
 5 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mmc/host/sdhci-pci-dwc-mshc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a29d10f..d062f51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12813,6 +12813,13 @@ S:	Maintained
 F:	drivers/mmc/host/sdhci*
 F:	include/linux/mmc/sdhci*
 
+SYNOPSYS SDHCI COMPLIANT DWC MSHC DRIVER
+M:	Prabu Thangamuthu <prabu.t@synopsys.com>
+M:	Manjunath M B <manjumb@synopsys.com>
+L:	linux-mmc@vger.kernel.org
+S:	Maintained
+F:	drivers/mmc/host/sdhci-pci-dwc-mshc.c
+
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) SAMSUNG DRIVER
 M:	Ben Dooks <ben-linux@fluff.org>
 M:	Jaehoon Chung <jh80.chung@samsung.com>
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index a18fbba..ce8398e 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -11,7 +11,8 @@ obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
 obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
 obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
-sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o
+sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o \
+				   sdhci-pci-dwc-mshc.o
 obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI))	+= sdhci-pci-data.o
 obj-$(CONFIG_MMC_SDHCI_ACPI)	+= sdhci-acpi.o
 obj-$(CONFIG_MMC_SDHCI_PXAV3)	+= sdhci-pxav3.o
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 3d36761..7bfd366 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1513,6 +1513,7 @@ static int amd_probe(struct sdhci_pci_chip *chip)
 	SDHCI_PCI_DEVICE(O2, SEABIRD0, o2),
 	SDHCI_PCI_DEVICE(O2, SEABIRD1, o2),
 	SDHCI_PCI_DEVICE(ARASAN, PHY_EMMC, arasan),
+	SDHCI_PCI_DEVICE(SYNOPSYS, DWC_MSHC, snps),
 	SDHCI_PCI_DEVICE_CLASS(AMD, SYSTEM_SDHCI, PCI_CLASS_MASK, amd),
 	/* Generic SD host controller */
 	{PCI_DEVICE_CLASS(SYSTEM_SDHCI, PCI_CLASS_MASK)},
diff --git a/drivers/mmc/host/sdhci-pci-dwc-mshc.c b/drivers/mmc/host/sdhci-pci-dwc-mshc.c
new file mode 100644
index 0000000..f78d654
--- /dev/null
+++ b/drivers/mmc/host/sdhci-pci-dwc-mshc.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SDHCI driver for Synopsys DWC_MSHC controller
+ *
+ * Copyright (C) 2018 Synopsys, Inc. (www.synopsys.com)
+ *
+ * Authors:
+ *	Prabu Thangamuthu <prabu.t@synopsys.com>
+ *	Manjunath M B <manjumb@synopsys.com>
+ */
+
+#include "sdhci.h"
+#include "sdhci-pci.h"
+
+#define SDHCI_VENDOR_PTR_R	0xE8
+
+/* Synopsys vendor specific registers */
+#define SDHC_GPIO_OUT		0x34
+#define SDHC_AT_CTRL_R		0x40
+#define SDHC_SW_TUNE_EN		0x00000010
+
+/* MMCM DRP */
+#define SDHC_MMCM_DIV_REG	0x1020
+#define DIV_REG_100_MHZ		0x1145
+#define DIV_REG_200_MHZ		0x1083
+#define SDHC_MMCM_CLKFBOUT	0x1024
+#define CLKFBOUT_100_MHZ	0x0000
+#define CLKFBOUT_200_MHZ	0x0080
+#define SDHC_CCLK_MMCM_RST	0x00000001
+
+static void sdhci_snps_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	u16 clk;
+	u32 reg, vendor_ptr;
+
+	vendor_ptr = sdhci_readw(host, SDHCI_VENDOR_PTR_R);
+
+	/* Disable software managed rx tuning */
+	reg = sdhci_readl(host, (SDHC_AT_CTRL_R + vendor_ptr));
+	reg &= ~SDHC_SW_TUNE_EN;
+	sdhci_writel(host, reg, (SDHC_AT_CTRL_R + vendor_ptr));
+
+	if (clock <= 52000000) {
+		sdhci_set_clock(host, clock);
+	} else {
+		/* Assert reset to MMCM */
+		reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
+		reg |= SDHC_CCLK_MMCM_RST;
+		sdhci_writel(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
+
+		/* Configure MMCM */
+		if (clock == 100000000) {
+			sdhci_writel(host, DIV_REG_100_MHZ, SDHC_MMCM_DIV_REG);
+			sdhci_writel(host, CLKFBOUT_100_MHZ,
+					SDHC_MMCM_CLKFBOUT);
+		} else {
+			sdhci_writel(host, DIV_REG_200_MHZ, SDHC_MMCM_DIV_REG);
+			sdhci_writel(host, CLKFBOUT_200_MHZ,
+					SDHC_MMCM_CLKFBOUT);
+		}
+
+		/* De-assert reset to MMCM */
+		reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
+		reg &= ~SDHC_CCLK_MMCM_RST;
+		sdhci_writel(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
+
+		/* Enable clock */
+		clk = SDHCI_PROG_CLOCK_MODE | SDHCI_CLOCK_INT_EN |
+			SDHCI_CLOCK_CARD_EN;
+		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+	}
+}
+
+static const struct sdhci_ops sdhci_snps_ops = {
+	.set_clock	= sdhci_snps_set_clock,
+	.enable_dma	= sdhci_pci_enable_dma,
+	.set_bus_width	= sdhci_set_bus_width,
+	.reset		= sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
+};
+
+const struct sdhci_pci_fixes sdhci_snps = {
+	.ops		= &sdhci_snps_ops,
+};
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 59af288..2ef0bdc 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -61,6 +61,8 @@
 #define PCI_VENDOR_ID_ARASAN		0x16e6
 #define PCI_DEVICE_ID_ARASAN_PHY_EMMC	0x0670
 
+#define PCI_DEVICE_ID_SYNOPSYS_DWC_MSHC 0xc202
+
 /*
  * PCI device class and mask
  */
@@ -184,5 +186,6 @@ static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
 #endif
 
 extern const struct sdhci_pci_fixes sdhci_arasan;
+extern const struct sdhci_pci_fixes sdhci_snps;
 
 #endif /* __SDHCI_PCI_H */
-- 
1.9.1

