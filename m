Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DACC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E1D2124D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E1D2124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbeHQNa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:30:29 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:54093 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeHQNa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:30:29 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MF3Yx-1ffKFY0w9b-00GG86; Fri, 17 Aug 2018 12:27:19 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 10/15] sparc/PCI: simplify pci_scan_one_pbm
Date:   Fri, 17 Aug 2018 12:26:40 +0200
Message-Id: <20180817102645.3839621-11-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817102645.3839621-1-arnd@arndb.de>
References: <20180817102645.3839621-1-arnd@arndb.de>
X-Provags-ID: V03:K1:tqfqrJow5W4imcQdki9mGzYbBLDxofa09sQuKVVmcKPe9NKicQu
 8BCFKR5x8HHGblInvnpgfM0Om9m61dXNuEzCIJ49sP//cfH3KTR8BqOqORdz4p1h7JROjqJ
 CiXbMgNkdpblfAYzq1OUFR9CqgorJFNPchgd2Qp4LZRLY2gq8SB2mQD0V3AQBL6R9BKkfBV
 T5dOLAgJhkzmztez96I5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HIAfquh0tdI=:0dA2U75J9e6Y7bRAeRLDpU
 fiYaLHOH0AVd2s9rov8WWEfjDdY97CTXbyas7dLBOmGUy3alOcAjpKpHC23tgOnaVQ+KqEI6h
 SY9mf4k7l5qaPraBVNvUcijJ5fmnEtBnPKgZ61VULSXOUZB5C/Ae7EZvleU8GoWQOaYqho0Wd
 uv/8+l54vLvdm+i5rPtjRntUa0wDwIEyviUXWwEMjn2CXS3RUp6te6SkpZAk/YRuhDiuAPAyn
 qS3vZeDS+n5QC9CSNsDkv/SZ+RjR/eqV5DgKB1PKXzj2nUybL8qQv/RkGazoc04kHmvd+GF6R
 pTM19Xq8siVJoyeODtmjIkZ0Ttt6uew7BA7y+E4RdhS0D4pgV2L9y4U9V4VxKgU2HjujjxexW
 Uw6KKZh3BTyN0rov5fERh2p1R5nunp9qffBcEle8v5LH2pInZmdZOMSZzDYRHk29LkoYJ7qFU
 Ba0xUQlY2OcL9tOKbHMps8HhKxVob6TtX+/MCqIRHQ07673JUS92Fnbu7MYYBBp8JHzjJTE96
 xlfE87rK553fEbwQ3WXiwNpYx+zmtNhznqU/mX/rLks1rS4WTfc5rEPfPn1fPOH4+xrf9FvkG
 OxcDpE4M86hDsuMcxq9q/dlgAfu34AMyTyIXeh0xv2ZFXedd8Z5m7vqzzTxVmz8oOCGMN9HVo
 /oqizZtfSKo7q+qqQIjvQG9mW/eRsqNid04WKSzays1sWwEwevVrC6W8SHm7Wl9Edo3I=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We no longer need a separate pci_create_root_bus() function, and
merging it into pci_scan_one_pbm() makes the implementation easier
to understand.

A possible future cleanup would move the allocation of the
pci_host_bridge structure into the callers of pci_scan_one_pbm,
and avoid duplication between pci_host_bridge and pci_pbm_info
fields.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sparc/kernel/pci.c | 62 ++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 41 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index afbce59d9231..0d34fb2ac55b 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -691,70 +691,50 @@ static void pci_claim_bus_resources(struct pci_bus *bus)
 		pci_claim_bus_resources(child_bus);
 }
 
-static struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
+				 struct device *parent)
 {
-	int error;
+	struct device_node *node = pbm->op->dev.of_node;
 	struct pci_host_bridge *bridge;
+	int ret;
 
 	bridge = pci_alloc_host_bridge(0);
 	if (!bridge)
 		return NULL;
 
 	bridge->dev.parent = parent;
+	bridge->sysdata = pbm;
+	bridge->busnr = pbm->pci_first_busno;
+	bridge->ops = pbm->pci_ops;
 
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
-struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
-				 struct device *parent)
-{
-	LIST_HEAD(resources);
-	struct device_node *node = pbm->op->dev.of_node;
-	struct pci_bus *bus;
-
-	printk("PCI: Scanning PBM %s\n", node->full_name);
-
-	pci_add_resource_offset(&resources, &pbm->io_space,
+	pci_add_resource_offset(&bridge->windows, &pbm->io_space,
 				pbm->io_offset);
-	pci_add_resource_offset(&resources, &pbm->mem_space,
+	pci_add_resource_offset(&bridge->windows, &pbm->mem_space,
 				pbm->mem_offset);
 	if (pbm->mem64_space.flags)
-		pci_add_resource_offset(&resources, &pbm->mem64_space,
+		pci_add_resource_offset(&bridge->windows, &pbm->mem64_space,
 					pbm->mem64_offset);
 	pbm->busn.start = pbm->pci_first_busno;
 	pbm->busn.end	= pbm->pci_last_busno;
 	pbm->busn.flags	= IORESOURCE_BUS;
-	pci_add_resource(&resources, &pbm->busn);
-	bus = pci_create_root_bus(parent, pbm->pci_first_busno, pbm->pci_ops,
-				  pbm, &resources);
-	if (!bus) {
+	pci_add_resource(&bridge->windows, &pbm->busn);
+
+	printk("PCI: Scanning PBM %s\n", node->full_name);
+	ret = pci_register_host_bridge(bridge);
+	if (!ret) {
 		printk(KERN_ERR "Failed to create bus for %s\n",
 		       node->full_name);
-		pci_free_resource_list(&resources);
+		pci_free_host_bridge(bridge);
 		return NULL;
 	}
 
-	pci_of_scan_bus(pbm, node, bus);
-	pci_bus_register_of_sysfs(bus);
+	pci_of_scan_bus(pbm, node, bridge->bus);
+	pci_bus_register_of_sysfs(bridge->bus);
 
-	pci_claim_bus_resources(bus);
+	pci_claim_bus_resources(bridge->bus);
 
-	pci_bus_add_devices(bus);
-	return bus;
+	pci_bus_add_devices(bridge->bus);
+	return bridge->bus;
 }
 
 int pcibios_enable_device(struct pci_dev *dev, int mask)
-- 
2.18.0

