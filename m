Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5EDECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6480D20671
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6480D20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388271AbeGWX1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:27:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60174 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388109AbeGWX1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:27:54 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 994DB85546;
        Mon, 23 Jul 2018 22:24:33 +0000 (UTC)
Received: from gimli.home (ovpn-116-105.phx2.redhat.com [10.3.116.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81A382010CA4;
        Mon, 23 Jul 2018 22:24:31 +0000 (UTC)
Subject: [PATCH 2/2] PCI: NVMe device specific reset quirk
From:   Alex Williamson <alex.williamson@redhat.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Date:   Mon, 23 Jul 2018 16:24:31 -0600
Message-ID: <20180723222431.4371.25962.stgit@gimli.home>
In-Reply-To: <20180723221533.4371.90064.stgit@gimli.home>
References: <20180723221533.4371.90064.stgit@gimli.home>
User-Agent: StGit/0.18-102-gdf9f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 23 Jul 2018 22:24:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take advantage of NVMe devices using a standard interface to quiesce
the controller prior to reset, including device specific delays before
and after that reset.  This resolves several NVMe device assignment
scenarios with two different vendors.  The Intel DC P3700 controller
has been shown to only work as a VM boot device on the initial VM
startup, failing after reset or reboot, and also fails to initialize
after hot-plug into a VM.  Adding a delay after FLR resolves these
cases.  The Samsung SM961/PM961 (960 EVO) sometimes fails to return
from FLR with the PCI config space reading back as -1.  A reproducible
instance of this behavior is resolved by clearing the enable bit in
the configuration register and waiting for the ready status to clear
(disabling the NVMe controller) prior to FLR.

As all NVMe devices make use of this standard interface and the NVMe
specification also requires PCIe FLR support, we can apply this quirk
to all devices with matching class code.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/quirks.c |  112 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e72c8742aafa..83853562f220 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -28,6 +28,7 @@
 #include <linux/platform_data/x86/apple.h>
 #include <linux/pm_runtime.h>
 #include <linux/switchtec.h>
+#include <linux/nvme.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 #include "pci.h"
 
@@ -3669,6 +3670,116 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, int probe)
 #define PCI_DEVICE_ID_INTEL_IVB_M_VGA      0x0156
 #define PCI_DEVICE_ID_INTEL_IVB_M2_VGA     0x0166
 
+/* NVMe controller needs delay before testing ready status */
+#define NVME_QUIRK_CHK_RDY_DELAY	(1 << 0)
+/* NVMe controller needs post-FLR delay */
+#define NVME_QUIRK_POST_FLR_DELAY	(1 << 1)
+
+static const struct pci_device_id nvme_reset_tbl[] = {
+	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
+		.driver_data = NVME_QUIRK_CHK_RDY_DELAY, },
+	{ PCI_DEVICE(0x1c58, 0x0003),   /* HGST adapter */
+		.driver_data = NVME_QUIRK_CHK_RDY_DELAY, },
+	{ PCI_DEVICE(0x1c58, 0x0023),   /* WDC SN200 adapter */
+		.driver_data = NVME_QUIRK_CHK_RDY_DELAY, },
+	{ PCI_DEVICE(0x1c5f, 0x0540),   /* Memblaze Pblaze4 adapter */
+		.driver_data = NVME_QUIRK_CHK_RDY_DELAY, },
+	{ PCI_DEVICE(0x144d, 0xa821),   /* Samsung PM1725 */
+		.driver_data = NVME_QUIRK_CHK_RDY_DELAY, },
+	{ PCI_DEVICE(0x144d, 0xa822),   /* Samsung PM1725a */
+		.driver_data = NVME_QUIRK_CHK_RDY_DELAY, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0953),   /* Intel DC P3700 */
+		.driver_data = NVME_QUIRK_POST_FLR_DELAY, },
+	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
+	{ 0 }
+};
+
+/*
+ * The NVMe specification requires that controllers support PCIe FLR, but
+ * but some Samsung SM961/PM961 controllers fail to recover after FLR (-1
+ * config space) unless the device is quiesced prior to FLR.  Do this for
+ * all NVMe devices by disabling the controller before reset.  Some Intel
+ * controllers also require an additional post-FLR delay or else attempts
+ * to re-enable will timeout, do that here as well with heuristically
+ * determined delay value.  Also maintain the delay between disabling and
+ * checking ready status as used by the native NVMe driver.
+ */
+static int reset_nvme(struct pci_dev *dev, int probe)
+{
+	const struct pci_device_id *id;
+	void __iomem *bar;
+	u16 cmd;
+	u32 cfg;
+
+	id = pci_match_id(nvme_reset_tbl, dev);
+	if (!id || !pcie_has_flr(dev) || !pci_resource_start(dev, 0))
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	bar = pci_iomap(dev, 0, NVME_REG_CC + sizeof(cfg));
+	if (!bar)
+		return -ENOTTY;
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	pci_write_config_word(dev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
+
+	cfg = readl(bar + NVME_REG_CC);
+
+	/* Disable controller if enabled */
+	if (cfg & NVME_CC_ENABLE) {
+		u64 cap = readq(bar + NVME_REG_CAP);
+		unsigned long timeout;
+
+		/*
+		 * Per nvme_disable_ctrl() skip shutdown notification as it
+		 * could complete commands to the admin queue.  We only intend
+		 * to quiesce the device before reset.
+		 */
+		cfg &= ~(NVME_CC_SHN_MASK | NVME_CC_ENABLE);
+
+		writel(cfg, bar + NVME_REG_CC);
+
+		/* A heuristic value, matches NVME_QUIRK_DELAY_AMOUNT */
+		if (id->driver_data & NVME_QUIRK_CHK_RDY_DELAY)
+			msleep(2300);
+
+		/* Cap register provides max timeout in 500ms increments */
+		timeout = ((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
+
+		for (;;) {
+			u32 status = readl(bar + NVME_REG_CSTS);
+
+			/* Ready status becomes zero on disable complete */
+			if (!(status & NVME_CSTS_RDY))
+				break;
+
+			msleep(100);
+
+			if (time_after(jiffies, timeout)) {
+				pci_warn(dev, "Timeout waiting for NVMe ready status to clear after disable\n");
+				break;
+			}
+		}
+	}
+
+	pci_iounmap(dev, bar);
+
+	/*
+	 * We could use the optional NVM Subsystem Reset here, hardware
+	 * supporting this is simply unavailable at the time of this code
+	 * to validate in comparison to PCIe FLR.  NVMe spec dictates that
+	 * NVMe devices shall implement PCIe FLR.
+	 */
+	pcie_flr(dev);
+
+	if (id->driver_data & NVME_QUIRK_POST_FLR_DELAY)
+		msleep(250); /* Heuristic based on Intel DC P3700 */
+
+	return 0;
+}
+
 static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
 		 reset_intel_82599_sfp_virtfn },
@@ -3678,6 +3789,7 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 		reset_ivb_igd },
 	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
 		reset_chelsio_generic_dev },
+	{ PCI_ANY_ID, PCI_ANY_ID, reset_nvme },
 	{ 0 }
 };
 

