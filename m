Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbeBWIZj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 03:25:39 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55405 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbeBWIZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 03:25:37 -0500
Date: Fri, 23 Feb 2018 00:25:11 -0800
From: tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-69c42d493db452ea87c1ac56e83c978512f4e6ec@git.kernel.org>
Cc: peterz@infradead.org, torvalds@linux-foundation.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, hpa@zytor.com, jdelvare@suse.com,
        andriy.shevchenko@linux.intel.com, bhelgaas@google.com,
        mingo@kernel.org, tglx@linutronix.de
Reply-To: tglx@linutronix.de, mingo@kernel.org, jdelvare@suse.com,
        bhelgaas@google.com, andriy.shevchenko@linux.intel.com,
        rjw@rjwysocki.net, peterz@infradead.org, torvalds@linux-foundation.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180222125923.57385-2-andriy.shevchenko@linux.intel.com>
References: <20180222125923.57385-2-andriy.shevchenko@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] x86/pci: Simplify code by using the new
 dmi_get_bios_year() helper
Git-Commit-ID: 69c42d493db452ea87c1ac56e83c978512f4e6ec
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

Commit-ID:  69c42d493db452ea87c1ac56e83c978512f4e6ec
Gitweb:     https://git.kernel.org/tip/69c42d493db452ea87c1ac56e83c978512f4e6ec
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Thu, 22 Feb 2018 14:59:21 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 23 Feb 2018 08:20:30 +0100

x86/pci: Simplify code by using the new dmi_get_bios_year() helper

...instead of open coding its functionality.

No changes in functionality.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-acpi@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Link: http://lkml.kernel.org/r/20180222125923.57385-2-andriy.shevchenko@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/pci/acpi.c            | 8 ++------
 arch/x86/pci/direct.c          | 5 ++---
 arch/x86/pci/mmconfig-shared.c | 9 ++-------
 3 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 7df49c40665e..00e60de30328 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -140,12 +140,8 @@ static const struct dmi_system_id pci_crs_quirks[] __initconst = {
 
 void __init pci_acpi_crs_quirks(void)
 {
-	int year;
-
-	if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) && year < 2008) {
-		if (iomem_resource.end <= 0xffffffff)
-			pci_use_crs = false;
-	}
+	if ((dmi_get_bios_year() < 2008) && (iomem_resource.end <= 0xffffffff))
+		pci_use_crs = false;
 
 	dmi_check_system(pci_crs_quirks);
 
diff --git a/arch/x86/pci/direct.c b/arch/x86/pci/direct.c
index 2d9503323d10..a51074c55982 100644
--- a/arch/x86/pci/direct.c
+++ b/arch/x86/pci/direct.c
@@ -195,14 +195,13 @@ static const struct pci_raw_ops pci_direct_conf2 = {
 static int __init pci_sanity_check(const struct pci_raw_ops *o)
 {
 	u32 x = 0;
-	int year, devfn;
+	int devfn;
 
 	if (pci_probe & PCI_NO_CHECKS)
 		return 1;
 	/* Assume Type 1 works for newer systems.
 	   This handles machines that don't have anything on PCI Bus 0. */
-	dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL);
-	if (year >= 2001)
+	if (dmi_get_bios_year() >= 2001)
 		return 1;
 
 	for (devfn = 0; devfn < 0x100; devfn++) {
diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 96684d0adcf9..0b40482578b8 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -547,19 +547,14 @@ static void __init pci_mmcfg_reject_broken(int early)
 static int __init acpi_mcfg_check_entry(struct acpi_table_mcfg *mcfg,
 					struct acpi_mcfg_allocation *cfg)
 {
-	int year;
-
 	if (cfg->address < 0xFFFFFFFF)
 		return 0;
 
 	if (!strncmp(mcfg->header.oem_id, "SGI", 3))
 		return 0;
 
-	if (mcfg->header.revision >= 1) {
-		if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) &&
-		    year >= 2010)
-			return 0;
-	}
+	if ((mcfg->header.revision >= 1) && (dmi_get_bios_year() >= 2010))
+		return 0;
 
 	pr_err(PREFIX "MCFG region for %04x [bus %02x-%02x] at %#llx "
 	       "is above 4GB, ignored\n", cfg->pci_segment,
