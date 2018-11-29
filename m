Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AA4C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724822082F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 724822082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbeK3CHx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:07:53 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:35004 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728787AbeK3CHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:07:52 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gSNpS-0008Nl-Ao; Thu, 29 Nov 2018 16:02:10 +0100
Date:   Thu, 29 Nov 2018 16:02:10 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 07/29 v2] x86/fpu: don't export __kernel_fpu_{begin|end}()
Message-ID: <20181129150210.2k4mawt37ow6c2vq@linutronix.de>
References: <20181128222035.2996-1-bigeasy@linutronix.de>
 <20181128222035.2996-8-bigeasy@linutronix.de>
 <da61c2af8aab3348d6fb09889b5531bec7e2f842.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <da61c2af8aab3348d6fb09889b5531bec7e2f842.camel@surriel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is one user using __kernel_fpu_begin() and before invoking it, it
invokes preempt_disable(). So it could invoke kernel_fpu_begin() right
away. The 32bit version of arch_efi_call_virt_setup() and
arch_efi_call_virt_teardown() does this already.

The comment above *kernel_fpu*() claims that before invoking
__kernel_fpu_begin() preemption should be disabled and that KVM is a
good example of doing it. Well, KVM doesn't do that since commit

  f775b13eedee2 ("x86,kvm: move qemu/guest FPU switching out to vcpu_run")

so it is not an example anymore.
With EFI gone as the last user of __kernel_fpu_{begin|end}(), it can be
made static and not exported anymore.

Reviewed-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1…v2: `carefull' -> `careful'

 arch/x86/include/asm/efi.h     |  6 ++----
 arch/x86/include/asm/fpu/api.h | 16 ++++++----------
 arch/x86/kernel/fpu/core.c     |  6 ++----
 3 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index eea40d52ca785..45864898f7e50 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -82,8 +82,7 @@ struct efi_scratch {
 #define arch_efi_call_virt_setup()					\
 ({									\
 	efi_sync_low_kernel_mappings();					\
-	preempt_disable();						\
-	__kernel_fpu_begin();						\
+	kernel_fpu_begin();						\
 	firmware_restrict_branch_speculation_start();			\
 									\
 	if (!efi_enabled(EFI_OLD_MEMMAP))				\
@@ -99,8 +98,7 @@ struct efi_scratch {
 		efi_switch_mm(efi_scratch.prev_mm);			\
 									\
 	firmware_restrict_branch_speculation_end();			\
-	__kernel_fpu_end();						\
-	preempt_enable();						\
+	kernel_fpu_end();						\
 })
 
 extern void __iomem *__init efi_ioremap(unsigned long addr, unsigned long size,
diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index a9caac9d4a729..e368d8d94ca68 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -12,17 +12,13 @@
 #define _ASM_X86_FPU_API_H
 
 /*
- * Careful: __kernel_fpu_begin/end() must be called with preempt disabled
- * and they don't touch the preempt state on their own.
- * If you enable preemption after __kernel_fpu_begin(), preempt notifier
- * should call the __kernel_fpu_end() to prevent the kernel/user FPU
- * state from getting corrupted. KVM for example uses this model.
- *
- * All other cases use kernel_fpu_begin/end() which disable preemption
- * during kernel FPU usage.
+ * Use kernel_fpu_begin/end() if you intend to use FPU in kernel context. It
+ * disables preemption so be careful if you intend to use it for long periods
+ * of time.
+ * If you intend to use the FPU in softirq you need to check first with
+ * irq_fpu_usable() if it is possible.
+ * Using the FPU in hardirq is not allowed.
  */
-extern void __kernel_fpu_begin(void);
-extern void __kernel_fpu_end(void);
 extern void kernel_fpu_begin(void);
 extern void kernel_fpu_end(void);
 extern bool irq_fpu_usable(void);
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 2ea85b32421a0..2e5003fef51a9 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -93,7 +93,7 @@ bool irq_fpu_usable(void)
 }
 EXPORT_SYMBOL(irq_fpu_usable);
 
-void __kernel_fpu_begin(void)
+static void __kernel_fpu_begin(void)
 {
 	struct fpu *fpu = &current->thread.fpu;
 
@@ -111,9 +111,8 @@ void __kernel_fpu_begin(void)
 		__cpu_invalidate_fpregs_state();
 	}
 }
-EXPORT_SYMBOL(__kernel_fpu_begin);
 
-void __kernel_fpu_end(void)
+static void __kernel_fpu_end(void)
 {
 	struct fpu *fpu = &current->thread.fpu;
 
@@ -122,7 +121,6 @@ void __kernel_fpu_end(void)
 
 	kernel_fpu_enable();
 }
-EXPORT_SYMBOL(__kernel_fpu_end);
 
 void kernel_fpu_begin(void)
 {
-- 
2.20.0.rc1

