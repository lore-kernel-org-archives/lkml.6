Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F18C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F07820859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389162AbfAOTGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:06:18 -0500
Received: from mga02.intel.com ([134.134.136.20]:53471 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727612AbfAOTGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:06:18 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2019 11:06:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,481,1539673200"; 
   d="scan'208";a="106829365"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by orsmga007.jf.intel.com with ESMTP; 15 Jan 2019 11:06:17 -0800
Date:   Tue, 15 Jan 2019 11:06:17 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kvm: add proper frame pointer logic for vmx
Message-ID: <20190115190617.GD21622@linux.intel.com>
References: <20190115064459.70513-1-cai@lca.pw>
 <a6477022-bbc0-fc00-2c8e-75007b468d3f@lca.pw>
 <5109b3c2-cac0-aa19-9cc7-801340afe198@redhat.com>
 <7d6ae0bc-b7c7-63ea-ae94-4437a29a31b1@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d6ae0bc-b7c7-63ea-ae94-4437a29a31b1@lca.pw>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc Josh

Josh,

The issue we're encountering is that vmx_vcpu_run() is marked with
STACK_FRAME_NON_STANDARD because %rbp is saved/modified/restored when
transitioning to/from the guest.  But vmx_vcpu_run() also happens to
be a giant blob of code that gcc will sometime split into separate
.part.* functions, which means that objtool's symbol lookup to whitelist
the function doesn't work.

On Tue, Jan 15, 2019 at 11:43:20AM -0500, Qian Cai wrote:
> 
> 
> On 1/15/19 2:13 AM, Paolo Bonzini wrote:
> > Hmm, maybe like this:
> > 
> > diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
> > index bcef2c7e9bc4..33122fa9d4bd 100644
> > --- a/arch/x86/kvm/vmx/vmenter.S
> > +++ b/arch/x86/kvm/vmx/vmenter.S
> > @@ -26,19 +26,17 @@ ENTRY(vmx_vmenter)
> >  	ret
> > 
> >  2:	vmlaunch
> > +3:
> >  	ret
> > 
> > -3:	cmpb $0, kvm_rebooting
> > -	jne 4f
> > -	call kvm_spurious_fault
> > -4:	ret
> > -
> >  	.pushsection .fixup, "ax"
> > -5:	jmp 3b
> > +4:	cmpb $0, kvm_rebooting
> > +	jne 3b
> > +	jmp kvm_spurious_fault
> >  	.popsection
> > 
> > -	_ASM_EXTABLE(1b, 5b)
> > -	_ASM_EXTABLE(2b, 5b)
> > +	_ASM_EXTABLE(1b, 4b)
> > +	_ASM_EXTABLE(2b, 4b)
> > 
> >  ENDPROC(vmx_vmenter)
> 
> No, that will not work. The problem is in vmx.o where I just sent another patch
> for it.
> 
> I can see there are five options to solve it.
> 
> 1) always inline vmx_vcpu_run()
> 2) always noinline vmx_vcpu_run()
> 3) add -fdiable-ipa-fnsplit option to Makefile for vmx.o
> 4) let STACK_FRAME_NON_STANDARD support part.* syntax.
> 5) trim-down vmx_vcpu_run() even more to not causing splitting by GCC.
> 
> Option 1) and 2) seems give away the decision for user with
> CONFIG_CC_OPTIMIZE_FOR_(PERFORMANCE/SIZE).
> 
> Option 3) prevents other functions there for splitting for optimization.
> 
> Option 4) and 5) seems tricky to implement.
> 
> I am not more leaning to 3) as only other fuction will miss splitting is
> vmx_segment_access_rights().

Option 4) is the most correct, but "tricky" is an understatement.  Unless
Josh is willing to pick up the task it'll likely have to wait.

There's actually a few more options:

 6) Replace "pop %rbp" in the vmx_vmenter() asm blob with an open-coded
    equivalent, e.g. "mov [%rsp], %rbp; add $8, %rsp".  This runs an end-
    around on objtool since objtool explicitly keys off "pop %rbp" and NOT
    "mov ..., %rbp" (which is probably an objtool checking flaw?").

 7) Move the vmx_vmenter() asm blob and a few other lines of code into a
    separate helper, e.g. __vmx_vcpu_run(), and mark that as having a
    non-standard stack frame.

Option 6) is an ugly (but amusing) hack.

Arguably we should do option 7) regardless of whether or not objtool gets
updated to support fnsplit behavior, as it it allows objtool to do proper
stack checking on the bulk of vmx_vcpu_run().  And it's a pretty trivial
change.

I'll send a patch for option 7), which in theory should fix the warning
for all .configs.
