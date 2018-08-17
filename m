Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4458FC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A7D2124D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A7D2124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbeHQNfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:35:32 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:56531 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeHQNfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:35:31 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M9oN6-1fjzDA0HrE-00B3KP; Fri, 17 Aug 2018 12:27:16 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 02/15] PCI: move pci_scan_bus into callers
Date:   Fri, 17 Aug 2018 12:26:32 +0200
Message-Id: <20180817102645.3839621-3-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817102645.3839621-1-arnd@arndb.de>
References: <20180817102645.3839621-1-arnd@arndb.de>
X-Provags-ID: V03:K1:LWXnCU+7Z6xUjdeuzFbZ45bQvgVeaaHfbEf3zC3L26Zzk+q2P/M
 eBqWnJgU7gwLWWrQHzKtQNFZcb0iVWb27FKaSLk3FaYqvRDAS8Fc4O+kVUSdbViQeydnUMw
 h7NpiAMFG72dNFXfPHSVlJ0LvhHR19fn798oy2WXLztnZxxmtfjsh5iUmx/CcbOiGkUFKfA
 9U53X0yWkPqyToR2KeuMw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i52elxbByfA=:zby/nqAY9+e5yB3sPpAwYv
 XLGsWsbrJP8EnEyYsf7aWdz+YQwQ06Ay+C2xJ5V8q/Z5WbutiLIkDZsmtklPkwbb7VCHQtmNc
 htBAhFuY5icvQ7ZSlxEM+0cGgKZ6I3KOhTvVIAI1hTJZCc+BkIF9BYnyKn0Yp+PCGgxGDQc9M
 z2qGTvyaoqU2FTh0gNlCN4py088cSrcuWuOyS7lrUNN+yexf76tAyIai6J/Qpo1nTPKfX4UaC
 a/AVBf3VrEDHfcR6l+BV8i7N5LVgln2sjTmuo8Yg0ZW5xLMpvJQQ7LDbTff8GLoJHdL/v9vSL
 l9M5feuoSNoq08gOtnzB7oh0V9yrObBfHyHyzIj2cw4sWC9u++uFOAaRAtFMZN94PM8BJ3wos
 j9q5FETIOSk9yTticaNzrsQkjVgxSCp0V7yo94oM1lVcK9JZiJ//fG1W8/rU5B2Re2dDyMPqj
 z8OF1cfeU1Uk4B22sF2AA9+660U331pPJxrV17EIAM6i/2TpX8dlrUBkXabg7pquF9KiJOSFI
 iLwaWs2BlcB74LMmqnjgmIPZ9LpA2kF2IE9kVlqdkJ3iltoUzxWxMatjJZJTVH4aB0puA0L8Z
 3E4j6jwjkz1DogegisuGl2kt9gbdDITkq6aqv9vgGww9e/6hPek/b5d4mHT/kyli11fgFtW4G
 2bcIKPNIenX30apnEBsXNGgTE7pq3vgJD97ENKj+H4O9bz1RK2rxVEgLDfx8bQnPwmJE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are only two remaining callers of the old pci_scan_bus()
interface. Since we want to expose the pci_host_bridge structure
everywhere and discourage users from calling the old interfaces,
let's move the implementation into the respective callsites.

While this duplicates the source code, it makes the object code
smaller for all users by avoiding the global implementation,
and it allows further cleanup of the two callers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sparc/kernel/pcic.c          | 35 ++++++++++++++++++++++++++++++
 drivers/pci/hotplug/ibmphp_core.c | 35 ++++++++++++++++++++++++++++++
 drivers/pci/probe.c               | 36 -------------------------------
 include/linux/pci.h               |  1 -
 4 files changed, 70 insertions(+), 37 deletions(-)

diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index ee4c9a9a171c..0197b80fe590 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -387,6 +387,41 @@ int __init pcic_probe(void)
 	return 0;
 }
 
+static struct resource busn_resource = {
+	.name	= "PCI busn",
+	.start	= 0,
+	.end	= 255,
+	.flags	= IORESOURCE_BUS,
+};
+
+static struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops,
+					void *sysdata)
+{
+	struct pci_host_bridge *bridge;
+	int error;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return NULL;
+
+	pci_add_resource(&bridge->windows, &ioport_resource);
+	pci_add_resource(&bridge->windows, &iomem_resource);
+	pci_add_resource(&bridge->windows, &busn_resource);
+	bridge->sysdata = sysdata;
+	bridge->busnr = bus;
+	bridge->ops = ops;
+
+	error = pci_scan_root_bus_bridge(bridge);
+	if (error < 0)
+		goto err;
+
+	return bridge->bus;
+
+err_res:
+	pci_free_host_bridge(bridge);
+	return NULL;
+}
+
 static void __init pcic_pbm_scan_bus(struct linux_pcic *pcic)
 {
 	struct linux_pbm_info *pbm = &pcic->pbm;
diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
index 4ea57e9019f1..d35463ee96ba 100644
--- a/drivers/pci/hotplug/ibmphp_core.c
+++ b/drivers/pci/hotplug/ibmphp_core.c
@@ -717,6 +717,41 @@ static void ibm_unconfigure_device(struct pci_func *func)
 	pci_unlock_rescan_remove();
 }
 
+static struct resource busn_resource = {
+	.name	= "pci busn",
+	.start	= 0,
+	.end	= 255,
+	.flags	= IORESOURCE_BUS,
+};
+
+static struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops,
+					void *sysdata)
+{
+	struct pci_host_bridge *bridge;
+	int error;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return NULL;
+
+	pci_add_resource(&bridge->windows, &ioport_resource);
+	pci_add_resource(&bridge->windows, &iomem_resource);
+	pci_add_resource(&bridge->windows, &busn_resource);
+	bridge->sysdata = sysdata;
+	bridge->busnr = bus;
+	bridge->ops = ops;
+
+	error = pci_scan_root_bus_bridge(bridge);
+	if (error < 0)
+		goto err;
+
+	return bridge->bus;
+
+err:
+	pci_free_host_bridge(bridge);
+	return NULL;
+}
+
 /*
  * The following function is to fix kernel bug regarding
  * getting bus entries, here we manually add those primary
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b0f666271245..12c3aa63c34d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3078,42 +3078,6 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 }
 EXPORT_SYMBOL(pci_scan_root_bus);
 
-static struct resource busn_resource = {
-	.name	= "PCI busn",
-	.start	= 0,
-	.end	= 255,
-	.flags	= IORESOURCE_BUS,
-};
-
-struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops,
-					void *sysdata)
-{
-	struct pci_host_bridge *bridge;
-	int error;
-
-	bridge = pci_alloc_host_bridge(0);
-	if (!bridge)
-		goto err;
-
-	pci_add_resource(&bridge->windows, &ioport_resource);
-	pci_add_resource(&bridge->windows, &iomem_resource);
-	pci_add_resource(&bridge->windows, &busn_resource);
-	bridge->sysdata = sysdata;
-	bridge->busnr = bus;
-	bridge->ops = ops;
-
-	error = pci_scan_root_bus_bridge(bridge);
-	if (error < 0)
-		goto err;
-
-	return bridge->bus;
-
-err:
-	pci_free_host_bridge(bridge);
-	return NULL;
-}
-EXPORT_SYMBOL(pci_scan_bus);
-
 /**
  * pci_rescan_bus_bridge_resize - Scan a PCI bus for devices
  * @bridge: PCI bridge for the bus to scan
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e72ca8dd6241..d77ce35a2b33 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -905,7 +905,6 @@ void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
 void pcibios_scan_specific_bus(int busn);
 struct pci_bus *pci_find_bus(int domain, int busnr);
 void pci_bus_add_devices(const struct pci_bus *bus);
-struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata);
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 				    struct pci_ops *ops, void *sysdata,
 				    struct list_head *resources);
-- 
2.18.0

