Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D8EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 14:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23CB222E6
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 14:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfBPOIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 09:08:20 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55207 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfBPOIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 09:08:19 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1GE83Au1676820
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 16 Feb 2019 06:08:03 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1GE83mK1676817;
        Sat, 16 Feb 2019 06:08:03 -0800
Date:   Sat, 16 Feb 2019 06:08:03 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-582a32e708823e5957fd73ccd78dc4a9e49d21ea@git.kernel.org>
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        rppt@linux.ibm.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mingo@kernel.org, ard.biesheuvel@linaro.org, will.deacon@arm.com,
        tglx@linutronix.de, marc.zyngier@arm.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, peterz@infradead.org,
          rppt@linux.ibm.com, marc.zyngier@arm.com, mingo@kernel.org,
          ard.biesheuvel@linaro.org, will.deacon@arm.com,
          tglx@linutronix.de
In-Reply-To: <20190215123333.21209-3-ard.biesheuvel@linaro.org>
References: <20190215123333.21209-3-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/urgent] efi/arm: Revert "Defer persistent reservations
 until after paging_init()"
Git-Commit-ID: 582a32e708823e5957fd73ccd78dc4a9e49d21ea
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

Commit-ID:  582a32e708823e5957fd73ccd78dc4a9e49d21ea
Gitweb:     https://git.kernel.org/tip/582a32e708823e5957fd73ccd78dc4a9e49d21ea
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Fri, 15 Feb 2019 13:33:33 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 16 Feb 2019 15:02:03 +0100

efi/arm: Revert "Defer persistent reservations until after paging_init()"

This reverts commit eff896288872d687d9662000ec9ae11b6d61766f, which
deferred the processing of persistent memory reservations to a point
where the memory may have already been allocated and overwritten,
defeating the purpose.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20190215123333.21209-3-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm64/kernel/setup.c               | 1 -
 drivers/firmware/efi/efi.c              | 4 ----
 drivers/firmware/efi/libstub/arm-stub.c | 3 ---
 include/linux/efi.h                     | 7 -------
 4 files changed, 15 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 4b0e1231625c..d09ec76f08cf 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -313,7 +313,6 @@ void __init setup_arch(char **cmdline_p)
 	arm64_memblock_init();
 
 	paging_init();
-	efi_apply_persistent_mem_reservations();
 
 	acpi_table_upgrade();
 
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 4c46ff6f2242..55b77c576c42 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -592,11 +592,7 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
 
 		early_memunmap(tbl, sizeof(*tbl));
 	}
-	return 0;
-}
 
-int __init efi_apply_persistent_mem_reservations(void)
-{
 	if (efi.mem_reserve != EFI_INVALID_TABLE_ADDR) {
 		unsigned long prsv = efi.mem_reserve;
 
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index eee42d5e25ee..c037c6c5d0b7 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -75,9 +75,6 @@ void install_memreserve_table(efi_system_table_t *sys_table_arg)
 	efi_guid_t memreserve_table_guid = LINUX_EFI_MEMRESERVE_TABLE_GUID;
 	efi_status_t status;
 
-	if (IS_ENABLED(CONFIG_ARM))
-		return;
-
 	status = efi_call_early(allocate_pool, EFI_LOADER_DATA, sizeof(*rsv),
 				(void **)&rsv);
 	if (status != EFI_SUCCESS) {
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 45ff763fba76..28604a8d0aa9 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1198,8 +1198,6 @@ static inline bool efi_enabled(int feature)
 extern void efi_reboot(enum reboot_mode reboot_mode, const char *__unused);
 
 extern bool efi_is_table_address(unsigned long phys_addr);
-
-extern int efi_apply_persistent_mem_reservations(void);
 #else
 static inline bool efi_enabled(int feature)
 {
@@ -1218,11 +1216,6 @@ static inline bool efi_is_table_address(unsigned long phys_addr)
 {
 	return false;
 }
-
-static inline int efi_apply_persistent_mem_reservations(void)
-{
-	return 0;
-}
 #endif
 
 extern int efi_status_to_err(efi_status_t status);
