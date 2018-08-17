Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C628DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AECE2124D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AECE2124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeHQNf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:35:59 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:53879 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeHQNfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:35:34 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LopY3-1gNDhj20RX-00glB0; Fri, 17 Aug 2018 12:27:20 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 13/15] PCI: turn pcibios_alloc_irq into a callback
Date:   Fri, 17 Aug 2018 12:26:43 +0200
Message-Id: <20180817102645.3839621-14-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817102645.3839621-1-arnd@arndb.de>
References: <20180817102645.3839621-1-arnd@arndb.de>
X-Provags-ID: V03:K1:vGOxD5cso1fRX7vOFpg6264LHD7qp984mQlv5MPT6s07XrS4K2q
 Ixzfk8bDO/hDFJUEyLUy4cqBFvWycxqJfqu8myqpu+DeGzm1WHg70Dm0VhCWS3UfXdQMZUh
 vCVDLDNLy0TIi89lHJhy6GxOzRcS4zgTlQr8KfLRoWv/eaypGIooBRH9J0jTanPDmePlu2G
 yp3nrpbGuNd8g0mqp4zsg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qiT72hH/I1Q=:9Hqj/v305t7b/4GjgDoN/e
 Ue8HbedIQ953rUOU4QCIrxtJEmq42LgC1lNOW2wV05FwAP1teCMpuw5EXUnwyVPR5Pst0E2oT
 yFIfuTQMC0KVvRUuZiHkl2xc8AV844sORxrAHRk2FYS6HDx3zKe98/ZfITQolb0YeyfUWSegv
 5kgbJb+UtFGVEoCzgiHqOV1URMwqykKggoFu98N5hGdy4ACiAHfwLtrfjAy3XgMtIp34q95eJ
 OLTSZTGpJWJCzzZGDuH78sPadMJmvRrWhgD/FQsYl9AZcG5gutbR7vaZK5V7TeNW/hfk/xuuG
 RoKaH+M4ewI+f7cG9bReKVqfGInD2+FlK4EPmJ8ItQmjzgCNAzALHkB8vlXsXRUVgH2lQ+3dI
 03VNLSmbzlhW+aTOur1hTEge9XLP6vHyWg+upyxLGH2zy3BedElcJxWQ1BDWFvux20M1regty
 +mz5A2Rn/dSr6r2aK2KPpTSr1P8DnlMFYoVGvnDwPULJd89k7o8WU2pnHdzi5deZxVHK//YDJ
 T7ctzSbG72zxqlW3vMSAAnCsQTbSNWnTU+EfZfiJGEBzfynJhquv+1ZugGcBASOSjn11dcq4C
 Ih6zebi1/g82y4cGXSIckDdAAjN+79Mv4TOkMu+LqPZnFxUnO4dxJgZtZOe1zrPAncRjTJh8F
 q3AJPPohH8aOM0jIpA5GNzi4LVgq7xnfVj7gjqc08fgObkjbZr8ajiTOFeLT+ajfY5tE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Weak functions are a bit confusing, and we can better deal with
this using a callback function. pcibios_free_irq() is actually
completely unused, but it seems better to treat it the same way
as the allocation, unless we want to remove it completely.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kernel/pci.c  | 16 +++-------------
 drivers/pci/pci-driver.c | 13 +++++++++++--
 include/linux/pci.h      |  2 ++
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 0e2ea1c78542..3d196c68e362 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -22,19 +22,6 @@
 #include <linux/pci-ecam.h>
 #include <linux/slab.h>
 
-#ifdef CONFIG_ACPI
-/*
- * Try to assign the IRQ number when probing a new device
- */
-int pcibios_alloc_irq(struct pci_dev *dev)
-{
-	if (!acpi_disabled)
-		acpi_pci_irq_enable(dev);
-
-	return 0;
-}
-#endif
-
 /*
  * raw_pci_read/write - Platform-specific PCI config space access.
  */
@@ -93,6 +80,9 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 
 		ACPI_COMPANION_SET(&bridge->dev, adev);
 		set_dev_node(bus_dev, acpi_get_node(acpi_device_handle(adev)));
+
+		/* Try to assign the IRQ number when probing a new device */
+		bridge->alloc_irq = acpi_pci_irq_enable;
 	}
 
 	return 0;
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index bef17c3fca67..c96bc7bd56da 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -387,13 +387,22 @@ static int __pci_device_probe(struct pci_driver *drv, struct pci_dev *pci_dev)
 	return error;
 }
 
-int __weak pcibios_alloc_irq(struct pci_dev *dev)
+int pcibios_alloc_irq(struct pci_dev *dev)
 {
+	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
+
+	if (bridge->alloc_irq)
+		return bridge->alloc_irq(dev);
+
 	return 0;
 }
 
-void __weak pcibios_free_irq(struct pci_dev *dev)
+void pcibios_free_irq(struct pci_dev *dev)
 {
+	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
+
+	if (bridge->free_irq)
+		bridge->free_irq(dev);
 }
 
 #ifdef CONFIG_PCI_IOV
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d1072690cb4f..1296d9fcc5da 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -476,6 +476,8 @@ struct pci_host_bridge {
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
 	void (*bus_add_device)(struct pci_dev *pdev);
+	int (*alloc_irq)(struct pci_dev *);
+	int (*free_irq)(struct pci_dev *);
 	void		*release_data;
 	struct msi_controller *msi;
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
-- 
2.18.0

