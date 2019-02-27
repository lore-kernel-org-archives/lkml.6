Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E62C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 07:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD05218E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 07:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551251657;
	bh=wHUUjqgJLobBbqPDrCrQGznWQHcXCdmppbCgepft848=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iRjGFrb0RWfQ5O5BaVF82abK1bgwLThtbKdAOCCWluk1IKzg8OhwRB0p/HQES3Ji3
	 OJhoN7V5pAe17DkREZzE9TzTXLUHTx08DcMQn072ZqJ1ZHQRAcOgE98HNjpyY7dEiq
	 csf0jsQ/LJycqnjHUBI82ZJ3Rm0r6t6+sWAIvgNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfB0HOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 02:14:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:44420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbfB0HOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 02:14:16 -0500
Received: from sol.localdomain (c-107-3-167-184.hsd1.ca.comcast.net [107.3.167.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 607C4218D0;
        Wed, 27 Feb 2019 07:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551251654;
        bh=wHUUjqgJLobBbqPDrCrQGznWQHcXCdmppbCgepft848=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dMjDLCbN9aOEnv+SBBmayWo1uIyvFiNTWTOBef07ATM9wZi0BA0S/bO9SfpTHY4/m
         7jB/DSAvqqSCCC6s7G4Zm3KU2tQHOsA30HulMGwMcFpZKLahtCeVzn7gfCMwiVTLK8
         h69aJvvMlkBA/BbEqHUJJjMgPnnljN6kHFjljEjI=
Date:   Tue, 26 Feb 2019 23:14:12 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     KVM list <kvm@vger.kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>, karahmed@amazon.de,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_KCOV causing crash in svm_vcpu_run()
Message-ID: <20190227071411.GB680@sol.localdomain>
References: <20180514030007.GH677@sol.localdomain>
 <20180514030205.GI677@sol.localdomain>
 <CACT4Y+bV3HQTZ5+ugQmukiiJBkhN_FWqPRuNRYRbe6xoKstWVA@mail.gmail.com>
 <20180514172508.GC252575@gmail.com>
 <CACT4Y+Y9O34yzF=0wj9X6kzW19x8o-0LECcWWTb7KJDo7KYaXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Y9O34yzF=0wj9X6kzW19x8o-0LECcWWTb7KJDo7KYaXA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviving this old thread because it wasn't fully fixed after all...

On Tue, May 15, 2018 at 07:33:48AM +0200, Dmitry Vyukov wrote:
> On Mon, May 14, 2018 at 7:25 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> > On Mon, May 14, 2018 at 07:14:41AM +0200, Dmitry Vyukov wrote:
> >> On Mon, May 14, 2018 at 5:02 AM, Eric Biggers <ebiggers3@gmail.com> wrote:
> >> > Sorry, messed up address for KVM mailing list.  See message below.
> >> >
> >> > On Sun, May 13, 2018 at 08:00:07PM -0700, Eric Biggers wrote:
> >> >> With CONFIG_KCOV=y and an AMD processor, running the following program crashes
> >> >> the kernel with no output (I'm testing in a VM, so it's using nested
> >> >> virtualization):
> >> >>
> >> >>       #include <fcntl.h>
> >> >>       #include <linux/kvm.h>
> >> >>       #include <sys/ioctl.h>
> >> >>
> >> >>       int main()
> >> >>       {
> >> >>               int dev, vm, cpu;
> >> >>               char page[4096] __attribute__((aligned(4096))) = { 0 };
> >> >>               struct kvm_userspace_memory_region memreg = {
> >> >>                       .memory_size = 4096,
> >> >>                       .userspace_addr = (unsigned long)page,
> >> >>               };
> >> >>               dev = open("/dev/kvm", O_RDONLY);
> >> >>               vm = ioctl(dev, KVM_CREATE_VM, 0);
> >> >>               cpu = ioctl(vm, KVM_CREATE_VCPU, 0);
> >> >>               ioctl(vm, KVM_SET_USER_MEMORY_REGION, &memreg);
> >> >>               ioctl(cpu, KVM_RUN, 0);
> >> >>       }
> >> >>
> >> >> It bisects down to commit b2ac58f90540e39 ("KVM/SVM: Allow direct access to
> >> >> MSR_IA32_SPEC_CTRL").  The bug is apparently that due to the new code for
> >> >> managing the SPEC_CTRL MSR, __sanitizer_cov_trace_pc() is being called from
> >> >> svm_vcpu_run() before the host's MSR_GS_BASE has been restored, which causes a
> >> >> crash somehow.  The following patch fixes it, though I don't know that it's the
> >> >> right solution; maybe KCOV should be disabled in the function instead, or maybe
> >> >> there's a more fundamental problem.  What do people think?
> >>
> >>
> >> If __sanitizer_cov_trace_pc() crashes, I would expect there must be
> >> few more of them here:
> >>
> >> if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
> >>     svm->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
> >>
> >> if (svm->spec_ctrl)
> >>     native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
> >>
> >> Compiler inserts these callbacks into every basic block/edge.. Aren't there?
> >>
> >> Unfortunately we don't have an attribute that disables instrumentation
> >> of a single function. This is currently possible only on file level.
> >>
> >
> > Yes, due to the code dealing with MSR_IA32_SPEC_CTRL, there were several calls
> > to __sanitizer_cov_trace_pc() before the write to MSR_GS_BASE.  The patch I
> > tested moves the write to MSR_GS_BASE to before all of them, so it's once again
> > the first thing after the asm block.  Again I'm not sure it's the proper
> > solution, but it did make it stop crashing.
> 
> From KCOV perspective:
> This is definitely the simplest and less intrusive solution.
> It's somewhat unreliable. But it's hard to tell if/when it will
> actually break in practice. Compiler can decide to insert the callback
> after asm block, or a branch can be added to wrmsrl (e.g. under some
> debug config). More reliable solution would be to restore registers in
> asm block itself, or move this to a separate file and disable
> instrumentation of that file (though, will not save from non-inlined
> wrmsrl). But again, the proposed solution may work well for the next
> 10 years, so additional complexity may not worth it.
> 
> Btw, I don't see anything about fs/gs in vmx_vcpu_run. Is it VMLAUNCH
> that saves/restores them?

So it turns out there *is* a branch in wrmsrl() when CONFIG_PARAVIRT=y &&
CONFIG_PARAVIRT_DEBUG=y, and that causes the same crash: the compiler inserts a
call to __sanitizer_cov_trace_pc() prior to the GS_BASE register being restored
in svm_vcpu_run().

	#ifdef CONFIG_PARAVIRT_DEBUG
	#define PVOP_TEST_NULL(op)      BUG_ON(pv_ops.op == NULL)
	#else
	#define PVOP_TEST_NULL(op)      ((void)pv_ops.op)
	#endif

Dmitry, in the long run maybe this should be solved by adding a function
attribute to gcc that disables coverage for a function?

But for now maybe CONFIG_KCOV should depend on !CONFIG_PARAVIRT_DEBUG?  Or does
anyone have a better idea?  Alternatively as Dmitry suggested, svm_vcpu_run()
could be moved to a separate file and compiled with different flags...

- Eric
