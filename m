Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBDBC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C66B2124D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C66B2124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeHQNfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:35:36 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:41337 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbeHQNfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:35:36 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0Mf0OX-1fXBJl1wd7-00OXrw; Fri, 17 Aug 2018 12:27:16 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 03/15] PCI: move pci_scan_root_bus into callers
Date:   Fri, 17 Aug 2018 12:26:33 +0200
Message-Id: <20180817102645.3839621-4-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817102645.3839621-1-arnd@arndb.de>
References: <20180817102645.3839621-1-arnd@arndb.de>
X-Provags-ID: V03:K1:/BkngKF/6b10KWqzjF4LQs6B6MkQtkRFmL6SWbFHT/fR7ZScAD6
 PxIPcoQ33neYAd2DVQLD4hSnISy5S+mjTGrPpMPdZPzOGGwcgsdWWFM+AuB+VXQ/Un5aGIY
 StxePL7nJko2UJ1UZ5SoqMJdCUyytat7rPOFwnoUXMwuQprWGUrja1NmIA1Y28QzLVqWGsL
 VZPgBGucfp/4ObNhRus3w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yk/2WoKa2Tc=:UZx4Ov030SIXEGCgA89BLa
 Fo7ZjH7sD3AjG5Olyljg6m0KZNfNxTw4KN4WaBTbdciiJyzE9Nw2OqOnlrR63j7oiDJBVZaOd
 s9NmiGAJunm6OpoovumSicVPX53M/9bECWo1zLMuDvmT2l55e9ph+zWE3+iWaXg0XqbsA9SnI
 wQVT1yyBFacJosDoePfbuMw5g2w8UGIfoOJQ3ewVd5qJk9XhbgfK6oJf02f7AoFHoPFSWLZe6
 t7vXC3p/uNgZlgxH2zg6f+gAvOfsiuGUU7c03yz7PE5qMswJpjkvnqWRPPXnqG6N02v3QJomV
 yiCAD2ZrXAnBidZ1nCpHyrI17n7/QvgK86I3h1psOQPsLieFhcawINXKNI1K+WXskW2lhZvrq
 2x6KiGWINfBINz6Y9VA4gLZQz1yWKxGglBCKphglpE6HGwLHVIaoki/7fb683+vjKpJv2xRXp
 YHAxC7s+/XR8lQRoKRCL7FUB4wqjeQ1Gsie8TZriTyMtUdqvMsLU7WjxbiUcgyLsguIw+vXr5
 97L4OarAAGrQcjvppO7sHk8eyu12XUuDYmjHgTKfPQBh3c+Af27LbvvIv6Z49ct5uYJUAeqn9
 VF2lOMRy5cP4spbAiTVydTZVhP0xQesHqYOwasIPqxePgv5iErX0JTIdpZ+DeuW0jQ8Eyh8t1
 Ta6LBxHDivrMsFXmCyrxPnINY+sjfjXqMtfSqpDRJRollpk7d7KE/NzL0a2BFiBtRkQ8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are only six remaining callers of the old pci_scan_root_bus()
interface. Since we want to expose the pci_host_bridge structure
everywhere and discourage users from calling the old interfaces, let's
move the implementation into the respective callsites.

While this duplicates the source code, it makes the object code smaller
for almost all users by avoiding the global implementation, and it allows
further cleanup of the callers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/ia64/sn/kernel/io_init.c    | 27 +++++++++++++++++++++++++++
 arch/microblaze/pci/pci-common.c | 27 +++++++++++++++++++++++++++
 arch/s390/pci/pci.c              | 27 +++++++++++++++++++++++++++
 arch/x86/pci/common.c            | 27 +++++++++++++++++++++++++++
 arch/xtensa/kernel/pci.c         | 27 +++++++++++++++++++++++++++
 drivers/pci/probe.c              | 28 ----------------------------
 drivers/pci/xen-pcifront.c       | 27 +++++++++++++++++++++++++++
 include/linux/pci.h              |  3 ---
 8 files changed, 162 insertions(+), 31 deletions(-)

diff --git a/arch/ia64/sn/kernel/io_init.c b/arch/ia64/sn/kernel/io_init.c
index d63809a6adfa..e768702a7b45 100644
--- a/arch/ia64/sn/kernel/io_init.c
+++ b/arch/ia64/sn/kernel/io_init.c
@@ -213,6 +213,33 @@ sn_io_slot_fixup(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(sn_io_slot_fixup);
 
+static struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	struct pci_host_bridge *bridge;
+	int error;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return NULL;
+
+	list_splice_init(resources, &bridge->windows);
+	bridge->dev.parent = parent;
+	bridge->sysdata = sysdata;
+	bridge->busnr = bus;
+	bridge->ops = ops;
+
+	error = pci_scan_root_bus_bridge(bridge);
+	if (error < 0)
+		goto err_out;
+
+	return bridge->bus;
+
+err_out:
+	kfree(bridge);
+	return NULL;
+}
+
 /*
  * sn_pci_controller_fixup() - This routine sets up a bus's resources
  *			       consistent with the Linux PCI abstraction layer.
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index f34346d56095..302071385e1b 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -977,6 +977,33 @@ static void pcibios_setup_phb_resources(struct pci_controller *hose,
 		 (unsigned long)hose->io_base_virt - _IO_BASE);
 }
 
+static struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	struct pci_host_bridge *bridge;
+	int error;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return NULL;
+
+	list_splice_init(resources, &bridge->windows);
+	bridge->dev.parent = parent;
+	bridge->sysdata = sysdata;
+	bridge->busnr = bus;
+	bridge->ops = ops;
+
+	error = pci_scan_root_bus_bridge(bridge);
+	if (error < 0)
+		goto err_out;
+
+	return bridge->bus;
+
+err_out:
+	kfree(bridge);
+	return NULL;
+}
+
 static void pcibios_scan_phb(struct pci_controller *hose)
 {
 	LIST_HEAD(resources);
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 9f6f392a4461..b21205f131ce 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -786,6 +786,33 @@ void pcibios_remove_bus(struct pci_bus *bus)
 	kfree(zdev);
 }
 
+static struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	struct pci_host_bridge *bridge;
+	int error;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return NULL;
+
+	list_splice_init(resources, &bridge->windows);
+	bridge->dev.parent = parent;
+	bridge->sysdata = sysdata;
+	bridge->busnr = bus;
+	bridge->ops = ops;
+
+	error = pci_scan_root_bus_bridge(bridge);
+	if (error < 0)
+		goto err_out;
+
+	return bridge->bus;
+
+err_out:
+	kfree(bridge);
+	return NULL;
+}
+
 static int zpci_scan_bus(struct zpci_dev *zdev)
 {
 	LIST_HEAD(resources);
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index d4ec117c1142..e740d9aa4024 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -453,6 +453,33 @@ void __init dmi_check_pciprobe(void)
 	dmi_check_system(pciprobe_dmi_table);
 }
 
+static struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	struct pci_host_bridge *bridge;
+	int error;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return NULL;
+
+	list_splice_init(resources, &bridge->windows);
+	bridge->dev.parent = parent;
+	bridge->sysdata = sysdata;
+	bridge->busnr = bus;
+	bridge->ops = ops;
+
+	error = pci_scan_root_bus_bridge(bridge);
+	if (error < 0)
+		goto err_out;
+
+	return bridge->bus;
+
+err_out:
+	kfree(bridge);
+	return NULL;
+}
+
 void pcibios_scan_root(int busnum)
 {
 	struct pci_bus *bus;
diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index 21f13e9aabe1..5a8fd67e6c5e 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -116,6 +116,33 @@ static void __init pci_controller_apertures(struct pci_controller *pci_ctrl,
 	}
 }
 
+static struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	struct pci_host_bridge *bridge;
+	int error;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return NULL;
+
+	list_splice_init(resources, &bridge->windows);
+	bridge->dev.parent = parent;
+	bridge->sysdata = sysdata;
+	bridge->busnr = bus;
+	bridge->ops = ops;
+
+	error = pci_scan_root_bus_bridge(bridge);
+	if (error < 0)
+		goto err_out;
+
+	return bridge->bus;
+
+err_out:
+	kfree(bridge);
+	return NULL;
+}
+
 static int __init pcibios_init(void)
 {
 	struct pci_controller *pci_ctrl;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 12c3aa63c34d..cf169742c03e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3050,34 +3050,6 @@ int pci_scan_root_bus_bridge(struct pci_host_bridge *bridge)
 }
 EXPORT_SYMBOL(pci_scan_root_bus_bridge);
 
-struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
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
-EXPORT_SYMBOL(pci_scan_root_bus);
-
 /**
  * pci_rescan_bus_bridge_resize - Scan a PCI bus for devices
  * @bridge: PCI bridge for the bus to scan
diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index eba6e33147a2..24070e1c5f22 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -443,6 +443,33 @@ static int pcifront_scan_bus(struct pcifront_device *pdev,
 	return 0;
 }
 
+static struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	struct pci_host_bridge *bridge;
+	int error;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return NULL;
+
+	list_splice_init(resources, &bridge->windows);
+	bridge->dev.parent = parent;
+	bridge->sysdata = sysdata;
+	bridge->busnr = bus;
+	bridge->ops = ops;
+
+	error = pci_scan_root_bus_bridge(bridge);
+	if (error < 0)
+		goto err_out;
+
+	return bridge->bus;
+
+err_out:
+	kfree(bridge);
+	return NULL;
+}
+
 static int pcifront_scan_root(struct pcifront_device *pdev,
 				 unsigned int domain, unsigned int bus)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d77ce35a2b33..d226e06fb5e5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -912,9 +912,6 @@ int pci_host_probe(struct pci_host_bridge *bridge);
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
 int pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
 void pci_bus_release_busn_res(struct pci_bus *b);
-struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
-				  struct pci_ops *ops, void *sysdata,
-				  struct list_head *resources);
 int pci_scan_root_bus_bridge(struct pci_host_bridge *bridge);
 struct pci_bus *pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev,
 				int busnr);
-- 
2.18.0

