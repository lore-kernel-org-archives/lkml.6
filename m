Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A930EC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60FAB20870
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60FAB20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbeHQNcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:32:33 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:55085 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeHQNcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:32:32 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LvSJX-1fz1xG2f1H-010giE; Fri, 17 Aug 2018 12:27:17 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 06/15] powerpc/pci: fold pci_create_root_bus into pcibios_scan_phb
Date:   Fri, 17 Aug 2018 12:26:36 +0200
Message-Id: <20180817102645.3839621-7-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817102645.3839621-1-arnd@arndb.de>
References: <20180817102645.3839621-1-arnd@arndb.de>
X-Provags-ID: V03:K1:GixNoySXnYxESLRg71MMIUbdbc//wFh3XcXU1/rjlBZzggqeBtp
 KPW4mj1HSwQZQBdmqQg5+/P2JSkT5CbRoRegXb4oiClTKfDQh+QKkW5IWPmMGJO014pWS9j
 rUlg1LOuTJCptgf5uWmttL2Kdz0uSl83sfIu0nv6TbSYcbgDSSGxso8c+NkJc0Hlzvd+op6
 I+pz8368UQ08r7uDZiDbw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:C2dcC/uIStM=:3Ei2a6aC1/jz/fC6EZFUqw
 QSvyA2LDGlBHcM8akYCfcsVYAUX9Sn93QVKdDUwUaIjZellX6+Jp08+YoKJ42rZueKfDM8cI2
 tdSn7be0cCWBSvAzSDIf3xptp63SGM3UnqcA+eKUfGB14qShFIioNxoGmxuSIa8COAZ+EQb5i
 E0rHSOoF4RwGk3rOK7VIrz+CtN/TkS13drpbZ1SPK3/aA8JsxLxpaoOp0k6AyTyvDl4KSvKco
 niiqoWZgL+tQGo9msu0Bwn5FsvgShgOHtZgCgZyKHS3xxzgdEaHZ12WfSziBXQtL2Rvagu1nt
 1uzeG9KTgRTMXRjGVHUz3qb6a1PFAxzpUa+dXsUge04dss81ZGpKdNlgzQtoU9Y9/7x24RhsF
 gDHCBftvOgWxzt/CB0XfsYa/1T2XXoMrEPo60+ctxFFsuzj9Kxkwm1hHaxB9RDjoxvM/qI5hN
 H702qoml66LVdN8BwvZ2Xxadpq1kfgX3Ek61O9sXCtG8+566F+6hSBca3MOYK4AFD2/1Udli3
 JiSNWzt9W0B+4GJ0LnWMxL8u0Rcs9V7BfNODINGNavNtMCB88UzaVBtXx4ccTs0Ne9KlHGixU
 E3uNjsM9wfOEAiSRYnoGgBGhomF68lw7y7k2g6H7owOaYcPkCS45r5zKAyFPFzGo03HW4zd0K
 VhnsBhPwJwpyt920c4dup7565tuAwVDIGRIuKedk+ndktXMirehAC/jTBYLdiIGEcXRI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This slightly simplifies the pcibios_scan_phb() implementation, and
gives us an easier point to add further fields in the pci_host_bridge
structure.

I tried removing fields that are duplicated between pci_host_bridge
and pci_controller (which really serve the same purpose), but
ran into the problem that we can't call pci_alloc_host_bridge()
as early as pcibios_alloc_controller(). Some more refactoring
is needed for that, but it could noticably clean the powerpc code
up more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/include/asm/pci-bridge.h |  3 ++
 arch/powerpc/kernel/pci-common.c      | 72 ++++++++++-----------------
 2 files changed, 30 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 94d449031b18..42ae567084d9 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -51,8 +51,11 @@ struct pci_controller_ops {
 
 /*
  * Structure of a PCI controller (host bridge)
+ * Some members here are duplicated in struct pci_host_bridge
+ * and should be moved there.
  */
 struct pci_controller {
+	struct pci_host_bridge *bridge;
 	struct pci_bus *bus;
 	char is_dynamic;
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 57ca621a32f4..096011ec8670 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1587,81 +1587,63 @@ struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
 	return of_node_get(hose->dn);
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
  * pci_scan_phb - Given a pci_controller, setup and scan the PCI bus
  * @hose: Pointer to the PCI host controller instance structure
  */
 void pcibios_scan_phb(struct pci_controller *hose)
 {
-	LIST_HEAD(resources);
-	struct pci_bus *bus;
 	struct device_node *node = hose->dn;
 	int mode;
+	struct pci_host_bridge *bridge;
+	int error;
 
 	pr_debug("PCI: Scanning PHB %pOF\n", node);
 
+	/* The allocation should ideally be done in pcibios_alloc_controller(),
+	 * but pci_alloc_host_bridge() requires slab to work first */
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return;
+
 	/* Get some IO space for the new PHB */
 	pcibios_setup_phb_io_space(hose);
 
 	/* Wire up PHB bus resources */
-	pcibios_setup_phb_resources(hose, &resources);
+	pcibios_setup_phb_resources(hose, &bridge->windows);
 
 	hose->busn.start = hose->first_busno;
 	hose->busn.end	 = hose->last_busno;
 	hose->busn.flags = IORESOURCE_BUS;
-	pci_add_resource(&resources, &hose->busn);
+	pci_add_resource(&bridge->windows, &hose->busn);
+
+	bridge->dev.parent = hose->parent;
+	bridge->sysdata = hose;
+	bridge->busnr = hose->first_busno;
+	bridge->ops = hose->ops;
 
-	/* Create an empty bus for the toplevel */
-	bus = pci_create_root_bus(hose->parent, hose->first_busno,
-				  hose->ops, hose, &resources);
-	if (bus == NULL) {
+	error = pci_register_host_bridge(bridge);
+	if (error < 0) {
 		pr_err("Failed to create bus for PCI domain %04x\n",
 			hose->global_number);
-		pci_free_resource_list(&resources);
+		pci_free_host_bridge(bridge);
 		return;
 	}
-	hose->bus = bus;
+	hose->bridge = bridge;
+	hose->bus = bridge->bus;
 
 	/* Get probe mode and perform scan */
 	mode = PCI_PROBE_NORMAL;
 	if (node && hose->controller_ops.probe_mode)
-		mode = hose->controller_ops.probe_mode(bus);
+		mode = hose->controller_ops.probe_mode(bridge->bus);
 	pr_debug("    probe mode: %d\n", mode);
 	if (mode == PCI_PROBE_DEVTREE)
-		of_scan_bus(node, bus);
+		of_scan_bus(node, bridge->bus);
 
 	if (mode == PCI_PROBE_NORMAL) {
-		pci_bus_update_busn_res_end(bus, 255);
-		hose->last_busno = pci_scan_child_bus(bus);
-		pci_bus_update_busn_res_end(bus, hose->last_busno);
+		pci_bus_update_busn_res_end(bridge->bus, 255);
+		hose->last_busno = pci_scan_child_bus(bridge->bus);
+		pci_bus_update_busn_res_end(bridge->bus, hose->last_busno);
 	}
 
 	/* Platform gets a chance to do some global fixups before
@@ -1671,9 +1653,9 @@ void pcibios_scan_phb(struct pci_controller *hose)
 		ppc_md.pcibios_fixup_phb(hose);
 
 	/* Configure PCI Express settings */
-	if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
+	if (bridge->bus && !pci_has_flag(PCI_PROBE_ONLY)) {
 		struct pci_bus *child;
-		list_for_each_entry(child, &bus->children, node)
+		list_for_each_entry(child, &bridge->bus->children, node)
 			pcie_bus_configure_settings(child);
 	}
 }
-- 
2.18.0

