Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbeDLB6A (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 21:58:00 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:40743 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbeDLB57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 21:57:59 -0400
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Thu, 12 Apr 2018 10:57:56 +0900
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
Message-ID: <20180412015756.GA6962@sejong>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180411192940.de8143a80bd9e5d98d87f6ec@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 07:29:40PM -0500, Kim Phillips wrote:
> On Thu, 12 Apr 2018 08:31:09 +0900
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > Hello,
> 
> Hi,
> 
> > On Wed, Apr 11, 2018 at 06:07:52PM -0500, Kim Phillips wrote:
> > > ---
> > > It's not clear to me what the specific intent of the original commit
> > > was, thus the revert.
> > 
> > Hmm.. maybe your kernel map has non-zero start and zero end.  I
> 
> On x86, the first line in /proc/kallsyms is:
> 
> 0000000000000000 A irq_stack_union
> 
> On arm64, it's:
> 
> ffff200008080000 t _head
> 
> Another arm64 box has:
> 
> ffff000008080000 t _head
> 
> (neither have RANDOMIZE_BASE set FWIW)
> 
> > thought it was just from an old or invalid data.  But now I think that
> 
> It would be good to know what that was, yes.
> 
> > overflow can create it..  could you please show me the mmap event?
> > 
> >   $ perf script --show-mmap-events
> 
> Here you go:
> 
>          swapper     0 [000]     0.000000: PERF_RECORD_MMAP -1/0: [0xffff200008080000(0xdffff7f7ffff) @ 0xffff200008080000]: x [kernel.kallsyms]_text

   0xffff200008080000
 +     0xdffff7f7ffff
 --------------------
   0xffffffffffffffff

So it should have ~0ULL of the 'end' already.  I don't know why it
caused the problem..  Was it from the `perf.good`?


>          swapper     0 [000]     0.000000: PERF_RECORD_MMAP -1/0: [0xffff2000021e0000(0x18000) @ 0]: x /lib/modules/4.16.0+/kernel/drivers/bus/arm-ccn.ko

Hmm.. also it seems arm64 loads modules under the kernel.  Then the
fixup logic in machine__create_kernel_maps() won't work.  Also as we
don't use the map_groups__fixup_end() anymore I think it's ok just
checking the end address.

Thanks,
Namhyung
