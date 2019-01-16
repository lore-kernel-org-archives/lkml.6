Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920A7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5842220657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404745AbfAPO5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:57:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:30338 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729315AbfAPO5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:57:03 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B38007266F;
        Wed, 16 Jan 2019 14:57:02 +0000 (UTC)
Received: from treble (ovpn-120-232.rdu2.redhat.com [10.10.120.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E1655C1B4;
        Wed, 16 Jan 2019 14:57:01 +0000 (UTC)
Date:   Wed, 16 Jan 2019 08:56:59 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Qian Cai <cai@lca.pw>, Paolo Bonzini <pbonzini@redhat.com>,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kvm: add proper frame pointer logic for vmx
Message-ID: <20190116145659.irwhvit7apzvni5n@treble>
References: <20190115064459.70513-1-cai@lca.pw>
 <a6477022-bbc0-fc00-2c8e-75007b468d3f@lca.pw>
 <5109b3c2-cac0-aa19-9cc7-801340afe198@redhat.com>
 <7d6ae0bc-b7c7-63ea-ae94-4437a29a31b1@lca.pw>
 <20190115190617.GD21622@linux.intel.com>
 <20190115223849.apk6tcbl7f7kd5d4@treble>
 <20190116005438.GA10795@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190116005438.GA10795@linux.intel.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 16 Jan 2019 14:57:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 04:54:38PM -0800, Sean Christopherson wrote:
> On Tue, Jan 15, 2019 at 04:38:49PM -0600, Josh Poimboeuf wrote:
> > On Tue, Jan 15, 2019 at 11:06:17AM -0800, Sean Christopherson wrote:
> > > > I can see there are five options to solve it.
> > > > 
> > > > 1) always inline vmx_vcpu_run()
> > > > 2) always noinline vmx_vcpu_run()
> > > > 3) add -fdiable-ipa-fnsplit option to Makefile for vmx.o
> > > > 4) let STACK_FRAME_NON_STANDARD support part.* syntax.
> > > > 5) trim-down vmx_vcpu_run() even more to not causing splitting by GCC.
> > > > 
> > > > Option 1) and 2) seems give away the decision for user with
> > > > CONFIG_CC_OPTIMIZE_FOR_(PERFORMANCE/SIZE).
> > > > 
> > > > Option 3) prevents other functions there for splitting for optimization.
> > > > 
> > > > Option 4) and 5) seems tricky to implement.
> > > > 
> > > > I am not more leaning to 3) as only other fuction will miss splitting is
> > > > vmx_segment_access_rights().
> > > 
> > > Option 4) is the most correct, but "tricky" is an understatement.  Unless
> > > Josh is willing to pick up the task it'll likely have to wait.
> > > 
> > > There's actually a few more options:
> > > 
> > >  6) Replace "pop %rbp" in the vmx_vmenter() asm blob with an open-coded
> > >     equivalent, e.g. "mov [%rsp], %rbp; add $8, %rsp".  This runs an end-
> > >     around on objtool since objtool explicitly keys off "pop %rbp" and NOT
> > >     "mov ..., %rbp" (which is probably an objtool checking flaw?").
> > > 
> > >  7) Move the vmx_vmenter() asm blob and a few other lines of code into a
> > >     separate helper, e.g. __vmx_vcpu_run(), and mark that as having a
> > >     non-standard stack frame.
> > 
> > Do you mean moving the asm blob to a .S file instead of inline asm?  If
> > so, I think that's definitely a good idea.  It would be a nice cleanup,
> > regardless of the objtool false positive.
> 
> No, just moving the inline asm to a separate function.  Moving the entire
> inline asm blob is annoying because it references a large number of struct
> offsets and doesn't solve the fundamental problem (more on this later).
> 
> The VMLAUNCH and VMRESUME invocations themselves, i.e. the really nasty
> bits, have already been moved to a .S file (by the commit that exposed
> this warning).  That approach eliminates the worst of the conflicts with
> compiler optimizations without having to deal with exposing the struct
> offsets to asm.

Exposing all the struct offsets isn't a big deal -- that's what
asm-offsets.c is for.

On the other hand, having such a large inline asm block is fragile and
unholy IMO.  I wouldn't be surprised if there are more GCC problems
lurking.

> > That would allow vmx_vcpu_run() to be a "normal" C function which
> > objtool can validate (and also create ORC data for).  It would also
> > prevent future nasty GCC optimizations (which was why the __noclone was
> > needed in the first place).
> 
> Moving the inline asm to a separate function (on top of having a separate
> .S file for VMLAUNCH/VMRESUME) accomplishes sort of the same thing, i.e.
> vmx_vcpu_run() gets to be a normal function.  It's not as bulletproof
> from a tooling perspective, but odds are pretty good that all usage of
> STACK_FRAME_NON_STANDARD will break if the compiler manages to muck up
> the inline asm wrapper function.

I wouldn't bet on that.  Many/most optimizations don't change the symbol
name, in which case STACK_FRAME_NON_STANDARD would work just fine.

> And having a dedicated function for VMLAUNCH/VMRESUME is actually nice
> from a stack trace perspective.  The transition to/from the guest is by
> far the most likely source of faults, i.e. a stack trace that originates
> in vmx_vmenter() all but guarantees that a fault occurred on VM-Enter or
> immediately after VM-Exit.

But moving __vmx_vcpu_run() to a proper asm function doesn't prevent
that.

BTW, do the stack traces from this path even work with the ORC unwinder?
Since objtool doesn't annotate vmx_vcpu_run() (or now __vmx_vcpu_run),
that should break stack tracing and instead produce a "guess" stack
trace (with the question marks), where it prints all text addresses it
finds on the stack, instead of doing a proper stack trace.

Which would be another reason to move this code to proper asm.

> > And also, I *think* objtool would no longer warn in that case, because
> > there would no longer be any calls in the function after popping %rbp.
> > Though if I'm wrong about that, I'd be glad to help fix the warning one
> > way or another.
> 
> In the vmx_vcpu_run() case, warning on calls after "pop %rbp" is actually
> a false positive.  The POP restores the host's RBP, i.e. the stack frame,
> meaning all calls after the POP are ok.  The window where stack traces
> will go awry is between loading RBP with the guest's value and the POP to
> restore the host's stack frame, i.e. in this case "mov <guest_rbp>, %rbp"
> should trigger a warning irrespective of any calls.
> 
> I'm not saying it's actually worth updating objtool, rather that "fixing"
> the KVM issue by moving the inline asm to a dedicated .S file doesn't
> solve the fundamental problem that VM-Enter/VM-Exit needs to temporarily
> corrupt RBP.

I agree the objtool warning was a false positive, but in many cases
these false positives end up pointing out some convoluted code which
really should be cleaned up anyway.  That's what I'm proposing here.
Moving the function to proper asm would be so much cleaner.

-- 
Josh
