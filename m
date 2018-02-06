Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753704AbeBFXGI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 18:06:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:42216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753171AbeBFXGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 18:06:07 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E62217B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AH8x225D2TiyaL4z9AUs/LOndcp9sWQtlN6MrsQQuIz8U2vJ7P5Dp5bTLsOMuXvX5L/yhA9FpZAInEBd6VCkZ1SZldA=
MIME-Version: 1.0
In-Reply-To: <CA+55aFyXfMhUNoU9WveiMyKq32LftUGzF-BAP7hxEQOfwBTJrA@mail.gmail.com>
References: <151787988045.7847.11830748914544718151.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151787989146.7847.15749181712358213254.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180206091727.GB15925@isilmar-4.linta.de> <20180206105139.nwlg3fwdxyhhrtc4@gmail.com>
 <20180206213202.GB2026@light.dominikbrodowski.net> <CA+55aFyXfMhUNoU9WveiMyKq32LftUGzF-BAP7hxEQOfwBTJrA@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 6 Feb 2018 23:05:45 +0000
X-Gmail-Original-Message-ID: <CALCETrXS_oCFMg-MXn1fr7f3xCEiyfFBKGyhhBgNcytBVCL40g@mail.gmail.com>
Message-ID: <CALCETrXS_oCFMg-MXn1fr7f3xCEiyfFBKGyhhBgNcytBVCL40g@mail.gmail.com>
Subject: Re: [PATCH tip-pti 2/2] x86/entry: interleave XOR register clearing
 with PUSH/MOV instructions
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        Ingo Molnar <mingo@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 6, 2018 at 10:48 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Feb 6, 2018 at 1:32 PM, Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
>> Same as is done for syscalls, interleave XOR with PUSH or MOV
>> instructions for exceptions/interrupts, in order to minimize
>> the cost of the additional instructions required for register
>> clearing.
>
> Side note: I would _really_ like to see
>
>  (a) SAVE_{C,EXTRA}_REGS go away entirely, to be replaced by just SAVE_REGS.
>
>      We never use them independently of each other any more.
>
>  (b) Get rid of ALLOC_PT_GPREGS_ON_STACK entirely, and make SAVE_REGS
> use pushq's instead of movs.

Agreed.

However, bit fat NAK to the patch as it.  There's no way I'm okay with
a macro called SAVE_C_REGS that actually saves *and clears* C regs.
Call it SAVE_AND_CLEAR_C_REGS.

>
> Doing (a) should be completely trivial.
>
> Doing (b) looks like it needs _some_ care, because
> ALLOC_PT_GPREGS_ON_STACK is not always done just before the SAVE_REGS,
> the error entry code does it in in the early entry code. But honestly,
> that seems mainly so that it can do
>
>         testb   $3, CS(%rsp)                    /* If coming from
> userspace, switch stacks */
>
> before registers are saved, yet use the same CS offset as if they had
> already been saved. So that _one_ stack offset in the 'idtentry' macro
> would need to be fixed up.
>
> There might be others that I don't see from just eyeballing, so it
> does need some care, but wouldn't it be nice if *all* the entry code
> could just use the same pushq sequences, and then put the xor's in
> there?
>
> The reason for that complexity is purely the system call fastpath case
> that no longer exists, I think.
>
> Am I missing something?

I don't think so.

idtentry could use some massive cleanups IMO.  At some point I'll find
time to do it.  We've added features to it piecemeal over time, and
the net result including the stack switch for PTI is a mess.

>
>                 Linus
