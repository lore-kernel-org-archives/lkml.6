Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751540AbeB0GFh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 01:05:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750770AbeB0GFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 01:05:36 -0500
From: Jonathan Toppins <jtoppins@redhat.com>
To: linux-arm-kernel@lists.infradead.org
Cc: jtoppins@redhat.com, astone@redhat.com, jcm@redhat.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        rafael.j.wysocki@intel.com, mingo@kernel.org, prarit@redhat.com,
        james.morse@arm.com, andriy.shevchenko@linux.intel.com,
        bhsharma@redhat.com, linux-kernel@vger.kernel.org,
        rhkernel-list@redhat.com
Subject: [PATCH] arm64/acpi: make ACPI boot preference configurable
Date: Tue, 27 Feb 2018 01:05:32 -0500
Message-Id: <85047448dc1d2d3c725b6b78d5ef2a89fc81b83b.1519659254.git.jtoppins@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows a user to configure ACPI to be preferred over
device-tree.

Currently for ACPI to be used a user either has to set acpi=on on the
kernel command line or make sure any device tree passed to the kernel
is empty. If the dtb passed to the kernel is non-empty then device-tree
will be chosen as the boot method of choice even if it is not correct.
To prevent this situation where a system is only intended to be booted
via ACPI a user can set this kernel configuration so it ignores
device-tree settings unless ACPI table checks fail.

Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>
---

 arch/arm64/Kconfig       | 13 +++++++++++++
 arch/arm64/kernel/acpi.c |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7381eeb7ef8e..da8d9ab62825 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1170,6 +1170,19 @@ config ARM64_ACPI_PARKING_PROTOCOL
 	  protocol even if the corresponding data is present in the ACPI
 	  MADT table.
 
+config ARM64_PREFER_ACPI
+	bool "Prefer usage of ACPI boot tables over device-tree"
+	depends on ACPI
+	help
+	  Normally device-tree is preferred over ACPI on arm64 unless
+	  explicitly preferred via kernel command line, something like: acpi=on
+	  This configuration changes this default behaviour by pretending
+	  the user set acpi=on on the command line. This configuration still
+	  allows the user to turn acpi table parsing off via acpi=off. If
+	  for some reason the table checks fail the system will still fall
+	  back to using device-tree unless the user explicitly sets acpi=force
+	  on the command line.
+
 config CMDLINE
 	string "Default kernel command string"
 	default ""
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 7b09487ff8fb..315b001c45f1 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -44,7 +44,7 @@ int acpi_pci_disabled = 1;	/* skip ACPI PCI scan and IRQ initialization */
 EXPORT_SYMBOL(acpi_pci_disabled);
 
 static bool param_acpi_off __initdata;
-static bool param_acpi_on __initdata;
+static bool param_acpi_on __initdata = IS_ENABLED(CONFIG_ARM64_PREFER_ACPI);
 static bool param_acpi_force __initdata;
 
 static int __init parse_acpi(char *arg)
-- 
2.13.6
