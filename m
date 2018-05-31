Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754487AbeEaKbP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:31:15 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44304 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754284AbeEaKbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:31:14 -0400
X-Google-Smtp-Source: ADUXVKIDWxtL8G74EBO+Trjx97r1A1R7QlIqqVrzUw2UmoyhNHQtDFz3Cp19oMwSH/4JjLn4wRy6YQ==
From: Jun Yao <yaojun8558363@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will.deacon@arm.com,
        ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v2 1/2] arm64/mm: split tramp_pg_dir off from the data segment
Date: Thu, 31 May 2018 18:31:06 +0800
Message-Id: <20180531103106.31740-1-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make tramp_pg_dir read-only, split it off from the data
segment and create a dedicated pgdir segment for it.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/include/asm/sections.h |  1 +
 arch/arm64/kernel/vmlinux.lds.S   |  3 +++
 arch/arm64/mm/mmu.c               | 13 +++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index caab039d6305..46a6646e886b 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -29,5 +29,6 @@ extern char __inittext_begin[], __inittext_end[];
 extern char __irqentry_text_start[], __irqentry_text_end[];
 extern char __mmuoff_data_start[], __mmuoff_data_end[];
 extern char __entry_tramp_text_start[], __entry_tramp_text_end[];
+extern char __tramp_pgdir_segment_start[], __tramp_pgdir_segment_end[];
 
 #endif /* __ASM_SECTIONS_H */
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 605d1b60469c..c3368782171d 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -220,8 +220,11 @@ SECTIONS
 	. += IDMAP_DIR_SIZE;
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	. = ALIGN(SEGMENT_ALIGN);
+	__tramp_pgdir_segment_start = .;
 	tramp_pg_dir = .;
 	. += PAGE_SIZE;
+	__tramp_pgdir_segment_end = .;
 #endif
 
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 2dbb2c9f1ec1..a675fb88914e 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -573,6 +573,9 @@ static void __init map_kernel(pgd_t *pgdp)
 {
 	static struct vm_struct vmlinux_text, vmlinux_rodata, vmlinux_inittext,
 				vmlinux_initdata, vmlinux_data;
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	static struct vm_struct vmlinux_tramp_pgdir, vmlinux_data_end;
+#endif
 
 	/*
 	 * External debuggers may need to write directly to the text
@@ -593,7 +596,17 @@ static void __init map_kernel(pgd_t *pgdp)
 			   &vmlinux_inittext, 0, VM_NO_GUARD);
 	map_kernel_segment(pgdp, __initdata_begin, __initdata_end, PAGE_KERNEL,
 			   &vmlinux_initdata, 0, VM_NO_GUARD);
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	map_kernel_segment(pgdp, _data, __tramp_pgdir_segment_start,
+			PAGE_KERNEL, &vmlinux_data, 0, VM_NO_GUARD);
+	map_kernel_segment(pgdp, __tramp_pgdir_segment_start,
+			__tramp_pgdir_segment_end, PAGE_KERNEL,
+			&vmlinux_tramp_pgdir, NO_CONT_MAPPINGS, VM_NO_GUARD);
+	map_kernel_segment(pgdp, __tramp_pgdir_segment_end, _end, PAGE_KERNEL,
+			&vmlinux_data_end, 0, 0);
+#else
 	map_kernel_segment(pgdp, _data, _end, PAGE_KERNEL, &vmlinux_data, 0, 0);
+#endif
 
 	if (!READ_ONCE(pgd_val(*pgd_offset_raw(pgdp, FIXADDR_START)))) {
 		/*
-- 
2.17.0
