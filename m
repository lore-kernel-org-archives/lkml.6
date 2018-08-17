Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA656C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BB6208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BB6208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeHQNad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:30:33 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:49229 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeHQNab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:30:31 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LbrfA-1gFk7r2rG0-00jIgT; Fri, 17 Aug 2018 12:27:15 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 01/15] PCI: clean up legacy host bridge scan functions
Date:   Fri, 17 Aug 2018 12:26:31 +0200
Message-Id: <20180817102645.3839621-2-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817102645.3839621-1-arnd@arndb.de>
References: <20180817102645.3839621-1-arnd@arndb.de>
X-Provags-ID: V03:K1:qDqhbuzSX8z08T2QJlMsg/+ruOlcqG1c6ro78J/5MxdL56nnRad
 yO5HhKo3efL2siEaAAY7qOiJJ3tKLIqKd6DJd1500VXoRHZnzIU11B5eNkG3bBfbRbiMaOC
 7sIxy4pZO0kdRg2lK5a97hD/1JtCLT9+XU9Bhcz8Phl5VVvzt8s/T5OnHN6eXScNldLezo9
 2xaQ1mtfde4n2i8BI3gDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jfQRhFGulKg=:XukBP/UhVY4BRzkO84yddY
 qQprVATs/qCyceQTQaz+NSylj38T+4mtihVDs3Lu2LdCa1KYaNdq3gRlgvmqPRcs8HvdHy6Oi
 9gEnQJaQJTT28Na47z6gb3ssYaSqkriElVDkOJ6POo3RjjkpCPEf+02/pTfuqK3E4fvzcxwD0
 BsvGfrcRv1rBlbcLybB4/WrFXvSLSgbapLU9ENLSsVJRMKh9bgR5IJtNotnR14UkHxxJl3X5k
 9pIUmf11wUVON5jlM9WT8wJBOFmcmsKfAxcQ5/dhB8fnzqtofDUYi8ghIisUjtYpusFeyI+lP
 XCOQ5IRbxIL1Mv+LBQ/O/jqMQ0hJwza3VFRwmrsFihyPai9gybRhVVear1GmMLGvHu1rpMjXP
 PkfaKh/Nche6GRkGXkltaZsVuMqrlDwFxTWN/qVCg92pRQk1VMSUQLvbWZYhelAs3GKgcKBRm
 uXLFTlGeXM3t3x6/3HyDjg4GBGEfs7MxcbUlJfhSkI1niAgMYb5TTB6fkbBex2PXKOah0tDE3
 NLbO9MPHnbrM88zKxCyN4CziOFndAmJTEH42nME+FcgVqAJc2gJkOGzJL9DwcC+zDTSule+RG
 lvvEzhnosFOE+1Phg9bv8wgPAmbyGBaoDqUia7FHDe0LutTZgvUruaDaa25nfzFZGGqRV8d4S
 GnUtdvrrcKhF2BVCA+dU2Gnpmp0a6aap6Q0M8QFyLPMA3HDxd2vt8msowj/dDlKIVlzE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aside from the modern pci_host_bridge based interfaces, we have a couple
of interfaces from old times that are still used in a couple of platforms:
pci_create_root_bus(), pci_scan_bus() and pci_scan_root_bus().

As a first step towards getting everybody to use the new interfaces,
this simplifies the latter two to call the pci_alloc_host_bridge() and
pci_register_host_bridge()/pci_scan_root_bus_bridge() interfaces directly.

The behavior should be entirely unchanged here, but we can then push
down the functions into the individual host implementations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/probe.c | 86 ++++++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ec784009a36b..b0f666271245 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -23,13 +23,6 @@
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
 #define CARDBUS_RESERVE_BUSNR	3
 
-static struct resource busn_resource = {
-	.name	= "PCI busn",
-	.start	= 0,
-	.end	= 255,
-	.flags	= IORESOURCE_BUS,
-};
-
 /* Ugh.  Need to stop exporting this to modules. */
 LIST_HEAD(pci_root_buses);
 EXPORT_SYMBOL(pci_root_buses);
@@ -3060,53 +3053,64 @@ EXPORT_SYMBOL(pci_scan_root_bus_bridge);
 struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 		struct pci_ops *ops, void *sysdata, struct list_head *resources)
 {
-	struct resource_entry *window;
-	bool found = false;
-	struct pci_bus *b;
-	int max;
-
-	resource_list_for_each_entry(window, resources)
-		if (window->res->flags & IORESOURCE_BUS) {
-			found = true;
-			break;
-		}
+	struct pci_host_bridge *bridge;
+	int error;
 
-	b = pci_create_root_bus(parent, bus, ops, sysdata, resources);
-	if (!b)
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
 		return NULL;
 
-	if (!found) {
-		dev_info(&b->dev,
-		 "No busn resource found for root bus, will use [bus %02x-ff]\n",
-			bus);
-		pci_bus_insert_busn_res(b, bus, 255);
-	}
+	list_splice_init(resources, &bridge->windows);
+	bridge->dev.parent = parent;
+	bridge->sysdata = sysdata;
+	bridge->busnr = bus;
+	bridge->ops = ops;
 
-	max = pci_scan_child_bus(b);
+	error = pci_scan_root_bus_bridge(bridge);
+	if (error < 0)
+		goto err_out;
 
-	if (!found)
-		pci_bus_update_busn_res_end(b, max);
+	return bridge->bus;
 
-	return b;
+err_out:
+	kfree(bridge);
+	return NULL;
 }
 EXPORT_SYMBOL(pci_scan_root_bus);
 
+static struct resource busn_resource = {
+	.name	= "PCI busn",
+	.start	= 0,
+	.end	= 255,
+	.flags	= IORESOURCE_BUS,
+};
+
 struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops,
 					void *sysdata)
 {
-	LIST_HEAD(resources);
-	struct pci_bus *b;
+	struct pci_host_bridge *bridge;
+	int error;
 
-	pci_add_resource(&resources, &ioport_resource);
-	pci_add_resource(&resources, &iomem_resource);
-	pci_add_resource(&resources, &busn_resource);
-	b = pci_create_root_bus(NULL, bus, ops, sysdata, &resources);
-	if (b) {
-		pci_scan_child_bus(b);
-	} else {
-		pci_free_resource_list(&resources);
-	}
-	return b;
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		goto err;
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
 }
 EXPORT_SYMBOL(pci_scan_bus);
 
-- 
2.18.0

