Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA063C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9427E20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbfAOQeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:34:18 -0500
Received: from mga02.intel.com ([134.134.136.20]:17790 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728257AbfAOQeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:34:18 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2019 08:34:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,481,1539673200"; 
   d="scan'208";a="116946713"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jan 2019 08:34:16 -0800
Date:   Tue, 15 Jan 2019 08:34:16 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Qian Cai <cai@lca.pw>, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kvm: add proper frame pointer logic for vmx
Message-ID: <20190115163416.GA21622@linux.intel.com>
References: <20190115064459.70513-1-cai@lca.pw>
 <a6477022-bbc0-fc00-2c8e-75007b468d3f@lca.pw>
 <5109b3c2-cac0-aa19-9cc7-801340afe198@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5109b3c2-cac0-aa19-9cc7-801340afe198@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 08:13:22AM +0100, Paolo Bonzini wrote:
> On 15/01/19 08:04, Qian Cai wrote:
> > 
> > 
> > On 1/15/19 1:44 AM, Qian Cai wrote:
> >> compilation warning since v5.0-rc1,
> >>
> >> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_vcpu_run.part.17()+0x3171:
> >> call without frame pointer save/setup

The warning is complaining about vmx_vcpu_run() in vmx.c, not vmenter.S.
The rule being "broken" is that a call is made without creating a stack
frame, and vmx_vmenter() obviously makes no calls.

E.g., manually running objtool check:

    $ tools/objtool/objtool check arch/x86/kvm/vmx/vmenter.o
    $ tools/objtool/objtool check arch/x86/kvm/vmx/vmx.o
    arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_vcpu_run.part.19()+0x83e: call without frame pointer save/setup

I put "broken" in quotes because AFAICT we're not actually violating the
rule.  From tools/objtool/Documentation/stack-validation.txt:

   If it's a GCC-compiled .c file, the error may be because the function
   uses an inline asm() statement which has a "call" instruction.  An
   asm() statement with a call instruction must declare the use of the
   stack pointer in its output operand.  On x86_64, this means adding
   the ASM_CALL_CONSTRAINT as an output constraint:

     asm volatile("call func" : ASM_CALL_CONSTRAINT);

   Otherwise the stack frame may not get created before the call.


The asm() blob that calls vmx_vmenter() uses ASM_CALL_CONSTRAINT, and
the resulting asm output generates a frame pointer, e.g. this is from
the vmx.o that objtool warns on:

Dump of assembler code for function vmx_vcpu_run:
   0x0000000000007440 <+0>:     e8 00 00 00 00  callq  0x7445 <vmx_vcpu_run+5>
   0x0000000000007445 <+5>:     55      push   %rbp
   0x0000000000007446 <+6>:     48 89 e5        mov    %rsp,%rbp


The warning only shows up in certain configs, e.g. I was only able to
reproduce this using the .config provided by lkp.  Even explicitly
enabling CONFIG_FRAME_POINTERS and CONFIG_STACK_VALIDATION didn't
trigger the warning using my usual config.

And all that being said, I'm pretty sure this isn't related to the call
to vmx_vmenter() at all, but rather is something that was exposed by
removing __noclone from vmx_vcpu_run().

E.g. I still get the warning if I comment out the call to vmx_vmenter,
it just shifts to something else (and continues to shift I comment out
more calls).  The warning goes away if I re-add __noclone, regardless
of whether or not commit 2bcbd406715d ("Revert "compiler-gcc: disable
-ftracer for __noclone functions"") is applied.

0x6659 is in vmx_vcpu_run (./arch/x86/include/asm/spec-ctrl.h:43).
38       * Avoids writing to the MSR if the content/bits are the same
39       */
40      static inline
41      void x86_spec_ctrl_restore_host(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl)
42      {
43              x86_virt_spec_ctrl(guest_spec_ctrl, guest_virt_spec_ctrl, false);
44      }
45
46      /* AMD specific Speculative Store Bypass MSR data */
47      extern u64 x86_amd_ls_cfg_base;

What's really baffling is that we explicitly tell objtool to not do stack
metadata validation on vmx_vcpu_run():

	STACK_FRAME_NON_STANDARD(vmx_vcpu_run);

As an aside, we might be able to remove STACK_FRAME_NON_STANDARD, assuming
we get this warning sorted out.

> >> Fixes: 453eafbe65f (KVM: VMX: Move VM-Enter + VM-Exit handling to
> >> non-inline sub-routines)
> > 
> > Oops, wrong fix. Back to square one.
> > 
> 
> Hmm, maybe like this:
> 
> diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
> index bcef2c7e9bc4..33122fa9d4bd 100644
> --- a/arch/x86/kvm/vmx/vmenter.S
> +++ b/arch/x86/kvm/vmx/vmenter.S
> @@ -26,19 +26,17 @@ ENTRY(vmx_vmenter)
>  	ret
> 
>  2:	vmlaunch
> +3:
>  	ret
> 
> -3:	cmpb $0, kvm_rebooting
> -	jne 4f
> -	call kvm_spurious_fault
> -4:	ret
> -
>  	.pushsection .fixup, "ax"
> -5:	jmp 3b
> +4:	cmpb $0, kvm_rebooting
> +	jne 3b
> +	jmp kvm_spurious_fault
>  	.popsection
> 
> -	_ASM_EXTABLE(1b, 5b)
> -	_ASM_EXTABLE(2b, 5b)
> +	_ASM_EXTABLE(1b, 4b)
> +	_ASM_EXTABLE(2b, 4b)
> 
>  ENDPROC(vmx_vmenter)
> 
> 
> Paolo
