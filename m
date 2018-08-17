Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E458C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B432124D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B432124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeHQNff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:35:35 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:42823 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeHQNfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:35:33 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M2Mj6-1g72xf2n4O-00s8O9; Fri, 17 Aug 2018 12:27:19 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 11/15] PCI: hyperv: convert to pci_scan_root_bus_bridge
Date:   Fri, 17 Aug 2018 12:26:41 +0200
Message-Id: <20180817102645.3839621-12-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817102645.3839621-1-arnd@arndb.de>
References: <20180817102645.3839621-1-arnd@arndb.de>
X-Provags-ID: V03:K1:GawKYPNeblKXqePXMTqVUwJzPp4kDv9XunHKMjoeqmVocUEEVjM
 lkYgN2PiNwSPbXjS7Dii+2JTCPx/c95lj3gECJvX5IBv4mvtne+6VUdTVunsCr0Y+mlTkfc
 DGbWBehQ648C/tekyqiyObV6jpd7FXp6y3vcEIFfvC8pa/mnrRfRoZ+Og0ehO+tP6FrDZE9
 w8e4yawJshAPLppwwwJWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fxpVOh8CRvU=:q/r7CREw9q7Zjc/R/UTtzI
 t09tyN3hj1ulxsUAzwtiN6AP+Rrjag5zkIt+HBEPBbM2Qt/i/TWhW/n8MjB28kbWWFK/MfDk7
 gYijMym2nAJA4EMb5oVzsbOB8TnLE9YGisDWuQtl09NvT0bvZWyCA7xZO3NUQVqQ0Gcl/o1sE
 YKJVPpgo+50TIG2bcPc9h5rl4Y1MLY/J866SsPVzk0buhtSh+ze5U0vDh23BIxCiXbln9ROdP
 XvD6AbRXd+Ab+OC6ueC6HDkxBTySOCIniSsVcKXivMdEmvxRdOAexM8J1kGzfL1niEItbNFF4
 jPnQLewOBUcKHhhbt8ywxxetNSttd2yMQ6g5guRzWrrxs6XkNsjGKcOF102uqXH6L4b33rkWw
 T7eaXdgQSv9TS+l5E32pKSbHyjQ0bqMdvtJhtjFxBXeg3R2N9QHjzSbXgHUwy8+7/oRgu/ZN/
 spJB24Qski3myqmjqhwQUg53lrz2irhiVphDyNLNPOavK116uauw6ZLjBH28xbYVU/3YUPFQl
 SLFzyR7Bb+XhM0L3GrmWQS9sx/AJgCwXWMUuE+Uv7/jNeORoJkSUNta25Ob6qPNSsHFV6ZsBu
 J/LvXO995FFGSi53/kmB9DbAj68BzSVuHU0E3BKj5GHm7w/cnTp1m2PGqGA6+/Z8WiiFTsg1N
 eZOkQdSTxgzBTJDY2e+UDyLrd8axaxN+A7+mMgqRIWYrx6PZtMOS4ps7zz5vqdsoA/VA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

create_root_hv_pci_bus() uses a rather generic method of probing the host
bridge, which can be simplified by just calling pci_scan_root_bus_bridge()
after setting up the pci_host_bridge structure.

Since we can no longer assign hbus->pci_bus in the middle, I just remove
that member completely and use the pci_host_bridge instead.

Ideally we'd convert it to pci_host_probe() for simplicity, but
that is a bit different and I could not easily test it. Using
pci_scan_root_bus_bridge should not change the behavior at all.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/controller/pci-hyperv.c | 75 +++++++++++------------------
 1 file changed, 28 insertions(+), 47 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index df7cddea8e30..49586aefa38b 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -443,7 +443,7 @@ struct hv_pcibus_device {
 	struct resource *high_mmio_res;
 	struct completion *survey_event;
 	struct completion remove_event;
-	struct pci_bus *pci_bus;
+	struct pci_host_bridge *bridge;
 	spinlock_t config_lock;	/* Avoid two threads writing index page */
 	spinlock_t device_list_lock;	/* Protect lists below */
 	void __iomem *cfg_addr;
@@ -1457,34 +1457,6 @@ static void prepopulate_bars(struct hv_pcibus_device *hbus)
 	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
 }
 
-static struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
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
 /**
  * create_root_hv_pci_bus() - Expose a new root PCI bus
  * @hbus:	Root PCI bus, as understood by this driver
@@ -1493,25 +1465,34 @@ static struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
  */
 static int create_root_hv_pci_bus(struct hv_pcibus_device *hbus)
 {
-	/* Register the device */
-	hbus->pci_bus = pci_create_root_bus(&hbus->hdev->device,
-					    0, /* bus number is always zero */
-					    &hv_pcifront_ops,
-					    &hbus->sysdata,
-					    &hbus->resources_for_children);
-	if (!hbus->pci_bus)
-		return -ENODEV;
+	struct pci_host_bridge *bridge;
+	int ret;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return -ENOMEM;
 
-	hbus->pci_bus->msi = &hbus->msi_chip;
-	hbus->pci_bus->msi->dev = &hbus->hdev->device;
+	hbus->bridge = bridge;
+	bridge->dev.parent = &hbus->hdev->device;
+	list_splice_init(&hbus->resources_for_children, &bridge->windows);
+	bridge->sysdata = &hbus->sysdata;
+	bridge->ops = &hv_pcifront_ops;
+	bridge->msi = &hbus->msi_chip;
+	bridge->msi->dev = &hbus->hdev->device;
 
 	pci_lock_rescan_remove();
-	pci_scan_child_bus(hbus->pci_bus);
-	pci_bus_assign_resources(hbus->pci_bus);
-	pci_bus_add_devices(hbus->pci_bus);
-	pci_unlock_rescan_remove();
+	/* ideally we should use pci_host_probe here */
+	ret = pci_scan_root_bus_bridge(bridge);
+	if (ret < 0) {
+		pci_free_host_bridge(bridge);
+		goto error;
+	}
+	pci_bus_assign_resources(bridge->bus);
+	pci_bus_add_devices(bridge->bus);
 	hbus->state = hv_pcibus_installed;
-	return 0;
+error:
+	pci_unlock_rescan_remove();
+	return ret;
 }
 
 struct q_res_req_compl {
@@ -1769,7 +1750,7 @@ static void pci_devices_present_work(struct work_struct *work)
 		 * because there may have been changes.
 		 */
 		pci_lock_rescan_remove();
-		pci_scan_child_bus(hbus->pci_bus);
+		pci_scan_child_bus(hbus->bridge->bus);
 		pci_unlock_rescan_remove();
 		break;
 
@@ -2669,8 +2650,8 @@ static int hv_pci_remove(struct hv_device *hdev)
 	if (hbus->state == hv_pcibus_installed) {
 		/* Remove the bus from PCI's point of view. */
 		pci_lock_rescan_remove();
-		pci_stop_root_bus(hbus->pci_bus);
-		pci_remove_root_bus(hbus->pci_bus);
+		pci_stop_root_bus(hbus->bridge->bus);
+		pci_remove_root_bus(hbus->bridge->bus);
 		pci_unlock_rescan_remove();
 		hbus->state = hv_pcibus_removed;
 	}
-- 
2.18.0

