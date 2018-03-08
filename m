Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755641AbeCHLfX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:35:23 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42241 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755329AbeCHLfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:35:21 -0500
Date: Thu, 8 Mar 2018 03:35:01 -0800
From: tip-bot for Otavio Pontes <tipbot@zytor.com>
Message-ID: <tip-6fa4a94e150be25d02547d51f03b4bc34aaec32f@git.kernel.org>
Cc: bhelgaas@google.com, andy.shevchenko@gmail.com, mingo@kernel.org,
        hpa@zytor.com, otavio.pontes@intel.com, jan.kiszka@siemens.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: bhelgaas@google.com, andy.shevchenko@gmail.com, mingo@kernel.org,
        hpa@zytor.com, otavio.pontes@intel.com, jan.kiszka@siemens.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <2ee9e4401fa22377b3965893a558120f169be82b.1520408357.git.jan.kiszka@siemens.com>
References: <2ee9e4401fa22377b3965893a558120f169be82b.1520408357.git.jan.kiszka@siemens.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] x86/jailhouse: Enable PCI mmconfig access in
 inmates
Git-Commit-ID: 6fa4a94e150be25d02547d51f03b4bc34aaec32f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6fa4a94e150be25d02547d51f03b4bc34aaec32f
Gitweb:     https://git.kernel.org/tip/6fa4a94e150be25d02547d51f03b4bc34aaec32f
Author:     Otavio Pontes <otavio.pontes@intel.com>
AuthorDate: Wed, 7 Mar 2018 08:39:14 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Mar 2018 12:30:38 +0100

x86/jailhouse: Enable PCI mmconfig access in inmates

Use the PCI mmconfig base address exported by jailhouse in boot parameters
in order to access the memory mapped PCI configuration space.

[Jan: rebased, fixed !CONFIG_PCI_MMCONFIG, used pcibios_last_bus]

Signed-off-by: Otavio Pontes <otavio.pontes@intel.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jailhouse-dev@googlegroups.com
Cc: linux-pci@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lkml.kernel.org/r/2ee9e4401fa22377b3965893a558120f169be82b.1520408357.git.jan.kiszka@siemens.com

---
 arch/x86/include/asm/pci_x86.h | 2 ++
 arch/x86/kernel/jailhouse.c    | 8 ++++++++
 arch/x86/pci/mmconfig-shared.c | 4 ++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index eb66fa9cd0fc..959d618dbb17 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -151,6 +151,8 @@ extern int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 			       phys_addr_t addr);
 extern int pci_mmconfig_delete(u16 seg, u8 start, u8 end);
 extern struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
+extern struct pci_mmcfg_region *__init pci_mmconfig_add(int segment, int start,
+							int end, u64 addr);
 
 extern struct list_head pci_mmcfg_list;
 
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index b68fd895235a..fa183a131edc 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -124,6 +124,14 @@ static int __init jailhouse_pci_arch_init(void)
 	if (pcibios_last_bus < 0)
 		pcibios_last_bus = 0xff;
 
+#ifdef CONFIG_PCI_MMCONFIG
+	if (setup_data.pci_mmconfig_base) {
+		pci_mmconfig_add(0, 0, pcibios_last_bus,
+				 setup_data.pci_mmconfig_base);
+		pci_mmcfg_arch_init();
+	}
+#endif
+
 	return 0;
 }
 
diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 0b40482578b8..7389db538c30 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -94,8 +94,8 @@ static struct pci_mmcfg_region *pci_mmconfig_alloc(int segment, int start,
 	return new;
 }
 
-static struct pci_mmcfg_region *__init pci_mmconfig_add(int segment, int start,
-							int end, u64 addr)
+struct pci_mmcfg_region *__init pci_mmconfig_add(int segment, int start,
+						 int end, u64 addr)
 {
 	struct pci_mmcfg_region *new;
 
