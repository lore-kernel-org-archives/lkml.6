Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeENHnw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 03:43:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51821 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752076AbeENHnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 03:43:49 -0400
Date: Mon, 14 May 2018 00:43:26 -0700
From: tip-bot for Daniel Kiper <tipbot@zytor.com>
Message-ID: <tip-a7012bdbdf406bbaa4e3de0cc3d8eb0faaacbf93@git.kernel.org>
Cc: tglx@linutronix.de, daniel.kiper@oracle.com, matt@codeblueprint.co.uk,
        linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@kernel.org,
        torvalds@linux-foundation.org, ard.biesheuvel@linaro.org,
        hpa@zytor.com
Reply-To: hpa@zytor.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org, matt@codeblueprint.co.uk,
        mingo@kernel.org, torvalds@linux-foundation.org, peterz@infradead.org,
        tglx@linutronix.de, daniel.kiper@oracle.com
In-Reply-To: <20180504060003.19618-2-ard.biesheuvel@linaro.org>
References: <20180504060003.19618-2-ard.biesheuvel@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] x86/xen/efi: Initialize UEFI secure boot state
 during dom0 boot
Git-Commit-ID: a7012bdbdf406bbaa4e3de0cc3d8eb0faaacbf93
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

Commit-ID:  a7012bdbdf406bbaa4e3de0cc3d8eb0faaacbf93
Gitweb:     https://git.kernel.org/tip/a7012bdbdf406bbaa4e3de0cc3d8eb0faaacbf93
Author:     Daniel Kiper <daniel.kiper@oracle.com>
AuthorDate: Fri, 4 May 2018 07:59:47 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 08:57:46 +0200

x86/xen/efi: Initialize UEFI secure boot state during dom0 boot

Initialize UEFI secure boot state during dom0 boot. Otherwise the kernel
may not even know that it runs on secure boot enabled platform.

Note that part of drivers/firmware/efi/libstub/secureboot.c is duplicated
by this patch, only in this case, it runs in the context of the kernel
proper rather than UEFI boot context. The reason for the duplication is
that maintaining the original code to run correctly on ARM/arm64 as well
as on all the quirky x86 firmware we support is enough of a burden as it
is, and adding the x86/Xen execution context to that mix just so we can
reuse a single routine just isn't worth it.

[ardb: explain rationale for code duplication]
Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180504060003.19618-2-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/xen/efi.c                        | 57 +++++++++++++++++++++++++++++++
 drivers/firmware/efi/libstub/secureboot.c |  3 ++
 2 files changed, 60 insertions(+)

diff --git a/arch/x86/xen/efi.c b/arch/x86/xen/efi.c
index a18703be9ead..1804b27f9632 100644
--- a/arch/x86/xen/efi.c
+++ b/arch/x86/xen/efi.c
@@ -115,6 +115,61 @@ static efi_system_table_t __init *xen_efi_probe(void)
 	return &efi_systab_xen;
 }
 
+/*
+ * Determine whether we're in secure boot mode.
+ *
+ * Please keep the logic in sync with
+ * drivers/firmware/efi/libstub/secureboot.c:efi_get_secureboot().
+ */
+static enum efi_secureboot_mode xen_efi_get_secureboot(void)
+{
+	static efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
+	static efi_guid_t shim_guid = EFI_SHIM_LOCK_GUID;
+	efi_status_t status;
+	u8 moksbstate, secboot, setupmode;
+	unsigned long size;
+
+	size = sizeof(secboot);
+	status = efi.get_variable(L"SecureBoot", &efi_variable_guid,
+				  NULL, &size, &secboot);
+
+	if (status == EFI_NOT_FOUND)
+		return efi_secureboot_mode_disabled;
+
+	if (status != EFI_SUCCESS)
+		goto out_efi_err;
+
+	size = sizeof(setupmode);
+	status = efi.get_variable(L"SetupMode", &efi_variable_guid,
+				  NULL, &size, &setupmode);
+
+	if (status != EFI_SUCCESS)
+		goto out_efi_err;
+
+	if (secboot == 0 || setupmode == 1)
+		return efi_secureboot_mode_disabled;
+
+	/* See if a user has put the shim into insecure mode. */
+	size = sizeof(moksbstate);
+	status = efi.get_variable(L"MokSBStateRT", &shim_guid,
+				  NULL, &size, &moksbstate);
+
+	/* If it fails, we don't care why. Default to secure. */
+	if (status != EFI_SUCCESS)
+		goto secure_boot_enabled;
+
+	if (moksbstate == 1)
+		return efi_secureboot_mode_disabled;
+
+ secure_boot_enabled:
+	pr_info("UEFI Secure Boot is enabled.\n");
+	return efi_secureboot_mode_enabled;
+
+ out_efi_err:
+	pr_err("Could not determine UEFI Secure Boot status.\n");
+	return efi_secureboot_mode_unknown;
+}
+
 void __init xen_efi_init(void)
 {
 	efi_system_table_t *efi_systab_xen;
@@ -129,6 +184,8 @@ void __init xen_efi_init(void)
 	boot_params.efi_info.efi_systab = (__u32)__pa(efi_systab_xen);
 	boot_params.efi_info.efi_systab_hi = (__u32)(__pa(efi_systab_xen) >> 32);
 
+	boot_params.secure_boot = xen_efi_get_secureboot();
+
 	set_bit(EFI_BOOT, &efi.flags);
 	set_bit(EFI_PARAVIRT, &efi.flags);
 	set_bit(EFI_64BIT, &efi.flags);
diff --git a/drivers/firmware/efi/libstub/secureboot.c b/drivers/firmware/efi/libstub/secureboot.c
index 8f07eb414c00..72d9dfbebf08 100644
--- a/drivers/firmware/efi/libstub/secureboot.c
+++ b/drivers/firmware/efi/libstub/secureboot.c
@@ -30,6 +30,9 @@ static const efi_char16_t shim_MokSBState_name[] = L"MokSBState";
 
 /*
  * Determine whether we're in secure boot mode.
+ *
+ * Please keep the logic in sync with
+ * arch/x86/xen/efi.c:xen_efi_get_secureboot().
  */
 enum efi_secureboot_mode efi_get_secureboot(efi_system_table_t *sys_table_arg)
 {
