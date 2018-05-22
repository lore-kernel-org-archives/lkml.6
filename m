Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753233AbeEVV5F (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 17:57:05 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41800 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753137AbeEVV5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 17:57:03 -0400
X-Google-Smtp-Source: AB8JxZpbaawilspuuPkqGv4F92WFPaeUy3icEhjayckFLCy9T5ey2TaYrQP7a+D3a1GlxOgcdKWFYQ==
Date: Tue, 22 May 2018 14:56:59 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: KVM list <kvm@vger.kernel.org>, karahmed@amazon.de,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: CONFIG_KCOV causing crash in svm_vcpu_run()
Message-ID: <20180522215659.GA658@sol.localdomain>
References: <20180514030007.GH677@sol.localdomain>
 <20180514030205.GI677@sol.localdomain>
 <CACT4Y+bV3HQTZ5+ugQmukiiJBkhN_FWqPRuNRYRbe6xoKstWVA@mail.gmail.com>
 <20180514172508.GC252575@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514172508.GC252575@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:25:08AM -0700, Eric Biggers wrote:
> On Mon, May 14, 2018 at 07:14:41AM +0200, Dmitry Vyukov wrote:
> > On Mon, May 14, 2018 at 5:02 AM, Eric Biggers <ebiggers3@gmail.com> wrote:
> > > Sorry, messed up address for KVM mailing list.  See message below.
> > >
> > > On Sun, May 13, 2018 at 08:00:07PM -0700, Eric Biggers wrote:
> > >> With CONFIG_KCOV=y and an AMD processor, running the following program crashes
> > >> the kernel with no output (I'm testing in a VM, so it's using nested
> > >> virtualization):
> > >>
> > >>       #include <fcntl.h>
> > >>       #include <linux/kvm.h>
> > >>       #include <sys/ioctl.h>
> > >>
> > >>       int main()
> > >>       {
> > >>               int dev, vm, cpu;
> > >>               char page[4096] __attribute__((aligned(4096))) = { 0 };
> > >>               struct kvm_userspace_memory_region memreg = {
> > >>                       .memory_size = 4096,
> > >>                       .userspace_addr = (unsigned long)page,
> > >>               };
> > >>               dev = open("/dev/kvm", O_RDONLY);
> > >>               vm = ioctl(dev, KVM_CREATE_VM, 0);
> > >>               cpu = ioctl(vm, KVM_CREATE_VCPU, 0);
> > >>               ioctl(vm, KVM_SET_USER_MEMORY_REGION, &memreg);
> > >>               ioctl(cpu, KVM_RUN, 0);
> > >>       }
> > >>
> > >> It bisects down to commit b2ac58f90540e39 ("KVM/SVM: Allow direct access to
> > >> MSR_IA32_SPEC_CTRL").  The bug is apparently that due to the new code for
> > >> managing the SPEC_CTRL MSR, __sanitizer_cov_trace_pc() is being called from
> > >> svm_vcpu_run() before the host's MSR_GS_BASE has been restored, which causes a
> > >> crash somehow.  The following patch fixes it, though I don't know that it's the
> > >> right solution; maybe KCOV should be disabled in the function instead, or maybe
> > >> there's a more fundamental problem.  What do people think?
> > 
> > 
> > If __sanitizer_cov_trace_pc() crashes, I would expect there must be
> > few more of them here:
> > 
> > if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
> >     svm->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
> > 
> > if (svm->spec_ctrl)
> >     native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
> > 
> > Compiler inserts these callbacks into every basic block/edge.. Aren't there?
> > 
> > Unfortunately we don't have an attribute that disables instrumentation
> > of a single function. This is currently possible only on file level.
> > 
> 
> Yes, due to the code dealing with MSR_IA32_SPEC_CTRL, there were several calls
> to __sanitizer_cov_trace_pc() before the write to MSR_GS_BASE.  The patch I
> tested moves the write to MSR_GS_BASE to before all of them, so it's once again
> the first thing after the asm block.  Again I'm not sure it's the proper
> solution, but it did make it stop crashing.
> 
> Also I'm guessing this isn't specific to nested virtualization; I just didn't
> have KCOV enabled on the host, thus the host didn't crash.
> 

Okay, this was (apparently coincidentally) fixed by commit 15e6c22fd8e5a:
"KVM: SVM: Move spec control call after restore of GS".  Thanks Thomas!

- Eric
