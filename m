Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B5E34C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B0A208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BantF8Xs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B0A208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755983AbeFOH4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 03:56:43 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35315 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755925AbeFOH4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 03:56:40 -0400
Received: by mail-pl0-f67.google.com with SMTP id k1-v6so4963948plt.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 00:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SVvccCNZOnC10fldZUKI5r72hoQShNewrJAgWxAVx0g=;
        b=BantF8Xs7NOjMKaFxleSbjk2rLcJvSWCo8wd55fvdPU8TXQrASc1uXwtzrQnzQWjPy
         ir9hqnD+0wPEZWsz9G/EMRSgPeTJHvLpkcqDzmOpnHbla9ZsnY++6R7UVePVXk2TTlzG
         A9VQi9RvzS0kPWA4Uhbk6I7QYi4YTz9gTXB0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SVvccCNZOnC10fldZUKI5r72hoQShNewrJAgWxAVx0g=;
        b=loqI/M8kopc15YXTDUbzgISF/sEMseZBUNbenBta3L/5ZVwqxMFNC7OMYs36CPrUoC
         82VUaPa9zRCi5c1+JH7k+XQl+hFHNpA2mSkr+L4lt/IWz+sAAbtOi6AUkeaE8j6BnGsZ
         vJQ67KH3EA2vKpakqE14jMPyetKoQuOsIC+MN3vdEdBzJLC36d6bO8vcLL4TR27v00lZ
         Dg1/7grdHZyg2Ox0R+e+0MQH5gwRCRvmfzwoa8mb1H5CdR9CVpnODz5Zll+CqRqnZfmL
         ooVR7KaZlJ14KSdLuIRfIphd7SJBQC4L+Iv7tIrtxTyTtM1nVQ8YsiqQbwy0DETRFv7q
         5RSg==
X-Gm-Message-State: APt69E29A4Oy0vMSwYM2EkxP2JwUZqScxGybNvmImT8iLGMV0kXBkkTY
        +RZpjWXdvPlj/3E4f60LYeYfYw==
X-Google-Smtp-Source: ADUXVKIti2VzofQL+jLHjFW/TlfMKS8dh5XgIRpMMAF8hvsk1kXqaUmt0phfZYS7Rxv+5XLSUxcNkQ==
X-Received: by 2002:a17:902:7105:: with SMTP id a5-v6mr758104pll.171.1529049400174;
        Fri, 15 Jun 2018 00:56:40 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id t68-v6sm13357123pfe.91.2018.06.15.00.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 00:56:39 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, ard.biesheuvel@linaro.org
Cc:     tbaicar@codeaurora.org, bhsharma@redhat.com, dyoung@redhat.com,
        james.morse@arm.com, mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 2/3] arm64: acpi,efi: fix alignment fault in accessing ACPI tables at kdump
Date:   Fri, 15 Jun 2018 16:56:22 +0900
Message-Id: <20180615075623.13454-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180615075623.13454-1-takahiro.akashi@linaro.org>
References: <20180615075623.13454-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a fix against the issue that crash dump kernel may hang up
during booting, which can happen on any ACPI-based system with "ACPI
Reclaim Memory."

(kernel messages after panic kicked off kdump)
	   (snip...)
	Bye!
	   (snip...)
	ACPI: Core revision 20170728
	pud=000000002e7d0003, *pmd=000000002e7c0003, *pte=00e8000039710707
	Internal error: Oops: 96000021 [#1] SMP
	Modules linked in:
	CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.14.0-rc6 #1
	task: ffff000008d05180 task.stack: ffff000008cc0000
	PC is at acpi_ns_lookup+0x25c/0x3c0
	LR is at acpi_ds_load1_begin_op+0xa4/0x294
	   (snip...)
	Process swapper/0 (pid: 0, stack limit = 0xffff000008cc0000)
	Call trace:
	   (snip...)
	[<ffff0000084a6764>] acpi_ns_lookup+0x25c/0x3c0
	[<ffff00000849b4f8>] acpi_ds_load1_begin_op+0xa4/0x294
	[<ffff0000084ad4ac>] acpi_ps_build_named_op+0xc4/0x198
	[<ffff0000084ad6cc>] acpi_ps_create_op+0x14c/0x270
	[<ffff0000084acfa8>] acpi_ps_parse_loop+0x188/0x5c8
	[<ffff0000084ae048>] acpi_ps_parse_aml+0xb0/0x2b8
	[<ffff0000084a8e10>] acpi_ns_one_complete_parse+0x144/0x184
	[<ffff0000084a8e98>] acpi_ns_parse_table+0x48/0x68
	[<ffff0000084a82cc>] acpi_ns_load_table+0x4c/0xdc
	[<ffff0000084b32f8>] acpi_tb_load_namespace+0xe4/0x264
	[<ffff000008baf9b4>] acpi_load_tables+0x48/0xc0
	[<ffff000008badc20>] acpi_early_init+0x9c/0xd0
	[<ffff000008b70d50>] start_kernel+0x3b4/0x43c
	Code: b9008fb9 2a000318 36380054 32190318 (b94002c0)
	---[ end trace c46ed37f9651c58e ]---
	Kernel panic - not syncing: Fatal exception
	Rebooting in 10 seconds..

(diagnosis)
* This fault is a data abort, alignment fault (ESR=0x96000021)
  during reading out ACPI table.
* Initial ACPI tables are normally stored in system ram and marked as
  "ACPI Reclaim memory" by the firmware.
* After the commit f56ab9a5b73c ("efi/arm: Don't mark ACPI reclaim
  memory as MEMBLOCK_NOMAP"), those regions are differently handled
  as they are "memblock-reserved", without NOMAP bit.
* So they are now excluded from device tree's "usable-memory-range"
  which kexec-tools determines based on a current view of /proc/iomem.
* When crash dump kernel boots up, it tries to accesses ACPI tables by
  mapping them with ioremap(), not ioremap_cache(), in acpi_os_ioremap()
  since they are no longer part of mapped system ram.
* Given that ACPI accessor/helper functions are compiled in without
  unaligned access support (ACPI_MISALIGNMENT_NOT_SUPPORTED),
  any unaligned access to ACPI tables can cause a fatal panic.

With this patch, acpi_os_ioremap() always honors memory attribute
information provided by the firmware (EFI) and retaining cacheability
allows the kernel safe access to ACPI tables.

Please note that arm_enable_runtime_services() is now renamed to
efi_enter_virtual_mode() due to the similarity to x86's.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Suggested-by: James Morse <james.morse@arm.com>
Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reported-by and Tested-by: Bhupesh Sharma <bhsharma@redhat.com>
  (for older version)
---
 arch/arm64/include/asm/acpi.h      | 23 ++++++++++++++++-------
 arch/arm64/kernel/acpi.c           | 11 +++--------
 drivers/firmware/efi/arm-runtime.c | 27 ++++++++++++---------------
 3 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 32f465a80e4e..d53c95f4e1a9 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -12,10 +12,12 @@
 #ifndef _ASM_ACPI_H
 #define _ASM_ACPI_H
 
+#include <linux/efi.h>
 #include <linux/memblock.h>
 #include <linux/psci.h>
 
 #include <asm/cputype.h>
+#include <asm/io.h>
 #include <asm/smp_plat.h>
 #include <asm/tlbflush.h>
 
@@ -29,18 +31,22 @@
 
 /* Basic configuration for ACPI */
 #ifdef	CONFIG_ACPI
+pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
+
 /* ACPI table mapping after acpi_permanent_mmap is set */
 static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
 					    acpi_size size)
 {
+	/* For normal memory we already have a cacheable mapping. */
+	if (memblock_is_map_memory(phys))
+		return (void __iomem *)__phys_to_virt(phys);
+
 	/*
-	 * EFI's reserve_regions() call adds memory with the WB attribute
-	 * to memblock via early_init_dt_add_memory_arch().
+	 * We should still honor the memory's attribute here because
+	 * crash dump kernel possibly excludes some ACPI (reclaim)
+	 * regions from memblock list.
 	 */
-	if (!memblock_is_memory(phys))
-		return ioremap(phys, size);
-
-	return ioremap_cache(phys, size);
+	return __ioremap(phys, size, __acpi_get_mem_attribute(phys));
 }
 #define acpi_os_ioremap acpi_os_ioremap
 
@@ -125,7 +131,10 @@ static inline const char *acpi_get_enable_method(int cpu)
  * for compatibility.
  */
 #define acpi_disable_cmcff 1
-pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr);
+static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
+{
+	return __acpi_get_mem_attribute(addr);
+}
 #endif /* CONFIG_ACPI_APEI */
 
 #ifdef CONFIG_ACPI_NUMA
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 7b09487ff8fb..ed46dc188b22 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -18,6 +18,7 @@
 #include <linux/acpi.h>
 #include <linux/bootmem.h>
 #include <linux/cpumask.h>
+#include <linux/efi.h>
 #include <linux/efi-bgrt.h>
 #include <linux/init.h>
 #include <linux/irq.h>
@@ -29,13 +30,9 @@
 
 #include <asm/cputype.h>
 #include <asm/cpu_ops.h>
+#include <asm/pgtable.h>
 #include <asm/smp_plat.h>
 
-#ifdef CONFIG_ACPI_APEI
-# include <linux/efi.h>
-# include <asm/pgtable.h>
-#endif
-
 int acpi_noirq = 1;		/* skip ACPI IRQ initialization */
 int acpi_disabled = 1;
 EXPORT_SYMBOL(acpi_disabled);
@@ -239,8 +236,7 @@ void __init acpi_boot_table_init(void)
 	}
 }
 
-#ifdef CONFIG_ACPI_APEI
-pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
+pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
 {
 	/*
 	 * According to "Table 8 Map: EFI memory types to AArch64 memory
@@ -261,4 +257,3 @@ pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
 		return __pgprot(PROT_NORMAL_NC);
 	return __pgprot(PROT_DEVICE_nGnRnE);
 }
-#endif
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 5889cbea60b8..566ef0a9edb5 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -106,46 +106,43 @@ static bool __init efi_virtmap_init(void)
  * non-early mapping of the UEFI system table and virtual mappings for all
  * EFI_MEMORY_RUNTIME regions.
  */
-static int __init arm_enable_runtime_services(void)
+void __init efi_enter_virtual_mode(void)
 {
 	u64 mapsize;
 
 	if (!efi_enabled(EFI_BOOT)) {
 		pr_info("EFI services will not be available.\n");
-		return 0;
+		return;
+	}
+
+	mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
+
+	if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
+		pr_err("Failed to remap EFI memory map\n");
+		return;
 	}
 
 	if (efi_runtime_disabled()) {
 		pr_info("EFI runtime services will be disabled.\n");
-		return 0;
+		return;
 	}
 
 	if (efi_enabled(EFI_RUNTIME_SERVICES)) {
 		pr_info("EFI runtime services access via paravirt.\n");
-		return 0;
+		return;
 	}
 
 	pr_info("Remapping and enabling EFI services.\n");
 
-	mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
-
-	if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
-		pr_err("Failed to remap EFI memory map\n");
-		return -ENOMEM;
-	}
-
 	if (!efi_virtmap_init()) {
 		pr_err("UEFI virtual mapping missing or invalid -- runtime services will not be available\n");
-		return -ENOMEM;
+		return;
 	}
 
 	/* Set up runtime services function pointers */
 	efi_native_runtime_setup();
 	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
-
-	return 0;
 }
-early_initcall(arm_enable_runtime_services);
 
 void efi_virtmap_load(void)
 {
-- 
2.17.0

