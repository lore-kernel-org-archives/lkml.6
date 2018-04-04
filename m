Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbeDDQ76 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 12:59:58 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37236 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752070AbeDDQ74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 12:59:56 -0400
X-Google-Smtp-Source: AIpwx4/Kmxff1EfcSQiCQMlZ35yigqYVDEhVHYULESGH1MO9xYn5Od2G5/a19MZ2snRtA3YNG8/5Sg==
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH] KVM: vmx: unify adjacent #ifdefs
Date: Wed,  4 Apr 2018 18:59:22 +0200
Message-Id: <1522861162-47491-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmx_save_host_state has multiple ifdefs for CONFIG_X86_64 that have
no other code between them.  Simplify by reducing them to a single
conditional.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 939c8724feb4..a1572461786e 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2392,20 +2392,16 @@ static void vmx_save_host_state(struct kvm_vcpu *vcpu)
 #ifdef CONFIG_X86_64
 	savesegment(ds, vmx->host_state.ds_sel);
 	savesegment(es, vmx->host_state.es_sel);
-#endif
 
-#ifdef CONFIG_X86_64
 	vmcs_writel(HOST_FS_BASE, current->thread.fsbase);
 	vmcs_writel(HOST_GS_BASE, cpu_kernelmode_gs_base(cpu));
-#else
-	vmcs_writel(HOST_FS_BASE, segment_base(vmx->host_state.fs_sel));
-	vmcs_writel(HOST_GS_BASE, segment_base(vmx->host_state.gs_sel));
-#endif
 
-#ifdef CONFIG_X86_64
 	vmx->msr_host_kernel_gs_base = current->thread.gsbase;
 	if (is_long_mode(&vmx->vcpu))
 		wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
+#else
+	vmcs_writel(HOST_FS_BASE, segment_base(vmx->host_state.fs_sel));
+	vmcs_writel(HOST_GS_BASE, segment_base(vmx->host_state.gs_sel));
 #endif
 	if (boot_cpu_has(X86_FEATURE_MPX))
 		rdmsrl(MSR_IA32_BNDCFGS, vmx->host_state.msr_host_bndcfgs);
-- 
1.8.3.1
