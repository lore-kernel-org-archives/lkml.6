Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751773AbeCaKgO (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 06:36:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33905 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751385AbeCaKgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 06:36:12 -0400
X-Google-Smtp-Source: AIpwx4/jbT7KfrnrJheTBkEQjZAW2ZzucwH14ZnWniBUwemoYDyES9jauCNjd3DcrHEfws5DzLq7yQ==
Date: Sat, 31 Mar 2018 12:36:08 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20180331103608.xoulw3lvokbuvdxx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: bd47a85acd727e27b7283daff557865ad04c59f6 x86/platform/UV: Fix critical UV MMR address error

Two UV platform fixes, and a kbuild fix.

 Thanks,

	Ingo

------------------>
Andrew Banman (1):
      x86/platform/uv/BAU: Add APIC idt entry

Sven Wegener (1):
      x86/purgatory: Avoid creating stray .<pid>.d files, remove -MD from KBUILD_CFLAGS

mike.travis@hpe.com (1):
      x86/platform/UV: Fix critical UV MMR address error


 arch/x86/include/asm/hw_irq.h     | 1 +
 arch/x86/include/asm/uv/uv_mmrs.h | 2 +-
 arch/x86/kernel/idt.c             | 3 +++
 arch/x86/platform/uv/tlb_uv.c     | 2 --
 arch/x86/purgatory/Makefile       | 2 +-
 5 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 2851077b6051..32e666e1231e 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -36,6 +36,7 @@ extern asmlinkage void kvm_posted_intr_wakeup_ipi(void);
 extern asmlinkage void kvm_posted_intr_nested_ipi(void);
 extern asmlinkage void error_interrupt(void);
 extern asmlinkage void irq_work_interrupt(void);
+extern asmlinkage void uv_bau_message_intr1(void);
 
 extern asmlinkage void spurious_interrupt(void);
 extern asmlinkage void thermal_interrupt(void);
diff --git a/arch/x86/include/asm/uv/uv_mmrs.h b/arch/x86/include/asm/uv/uv_mmrs.h
index ecb9ddef128f..62c79e26a59a 100644
--- a/arch/x86/include/asm/uv/uv_mmrs.h
+++ b/arch/x86/include/asm/uv/uv_mmrs.h
@@ -3833,7 +3833,7 @@ union uvh_rh_gam_mmioh_overlay_config0_mmr_u {
 #define UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR uv_undefined("UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR")
 #define UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR uv_undefined("UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR")
 #define UV3H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR 0x1603000UL
-#define UV4H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR 0x483000UL
+#define UV4H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR 0x484000UL
 #define UVH_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR (				\
 	is_uv1_hub() ? UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR :		\
 	is_uv2_hub() ? UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR :		\
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 56d99be3706a..5d039c848bd9 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -140,6 +140,9 @@ static const __initconst struct idt_data apic_idts[] = {
 # ifdef CONFIG_IRQ_WORK
 	INTG(IRQ_WORK_VECTOR,		irq_work_interrupt),
 # endif
+#ifdef CONFIG_X86_UV
+	INTG(UV_BAU_MESSAGE,		uv_bau_message_intr1),
+#endif
 	INTG(SPURIOUS_APIC_VECTOR,	spurious_interrupt),
 	INTG(ERROR_APIC_VECTOR,		error_interrupt),
 #endif
diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index db77e087adaf..b36caae0fb2f 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -2255,8 +2255,6 @@ static int __init uv_bau_init(void)
 			init_uvhub(uvhub, vector, uv_base_pnode);
 	}
 
-	alloc_intr_gate(vector, uv_bau_message_intr1);
-
 	for_each_possible_blade(uvhub) {
 		if (uv_blade_nr_possible_cpus(uvhub)) {
 			unsigned long val;
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 2f15a2ac4209..d70c15de417b 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -16,7 +16,7 @@ KCOV_INSTRUMENT := n
 # in turn leaves some undefined symbols like __fentry__ in purgatory and not
 # sure how to relocate those. Like kexec-tools, use custom flags.
 
-KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes -fno-zero-initialized-in-bss -fno-builtin -ffreestanding -c -MD -Os -mcmodel=large
+KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes -fno-zero-initialized-in-bss -fno-builtin -ffreestanding -c -Os -mcmodel=large
 KBUILD_CFLAGS += -m$(BITS)
 KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
 
