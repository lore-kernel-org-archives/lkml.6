Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935823AbeCHLgm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:36:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57139 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935810AbeCHLgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:36:40 -0500
Date: Thu, 8 Mar 2018 03:36:29 -0800
From: tip-bot for Jan Kiszka <tipbot@zytor.com>
Message-ID: <tip-8364e1f8379c7f9d3e63f127a585f889906b3e10@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, jan.kiszka@siemens.com,
        bhelgaas@google.com, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, andy.shevchenko@gmail.com
Reply-To: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        andy.shevchenko@gmail.com, jan.kiszka@siemens.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <788bbd5325d1922235e9562c213057425fbc548c.1520408357.git.jan.kiszka@siemens.com>
References: <788bbd5325d1922235e9562c213057425fbc548c.1520408357.git.jan.kiszka@siemens.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] x86/jailhouse: Allow to use PCI_MMCONFIG without
 ACPI
Git-Commit-ID: 8364e1f8379c7f9d3e63f127a585f889906b3e10
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

Commit-ID:  8364e1f8379c7f9d3e63f127a585f889906b3e10
Gitweb:     https://git.kernel.org/tip/8364e1f8379c7f9d3e63f127a585f889906b3e10
Author:     Jan Kiszka <jan.kiszka@siemens.com>
AuthorDate: Wed, 7 Mar 2018 08:39:17 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Mar 2018 12:30:39 +0100

x86/jailhouse: Allow to use PCI_MMCONFIG without ACPI

Jailhouse does not use ACPI, but it does support MMCONFIG. Make sure the
latter can be built without having to enable ACPI as well. Primarily, its
required to make the AMD mmconf-fam10h_64 depend upon MMCONFIG and
ACPI, instead of just the former.

Saves some bytes in the Jailhouse non-root kernel.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: jailhouse-dev@googlegroups.com
Cc: linux-pci@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lkml.kernel.org/r/788bbd5325d1922235e9562c213057425fbc548c.1520408357.git.jan.kiszka@siemens.com

---
 arch/x86/Kconfig          | 6 +++++-
 arch/x86/kernel/Makefile  | 2 +-
 arch/x86/kernel/cpu/amd.c | 2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 573b7c49d9f8..7f00f60a2028 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2642,7 +2642,7 @@ config PCI_DIRECT
 config PCI_MMCONFIG
 	bool "Support mmconfig PCI config space access" if X86_64
 	default y
-	depends on PCI && (ACPI || SFI)
+	depends on PCI && (ACPI || SFI || JAILHOUSE_GUEST)
 	depends on X86_64 || (PCI_GOANY || PCI_GOMMCONFIG)
 
 config PCI_OLPC
@@ -2658,6 +2658,10 @@ config PCI_DOMAINS
 	def_bool y
 	depends on PCI
 
+config MMCONF_FAM10H
+	def_bool y
+	depends on X86_64 && PCI_MMCONFIG && ACPI
+
 config PCI_CNB20LE_QUIRK
 	bool "Read CNB20LE Host Bridge Windows" if EXPERT
 	depends on PCI
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 29786c87e864..73ccf80c09a2 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -146,6 +146,6 @@ ifeq ($(CONFIG_X86_64),y)
 	obj-$(CONFIG_GART_IOMMU)	+= amd_gart_64.o aperture_64.o
 	obj-$(CONFIG_CALGARY_IOMMU)	+= pci-calgary_64.o tce_64.o
 
-	obj-$(CONFIG_PCI_MMCONFIG)	+= mmconf-fam10h_64.o
+	obj-$(CONFIG_MMCONF_FAM10H)	+= mmconf-fam10h_64.o
 	obj-y				+= vsmp_64.o
 endif
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index f0e6456ca7d3..12bc0a1139da 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -716,7 +716,7 @@ static void init_amd_k8(struct cpuinfo_x86 *c)
 
 static void init_amd_gh(struct cpuinfo_x86 *c)
 {
-#ifdef CONFIG_X86_64
+#ifdef CONFIG_MMCONF_FAM10H
 	/* do this for boot cpu */
 	if (c == &boot_cpu_data)
 		check_enable_amd_mmconf_dmi();
