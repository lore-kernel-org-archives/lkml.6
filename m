Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753367AbeEBAJg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 20:09:36 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:35111 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbeEBAJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 20:09:35 -0400
X-Google-Smtp-Source: AB8JxZpRT/OioL2j82qjzpTb7kQvnIBioARqqPizQSVh6u/k2SuB/spE+NoNovDVfqtBDTtO/sSW0//yF1J8kupuE8A=
MIME-Version: 1.0
References: <152520750404.36522.15462513519590065300.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFwoOee_8H-1KRnY1G-Ud4Rez16s8xjVbG8YOPn1jqxxtg@mail.gmail.com> <CAPcyv4jA98NVNqYFpj29OHE45HVp1DMH9oFO4-neWKA_4WKTwA@mail.gmail.com>
In-Reply-To: <CAPcyv4jA98NVNqYFpj29OHE45HVp1DMH9oFO4-neWKA_4WKTwA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 02 May 2018 00:09:23 +0000
Message-ID: <CA+55aFwZ3hrrOJ5W-C8gdam3aGNxz8FEAq9gPnRBkVmwu4BvYA@mail.gmail.com>
Subject: Re: [PATCH 0/6] use memcpy_mcsafe() for copy_to_iter()
To: Dan Williams <dan.j.williams@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 4:03 PM Dan Williams <dan.j.williams@intel.com>
wrote:

> I'm confused. Are you talking about getting rid of the block-layer
> bypass or changing how MCS errors are handled?

The latter.

> If it's the latter, MCS error handling, I don't see how get
> around something like copy_to_iter_mcsafe().

So the basic issue is that since everybody wants mmap() to be at least an
option (and preferably one of the _main_ options), I think that the whole
"MCS errors are fatal" is fundamentally flawed.

Which means that MCS errors can't be fatal.

Which in turn means that the whole "special memcpy" seems very suspect.

Can't we just do

  - use a normal memcpy()

  - basically set an "IO error flag" on MCE.

  - for a user access the IO error flag potentially causes a SIGBUS as you
mention, but even there it's not 100% clear that's necessarily possible or
a good idea (I'm assuming that it can be damned hard to figure out _who_
caused the problem if it was a cached write that causes an MCE much much
later).

  - for the kernel, the "IO error flag" can hopefully be then (again,
assuming you can correlate the MCE with the right process) be turned into
EIO.

> You mention mmap. Yes, we want the predominant access model to be
> dax-mmap for Persistent Memory, but there's still the question about
> what to do with media errors. To date we are trying to mirror the
> error handling model for System Memory, i.e. SIGBUS to the process
> that consumed the error. Is that error handling model also problematic
> in your view?

See above: if you can handle user space errors "gracefully" (ie with a
SIGBUS, no crazy "system fatal (reboot)" garbage), then I really don't see
why you can't do the same for the kernel accesses.

IOW, why do we need that special "copy_to_iter_mcsafe()", when a normal
"copy_to_iter()" should just work (and basically _has_ to work) anyway?

Put another way: I think the whole basic premis of your patch is wrong,
because (to quote your original patch descriptor), the fundamental starting
point is garbage:

    The result of the bypass is that the kernel treats machine checks during
    read as system fatal (reboot) [..]

See? If you are able to map that memory into user space, and recover, then
why the whole crazy "system fatal" thing for kernel accesses?

             Linus
