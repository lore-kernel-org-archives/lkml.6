Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934460AbeE3Eev (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 00:34:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47622 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbeE3Eer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 00:34:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 235A56028C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoffer Dall <cdall@linaro.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thymo van Beers <thymovanbeers@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Rientjes <rientjes@google.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        Mikulas Patocka <mpatocka@redhat.com>, Petr Tesarik <ptesarik@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>, Ram Pai <linuxram@us.ibm.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PCI: move early dump functionality from x86 arch into the common code
Date: Wed, 30 May 2018 00:34:30 -0400
Message-Id: <1527654876-26716-1-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move early dump functionality into common code so that it is available for
all archtiectures. No need to carry arch specific reads around as the read
hooks are already initialized by the time pci_setup_device() is getting
called during scan.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 arch/x86/include/asm/pci-direct.h               |  5 ---
 arch/x86/kernel/setup.c                         |  5 ---
 arch/x86/pci/common.c                           |  4 --
 arch/x86/pci/early.c                            | 50 -------------------------
 drivers/pci/pci.c                               |  4 ++
 drivers/pci/pci.h                               |  2 +-
 drivers/pci/probe.c                             | 19 ++++++++++
 8 files changed, 25 insertions(+), 66 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c247612..4459270 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2986,7 +2986,7 @@
 			See also Documentation/blockdev/paride.txt.
 
 	pci=option[,option...]	[PCI] various PCI subsystem options:
-		earlydump	[X86] dump PCI config space before the kernel
+		earlydump	dump PCI config space before the kernel
 				changes anything
 		off		[X86] don't probe for the PCI bus
 		bios		[X86-32] force use of PCI BIOS, don't access
diff --git a/arch/x86/include/asm/pci-direct.h b/arch/x86/include/asm/pci-direct.h
index e1084f7..e5e2129 100644
--- a/arch/x86/include/asm/pci-direct.h
+++ b/arch/x86/include/asm/pci-direct.h
@@ -14,9 +14,4 @@ extern void write_pci_config(u8 bus, u8 slot, u8 func, u8 offset, u32 val);
 extern void write_pci_config_byte(u8 bus, u8 slot, u8 func, u8 offset, u8 val);
 extern void write_pci_config_16(u8 bus, u8 slot, u8 func, u8 offset, u16 val);
 
-extern int early_pci_allowed(void);
-
-extern unsigned int pci_early_dump_regs;
-extern void early_dump_pci_device(u8 bus, u8 slot, u8 func);
-extern void early_dump_pci_devices(void);
 #endif /* _ASM_X86_PCI_DIRECT_H */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 2f86d88..480f250 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -991,11 +991,6 @@ void __init setup_arch(char **cmdline_p)
 		setup_clear_cpu_cap(X86_FEATURE_APIC);
 	}
 
-#ifdef CONFIG_PCI
-	if (pci_early_dump_regs)
-		early_dump_pci_devices();
-#endif
-
 	e820__reserve_setup_data();
 	e820__finish_early_params();
 
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 563049c..d4ec117 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -22,7 +22,6 @@
 unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 | PCI_PROBE_CONF2 |
 				PCI_PROBE_MMCONF;
 
-unsigned int pci_early_dump_regs;
 static int pci_bf_sort;
 int pci_routeirq;
 int noioapicquirk;
@@ -599,9 +598,6 @@ char *__init pcibios_setup(char *str)
 		pci_probe |= PCI_BIG_ROOT_WINDOW;
 		return NULL;
 #endif
-	} else if (!strcmp(str, "earlydump")) {
-		pci_early_dump_regs = 1;
-		return NULL;
 	} else if (!strcmp(str, "routeirq")) {
 		pci_routeirq = 1;
 		return NULL;
diff --git a/arch/x86/pci/early.c b/arch/x86/pci/early.c
index e5f753c..e20d449 100644
--- a/arch/x86/pci/early.c
+++ b/arch/x86/pci/early.c
@@ -51,53 +51,3 @@ void write_pci_config_16(u8 bus, u8 slot, u8 func, u8 offset, u16 val)
 	outw(val, 0xcfc + (offset&2));
 }
 
-int early_pci_allowed(void)
-{
-	return (pci_probe & (PCI_PROBE_CONF1|PCI_PROBE_NOEARLY)) ==
-			PCI_PROBE_CONF1;
-}
-
-void early_dump_pci_device(u8 bus, u8 slot, u8 func)
-{
-	u32 value[256 / 4];
-	int i;
-
-	pr_info("pci 0000:%02x:%02x.%d config space:\n", bus, slot, func);
-
-	for (i = 0; i < 256; i += 4)
-		value[i / 4] = read_pci_config(bus, slot, func, i);
-
-	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1, value, 256, false);
-}
-
-void early_dump_pci_devices(void)
-{
-	unsigned bus, slot, func;
-
-	if (!early_pci_allowed())
-		return;
-
-	for (bus = 0; bus < 256; bus++) {
-		for (slot = 0; slot < 32; slot++) {
-			for (func = 0; func < 8; func++) {
-				u32 class;
-				u8 type;
-
-				class = read_pci_config(bus, slot, func,
-							PCI_CLASS_REVISION);
-				if (class == 0xffffffff)
-					continue;
-
-				early_dump_pci_device(bus, slot, func);
-
-				if (func == 0) {
-					type = read_pci_config_byte(bus, slot,
-								    func,
-							       PCI_HEADER_TYPE);
-					if (!(type & 0x80))
-						break;
-				}
-			}
-		}
-	}
-}
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c03701..ae5a2ae 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -115,6 +115,8 @@ static bool pcie_ari_disabled;
 /* If set, the PCIe ATS capability will not be used. */
 static bool pcie_ats_disabled;
 
+bool pci_early_dump;
+
 bool pci_ats_disabled(void)
 {
 	return pcie_ats_disabled;
@@ -5848,6 +5850,8 @@ static int __init pci_setup(char *str)
 				pcie_ats_disabled = true;
 			} else if (!strcmp(str, "noaer")) {
 				pci_no_aer();
+			} else if (!strcmp(str, "earlydump")) {
+				pci_early_dump = true;
 			} else if (!strncmp(str, "realloc=", 8)) {
 				pci_realloc_get_opt(str + 8);
 			} else if (!strncmp(str, "realloc", 7)) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c358e7a0..9c66b7d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -7,7 +7,7 @@
 #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
 
 extern const unsigned char pcie_link_speed[];
-
+extern bool pci_early_dump;
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
 
 /* Functions internal to the PCI core code */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3840207..b1f068d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1549,6 +1549,22 @@ static int pci_intx_mask_broken(struct pci_dev *dev)
 	return 0;
 }
 
+static void early_dump_pci_device(struct pci_dev *pdev)
+{
+	u32 value[256 / 4];
+	int i;
+
+	dev_info(&pdev->dev, "pci 0000:%02x:%02x.%d config space:\n",
+		 pdev->bus->number, PCI_SLOT(pdev->devfn),
+		 PCI_FUNC(pdev->devfn));
+
+	for (i = 0; i < 256; i += 4)
+		pci_read_config_dword(pdev, i, &value[i / 4]);
+
+	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1, value,
+		       256, false);
+}
+
 /**
  * pci_setup_device - Fill in class and map information of a device
  * @dev: the device structure to fill
@@ -1598,6 +1614,9 @@ int pci_setup_device(struct pci_dev *dev)
 	pci_printk(KERN_DEBUG, dev, "[%04x:%04x] type %02x class %#08x\n",
 		   dev->vendor, dev->device, dev->hdr_type, dev->class);
 
+	if (pci_early_dump)
+		early_dump_pci_device(dev);
+
 	/* Need to have dev->class ready */
 	dev->cfg_size = pci_cfg_space_size(dev);
 
-- 
2.7.4
