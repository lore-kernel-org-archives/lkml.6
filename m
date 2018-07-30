Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265B013F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727B020881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 727B020881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbeG3LFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:05:25 -0400
Received: from nautica.notk.org ([91.121.71.147]:51982 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbeG3LFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:05:25 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id D8FA9C009; Mon, 30 Jul 2018 11:31:16 +0200 (CEST)
Date:   Mon, 30 Jul 2018 11:31:01 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Greg Kurz <groug@kaod.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] 9p: Use a slab for allocating requests
Message-ID: <20180730093101.GA7894@nautica>
References: <20180711210225.19730-1-willy@infradead.org>
 <20180711210225.19730-6-willy@infradead.org>
 <20180718100554.GA21781@nautica>
 <20180723135220.08ec45bf@bahia>
 <20180723122531.GA9773@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180723122531.GA9773@nautica>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dominique Martinet wrote on Mon, Jul 23, 2018:
> I'll try to get figures for various approaches before the merge window
> for 4.19 starts, it's getting closer though...

Here's some numbers; with v4.18-rc7 + current test tree (my 9p-next) as
a base.


For the context, I'm running on VMs that bind their cores to CPUs on the
host (32 cores), and have a Connect-IB mellanox card through SRIOV.

The server is nfs-ganesha, serving a tmpfs filesystem on a second VM
(different host)

Mounting with msize=$((1024*1024))

My main problem with this test is that the client has way too much
memory and it's mostly pristine with a boot not long before, so any kind
of memory pressure won't be seen here.
If someone knows how to fragment memory quickly I'll take that and rerun
the tests :)


I've changed my mind from mdtest to a simple ior, as I'm testing on
trans=rdma there's no difference and I'm more familiar with ior options.

I ran two workloads:
 - 32 processes, file per process, 512k at a time writing a total of
32GB (1GB per file), repeated 10 times
 - 32 processes, file per process, 32 bytes at a time writing a total of
16MB (512k per file), repeated 10 times.

The first test gives a proper impression of the throughput the systems
can sustain and the results are pretty much around what I was expecting
for the setup; the second test is purely a latency test (how long does
it take to send 512k RPCs)


I ran almost all of these tests with KASAN enabled in the VMs a first
time, so leaving the results with KASAN at the end for reference...


Overall I'm rather happy with the result, without KASAN the overhead of
the patch isn't negligible (~6%) but I'd say it's acceptable for
correctness and with an extra two patchs with the suggesteed changes
(rounding down the alloc size to not include the struct overhead and
separate kmem cache) it's getting down to 0.5% which is quite good, I
think.

I'll send the two patchs to the list shortly. The first one is rather
huge even if it's a trivial change logically, so part of me wants to get
it merged quickly to not have to deal with rebases... ;)


With KASAN, well, it certainly does more things but I hope
performance-critical systems don't have it enabled in the first place.



Raw results:

 * Base = 4.18-rc7 + queued patches, without request cache rework
- "Big" I/Os:
Summary of all tests:
Operation   Max(MiB)   Min(MiB)  Mean(MiB)     StdDev    Mean(s) Test# #Tasks tPN reps fPP reord reordoff reordrand seed segcnt blksiz xsize aggsize API RefNum
write        5842.40    5751.58    5793.53      23.93    5.65606 0 32 32 10 1 0 1 0 0 1 1073741824 524288 34359738368 POSIX 0
read         6098.92    6018.63    6064.30      20.00    5.40348 0 32 32 10 1 0 1 0 0 1 1073741824 524288 34359738368 POSIX 0

- "Small" I/Os:
Operation   Max(MiB)   Min(MiB)  Mean(MiB)     StdDev    Mean(s) Test# #Tasks tPN reps fPP reord reordoff reordrand seed segcnt blksiz xsize aggsize API RefNum
write           2.10       1.91       2.00       0.05    8.01074 0 32 32 10 1 0 1 0 0 1 524288 32 16777216 POSIX 0
read            1.27       1.07       1.15       0.06   13.93901 0 32 32 10 1 0 1 0 0 1 524288 32 16777216 POSIX 0
 -> 512k / 8.01074 = 65.4k req/s


 * Base + patch as submitted
- "Big" I/Os:
Operation   Max(MiB)   Min(MiB)  Mean(MiB)     StdDev    Mean(s) Test# #Tasks tPN reps fPP reord reordoff reordrand seed segcnt blksiz xsize aggsize API RefNum
write        5844.84    5665.32    5787.15      48.94    5.66261 0 32 32 10 1 0 1 0 0 1 1073741824 524288 34359738368 POSIX 0
read         6082.24    6039.62    6057.14      12.50    5.40983 0 32 32 10 1 0 1 0 0 1 1073741824 524288 34359738368 POSIX 0
                             
- "Small" I/Os:
Operation   Max(MiB)   Min(MiB)  Mean(MiB)     StdDev    Mean(s) Test# #Tasks tPN reps fPP reord reordoff reordrand seed segcnt blksiz xsize aggsize API RefNum
write           1.95       1.82       1.88       0.04    8.50453 0 32 32 10 1 0 1 0 0 1 524288 32 16777216 POSIX 0
read            1.18       1.07       1.14       0.03   14.04634 0 32 32 10 1 0 1 0 0 1 524288 32 16777216 POSIX 0
 -> 512k / 8.50453 = 61.6k req/s


 * Base + patch as submitted + moving the header into req so the
allocation is "round" as suggested by Matthew
- "Big" I/Os:
Operation   Max(MiB)   Min(MiB)  Mean(MiB)     StdDev    Mean(s) Test# #Tasks tPN reps fPP reord reordoff reordrand seed segcnt blksiz xsize aggsize API RefNum
write        5861.79    5680.99    5795.71      48.84    5.65424 0 32 32 10 1 0 1 0 0 1 1073741824 524288 34359738368 POSIX 0
read         6098.54    6037.55    6067.80      19.39    5.40036 0 32 32 10 1 0 1 0 0 1 1073741824 524288 34359738368 POSIX 0

- "Small" I/Os:
Operation   Max(MiB)   Min(MiB)  Mean(MiB)     StdDev    Mean(s) Test# #Tasks tPN reps fPP reord reordoff reordrand seed segcnt blksiz xsize aggsize API RefNum
write           1.98       1.81       1.90       0.06    8.43521 0 32 32 10 1 0 1 0 0 1 524288 32 16777216 POSIX 0
read            1.19       1.08       1.13       0.03   14.11709 0 32 32 10 1 0 1 0 0 1 524288 32 16777216 POSIX 0
 -> 62.2k req/s

 * Base + patchs submitted + round alloc + kmem cache in the client
struct
- "Big" I/Os
Operation   Max(MiB)   Min(MiB)  Mean(MiB)     StdDev    Mean(s) Test# #Tasks tPN reps fPP reord reordoff reordrand seed segcnt blksiz xsize aggsize API RefNum
write        5859.51    5747.64    5808.22      34.81    5.64186 0 32 32 10 1 0 1 0 0 1 1073741824 524288 34359738368 POSIX 0
read         6087.90    6037.03    6063.98      15.14    5.40374 0 32 32 10 1 0 1 0 0 1 1073741824 524288 34359738368 POSIX 0

- "Small" I/Os:
Operation   Max(MiB)   Min(MiB)  Mean(MiB)     StdDev    Mean(s) Test# #Tasks tPN reps fPP reord reordoff reordrand seed segcnt blksiz xsize aggsize API RefNum
write           2.07       1.95       1.99       0.03    8.05362 0 32 32 10 1 0 1 0 0 1 524288 32 16777216 POSIX 0
read            1.22       1.11       1.16       0.04   13.75312 0 32 32 10 1 0 1 0 0 1 524288 32 16777216 POSIX 0
 -> 65.1k req/s

 * Base + patchs submitted + kmem cache in the client struct (kind of
similar to testing an 'odd' msize like 1.001MB)
- "Big" I/Os:
Operation   Max(MiB)   Min(MiB)  Mean(MiB)     StdDev    Mean(s) Test# #Tasks tPN reps fPP reord reordoff reordrand seed segcnt blksiz xsize aggsize API RefNum
write        5883.03    5725.30    5811.58      45.22    5.63874 0 32 32 10 1 0 1 0 0 1 1073741824 524288 34359738368 POSIX 0
read         6090.29    6015.23    6062.49      25.93    5.40514 0 32 32 10 1 0 1 0 0 1 1073741824 524288 34359738368 POSIX 0

- "Small" I/Os:
Operation   Max(MiB)   Min(MiB)  Mean(MiB)     StdDev    Mean(s) Test# #Tasks tPN reps fPP reord reordoff reordrand seed segcnt blksiz xsize aggsize API RefNum
write           2.07       1.89       1.98       0.05    8.10028 0 32 32 10 1 0 1 0 0 1 524288 32 16777216 POSIX 0
read            1.23       1.05       1.12       0.05   14.25607 0 32 32 10 1 0 1 0 0 1 524288 32 16777216 POSIX 0
 -> 64.7k req/s




Raw results with KASAN:
 * Base = 4.18-rc7 + queued patches, without request cache rework
- "Big" I/Os:
Operation   Max(MiB)   Min(MiB)  Mean(MiB)     StdDev    Mean(s) Test# #Tasks tPN reps fPP reord reordoff reordrand seed segcnt blksiz xsize aggsize API RefNum
write        5790.03    5705.32    5749.69      27.63    5.69922 0 32 32 10 1 0 1 0 0 1 1073741824 524288 34359738368 POSIX 0
read         6095.11    6007.29    6066.50      26.26    5.40157 0 32 32 10 1 0 1 0 0 1 1073741824 524288 34359738368 POSIX 0

- "Small" I/Os:
Operation   Max(MiB)   Min(MiB)  Mean(MiB)     StdDev    Mean(s) Test# #Tasks tPN reps fPP reord reordoff reordrand seed segcnt blksiz xsize aggsize API RefNum
write           1.63       1.53       1.58       0.03   10.10286 0 32 32 10 1 0 1 0 0 1 524288 32 16777216 POSIX 0
read            1.43       1.19       1.31       0.07   12.27704 0 32 32 10 1 0 1 0 0 1 524288 32 16777216 POSIX 0


 * Base + patch as submitted
- "Big" I/Os:
Operation   Max(MiB)   Min(MiB)  Mean(MiB)     StdDev    Mean(s) Test# #Tasks tPN reps fPP reord reordoff reordrand seed segcnt blksiz xsize aggsize API RefNum
write        5773.60    5673.92    5729.01      29.63    5.71982 0 32 32 10 1 0 1 0 0 1 1073741824 524288 34359738368 POSIX 0
read         6097.96    6006.50    6059.40      26.74    5.40790 0 32 32 10 1 0 1 0 0 1 1073741824 524288 34359738368 POSIX 0

- "Small" I/Os:
Operation   Max(MiB)   Min(MiB)  Mean(MiB)     StdDev    Mean(s) Test# #Tasks tPN reps fPP reord reordoff reordrand seed segcnt blksiz xsize aggsize API RefNum
write           1.15       1.08       1.12       0.02   14.32230 0 32 32 10 1 0 1 0 0 1 524288 32 16777216 POSIX 0
read            1.18       1.06       1.10       0.04   14.51172 0 32 32 10 1 0 1 0 0 1 524288 32 16777216 POSIX 0


 * Base + patch as submitted + moving the header into req so the
allocation is "round" as suggested by Matthew
- "Big" I/Os:
Operation   Max(MiB)   Min(MiB)  Mean(MiB)     StdDev    Mean(s) Test# #Tasks tPN reps fPP reord reordoff reordrand seed segcnt blksiz xsize aggsize API RefNum
write        5878.75    5709.74    5798.96      57.12    5.65122 0 32 32 10 1 0 1 0 0 1 1073741824 524288 34359738368 POSIX 0
read         6089.83    6039.75    6072.64      14.78    5.39604 0 32 32 10 1 0 1 0 0 1 1073741824 524288 34359738368 POSIX 0

- "Small" I/Os
Operation   Max(MiB)   Min(MiB)  Mean(MiB)     StdDev    Mean(s) Test#
#Tasks tPN reps fPP reord reordoff reordrand seed segcnt blksiz xsize
aggsize API RefNum
write           1.33       1.26       1.29       0.02   12.38185 0 32 32
10 1 0 1 0 0 1 524288 32 16777216 POSIX 0
read            1.18       1.08       1.15       0.03   13.90525 0 32 32
10 1 0 1 0 0 1 524288 32 16777216 POSIX 0


 * Base + patchs submitted + round alloc + kmem cache in the client
struct
- "Big" I/Os
Operation   Max(MiB)   Min(MiB)  Mean(MiB)     StdDev    Mean(s) Test# #Tasks tPN reps fPP reord reordoff reordrand seed segcnt blksiz xsize aggsize API RefNum
write        5816.89    5729.58    5775.02      26.71    5.67422 0 32 32 10 1 0 1 0 0 1 1073741824 524288 34359738368 POSIX 0
read         6087.33    6032.62    6058.69      16.73    5.40847 0 32 32 10 1 0 1 0 0 1 1073741824 524288 34359738368 POSIX 0


- "Small" I/Os
Operation   Max(MiB)   Min(MiB)  Mean(MiB)     StdDev    Mean(s) Test# #Tasks tPN reps fPP reord reordoff reordrand seed segcnt blksiz xsize aggsize API RefNum
write           0.87       0.85       0.86       0.01   18.59584 0 32 32 10 1 0 1 0 0 1 524288 32 16777216 POSIX 0
read            0.89       0.86       0.88       0.01   18.26275 0 32 32 10 1 0 1 0 0 1 524288 32 16777216 POSIX 0
 -> I'm not sure why it's so different, actually; the cache doesn't turn
up in /proc/slabinfo so I'm figuring it got merged with kmalloc-1024 so
there should be no difference? And this turned out fine without KASAN...


-- 
Dominique
 
