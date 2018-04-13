Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753372AbeDMHkH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 03:40:07 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41137 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeDMHkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 03:40:06 -0400
X-Google-Smtp-Source: AIpwx49TWEnuev9UyXgl5qFRnvLAG3qybgTR+6P9CLy3gtJS/YD5bFbhR8SYOb82mb6FrCudDWw8Pg==
Date: Fri, 13 Apr 2018 16:36:20 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Kim Phillips <kim.phillips@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, kernel-team@lge.com
Subject: Re: [PATCH] Revert "perf machine: Fix paranoid check in
 machine__set_kernel_mmap()"
Message-ID: <20180413073620.GA21386@danjae.aot.lge.com>
References: <20180219022036.GB1583@sejong>
 <20180219100140.GA17630@krava>
 <20180219101936.GD1583@sejong>
 <20180219104917.GA19365@krava>
 <20180219121817.GC14978@kernel.org>
 <20180411180752.b64c4d105222fb22c159b852@arm.com>
 <20180411233109.GA6320@sejong>
 <20180411192940.de8143a80bd9e5d98d87f6ec@arm.com>
 <20180412015756.GA6962@sejong>
 <20180412190954.4c76039100b990675ec390bd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180412190954.4c76039100b990675ec390bd@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 07:09:54PM -0500, Kim Phillips wrote:
> On Thu, 12 Apr 2018 10:57:56 +0900
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > On Wed, Apr 11, 2018 at 07:29:40PM -0500, Kim Phillips wrote:
> > > On Thu, 12 Apr 2018 08:31:09 +0900
> > > Namhyung Kim <namhyung@kernel.org> wrote:
> > > > overflow can create it..  could you please show me the mmap event?
> > > > 
> > > >   $ perf script --show-mmap-events
> > > 
> > > Here you go:
> > > 
> > >          swapper     0 [000]     0.000000: PERF_RECORD_MMAP -1/0: [0xffff200008080000(0xdffff7f7ffff) @ 0xffff200008080000]: x [kernel.kallsyms]_text
> > 
> >    0xffff200008080000
> >  +     0xdffff7f7ffff
> >  --------------------
> >    0xffffffffffffffff
> > 
> > So it should have ~0ULL of the 'end' already.  I don't know why it
> > caused the problem..  Was it from the `perf.good`?
> 
> There's no difference between the output of perf.good and perf.bad (the
> difference between them is this reversion patch, .good being the one
> that includes it).

Strange.. I have no idea what's the problem if the end is already
~0ULL then.


> 
> > >          swapper     0 [000]     0.000000: PERF_RECORD_MMAP -1/0: [0xffff2000021e0000(0x18000) @ 0]: x /lib/modules/4.16.0+/kernel/drivers/bus/arm-ccn.ko
> > 
> > Hmm.. also it seems arm64 loads modules under the kernel.  Then the
> > fixup logic in machine__create_kernel_maps() won't work.  Also as we
> 
> you mean this:
> 
> void __map_groups__fixup_end(struct map_groups *mg, enum map_type type)
> ...
>                 if (!curr->end)
>                         curr->end = next->start;
> 
> ?

Right.  For the fixup routine to work, a map should have 0 end.


> Module symbol resolution is working, however.  Maybe because this
> 'paranoid' check was setting all the end addresses to ~0ULL?

Only if the end was 0.  Modules should have non-zero end.


> Does the
> design assume what maps__first() returns always has the lowest address,
> and they're in sorted order?  If so, what's the fix, to re-sort
> map_groups afterwards?

I think it's another problem but agree with you to fix it sorted.


> 
> > don't use the map_groups__fixup_end() anymore 
> 
> ?  I see map_groups__fixup_end() still being called.

Oops, sorry.  I looked a wrong branch (which I removed it but never
sent to the LKML).


> 
> > I think it's ok just checking the end address.
> 
> Where?  In machine__set_kernel_mmap(), like this reversion does?

Yes, the reason is all other maps (i.e. modules) are already have
non-zero end and we can fixup the end of kernel manually.


> 
> The original commit says:
> 
>     The machine__set_kernel_mmap() is to setup addresses of the kernel map
>     using external info.  But it has a check when the address is given from
>     an incorrect input which should have the start and end address of 0
>     (i.e. machine__process_kernel_mmap_event).
>     
>     But we also use the end address of 0 for a valid input so change it to
>     check both start and end addresses.
> 
> yet the comment above the code says:
> 
>                  * Be a bit paranoid here, some perf.data file came with
>                  * a zero sized synthesized MMAP event for the kernel.
> 
> I tracked the first comment insertion down to this commit:
> 
> commit 10fe12ef631a7e85022ed26304a37f033a6a95b8
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Sat Feb 20 19:53:13 2010 -0200
> 
>     perf symbols: Fix up map end too on modular kernels with no modules installed
>     
>     In 2161db9 we stopped failing when not finding modules when
>     asked too, but then the kernel maps (just one, for vmlinux)
>     wasn't having its ->end field correctly set up, so symbols were
>     not being found for the vmlinux map because its range was 0-0.
> 
> which, when reading that last part, one would assume start == end == 0,
> therefore size also == 0, the comment only talks about a zero *sized*
> event...so did the original commit 1d12cec6ce99 "perf machine: Fix
> paranoid check in machine__set_kernel_mmap()" really fix that case?
> Because it checks start == 0, not necessarily the size...

As I said I thought it only cares the start == end == 0 case and now
the problem is fixed.  So I added the start check for the fixup
routine to take care of the end address.  Otherwise kernel might have
an overlap with some module(s).

> 
> If not, can it be reverted until we figure out what's going on with
> arm64?  It's causing a regression in the meantime...

I think the right solution would be

1. sort map groups
2. set kernel end to ~0ULL in machine__create_kernel_maps()
3. fix the kernel end to the start of next module (if any) manually
   instead of calling map_groups__fixup_end()

Thanks,
Namhyung
