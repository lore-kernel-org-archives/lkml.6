Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9183FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B5421780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B5421780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbeKOTRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:17:46 -0500
Received: from terminus.zytor.com ([198.137.202.136]:32825 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728564AbeKOTRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:17:46 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAF9AUCs738735
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 15 Nov 2018 01:10:30 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAF9AU6k738732;
        Thu, 15 Nov 2018 01:10:30 -0800
Date:   Thu, 15 Nov 2018 01:10:30 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-33412b8673135b18ea42beb7f5117ed0091798b6@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        torvalds@linux-foundation.org, peterz@infradead.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@kernel.org
Reply-To: torvalds@linux-foundation.org, ard.biesheuvel@linaro.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
          tglx@linutronix.de, peterz@infradead.org
In-Reply-To: <20181114175544.12860-3-ard.biesheuvel@linaro.org>
References: <20181114175544.12860-3-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/urgent] efi/arm: Revert deferred unmap of early memmap
 mapping
Git-Commit-ID: 33412b8673135b18ea42beb7f5117ed0091798b6
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

Commit-ID:  33412b8673135b18ea42beb7f5117ed0091798b6
Gitweb:     https://git.kernel.org/tip/33412b8673135b18ea42beb7f5117ed0091798b6
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Wed, 14 Nov 2018 09:55:41 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 15 Nov 2018 10:04:46 +0100

efi/arm: Revert deferred unmap of early memmap mapping

Commit:

  3ea86495aef2 ("efi/arm: preserve early mapping of UEFI memory map longer for BGRT")

deferred the unmap of the early mapping of the UEFI memory map to
accommodate the ACPI BGRT code, which looks up the memory type that
backs the BGRT table to validate it against the requirements of the UEFI spec.

Unfortunately, this causes problems on ARM, which does not permit
early mappings to persist after paging_init() is called, resulting
in a WARN() splat. Since we don't support the BGRT table on ARM anway,
let's revert ARM to the old behaviour, which is to take down the
early mapping at the end of efi_init().

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Fixes: 3ea86495aef2 ("efi/arm: preserve early mapping of UEFI memory ...")
Link: http://lkml.kernel.org/r/20181114175544.12860-3-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/arm-init.c    | 4 ++++
 drivers/firmware/efi/arm-runtime.c | 2 +-
 drivers/firmware/efi/memmap.c      | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index 388a929baf95..1a6a77df8a5e 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -265,6 +265,10 @@ void __init efi_init(void)
 				    (params.mmap & ~PAGE_MASK)));
 
 	init_screen_info();
+
+	/* ARM does not permit early mappings to persist across paging_init() */
+	if (IS_ENABLED(CONFIG_ARM))
+		efi_memmap_unmap();
 }
 
 static int __init register_gop_device(void)
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 922cfb813109..a00934d263c5 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -110,7 +110,7 @@ static int __init arm_enable_runtime_services(void)
 {
 	u64 mapsize;
 
-	if (!efi_enabled(EFI_BOOT) || !efi_enabled(EFI_MEMMAP)) {
+	if (!efi_enabled(EFI_BOOT)) {
 		pr_info("EFI services will not be available.\n");
 		return 0;
 	}
diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index fa2904fb841f..38b686c67b17 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -118,6 +118,9 @@ int __init efi_memmap_init_early(struct efi_memory_map_data *data)
 
 void __init efi_memmap_unmap(void)
 {
+	if (!efi_enabled(EFI_MEMMAP))
+		return;
+
 	if (!efi.memmap.late) {
 		unsigned long size;
 
