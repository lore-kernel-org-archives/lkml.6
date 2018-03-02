Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426781AbeCBK5B (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 05:57:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1426710AbeCBKzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 05:55:10 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH RFC 2/3] x86/kvm/vmx: read MSR_KERNEL_GS_BASE from current->thread
Date: Fri,  2 Mar 2018 11:55:02 +0100
Message-Id: <20180302105503.24428-3-vkuznets@redhat.com>
In-Reply-To: <20180302105503.24428-1-vkuznets@redhat.com>
References: <20180302105503.24428-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmx_save_host_state() is only called from kvm_arch_vcpu_ioctl_run() so
the context is pretty well defined and as we're past 'swapgs'
MSR_KERNEL_GS_BASE should be current->thread.gsbase.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index ddefb7aeb96d..5be34d13d88f 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2165,7 +2165,7 @@ static void vmx_save_host_state(struct kvm_vcpu *vcpu)
 #endif
 
 #ifdef CONFIG_X86_64
-	rdmsrl(MSR_KERNEL_GS_BASE, vmx->msr_host_kernel_gs_base);
+	vmx->msr_host_kernel_gs_base = current->thread.gsbase;
 	if (is_long_mode(&vmx->vcpu))
 		wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
 #endif
-- 
2.14.3
