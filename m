Return-Path: <liuwenliang@huawei.com>
X-Google-Smtp-Source: AIpwx49ofDlAgxUW85Y+qkA1IhEz2NA6KvvY8kGq6M0T5K3ff3IhmdnWgPj/eQfCBX7/gdpUaGW6
ARC-Seal: i=1; a=rsa-sha256; t=1523538901; cv=none;
        d=google.com; s=arc-20160816;
        b=Z2mObXkYJefWFSFhDJaIhh82UcthBS5yywNBSUqs/m4o02TG27RSgqdC1SBzkKdWfP
         YJUTev+hCktqQZaRVXzqjjFL47znxTOAjNYspPYhDcT8vtT9eCeF6efgYGwZJo5mHP6y
         f1/0f67gHj4HSMxsu6mwpRYL1aEAHDhOHNDOGB/SkfxqJRofwoulIT1r6eoBW1c5T6fL
         tSqECNL/ljstuU/3zO+eTyGenbxWvRI6YG+hfmCKnMr/J6cxM4+t523tmZbnwc3ceVWz
         ad79sP4OJ7zIMpTCKu9urlXOgbbWx3lnWGqaIM81DJ/B585JKkmWzB7Obb4cvx/YR1Fb
         KUpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:to:from
         :arc-authentication-results;
        bh=+KdpYXeoosuQFiIPQfMxzd+rfJsGUgw02wHDrPB26j4=;
        b=xOTad4QtMzfeF5ZtTigF9mF3U9txuv1fu14Nl9Vgeuzovh5qeaeJUsa47+Dv3cEon2
         EfadM/zsHQj8kiVD8v10zcnFGRuCmnJ216O6zO+l/Vj8HBXGnPAr/zqqN3n00nZnxkKq
         qm5PmNMOVOHyKlbA839AIoQzq4lssYL4mAhPd80CHefjUJi75BE6dyJtWYAMrXqH3OFj
         JeMVAySSHh2XG3v2KcrlpoUMKv0v/MwU6KzfM+Lq5nhdPp6ob41OJw0k1qW3B6C/atvX
         rDmjPL4taSiUZEtBk8u1SuSTuie9BfKQ2bMydCbRhQBzVaC23Q3C7CqDF1WixPVg2YLW
         ZSow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.190 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.190 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
From: Abbott Liu <liuwenliang@huawei.com>
To: <aryabinin@virtuozzo.com>, <glider@google.com>, <dvyukov@google.com>,
	<corbet@lwn.net>, <linux@armlinux.org.uk>, <cdall@kernel.org>,
	<marc.zyngier@arm.com>, <arnd@arndb.de>, <nicolas.pitre@linaro.org>,
	<vladimir.murzin@arm.com>, <mingo@kernel.org>, <viro@zeniv.linux.org.uk>,
	<alexandre.belloni@bootlin.com>, <ard.biesheuvel@linaro.org>,
	<daniel.lezcano@linaro.org>, <pombredanne@nexb.com>,
	<kstewart@linuxfoundation.org>, <liuwenliang@huawei.com>,
	<gregkh@linuxfoundation.org>, <f.fainelli@gmail.com>,
	<mawilcox@microsoft.com>, <akpm@linux-foundation.org>,
	<mark.rutland@arm.com>, <afzal.mohd.ma@gmail.com>,
	<alexander.levin@verizon.com>, <tglx@linutronix.de>, <thgarnie@google.com>,
	<dhowells@redhat.com>, <keescook@chromium.org>, <geert@linux-m68k.org>,
	<tixy@linaro.org>, <julien.thierry@arm.com>, <james.morse@arm.com>,
	<zhichao.huang@linaro.org>, <jinb.park7@gmail.com>, <labbott@redhat.com>,
	<philip@cog.systems>, <grygorii.strashko@linaro.org>, <opendmb@gmail.com>,
	<mhocko@suse.com>, <kirill.shutemov@linux.intel.com>,
	<kasan-dev@googlegroups.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kvmarm@lists.cs.columbia.edu>
Subject: [PATCH 4/6] Define the virtual space of KASan's shadow region
Date: Thu, 12 Apr 2018 20:54:09 +0800
Message-ID: <20180412125411.326-5-liuwenliang@huawei.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180412125411.326-1-liuwenliang@huawei.com>
References: <20180412125411.326-1-liuwenliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.187.223]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597546327018526566?=
X-GMAIL-MSGID: =?utf-8?q?1597546327018526566?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Define KASAN_SHADOW_OFFSET,KASAN_SHADOW_START and KASAN_SHADOW_END for arm
kernel address sanitizer.

     +----+ 0xffffffff
     |    |
     |    |
     |    |
     +----+ CONFIG_PAGE_OFFSET
     |    |     |    | |->  module virtual address space area.
     |    |/
     +----+ MODULE_VADDR = KASAN_SHADOW_END
     |    |     |    | |-> the shadow area of kernel virtual address.
     |    |/
     +----+ TASK_SIZE(start of kernel space) = KASAN_SHADOW_START  the
     |    |\  shadow address of MODULE_VADDR
     |    | ---------------------+
     |    |                      |
     +    + KASAN_SHADOW_OFFSET  |-> the user space area. Kernel address
     |    |                      |    sanitizer do not use this space.
     |    | ---------------------+
     |    |/
     ------ 0

1)KASAN_SHADOW_OFFSET:
  This value is used to map an address to the corresponding shadow
address by the following formula:
shadow_addr = (address >> 3) + KASAN_SHADOW_OFFSET;

2)KASAN_SHADOW_START
  This value is the MODULE_VADDR's shadow address. It is the start
of kernel virtual space.

3)KASAN_SHADOW_END
  This value is the 0x100000000's shadow address. It is the end of
kernel addresssanitizer's shadow area. It is also the start of the
module area.

When enable kasan, the definition of TASK_SIZE is not an an 8-bit
rotated constant, so we need to modify the TASK_SIZE access code
in the *.s file.

Cc: Andrey Ryabinin <a.ryabinin@samsung.com>
Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Joel Stanley <joel@jms.id.au>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Abbott Liu <liuwenliang@huawei.com>
Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
---
 arch/arm/include/asm/kasan_def.h | 64 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/memory.h    |  5 ++++
 arch/arm/kernel/entry-armv.S     |  5 ++--
 arch/arm/kernel/entry-common.S   |  9 ++++--
 arch/arm/mm/init.c               |  6 ++++
 arch/arm/mm/mmu.c                |  7 ++++-
 6 files changed, 90 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/include/asm/kasan_def.h

diff --git a/arch/arm/include/asm/kasan_def.h b/arch/arm/include/asm/kasan_def.h
new file mode 100644
index 0000000..7b7f424
--- /dev/null
+++ b/arch/arm/include/asm/kasan_def.h
@@ -0,0 +1,64 @@
+/*
+ *  arch/arm/include/asm/kasan_def.h
+ *
+ *  Copyright (c) 2018 Huawei Technologies Co., Ltd.
+ *
+ *  Author: Abbott Liu <liuwenliang@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_KASAN_DEF_H
+#define __ASM_KASAN_DEF_H
+
+#ifdef CONFIG_KASAN
+
+/*
+ *    +----+ 0xffffffff
+ *    |    |
+ *    |    |
+ *    |    |
+ *    +----+ CONFIG_PAGE_OFFSET
+ *    |    |\
+ *    |    | |->  module virtual address space area.
+ *    |    |/
+ *    +----+ MODULE_VADDR = KASAN_SHADOW_END
+ *    |    |\
+ *    |    | |-> the shadow area of kernel virtual address.
+ *    |    |/
+ *    +----+ TASK_SIZE(start of kernel space) = KASAN_SHADOW_START  the
+ *    |    |\  shadow address of MODULE_VADDR
+ *    |    | ---------------------+
+ *    |    |                      |
+ *    +    + KASAN_SHADOW_OFFSET  |-> the user space area. Kernel address
+ *    |    |                      |    sanitizer do not use this space.
+ *    |    | ---------------------+
+ *    |    |/
+ *    ------ 0
+ *
+ *1)KASAN_SHADOW_OFFSET:
+ *    This value is used to map an address to the corresponding shadow
+ * address by the following formula:
+ * shadow_addr = (address >> 3) + KASAN_SHADOW_OFFSET;
+ *
+ * 2)KASAN_SHADOW_START
+ *     This value is the MODULE_VADDR's shadow address. It is the start
+ * of kernel virtual space.
+ *
+ * 3) KASAN_SHADOW_END
+ *   This value is the 0x100000000's shadow address. It is the end of
+ * kernel addresssanitizer's shadow area. It is also the start of the
+ * module area.
+ *
+ */
+
+#define KASAN_SHADOW_OFFSET     (KASAN_SHADOW_END - (1<<29))
+
+#define KASAN_SHADOW_START      ((KASAN_SHADOW_END >> 3) + KASAN_SHADOW_OFFSET)
+
+#define KASAN_SHADOW_END        (UL(CONFIG_PAGE_OFFSET) - UL(SZ_16M))
+
+#endif
+#endif
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 4966677..3ce1a9a 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -21,6 +21,7 @@
 #ifdef CONFIG_NEED_MACH_MEMORY_H
 #include <mach/memory.h>
 #endif
+#include <asm/kasan_def.h>
 
 /*
  * Allow for constants defined here to be used from assembly code
@@ -37,7 +38,11 @@
  * TASK_SIZE - the maximum size of a user space task.
  * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area
  */
+#ifndef CONFIG_KASAN
 #define TASK_SIZE		(UL(CONFIG_PAGE_OFFSET) - UL(SZ_16M))
+#else
+#define TASK_SIZE		(KASAN_SHADOW_START)
+#endif
 #define TASK_UNMAPPED_BASE	ALIGN(TASK_SIZE / 3, SZ_16M)
 
 /*
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 1752033..b4de9e4 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -183,7 +183,7 @@ ENDPROC(__und_invalid)
 
 	get_thread_info tsk
 	ldr	r0, [tsk, #TI_ADDR_LIMIT]
-	mov	r1, #TASK_SIZE
+	ldr	r1, =TASK_SIZE
 	str	r1, [tsk, #TI_ADDR_LIMIT]
 	str	r0, [sp, #SVC_ADDR_LIMIT]
 
@@ -437,7 +437,8 @@ ENDPROC(__fiq_abt)
 	@ if it was interrupted in a critical region.  Here we
 	@ perform a quick test inline since it should be false
 	@ 99.9999% of the time.  The rest is done out of line.
-	cmp	r4, #TASK_SIZE
+	ldr	r0, =TASK_SIZE
+	cmp	r4, r0
 	blhs	kuser_cmpxchg64_fixup
 #endif
 #endif
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 3c4f887..78046de 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -51,7 +51,8 @@ ret_fast_syscall:
  UNWIND(.cantunwind	)
 	disable_irq_notrace			@ disable interrupts
 	ldr	r2, [tsk, #TI_ADDR_LIMIT]
-	cmp	r2, #TASK_SIZE
+	ldr	r1, =TASK_SIZE
+	cmp	r2, r1
 	blne	addr_limit_check_failed
 	ldr	r1, [tsk, #TI_FLAGS]		@ re-check for syscall tracing
 	tst	r1, #_TIF_SYSCALL_WORK | _TIF_WORK_MASK
@@ -81,7 +82,8 @@ ret_fast_syscall:
 	str	r0, [sp, #S_R0 + S_OFF]!	@ save returned r0
 	disable_irq_notrace			@ disable interrupts
 	ldr	r2, [tsk, #TI_ADDR_LIMIT]
-	cmp	r2, #TASK_SIZE
+	ldr     r1, =TASK_SIZE
+	cmp     r2, r1
 	blne	addr_limit_check_failed
 	ldr	r1, [tsk, #TI_FLAGS]		@ re-check for syscall tracing
 	tst	r1, #_TIF_SYSCALL_WORK | _TIF_WORK_MASK
@@ -116,7 +118,8 @@ ret_slow_syscall:
 	disable_irq_notrace			@ disable interrupts
 ENTRY(ret_to_user_from_irq)
 	ldr	r2, [tsk, #TI_ADDR_LIMIT]
-	cmp	r2, #TASK_SIZE
+	ldr     r1, =TASK_SIZE
+	cmp	r2, r1
 	blne	addr_limit_check_failed
 	ldr	r1, [tsk, #TI_FLAGS]
 	tst	r1, #_TIF_WORK_MASK
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index bd6f451..da11f61 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -538,6 +538,9 @@ void __init mem_init(void)
 #ifdef CONFIG_MODULES
 			"    modules : 0x%08lx - 0x%08lx   (%4ld MB)\n"
 #endif
+#ifdef CONFIG_KASAN
+			"    kasan   : 0x%08lx - 0x%08lx   (%4ld MB)\n"
+#endif
 			"      .text : 0x%p" " - 0x%p" "   (%4td kB)\n"
 			"      .init : 0x%p" " - 0x%p" "   (%4td kB)\n"
 			"      .data : 0x%p" " - 0x%p" "   (%4td kB)\n"
@@ -558,6 +561,9 @@ void __init mem_init(void)
 #ifdef CONFIG_MODULES
 			MLM(MODULES_VADDR, MODULES_END),
 #endif
+#ifdef CONFIG_KASAN
+			MLM(KASAN_SHADOW_START, KASAN_SHADOW_END),
+#endif
 
 			MLK_ROUNDUP(_text, _etext),
 			MLK_ROUNDUP(__init_begin, __init_end),
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index e46a6a4..f5aa1de 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1251,9 +1251,14 @@ static inline void prepare_page_table(void)
 	/*
 	 * Clear out all the mappings below the kernel image.
 	 */
-	for (addr = 0; addr < MODULES_VADDR; addr += PMD_SIZE)
+	for (addr = 0; addr < TASK_SIZE; addr += PMD_SIZE)
 		pmd_clear(pmd_off_k(addr));
 
+#ifdef CONFIG_KASAN
+	/*TASK_SIZE ~ MODULES_VADDR is the KASAN's shadow area -- skip over it*/
+	addr = MODULES_VADDR;
+#endif
+
 #ifdef CONFIG_XIP_KERNEL
 	/* The XIP kernel is mapped in the module area -- skip over it */
 	addr = ((unsigned long)_exiprom + PMD_SIZE - 1) & PMD_MASK;
-- 
2.9.0
