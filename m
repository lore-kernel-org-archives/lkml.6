Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752583AbeENHpo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 03:45:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46851 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752039AbeENHpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 03:45:42 -0400
Date: Mon, 14 May 2018 00:45:11 -0700
From: tip-bot for Yazen Ghannam <tipbot@zytor.com>
Message-ID: <tip-f9e1bdb9f35f4f5cfa7c9025ac68c02909b6d3b1@git.kernel.org>
Cc: matt@codeblueprint.co.uk, hpa@zytor.com, peterz@infradead.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, yazen.ghannam@amd.com, tglx@linutronix.de,
        ard.biesheuvel@linaro.org
Reply-To: ard.biesheuvel@linaro.org, tglx@linutronix.de, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, yazen.ghannam@amd.com,
        matt@codeblueprint.co.uk, hpa@zytor.com
In-Reply-To: <20180504060003.19618-5-ard.biesheuvel@linaro.org>
References: <20180504060003.19618-5-ard.biesheuvel@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi: Decode IA32/X64 Processor Error Section
Git-Commit-ID: f9e1bdb9f35f4f5cfa7c9025ac68c02909b6d3b1
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

Commit-ID:  f9e1bdb9f35f4f5cfa7c9025ac68c02909b6d3b1
Gitweb:     https://git.kernel.org/tip/f9e1bdb9f35f4f5cfa7c9025ac68c02909b6d3b1
Author:     Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate: Fri, 4 May 2018 07:59:50 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 08:57:47 +0200

efi: Decode IA32/X64 Processor Error Section

Recognize the IA32/X64 Processor Error Section.

Do the section decoding in a new "cper-x86.c" file and add this to the
Makefile depending on a new "UEFI_CPER_X86" config option.

Print the Local APIC ID and CPUID info from the Processor Error Record.

The "Processor Error Info" and "Processor Context" fields will be
decoded in following patches.

Based on UEFI 2.7 Table 252. Processor Error Record.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180504060003.19618-5-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/Kconfig    |  5 +++++
 drivers/firmware/efi/Makefile   |  1 +
 drivers/firmware/efi/cper-x86.c | 23 +++++++++++++++++++++++
 drivers/firmware/efi/cper.c     | 10 ++++++++++
 include/linux/cper.h            |  2 ++
 5 files changed, 41 insertions(+)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 3098410abad8..781a4a337557 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -174,6 +174,11 @@ config UEFI_CPER_ARM
 	depends on UEFI_CPER && ( ARM || ARM64 )
 	default y
 
+config UEFI_CPER_X86
+	bool
+	depends on UEFI_CPER && X86
+	default y
+
 config EFI_DEV_PATH_PARSER
 	bool
 	depends on ACPI
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index cb805374f4bc..5f9f5039de50 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_ARM)			+= $(arm-obj-y)
 obj-$(CONFIG_ARM64)			+= $(arm-obj-y)
 obj-$(CONFIG_EFI_CAPSULE_LOADER)	+= capsule-loader.o
 obj-$(CONFIG_UEFI_CPER_ARM)		+= cper-arm.o
+obj-$(CONFIG_UEFI_CPER_X86)		+= cper-x86.o
diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
new file mode 100644
index 000000000000..863f0cd2a0ff
--- /dev/null
+++ b/drivers/firmware/efi/cper-x86.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018, Advanced Micro Devices, Inc.
+
+#include <linux/cper.h>
+
+/*
+ * We don't need a "CPER_IA" prefix since these are all locally defined.
+ * This will save us a lot of line space.
+ */
+#define VALID_LAPIC_ID			BIT_ULL(0)
+#define VALID_CPUID_INFO		BIT_ULL(1)
+
+void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
+{
+	if (proc->validation_bits & VALID_LAPIC_ID)
+		printk("%sLocal APIC_ID: 0x%llx\n", pfx, proc->lapic_id);
+
+	if (proc->validation_bits & VALID_CPUID_INFO) {
+		printk("%sCPUID Info:\n", pfx);
+		print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, proc->cpuid,
+			       sizeof(proc->cpuid), 0);
+	}
+}
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index ab21f1614007..3bf0dca378a6 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -467,6 +467,16 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 			cper_print_proc_arm(newpfx, arm_err);
 		else
 			goto err_section_too_small;
+#endif
+#if defined(CONFIG_UEFI_CPER_X86)
+	} else if (guid_equal(sec_type, &CPER_SEC_PROC_IA)) {
+		struct cper_sec_proc_ia *ia_err = acpi_hest_get_payload(gdata);
+
+		printk("%ssection_type: IA32/X64 processor error\n", newpfx);
+		if (gdata->error_data_length >= sizeof(*ia_err))
+			cper_print_proc_ia(newpfx, ia_err);
+		else
+			goto err_section_too_small;
 #endif
 	} else {
 		const void *err = acpi_hest_get_payload(gdata);
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 4b5f8459b403..9c703a0abe6e 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -551,5 +551,7 @@ const char *cper_mem_err_unpack(struct trace_seq *,
 				struct cper_mem_err_compact *);
 void cper_print_proc_arm(const char *pfx,
 			 const struct cper_sec_proc_arm *proc);
+void cper_print_proc_ia(const char *pfx,
+			const struct cper_sec_proc_ia *proc);
 
 #endif
