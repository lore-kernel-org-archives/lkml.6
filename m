Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D69AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25163222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391220AbfBMJHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:07:43 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50109 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbfBMJHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:07:43 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1D96tEA199087
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 13 Feb 2019 01:06:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1D96tK7199084;
        Wed, 13 Feb 2019 01:06:55 -0800
Date:   Wed, 13 Feb 2019 01:06:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-022442cbec93433ac260a417ab89a960ae6058f8@git.kernel.org>
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, x86@kernel.org, linux@roeck-us.net, bp@suse.de,
        hpa@zytor.com, fanc.fnst@cn.fujitsu.com, mingo@kernel.org,
        ard.biesheuvel@linaro.org, mingo@redhat.com
Reply-To: linux-kernel@vger.kernel.org, keescook@chromium.org,
          x86@kernel.org, tglx@linutronix.de, linux@roeck-us.net,
          bp@suse.de, hpa@zytor.com, fanc.fnst@cn.fujitsu.com,
          mingo@kernel.org, ard.biesheuvel@linaro.org, mingo@redhat.com
In-Reply-To: <20190208190248.GA10854@roeck-us.net>
References: <20190208190248.GA10854@roeck-us.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot: Correct RSDP parsing with 32-bit EFI
Git-Commit-ID: 022442cbec93433ac260a417ab89a960ae6058f8
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

Commit-ID:  022442cbec93433ac260a417ab89a960ae6058f8
Gitweb:     https://git.kernel.org/tip/022442cbec93433ac260a417ab89a960ae6058f8
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Mon, 11 Feb 2019 12:19:45 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 13 Feb 2019 09:59:35 +0100

x86/boot: Correct RSDP parsing with 32-bit EFI

Guenter Roeck reported triple faults of a 64-bit VM using a 32-bit OVMF
EFI image. After some singlestepping of the image in gdb, it turned out
that some of the EFI config tables were at bogus addresses. Which, as
Ard pointed out, results from using the wrong efi_config_table typedef.

So switch all EFI table pointers to unsigned longs and convert them to
the proper typedef only when accessing them. This way, the proper table
type is being used.

Shorten variable names, while at it.

Fixes: 33f0df8d843d ("x86/boot: Search for RSDP in the EFI tables")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
Link: https://lkml.kernel.org/r/20190208190248.GA10854@roeck-us.net
---
 arch/x86/boot/compressed/acpi.c | 50 +++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index c5a949335d8b..f8a321e30cc0 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -50,7 +50,8 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	acpi_physical_address rsdp_addr = 0;
 
 #ifdef CONFIG_EFI
-	efi_system_table_t *systab;
+	unsigned long systab, systab_tables, config_tables;
+	unsigned int nr_tables;
 	struct efi_info *ei;
 	bool efi_64;
 	int size, i;
@@ -70,46 +71,57 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 
 	/* Get systab from boot params. */
 #ifdef CONFIG_X86_64
-	systab = (efi_system_table_t *)(ei->efi_systab | ((__u64)ei->efi_systab_hi<<32));
+	systab = ei->efi_systab | ((__u64)ei->efi_systab_hi << 32);
 #else
 	if (ei->efi_systab_hi || ei->efi_memmap_hi) {
 		debug_putstr("Error getting RSDP address: EFI system table located above 4GB.\n");
 		return 0;
 	}
-	systab = (efi_system_table_t *)ei->efi_systab;
+	systab = ei->efi_systab;
 #endif
 	if (!systab)
 		error("EFI system table not found.");
 
-	/*
-	 * Get EFI tables from systab.
-	 */
-	size = efi_64 ? sizeof(efi_config_table_64_t) :
-			sizeof(efi_config_table_32_t);
+	/* Handle EFI bitness properly */
+	if (efi_64) {
+		efi_system_table_64_t *stbl = (efi_system_table_64_t *)systab;
+
+		config_tables	= stbl->tables;
+		nr_tables	= stbl->nr_tables;
+		size		= sizeof(efi_config_table_64_t);
+	} else {
+		efi_system_table_32_t *stbl = (efi_system_table_32_t *)systab;
 
-	for (i = 0; i < systab->nr_tables; i++) {
+		config_tables	= stbl->tables;
+		nr_tables	= stbl->nr_tables;
+		size		= sizeof(efi_config_table_32_t);
+	}
+
+	if (!config_tables)
+		error("EFI config tables not found.");
+
+	/* Get EFI tables from systab. */
+	for (i = 0; i < nr_tables; i++) {
 		acpi_physical_address table;
-		void *config_tables;
 		efi_guid_t guid;
 
-		config_tables = (void *)(systab->tables + size * i);
+		config_tables += size * i;
+
 		if (efi_64) {
-			efi_config_table_64_t *tmp_table;
+			efi_config_table_64_t *tbl = (efi_config_table_64_t *)config_tables;
 
-			tmp_table = config_tables;
-			guid = tmp_table->guid;
-			table = tmp_table->table;
+			guid  = tbl->guid;
+			table = tbl->table;
 
 			if (!IS_ENABLED(CONFIG_X86_64) && table >> 32) {
 				debug_putstr("Error getting RSDP address: EFI config table located above 4GB.\n");
 				return 0;
 			}
 		} else {
-			efi_config_table_32_t *tmp_table;
+			efi_config_table_32_t *tbl = (efi_config_table_32_t *)config_tables;
 
-			tmp_table = config_tables;
-			guid = tmp_table->guid;
-			table = tmp_table->table;
+			guid  = tbl->guid;
+			table = tbl->table;
 		}
 
 		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
