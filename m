Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF207C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C26C20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C26C20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeLEKPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:15:16 -0500
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:42555 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726171AbeLEKPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:15:16 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id 4123D1C229B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Dec 2018 10:15:14 +0000 (GMT)
Received: (qmail 11397 invoked from network); 5 Dec 2018 10:15:14 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.245.71])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 5 Dec 2018 10:15:13 -0000
Date:   Wed, 5 Dec 2018 10:15:12 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     David Rientjes <rientjes@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [patch 0/2 for-4.20] mm, thp: fix remote access and allocation
 regressions
Message-ID: <20181205101512.GY23260@techsingularity.net>
References: <alpine.DEB.2.21.1812031545080.161134@chino.kir.corp.google.com>
 <20181204073850.GW31738@dhcp22.suse.cz>
 <alpine.DEB.2.21.1812041415270.159770@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812041415270.159770@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 02:25:54PM -0800, David Rientjes wrote:
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

I'll make the same point as before, the form the fragmentation takes
matters as well as the types of pages that are resident and whether
they are active or not. It affects the level of work the system does
as well as the overall success rate of operations (be it reclaim, THP
allocation, compaction, whatever). This is why a reproduction case that is
representative of the problem you're facing on the real workload matters
would have been helpful because then any alternative proposal could have
taken your workload into account during testing.

-- 
Mel Gorman
SUSE Labs
