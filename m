Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeCMRsN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:48:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932508AbeCMRsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:48:10 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 1/2] x86/kvm/vmx: read MSR_{FS,KERNEL_GS}_BASE from current->thread
Date: Tue, 13 Mar 2018 18:48:04 +0100
Message-Id: <20180313174805.11825-2-vkuznets@redhat.com>
In-Reply-To: <20180313174805.11825-1-vkuznets@redhat.com>
References: <20180313174805.11825-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmx_save_host_state() is only called from kvm_arch_vcpu_ioctl_run() so
the context is pretty well defined. Read MSR_{FS,KERNEL_GS}_BASE from
current->thread after calling save_fsgs() which takes care of
X86_BUG_NULL_SEG case now and will do RD[FG,GS]BASE when FSGSBASE
extensions are exposed to userspace (currently they are not).

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/processor.h |  5 +++++
 arch/x86/kernel/process_64.c     | 14 ++++++++++++++
 arch/x86/kvm/vmx.c               | 13 ++++++++++---
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index b0ccd4847a58..1d816a3325a1 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -410,6 +410,11 @@ DECLARE_INIT_PER_CPU(irq_stack_union);
 DECLARE_PER_CPU(char *, irq_stack_ptr);
 DECLARE_PER_CPU(unsigned int, irq_count);
 extern asmlinkage void ignore_sysret(void);
+
+#if IS_ENABLED(CONFIG_KVM)
+/* Save actual FS/GS selectors and bases to current->thread */
+void save_fsgs_for_kvm(void);
+#endif
 #else	/* X86_64 */
 #ifdef CONFIG_CC_STACKPROTECTOR
 /*
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 9eb448c7859d..4b100fe0f508 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -205,6 +205,20 @@ static __always_inline void save_fsgs(struct task_struct *task)
 	save_base_legacy(task, task->thread.gsindex, GS);
 }
 
+#if IS_ENABLED(CONFIG_KVM)
+/*
+ * While a process is running,current->thread.fsbase and current->thread.gsbase
+ * may not match the corresponding CPU registers (see save_base_legacy()). KVM
+ * wants an efficient way to save and restore FSBASE and GSBASE.
+ * When FSGSBASE extensions are enabled, this will have to use RD{FS,GS}BASE.
+ */
+void save_fsgs_for_kvm(void)
+{
+	save_fsgs(current);
+}
+EXPORT_SYMBOL_GPL(save_fsgs_for_kvm);
+#endif
+
 static __always_inline void loadseg(enum which_selector which,
 				    unsigned short sel)
 {
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 051dab74e4e9..189a347f3952 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2135,7 +2135,15 @@ static void vmx_save_host_state(struct kvm_vcpu *vcpu)
 	 */
 	vmx->host_state.ldt_sel = kvm_read_ldt();
 	vmx->host_state.gs_ldt_reload_needed = vmx->host_state.ldt_sel;
+
+#ifdef CONFIG_X86_64
+	save_fsgs_for_kvm();
+	vmx->host_state.fs_sel = current->thread.fsindex;
+	vmx->host_state.gs_sel = current->thread.gsindex;
+#else
 	savesegment(fs, vmx->host_state.fs_sel);
+	savesegment(gs, vmx->host_state.gs_sel);
+#endif
 	if (!(vmx->host_state.fs_sel & 7)) {
 		vmcs_write16(HOST_FS_SELECTOR, vmx->host_state.fs_sel);
 		vmx->host_state.fs_reload_needed = 0;
@@ -2143,7 +2151,6 @@ static void vmx_save_host_state(struct kvm_vcpu *vcpu)
 		vmcs_write16(HOST_FS_SELECTOR, 0);
 		vmx->host_state.fs_reload_needed = 1;
 	}
-	savesegment(gs, vmx->host_state.gs_sel);
 	if (!(vmx->host_state.gs_sel & 7))
 		vmcs_write16(HOST_GS_SELECTOR, vmx->host_state.gs_sel);
 	else {
@@ -2157,7 +2164,7 @@ static void vmx_save_host_state(struct kvm_vcpu *vcpu)
 #endif
 
 #ifdef CONFIG_X86_64
-	vmcs_writel(HOST_FS_BASE, read_msr(MSR_FS_BASE));
+	vmcs_writel(HOST_FS_BASE, current->thread.fsbase);
 	vmcs_writel(HOST_GS_BASE, read_msr(MSR_GS_BASE));
 #else
 	vmcs_writel(HOST_FS_BASE, segment_base(vmx->host_state.fs_sel));
@@ -2165,7 +2172,7 @@ static void vmx_save_host_state(struct kvm_vcpu *vcpu)
 #endif
 
 #ifdef CONFIG_X86_64
-	rdmsrl(MSR_KERNEL_GS_BASE, vmx->msr_host_kernel_gs_base);
+	vmx->msr_host_kernel_gs_base = current->thread.gsbase;
 	if (is_long_mode(&vmx->vcpu))
 		wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
 #endif
-- 
2.14.3
