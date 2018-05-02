Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbeEBRrV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:47:21 -0400
Received: from mail-ot0-f182.google.com ([74.125.82.182]:41693 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbeEBRrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:47:13 -0400
X-Google-Smtp-Source: AB8JxZr9iIqKN87afqlPhYiQ/odHFfnzKDky11XzWS/ihOQ5fcEupSmTL5vpYfxAo0RsxiXEA11z5INZFL2of8AHKTM=
MIME-Version: 1.0
In-Reply-To: <CALCETrXxnaj+YL_NDM1u0tM9v6p8ZtQw62n+y4Tv4ScB0DdZPw@mail.gmail.com>
References: <152520750404.36522.15462513519590065300.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFwoOee_8H-1KRnY1G-Ud4Rez16s8xjVbG8YOPn1jqxxtg@mail.gmail.com>
 <CAPcyv4jA98NVNqYFpj29OHE45HVp1DMH9oFO4-neWKA_4WKTwA@mail.gmail.com>
 <CA+55aFwZ3hrrOJ5W-C8gdam3aGNxz8FEAq9gPnRBkVmwu4BvYA@mail.gmail.com>
 <CAPcyv4i=cjQr9xvxt+Mjp-fhzyNJdTTp7uaAtpJN9R4gPg_j-Q@mail.gmail.com>
 <CA+55aFyZXWoiWnEU8S1PNNyUTWsi7UCnBuDKOobfMLaE8uFKJg@mail.gmail.com>
 <CAPcyv4jTUn2gSPSB1r7p9A7VNxBf54Aa5dnGbGsomDqmbvsHLQ@mail.gmail.com>
 <CA+55aFzDt1uvDBqgkB0T2o2-d5Fi0tBiGcy5iAZ-wRNdAL4uQw@mail.gmail.com>
 <CAPcyv4hQVKL=OtoYbWDGfOMdWen3MkF5qBPrek98+w2gODHvtg@mail.gmail.com>
 <CAPcyv4ixtVC3w9BE3Z2ME-qMPCh9evBKP51SDrNPXAsg7xH1RQ@mail.gmail.com>
 <CA+55aFy2LAzRbjCEghN_7SAZgAOr0RoUFDwYkkB+V91jdTg-YA@mail.gmail.com> <CALCETrXxnaj+YL_NDM1u0tM9v6p8ZtQw62n+y4Tv4ScB0DdZPw@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 2 May 2018 10:47:12 -0700
Message-ID: <CAPcyv4jNkPjYLitvkw4mzXpm650rcYA7GJ6++psp_FZLRshE0g@mail.gmail.com>
Subject: Re: [PATCH 0/6] use memcpy_mcsafe() for copy_to_iter()
To: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 2, 2018 at 9:19 AM, Andy Lutomirski <luto@kernel.org> wrote:
> On Tue, May 1, 2018 at 8:34 PM Linus Torvalds
> <torvalds@linux-foundation.org>
> wrote:
>
>> On Tue, May 1, 2018 at 8:22 PM Dan Williams <dan.j.williams@intel.com>
>> wrote:
>
>> > All that to say that having a typical RAM page covering poisoned pmem
>> > would complicate the 'clear badblocks' implementation.
>
>> Ugh, ok.
>
>> I guess the good news is that your patches aren't so big, and don't really
>> affect anything else.
>
>
> I pondered this a bit.  Doing better might be a big pain in the arse.  The
> interesting case is where ordinary kernel code (memcpy, plain old memory
> operands, etc) access faulty pmem.  This means that there's no extable
> entry around.  If we actually try to recover, we have a few problems:
>
>   - We can't sanely skip the instruction without causing random errors.
>
>   - If the access was through the kernel direct map, then we could plausibly
> remap a different page in place of the faulty page.  The problem is that,
> if the page is *writable* and we share it between more than one faulty
> page, then we're enabling a giant information leak.  But we still need to
> figure out how we're supposed to invalidate the old mapping from a random,
> potentially atomic context.
>
>   - If the access is through kmap or similar, then we're talking about
> modifying a PTE out from under kernel code that really isn't expecting us
> to modify it.
>
>   - How are we supposed to signal the process or fail a syscall?  The fault
> could have come from interrupt context, softirq context, kernel thread
> context, etc, and figuring out who's to blame seems quite awkward and
> fragile.
>
> All that being said, I suspect that we still have issues even with accesses
> to user VAs that are protected by extable entries.  The whole #MC mechanism
> is a supremely shitty interface for recoverable errors (especially on
> Intel), and I'm a bit scared of what happens if the offending access is,
> say, inside a perf NMI.
>
> Dan, is there any chance you could put some pressure on the architecture
> folks to invent an entirely new, less shitty way to tell the OS about
> recoverable memory errors?  And to make it testable by normal people?
> Needing big metal EINJ hardware to test the house of cards that is #MC is
> just awful and means that there are few enough kernel developers that are
> actually able to test that I can probably count them on one hand.  And I'm
> not one of them...

I feel this testing pain too. The EINJ facility is not ubiquitous
which is why I punted and wrote patch 6 to unit test this. You're
right that does not scale for all the potential places we'd like to be
able to safely handle memory errors in the kernel.
