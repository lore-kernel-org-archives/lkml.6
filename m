Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEF4C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2783F20874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2783F20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbeGVQUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 12:20:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44557 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbeGVQUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 12:20:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6MFMiMJ3458484
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 22 Jul 2018 08:22:44 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6MFMipF3458481;
        Sun, 22 Jul 2018 08:22:44 -0700
Date:   Sun, 22 Jul 2018 08:22:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-aab9593c0cb4454f9d261a8c87a3361f3186c4ec@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        hdegoede@redhat.com, andriy.shevchenko@linux.intel.com,
        peterz@infradead.org, lukas@wunner.de, ard.biesheuvel@linaro.org
Reply-To: lukas@wunner.de, ard.biesheuvel@linaro.org, hdegoede@redhat.com,
          torvalds@linux-foundation.org, andriy.shevchenko@linux.intel.com,
          peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20180720014726.24031-8-ard.biesheuvel@linaro.org>
References: <20180720014726.24031-8-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/x86: Replace references to efi_early->is64 with
 efi_is_64bit()
Git-Commit-ID: aab9593c0cb4454f9d261a8c87a3361f3186c4ec
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

Commit-ID:  aab9593c0cb4454f9d261a8c87a3361f3186c4ec
Gitweb:     https://git.kernel.org/tip/aab9593c0cb4454f9d261a8c87a3361f3186c4ec
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Fri, 20 Jul 2018 10:47:24 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 22 Jul 2018 14:13:43 +0200

efi/x86: Replace references to efi_early->is64 with efi_is_64bit()

There are a couple of places in the x86 EFI stub code where we select
between 32-bit and 64-bit versions of the support routines based on
the value of efi_early->is64. Referencing that field directly is a
bad idea, since it prevents the compiler from inferring that this
field can never be true on a 32-bit build, and can only become false
on a 64-bit build if support for mixed mode is compiled in. This
results in dead code to be retained in the uncompressed part of the
kernel image, which is wasteful.

So switch to the efi_is_64bit() helper, which will resolve to a
constant boolean unless building for 64-bit with mixed mode support.

Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180720014726.24031-8-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/eboot.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 915c64edbe8e..1458b1700fc7 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -404,7 +404,7 @@ struct boot_params *make_boot_params(struct efi_config *c)
 	if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		return NULL;
 
-	if (efi_early->is64)
+	if (efi_is_64bit())
 		setup_boot_services64(efi_early);
 	else
 		setup_boot_services32(efi_early);
@@ -639,7 +639,6 @@ struct exit_boot_struct {
 	struct efi_info		*efi;
 	struct setup_data	*e820ext;
 	__u32			e820ext_size;
-	bool			is64;
 };
 
 static efi_status_t exit_boot_func(efi_system_table_t *sys_table_arg,
@@ -666,7 +665,8 @@ static efi_status_t exit_boot_func(efi_system_table_t *sys_table_arg,
 		first = false;
 	}
 
-	signature = p->is64 ? EFI64_LOADER_SIGNATURE : EFI32_LOADER_SIGNATURE;
+	signature = efi_is_64bit() ? EFI64_LOADER_SIGNATURE
+				   : EFI32_LOADER_SIGNATURE;
 	memcpy(&p->efi->efi_loader_signature, signature, sizeof(__u32));
 
 	p->efi->efi_systab		= (unsigned long)sys_table_arg;
@@ -683,8 +683,7 @@ static efi_status_t exit_boot_func(efi_system_table_t *sys_table_arg,
 	return EFI_SUCCESS;
 }
 
-static efi_status_t exit_boot(struct boot_params *boot_params,
-			      void *handle, bool is64)
+static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 {
 	unsigned long map_sz, key, desc_size, buff_size;
 	efi_memory_desc_t *mem_map;
@@ -705,7 +704,6 @@ static efi_status_t exit_boot(struct boot_params *boot_params,
 	priv.efi		= &boot_params->efi_info;
 	priv.e820ext		= NULL;
 	priv.e820ext_size	= 0;
-	priv.is64		= is64;
 
 	/* Might as well exit boot services now */
 	status = efi_exit_boot_services(sys_table, handle, &map, &priv,
@@ -740,13 +738,11 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
 	struct desc_struct *desc;
 	void *handle;
 	efi_system_table_t *_table;
-	bool is64;
 
 	efi_early = c;
 
 	_table = (efi_system_table_t *)(unsigned long)efi_early->table;
 	handle = (void *)(unsigned long)efi_early->image_handle;
-	is64 = efi_early->is64;
 
 	sys_table = _table;
 
@@ -754,7 +750,7 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
 	if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		goto fail;
 
-	if (is64)
+	if (efi_is_64bit())
 		setup_boot_services64(efi_early);
 	else
 		setup_boot_services32(efi_early);
@@ -810,7 +806,7 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
 		hdr->code32_start = bzimage_addr;
 	}
 
-	status = exit_boot(boot_params, handle, is64);
+	status = exit_boot(boot_params, handle);
 	if (status != EFI_SUCCESS) {
 		efi_printk(sys_table, "exit_boot() failed!\n");
 		goto fail;
