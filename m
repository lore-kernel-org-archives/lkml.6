Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BA1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F89120661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F89120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbeGTWcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 18:32:13 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35514 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbeGTWcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 18:32:12 -0400
Received: by mail-qt0-f196.google.com with SMTP id a5-v6so11582701qtp.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 14:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/Ld8wjs7KxCcl4zSvDzg4dEg33msapg+r54ggPPmxJE=;
        b=EXGjTE3dv6v6+5VGRI8o8lIjRFY+SB5W8jqOUdi3z/UQK7K6Mt1Y36TceAGycpDSL9
         T08eLATpSbTaC6+ktRlCt+1R1IvlX3UKYh3jpleUM8MmJQjt9H/4YuHmhg75tgX6jyj8
         yYWpYP0GCNSsnlMvy75W82WGqRu1gpdpnEqXXMQoeCekekGCLp8OGbk1KiV+ZwrqeshK
         oIbTyngZ1v3eVWeFg+Egc/E3ch9rfXexPFkRvLuDUZDrM9wQU12GXZjkaCdua4OZNFbw
         T02fL/ZoMLObyrISzf/0DlQhHfM2sCtbS6DpNbtiSQD+aWtMKOJ+svRLB/j8ITpAKe+s
         MRhQ==
X-Gm-Message-State: AOUpUlH39J8gXSd8cX605YEPZQjR+h8o4g6TXMox3kxj9TodRsgxdAOI
        ZcFn0f9r4iBfUXWGPylDI1Ioyw==
X-Google-Smtp-Source: AAOMgpdx042QU1GVq03zrlVrCyYBd8zFqUiWqivAoWS4XAt63fvec3sIQj334MqaUS78TFAVLa0QNg==
X-Received: by 2002:ac8:42b:: with SMTP id v43-v6mr3455714qtg.319.1532122924952;
        Fri, 20 Jul 2018 14:42:04 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc:4eb2:6dae:ab32:e5b0])
        by smtp.gmail.com with ESMTPSA id r4-v6sm1617385qtm.10.2018.07.20.14.42.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 14:42:03 -0700 (PDT)
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
Subject: [PATCHv3 2/2] arm64: Add support for STACKLEAK gcc plugin
Date:   Fri, 20 Jul 2018 14:41:54 -0700
Message-Id: <20180720214154.2940-3-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180720214154.2940-1-labbott@redhat.com>
References: <20180720214154.2940-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This adds support for the STACKLEAK gcc plugin to arm64 by implementing
stackleak_check_alloca(), based heavily on the x86 version, and adding the
two helpers used by the stackleak common code: current_top_of_stack() and
on_thread_stack(). The stack erasure calls are made at syscall returns.
Additionally, this disables the plugin in hypervisor and EFI stub code,
which are out of scope for the protection.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: Actual commit text courtesy of Kees. A comment explaining why we
panic
---
 arch/arm64/Kconfig                    |  1 +
 arch/arm64/include/asm/processor.h    | 15 +++++++++++++++
 arch/arm64/kernel/entry.S             |  7 +++++++
 arch/arm64/kernel/process.c           | 22 ++++++++++++++++++++++
 arch/arm64/kvm/hyp/Makefile           |  3 ++-
 drivers/firmware/efi/libstub/Makefile |  3 ++-
 6 files changed, 49 insertions(+), 2 deletions(-)

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
index e10bc363f533..f0ad00fb6a71 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -493,3 +493,25 @@ void arch_setup_new_exec(void)
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
+	/*
+	 * There's a good chance we're almost out of stack space if this
+	 * is true. Using panic() over BUG() is more likely to give
+	 * reliable debugging output.
+	 */
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

