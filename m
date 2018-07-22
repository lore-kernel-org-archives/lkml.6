Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BE8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34DC20874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34DC20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbeGVQSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 12:18:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40353 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbeGVQSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 12:18:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6MFK8eX3458116
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 22 Jul 2018 08:20:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6MFK8W73458113;
        Sun, 22 Jul 2018 08:20:08 -0700
Date:   Sun, 22 Jul 2018 08:20:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-75c5a713ab4b774c7d990ec748dddba714034436@git.kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, ard.biesheuvel@linaro.org, hpa@zytor.com,
        andriy.shevchenko@linux.intel.com, lukas@wunner.de,
        tglx@linutronix.de, mingo@kernel.org, torvalds@linux-foundation.org
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org,
          ard.biesheuvel@linaro.org, hdegoede@redhat.com,
          andriy.shevchenko@linux.intel.com, lukas@wunner.de,
          hpa@zytor.com, mingo@kernel.org, torvalds@linux-foundation.org,
          tglx@linutronix.de
In-Reply-To: <20180720014726.24031-3-ard.biesheuvel@linaro.org>
References: <20180720014726.24031-3-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/x86: Merge the setup_efi_pci32() and
 setup_efi_pci64() routines
Git-Commit-ID: 75c5a713ab4b774c7d990ec748dddba714034436
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

Commit-ID:  75c5a713ab4b774c7d990ec748dddba714034436
Gitweb:     https://git.kernel.org/tip/75c5a713ab4b774c7d990ec748dddba714034436
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Fri, 20 Jul 2018 10:47:19 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 22 Jul 2018 14:13:42 +0200

efi/x86: Merge the setup_efi_pci32() and setup_efi_pci64() routines

After merging the 32-bit and 64-bit versions of the code that invokes
the PCI I/O protocol methods to preserve PCI ROM images in commit:

  2c3625cb9fa2 ("efi/x86: Fold __setup_efi_pci32() and __setup_efi_pci64() ...")

there are still separate code paths for 32-bit and 64-bit, where the only
difference is the size of a EFI_HANDLE. So let's parameterize a single
implementation for that difference only, and get rid of the two copies of
the code.

While at it, rename __setup_efi_pci() to preserve_pci_rom_image() to
better reflect its purpose.

Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180720014726.24031-3-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/eboot.c | 123 ++++++++++-----------------------------
 1 file changed, 32 insertions(+), 91 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 9f6813493945..c72550783c16 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -111,7 +111,7 @@ void efi_char16_printk(efi_system_table_t *table, efi_char16_t *str)
 }
 
 static efi_status_t
-__setup_efi_pci(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
+preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 {
 	struct pci_setup_rom *rom = NULL;
 	efi_status_t status;
@@ -181,92 +181,6 @@ free_struct:
 	return status;
 }
 
-static void
-setup_efi_pci32(struct boot_params *params, void **pci_handle, unsigned long size)
-{
-	efi_pci_io_protocol_t *pci = NULL;
-	efi_guid_t pci_proto = EFI_PCI_IO_PROTOCOL_GUID;
-	u32 *handles = (u32 *)(unsigned long)pci_handle;
-	efi_status_t status;
-	unsigned long nr_pci;
-	struct setup_data *data;
-	int i;
-
-	data = (struct setup_data *)(unsigned long)params->hdr.setup_data;
-
-	while (data && data->next)
-		data = (struct setup_data *)(unsigned long)data->next;
-
-	nr_pci = size / sizeof(u32);
-	for (i = 0; i < nr_pci; i++) {
-		struct pci_setup_rom *rom = NULL;
-		u32 h = handles[i];
-
-		status = efi_call_early(handle_protocol, h,
-					&pci_proto, (void **)&pci);
-
-		if (status != EFI_SUCCESS)
-			continue;
-
-		if (!pci)
-			continue;
-
-		status = __setup_efi_pci(pci, &rom);
-		if (status != EFI_SUCCESS)
-			continue;
-
-		if (data)
-			data->next = (unsigned long)rom;
-		else
-			params->hdr.setup_data = (unsigned long)rom;
-
-		data = (struct setup_data *)rom;
-	}
-}
-
-static void
-setup_efi_pci64(struct boot_params *params, void **pci_handle, unsigned long size)
-{
-	efi_pci_io_protocol_t *pci = NULL;
-	efi_guid_t pci_proto = EFI_PCI_IO_PROTOCOL_GUID;
-	u64 *handles = (u64 *)(unsigned long)pci_handle;
-	efi_status_t status;
-	unsigned long nr_pci;
-	struct setup_data *data;
-	int i;
-
-	data = (struct setup_data *)(unsigned long)params->hdr.setup_data;
-
-	while (data && data->next)
-		data = (struct setup_data *)(unsigned long)data->next;
-
-	nr_pci = size / sizeof(u64);
-	for (i = 0; i < nr_pci; i++) {
-		struct pci_setup_rom *rom = NULL;
-		u64 h = handles[i];
-
-		status = efi_call_early(handle_protocol, h,
-					&pci_proto, (void **)&pci);
-
-		if (status != EFI_SUCCESS)
-			continue;
-
-		if (!pci)
-			continue;
-
-		status = __setup_efi_pci(pci, &rom);
-		if (status != EFI_SUCCESS)
-			continue;
-
-		if (data)
-			data->next = (unsigned long)rom;
-		else
-			params->hdr.setup_data = (unsigned long)rom;
-
-		data = (struct setup_data *)rom;
-	}
-}
-
 /*
  * There's no way to return an informative status from this function,
  * because any analysis (and printing of error messages) needs to be
@@ -282,6 +196,9 @@ static void setup_efi_pci(struct boot_params *params)
 	void **pci_handle = NULL;
 	efi_guid_t pci_proto = EFI_PCI_IO_PROTOCOL_GUID;
 	unsigned long size = 0;
+	unsigned long nr_pci;
+	struct setup_data *data;
+	int i;
 
 	status = efi_call_early(locate_handle,
 				EFI_LOCATE_BY_PROTOCOL,
@@ -305,10 +222,34 @@ static void setup_efi_pci(struct boot_params *params)
 	if (status != EFI_SUCCESS)
 		goto free_handle;
 
-	if (efi_early->is64)
-		setup_efi_pci64(params, pci_handle, size);
-	else
-		setup_efi_pci32(params, pci_handle, size);
+	data = (struct setup_data *)(unsigned long)params->hdr.setup_data;
+
+	while (data && data->next)
+		data = (struct setup_data *)(unsigned long)data->next;
+
+	nr_pci = size / (efi_is_64bit() ? sizeof(u64) : sizeof(u32));
+	for (i = 0; i < nr_pci; i++) {
+		efi_pci_io_protocol_t *pci = NULL;
+		struct pci_setup_rom *rom;
+
+		status = efi_call_early(handle_protocol,
+					efi_is_64bit() ? ((u64 *)pci_handle)[i]
+						       : ((u32 *)pci_handle)[i],
+					&pci_proto, (void **)&pci);
+		if (status != EFI_SUCCESS || !pci)
+			continue;
+
+		status = preserve_pci_rom_image(pci, &rom);
+		if (status != EFI_SUCCESS)
+			continue;
+
+		if (data)
+			data->next = (unsigned long)rom;
+		else
+			params->hdr.setup_data = (unsigned long)rom;
+
+		data = (struct setup_data *)rom;
+	}
 
 free_handle:
 	efi_call_early(free_pool, pci_handle);
