Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C114C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183B6218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548925094;
	bh=Lf1+wGMS3+pADaeiXoIvnPWpN03ZNiy8XJdc3U1H9qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SrVPYxD2eNXwVxmdXuh6HqILBrrpCE6ttg11ahLnNjVneurj+F2+rLJCuEExA+oXl
	 nEI2vPgoUwD8p/vhyeyNAIjCxW/nX064eyvzAkOLOYBQyXs1LRm1Ddc1lJEAfrSHL2
	 P9nlLFCZ7QkcxbXhNCULTOeXHsGUdvAFJDC4NylE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfAaI6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:58:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:60844 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbfAaI6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:58:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AFF46AD8A;
        Thu, 31 Jan 2019 08:58:09 +0000 (UTC)
Date:   Thu, 31 Jan 2019 09:58:08 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190131085808.GO18811@dhcp22.suse.cz>
References: <20190124170117.GS4087@dhcp22.suse.cz>
 <20190124182328.GA10820@cmpxchg.org>
 <20190125074824.GD3560@dhcp22.suse.cz>
 <20190125165152.GK50184@devbig004.ftw2.facebook.com>
 <20190125173713.GD20411@dhcp22.suse.cz>
 <20190125182808.GL50184@devbig004.ftw2.facebook.com>
 <20190128125151.GI18811@dhcp22.suse.cz>
 <20190130192345.GA20957@cmpxchg.org>
 <20190130200559.GI18811@dhcp22.suse.cz>
 <20190130213131.GA13142@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130213131.GA13142@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30-01-19 16:31:31, Johannes Weiner wrote:
> On Wed, Jan 30, 2019 at 09:05:59PM +0100, Michal Hocko wrote:
[...]
> > I thought I have already mentioned an example. Say you have an observer
> > on the top of a delegated cgroup hierarchy and you setup limits (e.g. hard
> > limit) on the root of it. If you get an OOM event then you know that the
> > whole hierarchy might be underprovisioned and perform some rebalancing.
> > Now you really do not care that somewhere down the delegated tree there
> > was an oom. Such a spurious event would just confuse the monitoring and
> > lead to wrong decisions.
> 
> You can construct a usecase like this, as per above with OOM, but it's
> incredibly unlikely for something like this to exist. There is plenty
> of evidence on adoption rate that supports this: we know where the big
> names in containerization are; we see the things we run into that have
> not been reported yet etc.
> 
> Compare this to real problems this has already caused for
> us. Multi-level control and monitoring is a fundamental concept of the
> cgroup design, so naturally our infrastructure doesn't monitor and log
> at the individual job level (too much data, and also kind of pointless
> when the jobs are identical) but at aggregate parental levels.
> 
> Because of this wart, we have missed problematic configurations when
> the low, high, max events were not propagated as expected (we log oom
> separately, so we still noticed those). Even once we knew about it, we
> had trouble tracking these configurations down for the same reason -
> the data isn't logged, and won't be logged, at this level.

Yes, I do understand that you might be interested in the hierarchical
accounting.

> Adding a separate, hierarchical file would solve this one particular
> problem for us, but it wouldn't fix this pitfall for all future users
> of cgroup2 (which by all available evidence is still most of them) and
> would be a wart on the interface that we'd carry forever.

I understand even this reasoning but if I have to chose between a risk
of user breakage that would require to reimplement the monitoring or an
API incosistency I vote for the first option. It is unfortunate but this
is the way we deal with APIs and compatibility.

> Adding a note in cgroup-v2.txt doesn't make up for the fact that this
> behavior flies in the face of basic UX concepts that underly the
> hierarchical monitoring and control idea of the cgroup2fs.
> 
> The fact that the current behavior MIGHT HAVE a valid application does
> not mean that THIS FILE should be providing it. It IS NOT an argument
> against this patch here, just an argument for a separate patch that
> adds this functionality in a way that is consistent with the rest of
> the interface (e.g. systematically adding .local files).
> 
> The current semantics have real costs to real users. You cannot
> dismiss them or handwave them away with a hypothetical regression.
> 
> I would really ask you to consider the real world usage and adoption
> data we have on cgroup2, rather than insist on a black and white
> answer to this situation.

Those users requiring the hierarchical beahvior can use the new file
without any risk of breakages so I really do not see why we should
undertake the risk and do it the other way around.
-- 
Michal Hocko
SUSE Labs
