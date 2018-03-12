Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932415AbeCLODP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:03:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932332AbeCLODI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:03:08 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 3/3] x86/kvm/vmx: avoid expensive rdmsr for MSR_GS_BASE
Date: Mon, 12 Mar 2018 15:03:00 +0100
Message-Id: <20180312140300.6166-4-vkuznets@redhat.com>
In-Reply-To: <20180312140300.6166-1-vkuznets@redhat.com>
References: <20180312140300.6166-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmx_save_host_state() is only called from kvm_arch_vcpu_ioctl_run() so
the context is pretty well defined and as we're past 'swapgs' MSR_GS_BASE
should contain kernel's GS base which we point to irq_stack_union.

Add new kernelmode_gs_base() API, irq_stack_union needs to be exported
as KVM can be build as module.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/processor.h | 5 +++++
 arch/x86/kernel/cpu/common.c     | 3 ++-
 arch/x86/kvm/vmx.c               | 3 ++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 006352b85ba3..ab3d3e426a41 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -407,6 +407,11 @@ union irq_stack_union {
 DECLARE_PER_CPU_FIRST(union irq_stack_union, irq_stack_union) __visible;
 DECLARE_INIT_PER_CPU(irq_stack_union);
 
+static inline unsigned long cpu_kernelmode_gs_base(int cpu)
+{
+	return (unsigned long)per_cpu(irq_stack_union.gs_base, cpu);
+}
+
 DECLARE_PER_CPU(char *, irq_stack_ptr);
 DECLARE_PER_CPU(unsigned int, irq_count);
 extern asmlinkage void ignore_sysret(void);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 348cf4821240..4702fbd98f92 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -487,7 +487,7 @@ void load_percpu_segment(int cpu)
 	loadsegment(fs, __KERNEL_PERCPU);
 #else
 	__loadsegment_simple(gs, 0);
-	wrmsrl(MSR_GS_BASE, (unsigned long)per_cpu(irq_stack_union.gs_base, cpu));
+	wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));
 #endif
 	load_stack_canary_segment();
 }
@@ -1398,6 +1398,7 @@ __setup("clearcpuid=", setup_clearcpuid);
 #ifdef CONFIG_X86_64
 DEFINE_PER_CPU_FIRST(union irq_stack_union,
 		     irq_stack_union) __aligned(PAGE_SIZE) __visible;
+EXPORT_PER_CPU_SYMBOL_GPL(irq_stack_union);
 
 /*
  * The following percpu variables are hot.  Align current_task to
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index d4d9bb2fd91e..36cb14a121ca 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2123,6 +2123,7 @@ static unsigned long segment_base(u16 selector)
 static void vmx_save_host_state(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	int cpu = raw_smp_processor_id();
 	int i;
 
 	if (vmx->host_state.loaded)
@@ -2160,7 +2161,7 @@ static void vmx_save_host_state(struct kvm_vcpu *vcpu)
 	/* Synchronize FS and GS bases to current->thread first */
 	save_current_fsgs();
 	vmcs_writel(HOST_FS_BASE, current->thread.fsbase);
-	vmcs_writel(HOST_GS_BASE, read_msr(MSR_GS_BASE));
+	vmcs_writel(HOST_GS_BASE, cpu_kernelmode_gs_base(cpu));
 #else
 	vmcs_writel(HOST_FS_BASE, segment_base(vmx->host_state.fs_sel));
 	vmcs_writel(HOST_GS_BASE, segment_base(vmx->host_state.gs_sel));
-- 
2.14.3
