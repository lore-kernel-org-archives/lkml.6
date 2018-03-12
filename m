Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932343AbeCLJci (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:32:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45989 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932256AbeCLJcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:32:25 -0400
Date: Mon, 12 Mar 2018 02:31:59 -0700
From: tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-36b649760e94968e0495b73284aaf07eed0a328f@git.kernel.org>
Cc: lukas@wunner.de, peterz@infradead.org, arnd@arndb.de,
        matt@codeblueprint.co.uk, mingo@kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        ard.biesheuvel@linaro.org, hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org, hpa@zytor.com,
        lukas@wunner.de, matt@codeblueprint.co.uk, peterz@infradead.org,
        arnd@arndb.de
In-Reply-To: <20180312084500.10764-6-ard.biesheuvel@linaro.org>
References: <20180312084500.10764-6-ard.biesheuvel@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi: Use string literals for efi_char16_t variable
 initializers
Git-Commit-ID: 36b649760e94968e0495b73284aaf07eed0a328f
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

Commit-ID:  36b649760e94968e0495b73284aaf07eed0a328f
Gitweb:     https://git.kernel.org/tip/36b649760e94968e0495b73284aaf07eed0a328f
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Mon, 12 Mar 2018 08:45:00 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Mar 2018 10:05:02 +0100

efi: Use string literals for efi_char16_t variable initializers

Now that we unambiguously build the entire kernel with -fshort-wchar,
it is no longer necessary to open code efi_char16_t[] initializers as
arrays of characters, and we can move to the L"xxx" notation instead.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180312084500.10764-6-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/eboot.c          |  3 ++-
 arch/x86/platform/efi/quirks.c            |  8 +++++---
 drivers/firmware/efi/libstub/Makefile     |  2 +-
 drivers/firmware/efi/libstub/secureboot.c | 12 +++---------
 drivers/firmware/efi/libstub/tpm.c        |  7 ++-----
 5 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index f2251c1c9853..47d3efff6805 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -421,9 +421,10 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 	}
 }
 
+static const efi_char16_t apple[] = L"Apple";
+
 static void setup_quirks(struct boot_params *boot_params)
 {
-	static efi_char16_t const apple[] = { 'A', 'p', 'p', 'l', 'e', 0 };
 	efi_char16_t *fw_vendor = (efi_char16_t *)(unsigned long)
 		efi_table_attr(efi_system_table, fw_vendor, sys_table);
 
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 1ef11c26f79b..36c1f8b9f7e0 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -75,7 +75,7 @@ struct quark_security_header {
 	u32 rsvd[2];
 };
 
-static efi_char16_t efi_dummy_name[6] = { 'D', 'U', 'M', 'M', 'Y', 0 };
+static const efi_char16_t efi_dummy_name[] = L"DUMMY";
 
 static bool efi_no_storage_paranoia;
 
@@ -105,7 +105,8 @@ early_param("efi_no_storage_paranoia", setup_storage_paranoia);
 */
 void efi_delete_dummy_variable(void)
 {
-	efi.set_variable(efi_dummy_name, &EFI_DUMMY_GUID,
+	efi.set_variable((efi_char16_t *)efi_dummy_name,
+			 &EFI_DUMMY_GUID,
 			 EFI_VARIABLE_NON_VOLATILE |
 			 EFI_VARIABLE_BOOTSERVICE_ACCESS |
 			 EFI_VARIABLE_RUNTIME_ACCESS,
@@ -182,7 +183,8 @@ efi_status_t efi_query_variable_store(u32 attributes, unsigned long size,
 		if (!dummy)
 			return EFI_OUT_OF_RESOURCES;
 
-		status = efi.set_variable(efi_dummy_name, &EFI_DUMMY_GUID,
+		status = efi.set_variable((efi_char16_t *)efi_dummy_name,
+					  &EFI_DUMMY_GUID,
 					  EFI_VARIABLE_NON_VOLATILE |
 					  EFI_VARIABLE_BOOTSERVICE_ACCESS |
 					  EFI_VARIABLE_RUNTIME_ACCESS,
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 7b3ba40f0745..a34e9290a699 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -9,7 +9,7 @@ cflags-$(CONFIG_X86_32)		:= -march=i386
 cflags-$(CONFIG_X86_64)		:= -mcmodel=small
 cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -O2 \
 				   -fPIC -fno-strict-aliasing -mno-red-zone \
-				   -mno-mmx -mno-sse
+				   -mno-mmx -mno-sse -fshort-wchar
 
 cflags-$(CONFIG_ARM64)		:= $(subst -pg,,$(KBUILD_CFLAGS)) -fpie
 cflags-$(CONFIG_ARM)		:= $(subst -pg,,$(KBUILD_CFLAGS)) \
diff --git a/drivers/firmware/efi/libstub/secureboot.c b/drivers/firmware/efi/libstub/secureboot.c
index 959777ec8a77..8f07eb414c00 100644
--- a/drivers/firmware/efi/libstub/secureboot.c
+++ b/drivers/firmware/efi/libstub/secureboot.c
@@ -16,18 +16,12 @@
 
 /* BIOS variables */
 static const efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
-static const efi_char16_t efi_SecureBoot_name[] = {
-	'S', 'e', 'c', 'u', 'r', 'e', 'B', 'o', 'o', 't', 0
-};
-static const efi_char16_t efi_SetupMode_name[] = {
-	'S', 'e', 't', 'u', 'p', 'M', 'o', 'd', 'e', 0
-};
+static const efi_char16_t efi_SecureBoot_name[] = L"SecureBoot";
+static const efi_char16_t efi_SetupMode_name[] = L"SetupMode";
 
 /* SHIM variables */
 static const efi_guid_t shim_guid = EFI_SHIM_LOCK_GUID;
-static efi_char16_t const shim_MokSBState_name[] = {
-	'M', 'o', 'k', 'S', 'B', 'S', 't', 'a', 't', 'e', 0
-};
+static const efi_char16_t shim_MokSBState_name[] = L"MokSBState";
 
 #define get_efi_var(name, vendor, ...) \
 	efi_call_runtime(get_variable, \
diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index da661bf8cb96..2298560cea72 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -16,11 +16,8 @@
 #include "efistub.h"
 
 #ifdef CONFIG_RESET_ATTACK_MITIGATION
-static const efi_char16_t efi_MemoryOverWriteRequest_name[] = {
-	'M', 'e', 'm', 'o', 'r', 'y', 'O', 'v', 'e', 'r', 'w', 'r', 'i', 't',
-	'e', 'R', 'e', 'q', 'u', 'e', 's', 't', 'C', 'o', 'n', 't', 'r', 'o',
-	'l', 0
-};
+static const efi_char16_t efi_MemoryOverWriteRequest_name[] =
+	L"MemoryOverwriteRequestControl";
 
 #define MEMORY_ONLY_RESET_CONTROL_GUID \
 	EFI_GUID(0xe20939be, 0x32d4, 0x41be, 0xa1, 0x50, 0x89, 0x7f, 0x85, 0xd4, 0x98, 0x29)
