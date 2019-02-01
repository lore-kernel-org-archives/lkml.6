Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC273C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A159E218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbfBALAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 06:00:15 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42797 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfBALAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 06:00:14 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x11AxuSV3281030
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 1 Feb 2019 02:59:56 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x11Axule3281027;
        Fri, 1 Feb 2019 02:59:56 -0800
Date:   Fri, 1 Feb 2019 02:59:56 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Chao Fan <tipbot@zytor.com>
Message-ID: <tip-33f0df8d843deb9ec24116dcd79a40ca0ea8e8a9@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, bp@suse.de, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        keescook@chromium.org, fanc.fnst@cn.fujitsu.com, x86@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, fanc.fnst@cn.fujitsu.com,
          x86@kernel.org, mingo@redhat.com, keescook@chromium.org,
          linux-kernel@vger.kernel.org, bp@suse.de, tglx@linutronix.de
In-Reply-To: <20190123110850.12433-4-fanc.fnst@cn.fujitsu.com>
References: <20190123110850.12433-4-fanc.fnst@cn.fujitsu.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot: Search for RSDP in the EFI tables
Git-Commit-ID: 33f0df8d843deb9ec24116dcd79a40ca0ea8e8a9
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  33f0df8d843deb9ec24116dcd79a40ca0ea8e8a9
Gitweb:     https://git.kernel.org/tip/33f0df8d843deb9ec24116dcd79a40ca0ea8e8a9
Author:     Chao Fan <fanc.fnst@cn.fujitsu.com>
AuthorDate: Wed, 23 Jan 2019 19:08:46 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 1 Feb 2019 11:52:54 +0100

x86/boot: Search for RSDP in the EFI tables

The immovable memory ranges information in the SRAT table is necessary
to fix the issue of KASLR not paying attention to movable memory regions
when selecting the offset. Therefore, SRAT needs to be parsed.

Depending on the boot: KEXEC/EFI/BIOS, the methods to compute RSDP are
different. When booting from EFI, the EFI table points to the RSDP. So
iterate over the EFI system tables in order to find the RSDP.

 [ bp:
   - Heavily massage commit message
   - Trim comments
   - Move the CONFIG_ACPI ifdeffery into the Makefile.
 ]

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: bhe@redhat.com
Cc: caoj.fnst@cn.fujitsu.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: indou.takao@jp.fujitsu.com
Cc: Ingo Molnar <mingo@redhat.com>
Cc: kasong@redhat.com
Cc: Kees Cook <keescook@chromium.org>
Cc: msys.mizuma@gmail.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190123110850.12433-4-fanc.fnst@cn.fujitsu.com
---
 arch/x86/boot/compressed/acpi.c | 81 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index bacfc4ea35ac..5559fde1c0fe 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -4,7 +4,8 @@
 #include "error.h"
 #include "../string.h"
 
-#ifdef CONFIG_ACPI
+#include <linux/efi.h>
+#include <asm/efi.h>
 
 /*
  * Max length of 64-bit hex address string is 19, prefix "0x" + 16 hex
@@ -29,4 +30,80 @@ static acpi_physical_address get_acpi_rsdp(void)
 #endif
 	return addr;
 }
-#endif /* CONFIG_ACPI */
+
+/* Search EFI system tables for RSDP. */
+static acpi_physical_address efi_get_rsdp_addr(void)
+{
+	acpi_physical_address rsdp_addr = 0;
+
+#ifdef CONFIG_EFI
+	efi_system_table_t *systab;
+	struct efi_info *ei;
+	bool efi_64;
+	int size, i;
+	char *sig;
+
+	ei = &boot_params->efi_info;
+	sig = (char *)&ei->efi_loader_signature;
+
+	if (!strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
+		efi_64 = true;
+	} else if (!strncmp(sig, EFI32_LOADER_SIGNATURE, 4)) {
+		efi_64 = false;
+	} else {
+		debug_putstr("Wrong EFI loader signature.\n");
+		return 0;
+	}
+
+	/* Get systab from boot params. */
+#ifdef CONFIG_X86_64
+	systab = (efi_system_table_t *)(ei->efi_systab | ((__u64)ei->efi_systab_hi<<32));
+#else
+	if (ei->efi_systab_hi || ei->efi_memmap_hi) {
+		debug_putstr("Error getting RSDP address: EFI system table located above 4GB.\n");
+		return 0;
+	}
+	systab = (efi_system_table_t *)ei->efi_systab;
+#endif
+	if (!systab)
+		error("EFI system table not found.");
+
+	/*
+	 * Get EFI tables from systab.
+	 */
+	size = efi_64 ? sizeof(efi_config_table_64_t) :
+			sizeof(efi_config_table_32_t);
+
+	for (i = 0; i < systab->nr_tables; i++) {
+		acpi_physical_address table;
+		void *config_tables;
+		efi_guid_t guid;
+
+		config_tables = (void *)(systab->tables + size * i);
+		if (efi_64) {
+			efi_config_table_64_t *tmp_table;
+
+			tmp_table = config_tables;
+			guid = tmp_table->guid;
+			table = tmp_table->table;
+
+			if (!IS_ENABLED(CONFIG_X86_64) && table >> 32) {
+				debug_putstr("Error getting RSDP address: EFI config table located above 4GB.\n");
+				return 0;
+			}
+		} else {
+			efi_config_table_32_t *tmp_table;
+
+			tmp_table = config_tables;
+			guid = tmp_table->guid;
+			table = tmp_table->table;
+		}
+
+		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
+			rsdp_addr = table;
+		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
+			return table;
+	}
+#endif
+	return rsdp_addr;
+}
