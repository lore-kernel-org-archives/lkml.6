Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753355AbeDMAJ6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 20:09:58 -0400
Received: from foss.arm.com ([217.140.101.70]:38452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751886AbeDMAJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 20:09:56 -0400
Date: Thu, 12 Apr 2018 19:09:54 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, <kernel-team@lge.com>
Subject: Re: [PATCH] Revert
 "perf machine: Fix paranoid check in machine__set_kernel_mmap()"
Message-Id: <20180412190954.4c76039100b990675ec390bd@arm.com>
In-Reply-To: <20180412015756.GA6962@sejong>
References: <20180215122635.24029-1-jolsa@kernel.org>
        <20180215122635.24029-7-jolsa@kernel.org>
        <20180219022036.GB1583@sejong>
        <20180219100140.GA17630@krava>
        <20180219101936.GD1583@sejong>
        <20180219104917.GA19365@krava>
        <20180219121817.GC14978@kernel.org>
        <20180411180752.b64c4d105222fb22c159b852@arm.com>
        <20180411233109.GA6320@sejong>
        <20180411192940.de8143a80bd9e5d98d87f6ec@arm.com>
        <20180412015756.GA6962@sejong>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2018 10:57:56 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> On Wed, Apr 11, 2018 at 07:29:40PM -0500, Kim Phillips wrote:
> > On Thu, 12 Apr 2018 08:31:09 +0900
> > Namhyung Kim <namhyung@kernel.org> wrote:
> > > On Wed, Apr 11, 2018 at 06:07:52PM -0500, Kim Phillips wrote:
> > > > ---
> > > > It's not clear to me what the specific intent of the original commit
> > > > was, thus the revert.
> > > 
> > > Hmm.. maybe your kernel map has non-zero start and zero end.  I
> > 
> > On x86, the first line in /proc/kallsyms is:
> > 
> > 0000000000000000 A irq_stack_union
> > 
> > On arm64, it's:
> > 
> > ffff200008080000 t _head
> > 
> > Another arm64 box has:
> > 
> > ffff000008080000 t _head
> > 
> > (neither have RANDOMIZE_BASE set FWIW)
> > 
> > > thought it was just from an old or invalid data.  But now I think that
> > 
> > It would be good to know what that was, yes.
> > 
> > > overflow can create it..  could you please show me the mmap event?
> > > 
> > >   $ perf script --show-mmap-events
> > 
> > Here you go:
> > 
> >          swapper     0 [000]     0.000000: PERF_RECORD_MMAP -1/0: [0xffff200008080000(0xdffff7f7ffff) @ 0xffff200008080000]: x [kernel.kallsyms]_text
> 
>    0xffff200008080000
>  +     0xdffff7f7ffff
>  --------------------
>    0xffffffffffffffff
> 
> So it should have ~0ULL of the 'end' already.  I don't know why it
> caused the problem..  Was it from the `perf.good`?

There's no difference between the output of perf.good and perf.bad (the
difference between them is this reversion patch, .good being the one
that includes it).

> >          swapper     0 [000]     0.000000: PERF_RECORD_MMAP -1/0: [0xffff2000021e0000(0x18000) @ 0]: x /lib/modules/4.16.0+/kernel/drivers/bus/arm-ccn.ko
> 
> Hmm.. also it seems arm64 loads modules under the kernel.  Then the
> fixup logic in machine__create_kernel_maps() won't work.  Also as we

you mean this:

void __map_groups__fixup_end(struct map_groups *mg, enum map_type type)
...
                if (!curr->end)
                        curr->end = next->start;

?  Module symbol resolution is working, however.  Maybe because this
'paranoid' check was setting all the end addresses to ~0ULL?  Does the
design assume what maps__first() returns always has the lowest address,
and they're in sorted order?  If so, what's the fix, to re-sort
map_groups afterwards?

> don't use the map_groups__fixup_end() anymore 

?  I see map_groups__fixup_end() still being called.

> I think it's ok just
> checking the end address.

Where?  In machine__set_kernel_mmap(), like this reversion does?

The original commit says:

    The machine__set_kernel_mmap() is to setup addresses of the kernel map
    using external info.  But it has a check when the address is given from
    an incorrect input which should have the start and end address of 0
    (i.e. machine__process_kernel_mmap_event).
    
    But we also use the end address of 0 for a valid input so change it to
    check both start and end addresses.

yet the comment above the code says:

                 * Be a bit paranoid here, some perf.data file came with
                 * a zero sized synthesized MMAP event for the kernel.

I tracked the first comment insertion down to this commit:

commit 10fe12ef631a7e85022ed26304a37f033a6a95b8
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Sat Feb 20 19:53:13 2010 -0200

    perf symbols: Fix up map end too on modular kernels with no modules installed
    
    In 2161db9 we stopped failing when not finding modules when
    asked too, but then the kernel maps (just one, for vmlinux)
    wasn't having its ->end field correctly set up, so symbols were
    not being found for the vmlinux map because its range was 0-0.

which, when reading that last part, one would assume start == end == 0,
therefore size also == 0, the comment only talks about a zero *sized*
event...so did the original commit 1d12cec6ce99 "perf machine: Fix
paranoid check in machine__set_kernel_mmap()" really fix that case?
Because it checks start == 0, not necessarily the size...

If not, can it be reverted until we figure out what's going on with
arm64?  It's causing a regression in the meantime...

Thanks,

Kim
