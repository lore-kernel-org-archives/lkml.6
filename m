Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F363C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43692087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43692087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbeLDLqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:46:18 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41709 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeLDLqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:46:18 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wB4BjqXB849064
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 4 Dec 2018 03:45:52 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wB4BjqkY849061;
        Tue, 4 Dec 2018 03:45:52 -0800
Date:   Tue, 4 Dec 2018 03:45:52 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-12209993e98c5fa1855c467f22a24e3d5b8be205@git.kernel.org>
Cc:     Jason@zx2c4.com, hpa@zytor.com, luto@kernel.org,
        rkrcmar@redhat.com, pbonzini@redhat.com, mingo@redhat.com,
        dave.hansen@linux.intel.com, riel@surriel.com,
        ard.biesheuvel@linaro.org, nstange@suse.de,
        linux-efi@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, bp@suse.de, tglx@linutronix.de
Reply-To: riel@surriel.com, dave.hansen@linux.intel.com, Jason@zx2c4.com,
          hpa@zytor.com, luto@kernel.org, rkrcmar@redhat.com,
          mingo@redhat.com, pbonzini@redhat.com,
          linux-kernel@vger.kernel.org, bigeasy@linutronix.de, bp@suse.de,
          tglx@linutronix.de, ard.biesheuvel@linaro.org, nstange@suse.de,
          linux-efi@vger.kernel.org, mingo@kernel.org, x86@kernel.org,
          kvm@vger.kernel.org
In-Reply-To: <20181129150210.2k4mawt37ow6c2vq@linutronix.de>
References: <20181129150210.2k4mawt37ow6c2vq@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Don't export __kernel_fpu_{begin,end}()
Git-Commit-ID: 12209993e98c5fa1855c467f22a24e3d5b8be205
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

Commit-ID:  12209993e98c5fa1855c467f22a24e3d5b8be205
Gitweb:     https://git.kernel.org/tip/12209993e98c5fa1855c467f22a24e3d5b8be205
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Thu, 29 Nov 2018 16:02:10 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 4 Dec 2018 12:37:28 +0100

x86/fpu: Don't export __kernel_fpu_{begin,end}()

There is one user of __kernel_fpu_begin() and before invoking it,
it invokes preempt_disable(). So it could invoke kernel_fpu_begin()
right away. The 32bit version of arch_efi_call_virt_setup() and
arch_efi_call_virt_teardown() does this already.

The comment above *kernel_fpu*() claims that before invoking
__kernel_fpu_begin() preemption should be disabled and that KVM is a
good example of doing it. Well, KVM doesn't do that since commit

  f775b13eedee2 ("x86,kvm: move qemu/guest FPU switching out to vcpu_run")

so it is not an example anymore.

With EFI gone as the last user of __kernel_fpu_{begin|end}(), both can
be made static and not exported anymore.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Rik van Riel <riel@surriel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kvm ML <kvm@vger.kernel.org>
Cc: linux-efi <linux-efi@vger.kernel.org>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20181129150210.2k4mawt37ow6c2vq@linutronix.de
---
 arch/x86/include/asm/efi.h     |  6 ++----
 arch/x86/include/asm/fpu/api.h | 15 +++++----------
 arch/x86/kernel/fpu/core.c     |  6 ++----
 3 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index eea40d52ca78..45864898f7e5 100644
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
index a9caac9d4a72..b56d504af654 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -12,17 +12,12 @@
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
  */
-extern void __kernel_fpu_begin(void);
-extern void __kernel_fpu_end(void);
 extern void kernel_fpu_begin(void);
 extern void kernel_fpu_end(void);
 extern bool irq_fpu_usable(void);
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 2ea85b32421a..2e5003fef51a 100644
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
