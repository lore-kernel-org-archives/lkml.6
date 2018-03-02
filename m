Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426767AbeCBKz7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 05:55:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1426720AbeCBKzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 05:55:11 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH RFC 3/3] x86/kvm/vmx: avoid expensive rdmsr for MSR_GS_BASE
Date: Fri,  2 Mar 2018 11:55:03 +0100
Message-Id: <20180302105503.24428-4-vkuznets@redhat.com>
In-Reply-To: <20180302105503.24428-1-vkuznets@redhat.com>
References: <20180302105503.24428-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmx_save_host_state() is only called from kvm_arch_vcpu_ioctl_run() so
the context is pretty well defined and as we're past 'swapgs' MSR_GS_BASE
should contain kernel's GS base which we point to irq_stack_union.

irq_stack_union needs to be exported as KVM can be a module.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kernel/cpu/common.c | 1 +
 arch/x86/kvm/vmx.c           | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 348cf4821240..057393711093 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1398,6 +1398,7 @@ __setup("clearcpuid=", setup_clearcpuid);
 #ifdef CONFIG_X86_64
 DEFINE_PER_CPU_FIRST(union irq_stack_union,
 		     irq_stack_union) __aligned(PAGE_SIZE) __visible;
+EXPORT_PER_CPU_SYMBOL(irq_stack_union);
 
 /*
  * The following percpu variables are hot.  Align current_task to
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 5be34d13d88f..bf856b7ece3f 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2158,7 +2158,8 @@ static void vmx_save_host_state(struct kvm_vcpu *vcpu)
 
 #ifdef CONFIG_X86_64
 	vmcs_writel(HOST_FS_BASE, current->thread.fsbase);
-	vmcs_writel(HOST_GS_BASE, read_msr(MSR_GS_BASE));
+	vmcs_writel(HOST_GS_BASE, (unsigned long)
+		    per_cpu(irq_stack_union.gs_base, smp_processor_id()));
 #else
 	vmcs_writel(HOST_FS_BASE, segment_base(vmx->host_state.fs_sel));
 	vmcs_writel(HOST_GS_BASE, segment_base(vmx->host_state.gs_sel));
-- 
2.14.3
