Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66380C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0DD20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0DD20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeLEHk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:40:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:55892 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbeLEHk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:40:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BCC9FAE7A;
        Wed,  5 Dec 2018 07:40:53 +0000 (UTC)
Date:   Wed, 5 Dec 2018 08:40:52 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        s.priebe@profihost.ag, mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [patch 0/2 for-4.20] mm, thp: fix remote access and allocation
 regressions
Message-ID: <20181205074052.GU1286@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1812031545080.161134@chino.kir.corp.google.com>
 <20181204073850.GW31738@dhcp22.suse.cz>
 <alpine.DEB.2.21.1812041415270.159770@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812041415270.159770@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04-12-18 14:25:54, David Rientjes wrote:
> On Tue, 4 Dec 2018, Michal Hocko wrote:
> 
> > > This fixes a 13.9% of remote memory access regression and 40% remote
> > > memory allocation regression on Haswell when the local node is fragmented
> > > for hugepage sized pages and memory is being faulted with either the thp
> > > defrag setting of "always" or has been madvised with MADV_HUGEPAGE.
> > > 
> > > The usecase that initially identified this issue were binaries that mremap
> > > their .text segment to be backed by transparent hugepages on startup.
> > > They do mmap(), madvise(MADV_HUGEPAGE), memcpy(), and mremap().
> > 
> > Do you have something you can share with so that other people can play
> > and try to reproduce?
> > 
> 
> This is a single MADV_HUGEPAGE usecase, there is nothing special about it.  
> It would be the same as if you did mmap(), madvise(MADV_HUGEPAGE), and 
> faulted the memory with a fragmented local node and then measured the 
> remote access latency to the remote hugepage that occurs without setting 
> __GFP_THISNODE.  You can also measure the remote allocation latency by 
> fragmenting the entire system and then faulting.
> 
> (Remapping the text segment only involves parsing /proc/self/exe, mmap, 
> madvise, memcpy, and mremap.)

How does this reflect your real workload and regressions in it. It
certainly shows the worst case behavior where the access penalty is
prevalent while there are no other metrics which might be interesting or
even important. E.g. page table savings or the TLB pressure in general
when THP fail too eagerly.
As Anrea mentioned there are really valid cases where the remote latency
pays off.

Have you actually seen the advertised regression in the real workload
and do you have any means to simulate that workload.

> > > This requires a full revert and partial revert of commits merged during
> > > the 4.20 rc cycle.  The full revert, of ac5b2c18911f ("mm: thp: relax
> > > __GFP_THISNODE for MADV_HUGEPAGE mappings"), was anticipated to fix large
> > > amounts of swap activity on the local zone when faulting hugepages by
> > > falling back to remote memory.  This remote allocation causes the access
> > > regression and, if fragmented, the allocation regression.
> > 
> > Have you tried to measure any of the workloads Mel and Andrea have
> > pointed out during the previous review discussion? In other words what
> > is the impact on the THP success rate and allocation latencies for other
> > usecases?
> 
> It isn't a property of the workload, it's a property of the how fragmented 
> both local and remote memory is.  In Andrea's case, I believe he has 
> stated that memory compaction has failed locally and the resulting reclaim 
> activity ends up looping and causing it the thrash the local node whereas 
> 75% of remote memory is free and not fragmented.  So we have local 
> fragmentation and reclaim is very expensive to enable compaction to 
> succeed, if it ever does succeed[*], and mostly free remote memory.
> 
> If remote memory is also fragmented, Andrea's case will run into a much 
> more severe swap storm as a result of not setting __GFP_THISNODE.  The 
> premise of the entire change is that his remote memory is mostly free so 
> fallback results in a quick allocation.  For balanced nodes, that's not 
> going to be the case.  The fix to prevent the heavy reclaim activity is to 
> set __GFP_NORETRY as the page allocator suspects, which patch 2 here does.

You are not answering my question and I take it as you haven't actually
tested this in a variety of workload and base your assumptions on an
artificial worst case scenario. Please correct me if I am wrong.

-- 
Michal Hocko
SUSE Labs
