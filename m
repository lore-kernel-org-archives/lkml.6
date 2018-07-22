Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A3BECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C8720874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C8720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbeGVQSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 12:18:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39737 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbeGVQSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 12:18:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6MFLADX3458378
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 22 Jul 2018 08:21:10 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6MFLATS3458374;
        Sun, 22 Jul 2018 08:21:10 -0700
Date:   Sun, 22 Jul 2018 08:21:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-290084c2fa13e9aaa7f856ed1ab30760327dd9f8@git.kernel.org>
Cc:     torvalds@linux-foundation.org, lukas@wunner.de,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        ard.biesheuvel@linaro.org, mingo@kernel.org, hdegoede@redhat.com,
        tglx@linutronix.de, hpa@zytor.com,
        andriy.shevchenko@linux.intel.com
Reply-To: ard.biesheuvel@linaro.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, lukas@wunner.de,
          torvalds@linux-foundation.org, hdegoede@redhat.com,
          mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
          andriy.shevchenko@linux.intel.com
In-Reply-To: <20180720014726.24031-5-ard.biesheuvel@linaro.org>
References: <20180720014726.24031-5-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/x86: Merge 32-bit and 64-bit UGA draw protocol
 setup routines
Git-Commit-ID: 290084c2fa13e9aaa7f856ed1ab30760327dd9f8
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

Commit-ID:  290084c2fa13e9aaa7f856ed1ab30760327dd9f8
Gitweb:     https://git.kernel.org/tip/290084c2fa13e9aaa7f856ed1ab30760327dd9f8
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Fri, 20 Jul 2018 10:47:21 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 22 Jul 2018 14:13:43 +0200

efi/x86: Merge 32-bit and 64-bit UGA draw protocol setup routines

The two versions of setup_uga##() are mostly identical, with the
exception of the size of EFI_HANDLE. So let's merge the two, and
pull the implementation into the calling function setup_uga().

Note that the 32-bit version was only mixed-mode safe by accident:
it only calls the get_mode() method of the UGA draw protocol, which
happens to be the first member, and so truncating the 64-bit void* at
offset 0 to 32 bits happens to produce the correct value. But let's
not rely on that, and use the proper API instead.

Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180720014726.24031-5-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/eboot.c | 111 +++++++++------------------------------
 1 file changed, 26 insertions(+), 85 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 011d5c289449..ac8e442db71f 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -318,81 +318,54 @@ static void setup_quirks(struct boot_params *boot_params)
 	}
 }
 
+/*
+ * See if we have Universal Graphics Adapter (UGA) protocol
+ */
 static efi_status_t
-setup_uga32(void **uga_handle, unsigned long size, u32 *width, u32 *height)
+setup_uga(struct screen_info *si, efi_guid_t *uga_proto, unsigned long size)
 {
+	efi_status_t status;
+	u32 width, height;
+	void **uga_handle = NULL;
 	efi_uga_draw_protocol_t *uga = NULL, *first_uga;
-	efi_guid_t uga_proto = EFI_UGA_PROTOCOL_GUID;
 	unsigned long nr_ugas;
-	u32 *handles = (u32 *)uga_handle;
-	efi_status_t status = EFI_INVALID_PARAMETER;
 	int i;
 
-	first_uga = NULL;
-	nr_ugas = size / sizeof(u32);
-	for (i = 0; i < nr_ugas; i++) {
-		efi_guid_t pciio_proto = EFI_PCI_IO_PROTOCOL_GUID;
-		u32 w, h, depth, refresh;
-		void *pciio;
-		u32 handle = handles[i];
-
-		status = efi_call_early(handle_protocol, handle,
-					&uga_proto, (void **)&uga);
-		if (status != EFI_SUCCESS)
-			continue;
-
-		efi_call_early(handle_protocol, handle, &pciio_proto, &pciio);
-
-		status = efi_early->call((unsigned long)uga->get_mode, uga,
-					 &w, &h, &depth, &refresh);
-		if (status == EFI_SUCCESS && (!first_uga || pciio)) {
-			*width = w;
-			*height = h;
-
-			/*
-			 * Once we've found a UGA supporting PCIIO,
-			 * don't bother looking any further.
-			 */
-			if (pciio)
-				break;
-
-			first_uga = uga;
-		}
-	}
+	status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
+				size, (void **)&uga_handle);
+	if (status != EFI_SUCCESS)
+		return status;
 
-	return status;
-}
+	status = efi_call_early(locate_handle,
+				EFI_LOCATE_BY_PROTOCOL,
+				uga_proto, NULL, &size, uga_handle);
+	if (status != EFI_SUCCESS)
+		goto free_handle;
 
-static efi_status_t
-setup_uga64(void **uga_handle, unsigned long size, u32 *width, u32 *height)
-{
-	efi_uga_draw_protocol_t *uga = NULL, *first_uga;
-	efi_guid_t uga_proto = EFI_UGA_PROTOCOL_GUID;
-	unsigned long nr_ugas;
-	u64 *handles = (u64 *)uga_handle;
-	efi_status_t status = EFI_INVALID_PARAMETER;
-	int i;
+	height = 0;
+	width = 0;
 
 	first_uga = NULL;
-	nr_ugas = size / sizeof(u64);
+	nr_ugas = size / (efi_is_64bit() ? sizeof(u64) : sizeof(u32));
 	for (i = 0; i < nr_ugas; i++) {
 		efi_guid_t pciio_proto = EFI_PCI_IO_PROTOCOL_GUID;
 		u32 w, h, depth, refresh;
 		void *pciio;
-		u64 handle = handles[i];
+		unsigned long handle = efi_is_64bit() ? ((u64 *)uga_handle)[i]
+						      : ((u32 *)uga_handle)[i];
 
 		status = efi_call_early(handle_protocol, handle,
-					&uga_proto, (void **)&uga);
+					uga_proto, (void **)&uga);
 		if (status != EFI_SUCCESS)
 			continue;
 
 		efi_call_early(handle_protocol, handle, &pciio_proto, &pciio);
 
-		status = efi_early->call((unsigned long)uga->get_mode, uga,
-					 &w, &h, &depth, &refresh);
+		status = efi_call_proto(efi_uga_draw_protocol, get_mode, uga,
+					&w, &h, &depth, &refresh);
 		if (status == EFI_SUCCESS && (!first_uga || pciio)) {
-			*width = w;
-			*height = h;
+			width = w;
+			height = h;
 
 			/*
 			 * Once we've found a UGA supporting PCIIO,
@@ -405,38 +378,6 @@ setup_uga64(void **uga_handle, unsigned long size, u32 *width, u32 *height)
 		}
 	}
 
-	return status;
-}
-
-/*
- * See if we have Universal Graphics Adapter (UGA) protocol
- */
-static efi_status_t
-setup_uga(struct screen_info *si, efi_guid_t *uga_proto, unsigned long size)
-{
-	efi_status_t status;
-	u32 width, height;
-	void **uga_handle = NULL;
-
-	status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
-				size, (void **)&uga_handle);
-	if (status != EFI_SUCCESS)
-		return status;
-
-	status = efi_call_early(locate_handle,
-				EFI_LOCATE_BY_PROTOCOL,
-				uga_proto, NULL, &size, uga_handle);
-	if (status != EFI_SUCCESS)
-		goto free_handle;
-
-	height = 0;
-	width = 0;
-
-	if (efi_early->is64)
-		status = setup_uga64(uga_handle, size, &width, &height);
-	else
-		status = setup_uga32(uga_handle, size, &width, &height);
-
 	if (!width && !height)
 		goto free_handle;
 
