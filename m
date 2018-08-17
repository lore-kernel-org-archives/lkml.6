Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213CBC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D583D2124D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D583D2124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeHQNfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:35:34 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:32981 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeHQNfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:35:33 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M7Knm-1g271607FO-00x44h; Fri, 17 Aug 2018 12:27:18 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 07/15] PCI/ACPI: clean up acpi_pci_root_create()
Date:   Fri, 17 Aug 2018 12:26:37 +0200
Message-Id: <20180817102645.3839621-8-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817102645.3839621-1-arnd@arndb.de>
References: <20180817102645.3839621-1-arnd@arndb.de>
X-Provags-ID: V03:K1:d27yj6uZ03Y8vFzVtfOG4i3FXwc0amjneq2jCzS3uuPksZ77MJw
 z4AgJqMZ+dms4uVm3++DD8efqm6WoDdC/G6wfOryIsOV1RJ2ZY4ekevcPFE7ZTFqkpdKzEv
 v8GV2slLum4Zw9yyUZDD4tFjdvfudOKVLZwMAK0sYh5leF4mXZD6qcPYHNKEZHtlwNRN1V2
 bRQa6vslOKqjMiXp7VGJw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dQxK7tItEl4=:M58Fmg5hzmIJtGAnJoWRiX
 lolFQgFa9Bv2Jzomd8ZcKQFhSRZvChrCKG6kMN4eONirFrjiQvLDtv1Xquv0p8/2VpgFiYgcE
 vCu0/uhbhORMSrGBxJBz9GEKFGYSXOMJHltVdDKPNhxY/pu0C1LrOxCbpRECgS930TbBXtL3g
 ZO6yChgg5Oj7V4bNhSRjm6LPDmhje4+qCpygbu1ZUEfXWdmc/g5kxL7LCFKZYvr4PJ9Tl6ary
 FVjhbbXqR3+3VP8ljQ3GY/od8tVN3WyDLhrEU1OPf6mgcaKFbd8oKlTUxlCC8TBCyptLH6Qdm
 BdOqGgMxGLALN3gKh5ptAWLsfsKYDQsEb75eovdwMEarGTjHUzi94I4LG5tK/b9sexHFELK50
 vhN7zaEakHOQlz1Q60WzTb8GplZ+TCR3FflwWKesT2kQ/RInMyyYAHcxQfUUnEAqth6SNIQCb
 v2Bm0ntVXggdTjsRQ0yMwMuZh287Is44XfttsP7ELxU92jaLQEzRvJgGG45O4xlS1PIpAnsZg
 95t2v0gEe2eV60wSpm/mNwHz6hOzcxtNNz2ZGWUo0oOtOioq11nuxSeMHPiVaY1F80O0nHt/t
 781UwKEK/tkhs7/WF94ZbLmsgRr346WW+W+KuloOyzmNrgg8GiiWHdNrJyF9nXNGFLfglJV78
 eG562zDwpU6+HVPCDRIUAwzjUeH2gxhKMehascMDaXSFSPjKao20exZi9lZwJqyb4tiM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The acpi_pci_create_root_bus() can be fully integrated into
acpi_pci_root_create(), improving a few things:

* We can call pci_scan_root_bus_bridge(), which registers and
  scans the bridge in one step.
* After a failure in pci_register_host_bridge(), we correctly
  clean up the resources.
* The bridge settings (release function, flags, operations etc)
  can get set up before registering the bridge.
* Further cleanup would be possible, removing duplication between
  pci_host_bridge and some ACPI structures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/acpi/pci_root.c | 68 +++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 44 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 85dbcf47015b..5f73de3b67c8 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -873,34 +873,6 @@ static void acpi_pci_root_release_info(struct pci_host_bridge *bridge)
 	__acpi_pci_root_release_info(bridge->release_data);
 }
 
-static struct pci_bus *acpi_pci_create_root_bus(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata, struct list_head *resources)
-{
-	int error;
-	struct pci_host_bridge *bridge;
-
-	bridge = pci_alloc_host_bridge(0);
-	if (!bridge)
-		return NULL;
-
-	bridge->dev.parent = parent;
-
-	list_splice_init(resources, &bridge->windows);
-	bridge->sysdata = sysdata;
-	bridge->busnr = bus;
-	bridge->ops = ops;
-
-	error = pci_register_host_bridge(bridge);
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
 struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 				     struct acpi_pci_root_ops *ops,
 				     struct acpi_pci_root_info *info,
@@ -909,8 +881,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	int ret, busnum = root->secondary.start;
 	struct acpi_device *device = root->device;
 	int node = acpi_get_node(device->handle);
-	struct pci_bus *bus;
-	struct pci_host_bridge *host_bridge;
+	struct pci_host_bridge *bridge;
 
 	info->root = root;
 	info->bridge = device;
@@ -930,30 +901,39 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 
 	pci_acpi_root_add_resources(info);
 	pci_add_resource(&info->resources, &root->secondary);
-	bus = acpi_pci_create_root_bus(NULL, busnum, ops->pci_ops,
-				  sysdata, &info->resources);
-	if (!bus)
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
 		goto out_release_info;
 
-	host_bridge = to_pci_host_bridge(bus->bridge);
+	list_splice_init(&info->resources, &bridge->windows);
+	bridge->sysdata = sysdata;
+	bridge->busnr = busnum;
+	bridge->ops = ops->pci_ops;
+	pci_set_host_bridge_release(bridge, acpi_pci_root_release_info,
+				    info);
+
 	if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
-		host_bridge->native_pcie_hotplug = 0;
+		bridge->native_pcie_hotplug = 0;
 	if (!(root->osc_control_set & OSC_PCI_SHPC_NATIVE_HP_CONTROL))
-		host_bridge->native_shpc_hotplug = 0;
+		bridge->native_shpc_hotplug = 0;
 	if (!(root->osc_control_set & OSC_PCI_EXPRESS_AER_CONTROL))
-		host_bridge->native_aer = 0;
+		bridge->native_aer = 0;
 	if (!(root->osc_control_set & OSC_PCI_EXPRESS_PME_CONTROL))
-		host_bridge->native_pme = 0;
+		bridge->native_pme = 0;
 	if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
-		host_bridge->native_ltr = 0;
+		bridge->native_ltr = 0;
+
+	ret = pci_scan_root_bus_bridge(bridge);
+	if (ret < 0)
+		goto out_release_bridge;
 
-	pci_scan_child_bus(bus);
-	pci_set_host_bridge_release(host_bridge, acpi_pci_root_release_info,
-				    info);
 	if (node != NUMA_NO_NODE)
-		dev_printk(KERN_DEBUG, &bus->dev, "on NUMA node %d\n", node);
-	return bus;
+		dev_printk(KERN_DEBUG, &bridge->bus->dev, "on NUMA node %d\n", node);
+	return bridge->bus;
 
+out_release_bridge:
+	pci_free_host_bridge(bridge);
 out_release_info:
 	__acpi_pci_root_release_info(info);
 	return NULL;
-- 
2.18.0

