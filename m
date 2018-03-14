Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeCNRUb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:20:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751381AbeCNRU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:20:29 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
        x86@kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] x86/kvm: use Enlightened VMCS when running on Hyper-V
References: <20180309140249.2840-1-vkuznets@redhat.com>
        <20180309140249.2840-8-vkuznets@redhat.com>
        <alpine.DEB.2.21.1803091507300.1364@nanos.tec.linutronix.de>
        <87r2opcr6u.fsf@vitty.brq.redhat.com> <20180313191242.GB13426@flask>
Date: Wed, 14 Mar 2018 18:20:25 +0100
In-Reply-To: <20180313191242.GB13426@flask> ("Radim \=\?utf-8\?B\?S3LEjW3DocWZ\?\=
 \=\?utf-8\?B\?Iidz\?\= message of "Tue,
        13 Mar 2018 20:12:42 +0100")
Message-ID: <87r2ombmli.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Radim Krčmář <rkrcmar@redhat.com> writes:

> 2018-03-12 15:19+0100, Vitaly Kuznetsov:
>> 
>> That said I'd like to defer the question to KVM maintainers: Paolo,
>> Radim, what would you like me to do? Use STATIC_JUMP_IF_TRUE/FALSE as
>> they are, try to make them work for !HAVE_JUMP_LABEL and use them or
>> maybe we can commit the series as-is and have it as a future
>> optimization (e.g. when HAVE_JUMP_LABEL becomes mandatory)?
>
> Please take a look into making a macro that uses STATIC_JUMP_IF_FALSE or
> reads the value from provided static_key and does a test-jump, depending
> on HAVE_JUMP_LABEL.
> It doesn't need to be suited for general use, just something that moves
> the ugliness away from vmx_vcpu_run.
> (Although having it in jump_label.h would be great. I think the main
>  obstacle is clobbering of flags.)
>

The other problem is that we actually have inline assembly and I'm not
sure how to use .macros from '#ifdef __ASSEMBLY__' sections there ...

anyway, I tried using the jump label magic and I ended up with the
following:

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 44b6efa7d54e..fb15ccf260fb 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9932,10 +9932,26 @@ static void vmx_arm_hv_timer(struct kvm_vcpu *vcpu)
 	vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, delta_tsc);
 }
 
+#ifdef HAVE_JUMP_LABEL
+#define STATIC_CHECK_EVMCS_INUSE(label, key)				\
+	".Lstatic_evmcs:\n\t"						\
+	".byte 0xe9\n\t"						\
+	".long " #label " - .Lstatic_evmcs_after\n\t"			\
+	".Lstatic_evmcs_after:\n"					\
+	".pushsection __jump_table,  \"aw\" \n\t" 			\
+	_ASM_ALIGN "\n\t"						\
+	_ASM_PTR ".Lstatic_evmcs, " #label ", %c[" #key "] + 1 \n\t"	\
+	".popsection \n\t"
+#else
+#define STATIC_CHECK_EVMCS_INUSE(label, key)				\
+	"cmpl $0, (%c[" #key "])\n\t"					\
+	"je " #label "\n\t"
+#endif
+
 static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	unsigned long cr3, cr4, evmcs_rsp;
+	unsigned long cr3, cr4;
 
 	/* Record the guest's net vcpu time for enforced NMI injections. */
 	if (unlikely(!enable_vnmi &&
@@ -10002,9 +10018,6 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 
 	vmx->__launched = vmx->loaded_vmcs->launched;
 
-	evmcs_rsp = static_branch_unlikely(&enable_evmcs) ?
-		(unsigned long)&current_evmcs->host_rsp : 0;
-
 	asm(
 		/* Store host registers */
 		"push %%" _ASM_DX "; push %%" _ASM_BP ";"
@@ -10013,12 +10026,11 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		"cmp %%" _ASM_SP ", %c[host_rsp](%0) \n\t"
 		"je 1f \n\t"
 		"mov %%" _ASM_SP ", %c[host_rsp](%0) \n\t"
-		/* Avoid VMWRITE when Enlightened VMCS is in use */
-		"test %%" _ASM_SI ", %%" _ASM_SI " \n\t"
-		"jz 2f \n\t"
-		"mov %%" _ASM_SP ", (%%" _ASM_SI ") \n\t"
+		/* Avoid VMWRITE to HOST_SP when Enlightened VMCS is in use */
+		STATIC_CHECK_EVMCS_INUSE(.Lvmwrite_sp, enable_evmcs)
+		"mov %%" _ASM_SP ", %c[evmcs_hrsp](%2) \n\t"
 		"jmp 1f \n\t"
-		"2: \n\t"
+		".Lvmwrite_sp: \n\t"
 		__ex(ASM_VMX_VMWRITE_RSP_RDX) "\n\t"
 		"1: \n\t"
 		/* Reload cr2 if changed */
@@ -10096,10 +10108,12 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		".global vmx_return \n\t"
 		"vmx_return: " _ASM_PTR " 2b \n\t"
 		".popsection"
-	      : : "c"(vmx), "d"((unsigned long)HOST_RSP), "S"(evmcs_rsp),
+	      : : "c"(vmx), "d"((unsigned long)HOST_RSP), "S"(current_evmcs),
+		[enable_evmcs]"i"(&enable_evmcs),
 		[launched]"i"(offsetof(struct vcpu_vmx, __launched)),
 		[fail]"i"(offsetof(struct vcpu_vmx, fail)),
 		[host_rsp]"i"(offsetof(struct vcpu_vmx, host_rsp)),
+		[evmcs_hrsp]"i"(offsetof(struct hv_enlightened_vmcs, host_rsp)),
 		[rax]"i"(offsetof(struct vcpu_vmx, vcpu.arch.regs[VCPU_REGS_RAX])),
 		[rbx]"i"(offsetof(struct vcpu_vmx, vcpu.arch.regs[VCPU_REGS_RBX])),
 		[rcx]"i"(offsetof(struct vcpu_vmx, vcpu.arch.regs[VCPU_REGS_RCX])),

What I particularly dislike is that we now depend on jump labels
internals. Generalizing this hack doesn't seem practical as
non-HAVE_JUMP_LABEL path cloobbers FLAGS and requiring users to know
that is cumbersome...

I'd say 'too ugly' but I can continue investigating if there're fresh ideas.

-- 
  Vitaly
