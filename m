Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1906C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1BB221780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1BB221780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387660AbeKOTTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:19:01 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37363 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbeKOTTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:19:01 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAF9BgEX738829
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 15 Nov 2018 01:11:42 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAF9Bgxq738826;
        Thu, 15 Nov 2018 01:11:42 -0800
Date:   Thu, 15 Nov 2018 01:11:42 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-eff896288872d687d9662000ec9ae11b6d61766f@git.kernel.org>
Cc:     ard.biesheuvel@linaro.org, hpa@zytor.com, mingo@kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org,
        marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Reply-To: hpa@zytor.com, ard.biesheuvel@linaro.org,
          torvalds@linux-foundation.org, mingo@kernel.org,
          peterz@infradead.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, marc.zyngier@arm.com
In-Reply-To: <20181114175544.12860-5-ard.biesheuvel@linaro.org>
References: <20181114175544.12860-5-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/urgent] efi/arm: Defer persistent reservations until after
 paging_init()
Git-Commit-ID: eff896288872d687d9662000ec9ae11b6d61766f
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

Commit-ID:  eff896288872d687d9662000ec9ae11b6d61766f
Gitweb:     https://git.kernel.org/tip/eff896288872d687d9662000ec9ae11b6d61766f
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Wed, 14 Nov 2018 09:55:43 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 15 Nov 2018 10:04:46 +0100

efi/arm: Defer persistent reservations until after paging_init()

The new memory EFI reservation feature we introduced to allow memory
reservations to persist across kexec may trigger an unbounded number
of calls to memblock_reserve(). The memblock subsystem can deal with
this fine, but not before memblock resizing is enabled, which we can
only do after paging_init(), when the memory we reallocate the array
into is actually mapped.

So break out the memreserve table processing into a separate routine
and call it after paging_init() on arm64. On ARM, because of limited
reviewing bandwidth of the maintainer, we cannot currently fix this,
so instead, disable the EFI persistent memreserve entirely on ARM so
we can fix it later.

Tested-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20181114175544.12860-5-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm64/kernel/setup.c               | 1 +
 drivers/firmware/efi/efi.c              | 4 ++++
 drivers/firmware/efi/libstub/arm-stub.c | 3 +++
 include/linux/efi.h                     | 7 +++++++
 4 files changed, 15 insertions(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 953e316521fc..f4fc1e0544b7 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -313,6 +313,7 @@ void __init setup_arch(char **cmdline_p)
 	arm64_memblock_init();
 
 	paging_init();
+	efi_apply_persistent_mem_reservations();
 
 	acpi_table_upgrade();
 
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 249eb70691b0..72a4da76d274 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -592,7 +592,11 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
 
 		early_memunmap(tbl, sizeof(*tbl));
 	}
+	return 0;
+}
 
+int __init efi_apply_persistent_mem_reservations(void)
+{
 	if (efi.mem_reserve != EFI_INVALID_TABLE_ADDR) {
 		unsigned long prsv = efi.mem_reserve;
 
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 30ac0c975f8a..3d36142cf812 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -75,6 +75,9 @@ void install_memreserve_table(efi_system_table_t *sys_table_arg)
 	efi_guid_t memreserve_table_guid = LINUX_EFI_MEMRESERVE_TABLE_GUID;
 	efi_status_t status;
 
+	if (IS_ENABLED(CONFIG_ARM))
+		return;
+
 	status = efi_call_early(allocate_pool, EFI_LOADER_DATA, sizeof(*rsv),
 				(void **)&rsv);
 	if (status != EFI_SUCCESS) {
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 845174e113ce..100ce4a4aff6 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1167,6 +1167,8 @@ static inline bool efi_enabled(int feature)
 extern void efi_reboot(enum reboot_mode reboot_mode, const char *__unused);
 
 extern bool efi_is_table_address(unsigned long phys_addr);
+
+extern int efi_apply_persistent_mem_reservations(void);
 #else
 static inline bool efi_enabled(int feature)
 {
@@ -1185,6 +1187,11 @@ static inline bool efi_is_table_address(unsigned long phys_addr)
 {
 	return false;
 }
+
+static inline int efi_apply_persistent_mem_reservations(void)
+{
+	return 0;
+}
 #endif
 
 extern int efi_status_to_err(efi_status_t status);
