Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751589AbeBETsh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 14:48:37 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39417 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeBETsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 14:48:31 -0500
X-Google-Smtp-Source: AH8x226t+wdzECF5cZ5RfciLiGC1zafQLwRAsx5rC6m8O+NkuBzJYmHxsLXvyB12ez5mkk4LXuIAuQ==
Date: Mon, 5 Feb 2018 20:48:22 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/3] x86/entry: Clear extra registers beyond syscall
 arguments for 64bit kernels
Message-ID: <20180205194822.cki2woaewdwx7stg@gmail.com>
References: <151770009169.7213.12476757146099518628.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151770009703.7213.12036560755602017391.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAMzpN2jeq+LDajvwSALpmaZKOChNX1uhRbuEJ3v97HyOEsH44A@mail.gmail.com>
 <CAPcyv4gy=Oq5=ZXCvs0mgziwfgEb2p+pE9BJZZP47W+4yrz0Vg@mail.gmail.com>
 <CA+55aFzC03b5VASq3xjLhU4WAA=gwqKNT2i6-9OBPQd-G_AHEA@mail.gmail.com>
 <20180205162659.kimgef6dkskc6quq@gmail.com>
 <CALCETrU4S3owtVF5_zVMxH_dXox6HXBbb-Q3+GzTQ-RU_xqgcw@mail.gmail.com>
 <20180205182957.xbeufjgyhd7pgdvq@gmail.com>
 <CAMzpN2iLXsvufY6yHWg7f-r4J+uCW9bA4fVE=ZjEDf7KnrZuRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2iLXsvufY6yHWg7f-r4J+uCW9bA4fVE=ZjEDf7KnrZuRw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Brian Gerst <brgerst@gmail.com> wrote:

> On Mon, Feb 5, 2018 at 1:29 PM, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > * Andy Lutomirski <luto@kernel.org> wrote:
> >
> >> [...] Clearing R10 is mostly useless in the syscall path because we'll just
> >> unconditionally reload it in do_syscall_64().
> >
> > AFAICS do_syscall_64() doesn't touch R10 at all. So how does it reload R10?
> >
> > In fact do_syscall_64() as a C function does not touch R10, R11, R12, R13, R14,
> > R15 - it passes their values through.
> >
> > What am I missing?
> 
> The syscall ABI uses R10 for the 4th argument instead of RCX, because
> RCX gets clobbered by the SYSCALL instruction for RIP.

But we only reload the syscall-entry value of R10 it into RCX (4th C function 
argument):

                regs->ax = sys_call_table[nr](
                        regs->di, regs->si, regs->dx,
                        regs->r10, regs->r8, regs->r9);

while RCX is a clobbered register, so in practice, while it will be briefly 
present in do_syscall_64() and the high level syscall functions, the value in RCX 
will be cleared from RCX in the overwhelming majority of cases.

But the real R10 will survive much longer, because it's only used in a very small 
minority of the C functions!

So my point: if we clear R10 (and R11) from the _real_ registers, we can stop 
propagating these user controlled values further into the kernel.

Thanks,

	Ingo
