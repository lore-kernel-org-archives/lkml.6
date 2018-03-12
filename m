Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751588AbeCLM0c (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 08:26:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55477 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbeCLM0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 08:26:31 -0400
Date: Mon, 12 Mar 2018 05:26:09 -0700
From: tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-81b53e5ff21e09b42525cfa08f2b0af2b8c5f465@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, ebiederm@xmission.com,
        peterz@infradead.org, jgross@suse.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        rafael.j.wysocki@intel.com, mingo@kernel.org,
        torvalds@linux-foundation.org
Reply-To: ebiederm@xmission.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        rafael.j.wysocki@intel.com, mingo@kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org, jgross@suse.com,
        tglx@linutronix.de, andriy.shevchenko@linux.intel.com
In-Reply-To: <20180220180506.65523-2-andriy.shevchenko@linux.intel.com>
References: <20180220180506.65523-2-andriy.shevchenko@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] ACPI, x86/boot: Introduce the
 ->reduced_hw_early_init() ACPI callback
Git-Commit-ID: 81b53e5ff21e09b42525cfa08f2b0af2b8c5f465
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

Commit-ID:  81b53e5ff21e09b42525cfa08f2b0af2b8c5f465
Gitweb:     https://git.kernel.org/tip/81b53e5ff21e09b42525cfa08f2b0af2b8c5f465
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Tue, 20 Feb 2018 20:05:05 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Mar 2018 12:32:57 +0100

ACPI, x86/boot: Introduce the ->reduced_hw_early_init() ACPI callback

Some ACPI hardware reduced platforms need to initialize certain devices
defined by the ACPI hardware specification even though in principle
those devices should not be present in an ACPI hardware reduced platform.

To allow that to happen, make it possible to override the generic
x86_init callbacks and provide a custom legacy_pic value, add a new
->reduced_hw_early_init() callback to struct x86_init_acpi and make
acpi_reduced_hw_init() use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-acpi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180220180506.65523-2-andriy.shevchenko@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
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
index b8cff22a8785..ac67ccffeef0 100644
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
 
