Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DEBC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46BC20851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46BC20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbeLDIs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:48:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:51796 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725764AbeLDIs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:48:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D5B52B009;
        Tue,  4 Dec 2018 08:48:22 +0000 (UTC)
Date:   Tue, 4 Dec 2018 09:48:21 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ying.huang@intel.com, Andrea Arcangeli <aarcange@redhat.com>,
        s.priebe@profihost.ag, mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
Message-ID: <20181204084821.GB1286@dhcp22.suse.cz>
References: <CAHk-=wjgRO-=NPaU9EmrdC3it3o7kvf4u7sewv3crtNLkE13Hg@mail.gmail.com>
 <CAHk-=wjgpWOA7zQ9H5=Zj6KQijm5CBXZc7J=it6C5gdEV0hb5Q@mail.gmail.com>
 <20181203181456.GK31738@dhcp22.suse.cz>
 <CAHk-=whrfDw4yV4h2ijbX3vpXf5m4hzJ5pGX7_v6pU31RGib-g@mail.gmail.com>
 <20181203183050.GL31738@dhcp22.suse.cz>
 <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com>
 <20181203185954.GM31738@dhcp22.suse.cz>
 <alpine.DEB.2.21.1812031237340.192288@chino.kir.corp.google.com>
 <20181203212539.GR31738@dhcp22.suse.cz>
 <alpine.DEB.2.21.1812031345180.224765@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812031345180.224765@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 03-12-18 13:53:21, David Rientjes wrote:
> On Mon, 3 Dec 2018, Michal Hocko wrote:
> 
> > > I think extending functionality so thp can be allocated remotely if truly 
> > > desired is worthwhile
> > 
> > This is a complete NUMA policy antipatern that we have for all other
> > user memory allocations. So far you have to be explicit for your numa
> > requirements. You are trying to conflate NUMA api with MADV and that is
> > just conflating two orthogonal things and that is just wrong.
> > 
> 
> No, the page allocator change for both my patch and __GFP_COMPACT_ONLY has 
> nothing to do with any madvise() mode.  It has to do with where thp 
> allocations are preferred.  Yes, this is different than other memory 
> allocations where it doesn't cause a 13.9% access latency regression for 
> the lifetime of a binary for users who back their text with hugepages.  
> MADV_HUGEPAGE still has its purpose to try synchronous memory compaction 
> at fault time under all thp defrag modes other than "never".  The specific 
> problem being reported here, and that both my patch and __GFP_COMPACT_ONLY 
> address, is the pointless reclaim activity that does not assist in making 
> compaction more successful.

You do not address my concern though. Sure there are reclaim related
issues. Nobody is questioning that. But that is only half of the
problem.

The thing I am really up to here is that reintroduction of
__GFP_THISNODE, which you are pushing for, will conflate madvise mode
resp. defrag=always with a numa placement policy because the allocation
doesn't fallback to a remote node.

And that is a fundamental problem and the antipattern I am talking
about. Look at it this way. All normal allocations are utilizing all the
available memory even though they might hit a remote latency penalty. If
you do care about NUMA placement you have an API to enforce a specific
placement.  What is so different about THP to behave differently. Do
we really want to later invent an API to actually allow to utilize all
the memory? There are certainly usecases (that triggered the discussion
previously) that do not mind the remote latency because all other
benefits simply outweight it?

That being said what should users who want to use all the memory do to
use as many THPs as possible?
-- 
Michal Hocko
SUSE Labs
