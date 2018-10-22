Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD96ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F11A2083E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F11A2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeJVJxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 05:53:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:63585 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbeJVJxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 05:53:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2018 18:36:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,410,1534834800"; 
   d="scan'208";a="97296423"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by fmsmga002.fm.intel.com with ESMTP; 21 Oct 2018 18:36:51 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 2/2] x86/efi: Move efi_<reserve/free>_boot_services() to arch/x86
Date:   Sun, 21 Oct 2018 18:35:45 -0700
Message-Id: <1540172145-17134-3-git-send-email-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540172145-17134-1-git-send-email-sai.praneeth.prakhya@intel.com>
References: <1540172145-17134-1-git-send-email-sai.praneeth.prakhya@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

efi_<reserve/free>_boot_services() are x86 specific quirks and as such
should be in asm/efi.h, so move them from linux/efi.h. Also, call
efi_free_boot_services() from __efi_enter_virtual_mode() as it is x86
specific call and ideally shouldn't be part of init/main.c

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/include/asm/efi.h  | 2 ++
 arch/x86/platform/efi/efi.c | 2 ++
 include/linux/efi.h         | 3 ---
 init/main.c                 | 4 ----
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index eea40d52ca78..d1e64ac80b9c 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -141,6 +141,8 @@ extern int __init efi_reuse_config(u64 tables, int nr_tables);
 extern void efi_delete_dummy_variable(void);
 extern void efi_switch_mm(struct mm_struct *mm);
 extern void efi_recover_from_page_fault(unsigned long phys_addr);
+extern void efi_free_boot_services(void);
+extern void efi_reserve_boot_services(void);
 
 struct efi_setup_data {
 	u64 fw_vendor;
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 9061babfbc83..93924a353e3b 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -994,6 +994,8 @@ static void __init __efi_enter_virtual_mode(void)
 		panic("EFI call to SetVirtualAddressMap() failed!");
 	}
 
+	efi_free_boot_services();
+
 	/*
 	 * Now that EFI is in virtual mode, update the function
 	 * pointers in the runtime service table to the new virtual addresses.
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 845174e113ce..ed2058073385 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1000,13 +1000,11 @@ extern void efi_memmap_walk (efi_freemem_callback_t callback, void *arg);
 extern void efi_gettimeofday (struct timespec64 *ts);
 extern void efi_enter_virtual_mode (void);	/* switch EFI to virtual mode, if possible */
 #ifdef CONFIG_X86
-extern void efi_free_boot_services(void);
 extern efi_status_t efi_query_variable_store(u32 attributes,
 					     unsigned long size,
 					     bool nonblocking);
 extern void efi_find_mirror(void);
 #else
-static inline void efi_free_boot_services(void) {}
 
 static inline efi_status_t efi_query_variable_store(u32 attributes,
 						    unsigned long size,
@@ -1046,7 +1044,6 @@ extern void efi_mem_reserve(phys_addr_t addr, u64 size);
 extern int efi_mem_reserve_persistent(phys_addr_t addr, u64 size);
 extern void efi_initialize_iomem_resources(struct resource *code_resource,
 		struct resource *data_resource, struct resource *bss_resource);
-extern void efi_reserve_boot_services(void);
 extern int efi_get_fdt_params(struct efi_fdt_params *params);
 extern struct kobject *efi_kobj;
 
diff --git a/init/main.c b/init/main.c
index 18f8f0140fa0..174fb14196cc 100644
--- a/init/main.c
+++ b/init/main.c
@@ -731,10 +731,6 @@ asmlinkage __visible void __init start_kernel(void)
 	arch_post_acpi_subsys_init();
 	sfi_init_late();
 
-	if (efi_enabled(EFI_RUNTIME_SERVICES)) {
-		efi_free_boot_services();
-	}
-
 	/* Do the rest non-__init'ed, we're now alive */
 	rest_init();
 }
-- 
2.7.4

