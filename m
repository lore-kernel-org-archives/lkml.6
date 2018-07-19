Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B00ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B71F2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B71F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbeGTANm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:13:42 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38843 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731398AbeGTANl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:13:41 -0400
Received: by mail-qt0-f194.google.com with SMTP id y19-v6so8796441qto.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 16:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gN8QL/Y11A7E6FhcHbLbCidBJaN3nqe2yD2uQB8Up3Q=;
        b=rEwunnlTBAOB1IRIUrhbgKkxwPw+rOTTxqpx76dLYyP5DRnf9bKME2Sld+aYOdvDar
         OP+7P584r4+v7JjHl22JSZPTL62aZS2RSkbX6rkje/yDcrvdGREzx7kzuPGLY1N0AtcI
         70JPEx1IDEKg9y0SUt+Ss/xDRYmHW3YyoF5UNwhrgxMRD5hsDwbz/ASgh3fPr5C8jO8S
         +9qvfT1GaPfEXIGir+lXEqiilCN0VDWHIKf4pEvSObTRwGjOkpPHdzgHxA/k3ypwzHGF
         VTo8K8EJS9NifmQ80APRu/XaC7lJnvg77Vj6EODXo8igebGuBCqGA/IpAyBuZov/ouuq
         WFzQ==
X-Gm-Message-State: AOUpUlE2ZY1lt54OmhOyGdnyGqS956RwpIRCcnM4n6fuMkQkAytS04jj
        7QnhSDHly4SJHEvG6Y4Iynm6Gw==
X-Google-Smtp-Source: AAOMgpeENeJlWCbP9LStrn6WbJsxLuOQmabTiD2Wpd5UEKVOSqTSuEMDpYJcOE6qksHsR0zQRWMRbg==
X-Received: by 2002:a0c:d8d8:: with SMTP id w24-v6mr7599521qvj.49.1532042898149;
        Thu, 19 Jul 2018 16:28:18 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc:4eb2:6dae:ab32:e5b0])
        by smtp.gmail.com with ESMTPSA id f70-v6sm258205qke.77.2018.07.19.16.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 16:28:17 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Alexander Popov <alex.popov@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCHv2 2/2] arm64: Clear the stack
Date:   Thu, 19 Jul 2018 16:28:06 -0700
Message-Id: <20180719232806.3397-3-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180719232806.3397-1-labbott@redhat.com>
References: <20180719232806.3397-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implementation of stackleak based heavily on the x86 version

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v2: Convert to adjusted on_acessible_stack APIs. Fixed alloca check to
just panic. Dropped the extra include per Kees. I also didn't add the
Reviewed-by since the APIs did change and I wanted another pass.
---
 arch/arm64/Kconfig                    |  1 +
 arch/arm64/include/asm/processor.h    | 15 +++++++++++++++
 arch/arm64/kernel/entry.S             |  7 +++++++
 arch/arm64/kernel/process.c           | 17 +++++++++++++++++
 arch/arm64/kvm/hyp/Makefile           |  3 ++-
 drivers/firmware/efi/libstub/Makefile |  3 ++-
 6 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 42c090cf0292..216d36a49ab5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -96,6 +96,7 @@ config ARM64
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
 	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ARCH_STACKLEAK
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index a73ae1e49200..0061450a793b 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -266,5 +266,20 @@ extern void __init minsigstksz_setup(void);
 #define SVE_SET_VL(arg)	sve_set_current_vl(arg)
 #define SVE_GET_VL()	sve_get_current_vl()
 
+/*
+ * For CONFIG_GCC_PLUGIN_STACKLEAK
+ *
+ * These need to be macros because otherwise we get stuck in a nightmare
+ * of header definitions for the use of task_stack_page.
+ */
+
+#define current_top_of_stack()							\
+({										\
+	struct stack_info _info;						\
+	BUG_ON(!on_accessible_stack(current, current_stack_pointer, &_info));	\
+	_info.high;								\
+})
+#define on_thread_stack()	(on_task_stack(current, current_stack_pointer, NULL))
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_PROCESSOR_H */
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 28ad8799406f..67d12016063d 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -431,6 +431,11 @@ tsk	.req	x28		// current thread_info
 
 	.text
 
+	.macro	stackleak_erase
+#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+	bl	stackleak_erase
+#endif
+	.endm
 /*
  * Exception vectors.
  */
@@ -910,6 +915,7 @@ ret_fast_syscall:
 	and	x2, x1, #_TIF_WORK_MASK
 	cbnz	x2, work_pending
 	enable_step_tsk x1, x2
+	stackleak_erase
 	kernel_exit 0
 ret_fast_syscall_trace:
 	enable_daif
@@ -936,6 +942,7 @@ ret_to_user:
 	cbnz	x2, work_pending
 finish_ret_to_user:
 	enable_step_tsk x1, x2
+	stackleak_erase
 	kernel_exit 0
 ENDPROC(ret_to_user)
 
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index e10bc363f533..2724e4d31b16 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -493,3 +493,20 @@ void arch_setup_new_exec(void)
 {
 	current->mm->context.flags = is_compat_task() ? MMCF_AARCH32 : 0;
 }
+
+#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+void __used stackleak_check_alloca(unsigned long size)
+{
+	unsigned long stack_left;
+	unsigned long current_sp = current_stack_pointer;
+	struct stack_info info;
+
+	BUG_ON(!on_accessible_stack(current, current_sp, &info));
+
+	stack_left = current_sp - info.low;
+
+	if (size >= stack_left)
+		panic("alloca() over the kernel stack boundary\n");
+}
+EXPORT_SYMBOL(stackleak_check_alloca);
+#endif
diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index 4313f7475333..2fabc2dc1966 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -3,7 +3,8 @@
 # Makefile for Kernel-based Virtual Machine module, HYP part
 #
 
-ccflags-y += -fno-stack-protector -DDISABLE_BRANCH_PROFILING
+ccflags-y += -fno-stack-protector -DDISABLE_BRANCH_PROFILING \
+		$(DISABLE_STACKLEAK_PLUGIN)
 
 KVM=../../../../virt/kvm
 
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index a34e9290a699..25dd2a14560d 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -20,7 +20,8 @@ cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
 KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
 				   -D__NO_FORTIFY \
 				   $(call cc-option,-ffreestanding) \
-				   $(call cc-option,-fno-stack-protector)
+				   $(call cc-option,-fno-stack-protector) \
+				   $(DISABLE_STACKLEAK_PLUGIN)
 
 GCOV_PROFILE			:= n
 KASAN_SANITIZE			:= n
-- 
2.17.1

