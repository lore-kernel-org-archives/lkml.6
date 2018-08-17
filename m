Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C25C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C554208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C554208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbeHQNax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:30:53 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:44097 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbeHQNac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:30:32 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LfAVs-1gEfGg3Ql6-00olnh; Fri, 17 Aug 2018 12:27:18 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 09/15] PCI: xenfront: clean up pcifront_scan_root()
Date:   Fri, 17 Aug 2018 12:26:39 +0200
Message-Id: <20180817102645.3839621-10-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817102645.3839621-1-arnd@arndb.de>
References: <20180817102645.3839621-1-arnd@arndb.de>
X-Provags-ID: V03:K1:imp36udsrO2nyS8JPjqHA5Ds3hFhxVLPHpRGVSWPBGXVbL9/rNV
 imiE1c81Sfttwp+bT8f8tuK+epvIVP0/tH2n09iCfqvqjLRLlFBwdbr6U+nTVjL+eKbRy82
 /29LhtzYPzABNffKaggHUp+zeicohWvtT/S8mD+XO+rHW/DejrjMQq9cGaJyd1HBBEumpqw
 plfhY45irAx+gsxE+znig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FL2ZqB/032s=:1A5r01tQmTrILHRXQDy23a
 KFl3ApCPT8sFp2nlafvObwMRHbliIqVL2rMDndnA07kCYvYEizbMGt3o0wJZAFdpNz3kS7ln6
 doQt8lxk5AjbiyNPeSPVypLaLKBL+9ecrGYPefgriCFVt9Ddh617MIlRnTb/RM4FjvZzpdzk2
 aW8MbQIuJtfC+B2Q15BroI+/75njcF7WXHu6vf9kZu1mYXNPAoq4nS/qN+BBq1q10kF/qZiSB
 4ElYO57rst6Jvl7XlbRKy1D9O+uqCHLl1NiZZeWHGuAh7LvkLCBB6sQL1mgERYY1HPInoadrM
 NaNGhb6gpNJAaJ+aOhqBqZTwSEz905wppbKg8my0ZgosbExtpjhGJBpDrImOpXkrw9Sb85cZT
 PhYnGbAjh+HxCXfyWW8G3raZzukxI7xGnFVlaaxLXgYduuV7CMu/Qll6tQQCQIGokEipROWKF
 Zk9BsAVXb5wdT7saIcAAplUs0nccZd6gYsyLcEnHSur1Z6OIsevthXjOvaReUUF1XggWq4Ze/
 Q4LljBdzAVS14y6HHjFLmP7+dsqXO6uLSPiicMrc/2jS+mzp4QV3fFuzubU2V1pV+mVeG8DxR
 iPsP7lfV+geEoBhHreBzfk9KOHzn00fI60UbvvvOEj6R0j3U5WLp2DZV58EHejQqaTxd40NGA
 nLme5S/oqqT7vNaz8ku8EyO+SZ1KgTzYgkvH3VlEQQaBAxuKnuzI9PXk/u92Ay6Ic9vw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merging pci_scan_root_bus() into pcifront_scan_root() simplifies
the implementation and makes it more readable. We can allocate
the pcifront_sd structure along with the bridge structure, which
helps manage its lifetime rules so we don't free it before the
device has been released.

There are two small issues that I noticed that could be improved:

- It seems we unregister the 'bus' device that is a child of the
  'pci_host_bridge' device after we unregister its parent in
  pcifront_free_roots(), which seems odd.
- We probably don't need an extra pci_bus_entry list at all,
  but could instead walk the children of the pcifront_device,
  which are all pci_host_bridge devices.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/xen-pcifront.c | 67 ++++++++++++--------------------------
 1 file changed, 21 insertions(+), 46 deletions(-)

diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 24070e1c5f22..a5eb6cb02bec 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -443,40 +443,12 @@ static int pcifront_scan_bus(struct pcifront_device *pdev,
 	return 0;
 }
 
-static struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata, struct list_head *resources)
-{
-	struct pci_host_bridge *bridge;
-	int error;
-
-	bridge = pci_alloc_host_bridge(0);
-	if (!bridge)
-		return NULL;
-
-	list_splice_init(resources, &bridge->windows);
-	bridge->dev.parent = parent;
-	bridge->sysdata = sysdata;
-	bridge->busnr = bus;
-	bridge->ops = ops;
-
-	error = pci_scan_root_bus_bridge(bridge);
-	if (error < 0)
-		goto err_out;
-
-	return bridge->bus;
-
-err_out:
-	kfree(bridge);
-	return NULL;
-}
-
 static int pcifront_scan_root(struct pcifront_device *pdev,
 				 unsigned int domain, unsigned int bus)
 {
-	struct pci_bus *b;
-	LIST_HEAD(resources);
 	struct pcifront_sd *sd = NULL;
 	struct pci_bus_entry *bus_entry = NULL;
+	struct pci_host_bridge *bridge;
 	int err = 0;
 	static struct resource busn_res = {
 		.start = 0,
@@ -498,50 +470,55 @@ static int pcifront_scan_root(struct pcifront_device *pdev,
 	dev_info(&pdev->xdev->dev, "Creating PCI Frontend Bus %04x:%02x\n",
 		 domain, bus);
 
+	bridge = pci_alloc_host_bridge(sizeof(*sd));
+	if (!bridge)
+		return -ENOMEM;
+
 	bus_entry = kzalloc(sizeof(*bus_entry), GFP_KERNEL);
-	sd = kzalloc(sizeof(*sd), GFP_KERNEL);
-	if (!bus_entry || !sd) {
+	sd = pci_host_bridge_priv(bridge);
+	if (!bus_entry) {
 		err = -ENOMEM;
 		goto err_out;
 	}
-	pci_add_resource(&resources, &ioport_resource);
-	pci_add_resource(&resources, &iomem_resource);
-	pci_add_resource(&resources, &busn_res);
+	pci_add_resource(&bridge->windows, &ioport_resource);
+	pci_add_resource(&bridge->windows, &iomem_resource);
+	pci_add_resource(&bridge->windows, &busn_res);
 	pcifront_init_sd(sd, domain, bus, pdev);
+	bridge->dev.parent = &pdev->xdev->dev;
+	bridge->sysdata = sd;
+	bridge->busnr = bus;
+	bridge->ops = &pcifront_bus_ops;
 
 	pci_lock_rescan_remove();
 
-	b = pci_scan_root_bus(&pdev->xdev->dev, bus,
-				  &pcifront_bus_ops, sd, &resources);
-	if (!b) {
+	err = pci_scan_root_bus_bridge(bridge);
+	if (err < 0) {
 		dev_err(&pdev->xdev->dev,
 			"Error creating PCI Frontend Bus!\n");
-		err = -ENOMEM;
 		pci_unlock_rescan_remove();
-		pci_free_resource_list(&resources);
 		goto err_out;
 	}
 
-	bus_entry->bus = b;
+	bus_entry->bus = bridge->bus;
 
 	list_add(&bus_entry->list, &pdev->root_buses);
 
 	/* pci_scan_root_bus skips devices which do not have a
 	* devfn==0. The pcifront_scan_bus enumerates all devfn. */
-	err = pcifront_scan_bus(pdev, domain, bus, b);
+	err = pcifront_scan_bus(pdev, domain, bus, bridge->bus);
 
 	/* Claim resources before going "live" with our devices */
-	pci_walk_bus(b, pcifront_claim_resource, pdev);
+	pci_walk_bus(bridge->bus, pcifront_claim_resource, pdev);
 
 	/* Create SysFS and notify udev of the devices. Aka: "going live" */
-	pci_bus_add_devices(b);
+	pci_bus_add_devices(bridge->bus);
 
 	pci_unlock_rescan_remove();
 	return err;
 
 err_out:
+	pci_free_host_bridge(bridge);
 	kfree(bus_entry);
-	kfree(sd);
 
 	return err;
 }
@@ -605,8 +582,6 @@ static void pcifront_free_roots(struct pcifront_device *pdev)
 
 		free_root_bus_devs(bus_entry->bus);
 
-		kfree(bus_entry->bus->sysdata);
-
 		device_unregister(bus_entry->bus->bridge);
 		pci_remove_bus(bus_entry->bus);
 
-- 
2.18.0

