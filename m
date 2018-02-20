Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753454AbeBTSFP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 13:05:15 -0500
Received: from mga14.intel.com ([192.55.52.115]:44586 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752317AbeBTSFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 13:05:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,540,1511856000";
   d="scan'208";a="19029059"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 2/3] ACPI / x86: boot: Not all platforms require acpi_generic_reduced_hw_init()
Date: Tue, 20 Feb 2018 20:05:05 +0200
Message-Id: <20180220180506.65523-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180220180506.65523-1-andriy.shevchenko@linux.intel.com>
References: <20180220180506.65523-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some ACPI hardware reduced platforms need to initialize certain devices
defined by the ACPI hardware specification even though in principle
those devices should not be present in an ACPI hardware reduced platform.

To allow that to happen, make it possible to override the generic
x86_init callbacks and provide a custom legacy_pic value, add a new
->reduced_hw_early_init() callback to struct x86_init_acpi and make
acpi_reduced_hw_init() use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

- address Rafael's comments
- requires patches from Juergen Gross
- supposed to go via tip tree (x86/boot branch)
- tested on ASuS T100ta (HW reduced) and Intel Broxton based platforms

 arch/x86/include/asm/x86_init.h | 2 ++
 arch/x86/kernel/acpi/boot.c     | 2 +-
 arch/x86/kernel/x86_init.c      | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 2e2c34d2bb00..5bd45a8f5ae3 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -133,9 +133,11 @@ struct x86_hyper_init {
 /**
  * struct x86_init_acpi - x86 ACPI init functions
  * @get_root_pointer:		get RSDP address
+ * @reduced_hw_early_init:	hardware reduced platform early init
  */
 struct x86_init_acpi {
 	u64 (*get_root_pointer)(void);
+	void (*reduced_hw_early_init)(void);
 };
 
 /**
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index baa084ecffdb..7a37d9357bc4 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1390,7 +1390,7 @@ void __init acpi_generic_reduced_hw_init(void)
 static void __init acpi_reduced_hw_init(void)
 {
 	if (acpi_gbl_reduced_hardware)
-		acpi_generic_reduced_hw_init();
+		x86_init.acpi.reduced_hw_early_init();
 }
 
 /*
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 9e4e994a4836..03452b73e2ea 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/pci.h>
 
+#include <asm/acpi.h>
 #include <asm/bios_ebda.h>
 #include <asm/paravirt.h>
 #include <asm/pci_x86.h>
@@ -95,6 +96,7 @@ struct x86_init_ops x86_init __initdata = {
 
 	.acpi = {
 		.get_root_pointer	= u64_x86_init_noop,
+		.reduced_hw_early_init	= acpi_generic_reduced_hw_init,
 	},
 };
 
-- 
2.15.1
