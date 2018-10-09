Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502EFC43441
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA6D2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA6D2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbeJJGXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 02:23:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbeJJGXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 02:23:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E14D2307D861;
        Tue,  9 Oct 2018 23:03:53 +0000 (UTC)
Received: from sky.random (ovpn-120-22.rdu2.redhat.com [10.10.120.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD2F27C81E;
        Tue,  9 Oct 2018 23:03:53 +0000 (UTC)
Date:   Tue, 9 Oct 2018 19:03:52 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mel Gorman <mgorman@suse.de>, David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: thp:  relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
Message-ID: <20181009230352.GE9307@redhat.com>
References: <20180925120326.24392-2-mhocko@kernel.org>
 <alpine.DEB.2.21.1810041302330.16935@chino.kir.corp.google.com>
 <20181005073854.GB6931@suse.de>
 <alpine.DEB.2.21.1810051320270.202739@chino.kir.corp.google.com>
 <20181005232155.GA2298@redhat.com>
 <alpine.DEB.2.21.1810081303060.221006@chino.kir.corp.google.com>
 <20181009094825.GC6931@suse.de>
 <20181009122745.GN8528@dhcp22.suse.cz>
 <20181009130034.GD6931@suse.de>
 <20181009142510.GU8528@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009142510.GU8528@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 09 Oct 2018 23:03:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 04:25:10PM +0200, Michal Hocko wrote:
> On Tue 09-10-18 14:00:34, Mel Gorman wrote:
> > On Tue, Oct 09, 2018 at 02:27:45PM +0200, Michal Hocko wrote:
> > > [Sorry for being slow in responding but I was mostly offline last few
> > >  days]
> > > 
> > > On Tue 09-10-18 10:48:25, Mel Gorman wrote:
> > > [...]
> > > > This goes back to my point that the MADV_HUGEPAGE hint should not make
> > > > promises about locality and that introducing MADV_LOCAL for specialised
> > > > libraries may be more appropriate with the initial semantic being how it
> > > > treats MADV_HUGEPAGE regions.
> > > 
> > > I agree with your other points and not going to repeat them. I am not
> > > sure madvise s the best API for the purpose though. We are talking about
> > > memory policy here and there is an existing api for that so I would
> > > _prefer_ to reuse it for this purpose.
> > > 
> > 
> > I flip-flopped on that one in my head multiple times on the basis of
> > how strict it should be. Memory policies tend to be black or white --
> > bind here, interleave there, etc. It wasn't clear to me what the best
> > policy would be to describe "allocate local as best as you can but allow
> > fallbacks if necessary".

MPOL_PREFERRED is not black and white. In fact I asked David earlier
if MPOL_PREFERRED could check if it would already be a good fit for
this. Still the point is it requires privilege (and for a good
reason).

> I was thinking about MPOL_NODE_PROXIMITY with the following semantic:
> - try hard to allocate from a local or very close numa node(s) even when
> that requires expensive operations like the memory reclaim/compaction
> before falling back to other more distant numa nodes.

If MPOL_PREFERRED can't work something like this could be added.

I think "madvise vs mbind" is more an issue of "no-permission vs
permission" required. And if the processes ends up swapping out all
other process with their memory already allocated in the node, I think
some permission is correct to be required, in which case an mbind
looks a better fit. MPOL_PREFERRED also looks a first candidate for
investigation as it's already not black and white and allows spillover
and may already do the right thing in fact if set on top of
MADV_HUGEPAGE.

Thanks,
Andrea
