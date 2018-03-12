Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932482AbeCLOES (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:04:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45846 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751985AbeCLODG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:03:06 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 2/3] x86/kvm/vmx: read MSR_KERNEL_GS_BASE from current->thread
Date: Mon, 12 Mar 2018 15:02:59 +0100
Message-Id: <20180312140300.6166-3-vkuznets@redhat.com>
In-Reply-To: <20180312140300.6166-1-vkuznets@redhat.com>
References: <20180312140300.6166-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmx_save_host_state() is only called from kvm_arch_vcpu_ioctl_run() so
the context is pretty well defined and as we're past 'swapgs'
MSR_KERNEL_GS_BASE is equal to current->thread.gsbase (after previous
save_current_fsgs() call).

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index e46b7b24ebae..d4d9bb2fd91e 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2167,7 +2167,7 @@ static void vmx_save_host_state(struct kvm_vcpu *vcpu)
 #endif
 
 #ifdef CONFIG_X86_64
-	rdmsrl(MSR_KERNEL_GS_BASE, vmx->msr_host_kernel_gs_base);
+	vmx->msr_host_kernel_gs_base = current->thread.gsbase;
 	if (is_long_mode(&vmx->vcpu))
 		wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
 #endif
-- 
2.14.3
