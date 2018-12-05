Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D03C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCA62081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dy1JgZnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BCA62081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbeLEAr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:47:27 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33265 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeLEAr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:47:26 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so9163422plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 16:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=2fDtvRlcYUV/Ba0HAIBB/r+NMGqCb1B6XvYwDlx/Wzs=;
        b=dy1JgZnSAZdoXKNtu/APNHvQruM4yYc3y9Hj7sKfgDBKWZ9u82hhwQTNl9JpRvJI7t
         Q/VHQAyppS05KT4Xm6t+0UoztvQZnBW8gEdrhyCPtiMRBEO1SKkNvNOLMbMijKxLBxSM
         vKRzstf83k37O+avBUstQrWon5s/C8QheoSOjrHlYCPIr9/VIeJ15fAJsMLD2es8Qina
         /PGZfTRAJgW2s7GJGJ0ipIHDXuTeV4MA1EwKGRqCvoDuDGD71Q+XukRJyqYWFVhTIH6G
         QRHf3QsNRyOu58RnkU1t9TQ0Nrf8e1rYJmDw27yztomOeOTXB3RCz5EFnt8FRisdor4o
         1E6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=2fDtvRlcYUV/Ba0HAIBB/r+NMGqCb1B6XvYwDlx/Wzs=;
        b=NRMDOYg1GDw8jFk6RO8x9Kj4Y9IodQD6orDTIcWGrwAtguNGxIZc0m5n0hjmfKwB+u
         yO+mt0Oa7OHWA+2Uo5geXtfFLGYWP0UNzcI/B8xKm3fji+uzJ9jzKZ/X9X2rSc4GlPBU
         nK7nnT1Vlf0oAxIz/H2RJCUA/mvAcZvdN3DvtxEdKP7mb1WYt2Ij4PBObTZMeeZ/RD6K
         +QdI5a+f9PYt+3bnQyqMACzmPyu65yg3tsV4s14OWMQZpgJE31sHizSF2sUVUsyfCDtS
         U6p7KWUoc2uGDBfVhhI4RFXMeVmn1g7MtmEpr6g13Zhbj1LMqStZRn3vgCZ6bYhLnXNu
         DJWA==
X-Gm-Message-State: AA+aEWbUrQpFBKLLlcBsO++liiEYQrQynMUfOOUHOU7Wn4fxr8dUXMe+
        8ThEbqveBEsx0BE3GYGkJXvKJQ==
X-Google-Smtp-Source: AFSGD/VX+mGRmwrPtZb1OamU8kFNVK7w9OuD2Mbou6/ui14bT7U7OyFOetCJEoIcKogQsr7Tq7KLbQ==
X-Received: by 2002:a17:902:b282:: with SMTP id u2mr22412438plr.89.1543970845675;
        Tue, 04 Dec 2018 16:47:25 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id g136sm25982035pfb.154.2018.12.04.16.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 16:47:24 -0800 (PST)
Date:   Tue, 4 Dec 2018 16:47:23 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mel Gorman <mgorman@techsingularity.net>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, mhocko@kernel.org,
        ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
In-Reply-To: <20181204104558.GV23260@techsingularity.net>
Message-ID: <alpine.DEB.2.21.1812041609160.213718@chino.kir.corp.google.com>
References: <20181203181456.GK31738@dhcp22.suse.cz> <CAHk-=whrfDw4yV4h2ijbX3vpXf5m4hzJ5pGX7_v6pU31RGib-g@mail.gmail.com> <20181203183050.GL31738@dhcp22.suse.cz> <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com> <20181203185954.GM31738@dhcp22.suse.cz>
 <CAHk-=wiNKLH2Pbnr9z2SvmDhf7XT==U6NPRkQNX13Sg-FRk0Yw@mail.gmail.com> <20181203201214.GB3540@redhat.com> <CAHk-=wg=6uxAJMbvGJC-5CSikC8OdqsjE1vw+DsCMj=2SNSnZg@mail.gmail.com> <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com>
 <64a4aec6-3275-a716-8345-f021f6186d9b@suse.cz> <20181204104558.GV23260@techsingularity.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018, Mel Gorman wrote:

> What should also be kept in mind is that we should avoid conflating
> locality preferences with THP preferences which is separate from THP
> allocation latencies. The whole __GFP_THISNODE approach is pushing too
> hard on locality versus huge pages when MADV_HUGEPAGE or always-defrag
> are used which is very unfortunate given that MADV_HUGEPAGE in itself says
> nothing about locality -- that is the business of other madvise flags or
> a specific policy.

We currently lack those other madvise modes or mempolicies: mbind() is not 
a viable alternative because we do not want to oom kill when local memory 
is depleted, we want to fallback to remote memory.  In my response to 
Michal, I noted three possible usecases that MADV_HUGEPAGE either 
currently has or has taken before: direct compaction/reclaim, avoid 
increased rss, and allow fallback to remote memory.  It's certainly not 
the business of one madvise mode to define this.  Thus, I'm trying to 
return to the behavior that was in 4.1 and what was restored three years 
ago because suddenly changing the behavior to allow remote allocation 
causes real-world regressions.

> Using remote nodes is bad but reclaiming excessively
> and pushing data out of memory is worse as the latency to fault data back
> from disk is higher than a remote access.
> 

That's discussing two things at the same time: local fragmentation and 
local low-on-memory conditions.  If compaction quickly fails and local 
pages are available as fallback, that requires no reclaim.  If we're truly 
low-on-memory locally then it is obviously better to allocate remotely 
than aggressively reclaim.

> Andrea already pointed it out -- workloads that fit within a node are happy
> to reclaim local memory, particularly in the case where the existing data
> is old which is the ideal for David. Workloads that do not fit within a
> node will often prefer using remote memory -- either THP or base pages
> in the general case and THP for definite in the KVM case. While KVM
> might not like remote memory, using THP at least reduces the page table
> access overhead even if the access is remote and eventually automatic
> NUMA balancing might intervene.
> 

Sure, but not at the cost of regressing real-world workloads; what is 
being asked for here is legitimate and worthy of an extension, but since 
the long-standing behavior has been to use __GFP_THISNODE and people 
depend on that for NUMA locality, can we not fix the swap storm and look 
to extending the API to include workloads that span multiple nodes?

> I have *one* result of the series on a 1-socket machine running
> "thpscale". It creates a file, punches holes in it to create a
> very light form of fragmentation and then tries THP allocations
> using madvise measuring latency and success rates. It's the
> global-dhp__workload_thpscale-madvhugepage in mmtests using XFS as the
> filesystem.
> 
> thpscale Fault Latencies
>                                     4.20.0-rc4             4.20.0-rc4
>                                 mmots-20181130       gfpthisnode-v1r1
> Amean     fault-base-3      5358.54 (   0.00%)     2408.93 *  55.04%*
> Amean     fault-base-5      9742.30 (   0.00%)     3035.25 *  68.84%*
> Amean     fault-base-7     13069.18 (   0.00%)     4362.22 *  66.62%*
> Amean     fault-base-12    14882.53 (   0.00%)     9424.38 *  36.67%*
> Amean     fault-base-18    15692.75 (   0.00%)    16280.03 (  -3.74%)
> Amean     fault-base-24    28775.11 (   0.00%)    18374.84 *  36.14%*
> Amean     fault-base-30    42056.32 (   0.00%)    21984.55 *  47.73%*
> Amean     fault-base-32    38634.26 (   0.00%)    22199.49 *  42.54%*
> Amean     fault-huge-1         0.00 (   0.00%)        0.00 (   0.00%)
> Amean     fault-huge-3      3628.86 (   0.00%)      963.45 *  73.45%*
> Amean     fault-huge-5      4926.42 (   0.00%)     2959.85 *  39.92%*
> Amean     fault-huge-7      6717.15 (   0.00%)     3828.68 *  43.00%*
> Amean     fault-huge-12    11393.47 (   0.00%)     5772.92 *  49.33%*
> Amean     fault-huge-18    16979.38 (   0.00%)     4435.95 *  73.87%*
> Amean     fault-huge-24    16558.00 (   0.00%)     4416.46 *  73.33%*
> Amean     fault-huge-30    20351.46 (   0.00%)     5099.73 *  74.94%*
> Amean     fault-huge-32    23332.54 (   0.00%)     6524.73 *  72.04%*
> 
> So, looks like massive latency improvements but then the THP allocation
> success rates
> 
> thpscale Percentage Faults Huge
>                                4.20.0-rc4             4.20.0-rc4
>                            mmots-20181130       gfpthisnode-v1r1
> Percentage huge-3        95.14 (   0.00%)        7.94 ( -91.65%)
> Percentage huge-5        91.28 (   0.00%)        5.00 ( -94.52%)
> Percentage huge-7        86.87 (   0.00%)        9.36 ( -89.22%)
> Percentage huge-12       83.36 (   0.00%)       21.03 ( -74.78%)
> Percentage huge-18       83.04 (   0.00%)       30.73 ( -63.00%)
> Percentage huge-24       83.74 (   0.00%)       27.47 ( -67.20%)
> Percentage huge-30       83.66 (   0.00%)       31.85 ( -61.93%)
> Percentage huge-32       83.89 (   0.00%)       29.09 ( -65.32%)
> 
> They're down the toilet. 3 threads are able to get 95% of the requested
> THP pages with Andrews tree as of Nov 30th. David's patch drops that to
> 8% success rate.
> 

I'm not as concerned about fault latency for these binaries that remap 
their text segments to be backed by transparent hugepages, that's 
secondary to the primary concern: access latency.  I agree that faulting 
thp is more likely successful if allowed to access remote memory; I'm 
reporting the regression in the access latency to that memory for the 
lifetime of the binary.

> "Compaction efficiency" which takes success vs failure rate into account
> goes from 45% to 1%. Compaction scan efficiency, which is how many pages
> for migration are scanned vs how many are scanned as free targets goes
> from 21% to 1%.
> 
> I do not consider this to be a good outcome and hence will not be acking
> the patches.
> 
> I would also re-emphasise that a major problem with addressing this
> problem is that we do not have a general reproducible test case for
> David's scenario where as we do have reproduction cases for the others.
> They're not related to KVM but that doesn't matter because it's enough
> to have a memory hog try allocating more memory than fits on a single node.
> 

It's trivial to reproduce this issue: fragment all local memory that 
compaction cannot resolve, do posix_memalign() for hugepage aligned 
memory, and measure the access latency.  To fragment all local memory, you 
can simply insert a kernel module and allocate high-order memory (just do 
kmem_cache_alloc_node() or get_page() to pin it so compaction fails or 
punch holes in the file as you did above).  You can do this for all memory 
rather than the local node to measure the even more severe allocation 
latency regression that not setting __GFP_THISNODE introduces.
