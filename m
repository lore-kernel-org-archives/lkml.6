Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6252C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87CA020880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CA020880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeILT0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:26:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:43758 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726537AbeILT0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:26:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8C1F9AD18;
        Wed, 12 Sep 2018 14:21:27 +0000 (UTC)
Date:   Wed, 12 Sep 2018 16:21:26 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: [PATCH] mm, thp: relax __GFP_THISNODE for MADV_HUGEPAGE mappings
Message-ID: <20180912142126.GM10951@dhcp22.suse.cz>
References: <20180907130550.11885-1-mhocko@kernel.org>
 <alpine.DEB.2.21.1809101253080.177111@chino.kir.corp.google.com>
 <20180911115613.GR10951@dhcp22.suse.cz>
 <20180912135417.GA15194@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912135417.GA15194@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-09-18 09:54:17, Andrea Arcangeli wrote:
> Hello,
> 
> On Tue, Sep 11, 2018 at 01:56:13PM +0200, Michal Hocko wrote:
> > Well, it seems that expectations differ for users. It seems that kvm
> > users do not really agree with your interpretation.
> 
> Like David also mentioned here:
> 
> lkml.kernel.org/r/alpine.DEB.2.21.1808211021110.258924@chino.kir.corp.google.com
> 
> depends on the hardware what is a win, so there's no one size fits
> all.
> 
> For two sockets providing remote THP to KVM is likely a win, but
> changing the defaults depending on boot-time NUMA topology makes
> things less deterministic and it's also impossible to define an exact
> break even point.
> 
> > I do realize that this is a gray zone because nobody bothered to define
> > the semantic since the MADV_HUGEPAGE has been introduced (a826e422420b4
> > is exceptionaly short of information). So we are left with more or less
> > undefined behavior and define it properly now. As we can see this might
> > regress in some workloads but I strongly suspect that an explicit
> > binding sounds more logical approach than a thp specific mpol mode. If
> > anything this should be a more generic memory policy basically saying
> > that a zone/node reclaim mode should be enabled for the particular
> > allocation.
> 
> MADV_HUGEPAGE means the allocation is long lived, so the cost of
> compaction is worth it in direct reclaim. Not much else. That is not
> the problem.

It seems there is no general agreement here. My understanding is that
this means that the user really prefers THP for whatever reasons.

> The problem is that even if you ignore the breakage and regression to
> real life workloads, what is happening right now obviously would
> require root privilege but MADV_HUEGPAGE requires no root privilege.

I do not follow.

> Swapping heavy because MADV_HUGEPAGE when there are gigabytes free on
> other nodes and not even 4k would be swapped-out with THP turned off
> in sysfs, is simply not possibly what MADV_HUGEPAGE could have been
> about, and it's a kernel regression that never existed until that
> commit that added __GFP_THISNODE to the default THP heuristic in
> mempolicy.

agreed

> I think we should defer the problem of what is better between 4k NUMA
> local or remote THP by default for later, I provided two options
> myself because it didn't matter so much which option we picked in the
> short term, as long as the bug was fixed.
> 
> I wasn't particularly happy about your patch because it still swaps
> with certain defrag settings which is still allowing things that
> shouldn't happen without some kind of privileged capability.

Well, I am not really sure about defrag=always. I would rather care
about the default behavior to plug the regression first. And think about
`always' mode on top. Or is this a no-go from your POV?

-- 
Michal Hocko
SUSE Labs
