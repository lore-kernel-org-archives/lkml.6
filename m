Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AC8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A872145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yl67IxDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A872145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbeK3ETF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:19:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36529 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730555AbeK3ETE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:19:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id u3so2674561wrs.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kZ9qAKUFhDNWQgwFHfyYbRlwlOBWhnuPIzx1kDDdeg4=;
        b=Yl67IxDWCaxwjil2nX89/whyxy5/ukSWgHYZpMBQQIot+PIfkOxMwhGseVxhd3BBtB
         D9M2MIOs9cboB2w/sSofoQkiNk8ae1wJgldy7FL+mMsL8bpX/tsOnPr3k20axn4Y65Wf
         5rJz8R7H0vFt9oIPhrZlTL6EWZd4wY30CdsLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kZ9qAKUFhDNWQgwFHfyYbRlwlOBWhnuPIzx1kDDdeg4=;
        b=fb2z00OxfoW/OUSsV6biCZAxOa8B1rD9n3Fb77pTWydJO9VTT3PzafZRsvLsp5v+Ha
         UHFqJpU0y8Hr9iLhOxfErrecZciJNnJCY3C6d4HX6MU0+n/O6BkMV3It+DK7iJTd9OXT
         byGUsEKALYgy+uAMIa+SRFOOJaOcLXtX9Prdky5rkAzr2fxzjqyNx3v2hNB+MkzCbjHt
         pe4JMF+5EWkmq6cap442CMdO9q7V2q8jl3RJnDZQVv4MiNxA/m4E9guGJF2eCAbHQn4h
         x68GW/z0x9VG4TPtk6+paPDwGeefXCVD6exPuo1ypaRH5+Kw6ayW4uASzS5tqllplzO2
         a+jA==
X-Gm-Message-State: AA+aEWYwOQLyox87D/4npZw6pVMi7pxZIp7+oCuT5yJ7V2WPzogjwRMJ
        a/ou4fuNiKl7hN7TCQAP3jMMtw==
X-Google-Smtp-Source: AFSGD/UtnT0sj58bIGg9qkNnTEosV50ZPLk33LKcL2ORLzhMLpsD1cqFWNp5CiDb9TBrtUTCqaXa8A==
X-Received: by 2002:adf:b102:: with SMTP id l2mr2059081wra.296.1543511577963;
        Thu, 29 Nov 2018 09:12:57 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:f070:d240:312e:9f99])
        by smtp.gmail.com with ESMTPSA id y185sm1593882wmg.34.2018.11.29.09.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:12:57 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Joe Perches <joe@perches.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Subject: [PATCH 06/11] x86/efi: Move efi_<reserve/free>_boot_services() to arch/x86
Date:   Thu, 29 Nov 2018 18:12:25 +0100
Message-Id: <20181129171230.18699-7-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
References: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

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
Cc: Peter Zijlstra <peterz@infradead.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
index 7ae939e353cd..e1cb01a22fa8 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -993,6 +993,8 @@ static void __init __efi_enter_virtual_mode(void)
 		panic("EFI call to SetVirtualAddressMap() failed!");
 	}
 
+	efi_free_boot_services();
+
 	/*
 	 * Now that EFI is in virtual mode, update the function
 	 * pointers in the runtime service table to the new virtual addresses.
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 100ce4a4aff6..2b3b33c83b05 100644
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
index ee147103ba1b..ccefcd8e855f 100644
--- a/init/main.c
+++ b/init/main.c
@@ -737,10 +737,6 @@ asmlinkage __visible void __init start_kernel(void)
 	arch_post_acpi_subsys_init();
 	sfi_init_late();
 
-	if (efi_enabled(EFI_RUNTIME_SERVICES)) {
-		efi_free_boot_services();
-	}
-
 	/* Do the rest non-__init'ed, we're now alive */
 	arch_call_rest_init();
 }
-- 
2.19.1

