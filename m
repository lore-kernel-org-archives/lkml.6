Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932328AbeCLODI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:03:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45834 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751850AbeCLODF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:03:05 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 1/3] x86/kvm/vmx: read MSR_FS_BASE from current->thread
Date: Mon, 12 Mar 2018 15:02:58 +0100
Message-Id: <20180312140300.6166-2-vkuznets@redhat.com>
In-Reply-To: <20180312140300.6166-1-vkuznets@redhat.com>
References: <20180312140300.6166-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmx_save_host_state() is only called from kvm_arch_vcpu_ioctl_run() so
the context is pretty well defined. Read MSR_FS_BASE from
current->thread.fsbase after calling save_fsgs() which takes care of
X86_BUG_NULL_SEG case now and will do RD[FG,GS]BASE when FSGSBASE
extensions are exposed to userspace (currently they are not).

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/processor.h |  3 +++
 arch/x86/kernel/process_64.c     | 20 ++++++++++++++++++++
 arch/x86/kvm/vmx.c               |  4 +++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index b0ccd4847a58..006352b85ba3 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -410,6 +410,9 @@ DECLARE_INIT_PER_CPU(irq_stack_union);
 DECLARE_PER_CPU(char *, irq_stack_ptr);
 DECLARE_PER_CPU(unsigned int, irq_count);
 extern asmlinkage void ignore_sysret(void);
+
+/* Save actual FS/GS selectors and bases to current->thread */
+void save_current_fsgs(void);
 #else	/* X86_64 */
 #ifdef CONFIG_CC_STACKPROTECTOR
 /*
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 9eb448c7859d..eb907fefe02e 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -205,6 +205,26 @@ static __always_inline void save_fsgs(struct task_struct *task)
 	save_base_legacy(task, task->thread.gsindex, GS);
 }
 
+/*
+ * Currently, the only way for processes to change their FS/GS base is to call
+ * ARCH_SET_FS/GS prctls and these reflect changes they make in task->thread.
+ * There are, however, additional considerations:
+ *
+ * There is X86_BUG_NULL_SEG: on some CPUs writing '0' to FS/GS selectors zeroes
+ * the base and on some it doesn't, we need to check for that
+ * (see save_base_legacy()).
+ *
+ * When FSGSBASE extensions are enabled userspace processes will be able to
+ * change their FS/GS bases without kernel intervention. save_fsgs() will
+ * have to be updated to actually read FS and GS bases with RD[FG,GS]BASE
+ * instructions.
+ */
+void save_current_fsgs(void)
+{
+	save_fsgs(current);
+}
+EXPORT_SYMBOL_GPL(save_current_fsgs);
+
 static __always_inline void loadseg(enum which_selector which,
 				    unsigned short sel)
 {
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 051dab74e4e9..e46b7b24ebae 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2157,7 +2157,9 @@ static void vmx_save_host_state(struct kvm_vcpu *vcpu)
 #endif
 
 #ifdef CONFIG_X86_64
-	vmcs_writel(HOST_FS_BASE, read_msr(MSR_FS_BASE));
+	/* Synchronize FS and GS bases to current->thread first */
+	save_current_fsgs();
+	vmcs_writel(HOST_FS_BASE, current->thread.fsbase);
 	vmcs_writel(HOST_GS_BASE, read_msr(MSR_GS_BASE));
 #else
 	vmcs_writel(HOST_FS_BASE, segment_base(vmx->host_state.fs_sel));
-- 
2.14.3
