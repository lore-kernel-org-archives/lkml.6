Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518E1C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2256E214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548679917;
	bh=ya2u3y20UCipfj7wruYu3vAMWhRAs3dbQVbq0grBMvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gjSz6yniq+Ghvox9H0nZYxI8n9qDC0o/DtIed64ia0iIiQb7RlS6te5zwVi0UwPsa
	 CKS0i5BWGFhBubLOiIbuXUXZ2A2m755g7Pkynhhk2phGCsdwGF75gSDNErtYgGcjwF
	 +lAxdnqBiVrRh8r9qqOZP0azGn2ctKH2EE8Py9Pg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfA1Mvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:51:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:37136 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726647AbfA1Mvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:51:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DBF96AD76;
        Mon, 28 Jan 2019 12:51:52 +0000 (UTC)
Date:   Mon, 28 Jan 2019 13:51:51 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190128125151.GI18811@dhcp22.suse.cz>
References: <20190123223144.GA10798@chrisdown.name>
 <20190124082252.GD4087@dhcp22.suse.cz>
 <20190124160009.GA12436@cmpxchg.org>
 <20190124170117.GS4087@dhcp22.suse.cz>
 <20190124182328.GA10820@cmpxchg.org>
 <20190125074824.GD3560@dhcp22.suse.cz>
 <20190125165152.GK50184@devbig004.ftw2.facebook.com>
 <20190125173713.GD20411@dhcp22.suse.cz>
 <20190125182808.GL50184@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125182808.GL50184@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-01-19 10:28:08, Tejun Heo wrote:
> Hello, Michal.
> 
> On Fri, Jan 25, 2019 at 06:37:13PM +0100, Michal Hocko wrote:
> > > What if a user wants to monitor any ooms in the subtree tho, which is
> > > a valid use case?
> > 
> > How is that information useful without know which memcg the oom applies
> > to?
> 
> For example, a workload manager watching over a subtree for a job with
> nested memory limits set by the job itself.  It wants to take action
> (reporting and possibly other remediative actions) when something goes
> wrong in the delegated subtree but isn't involved in how the subtree
> is configured inside.

Yes, I understand this part, but it is not clear to me, _how_ to report
anything sensible without knowing _what_ has caused the event. You can
walk the cgroup hierarchy and compare cached results with new ones but
this is a) racy and b) clumsy.

> > > If local event monitoring is useful and it can be,
> > > let's add separate events which are clearly identifiable to be local.
> > > Right now, it's confusing like hell.
> > 
> > From a backward compatible POV it should be a new interface added.
> 
> That sure is an option for use cases like above but it has the
> downside of carrying over the confusing interface into the indefinite
> future.

I actually believe that this is not such a big deal. For one thing the
current events are actually helpful to watch the reclaim/setup behavior.

> Again, I'd like to point back at how we changed the
> accounting write and trim accounting because the benefits outweighted
> the risks.
> 
> > Please note that I understand that this might be confusing with the rest
> > of the cgroup APIs but considering that this is the first time somebody
> > is actually complaining and the interface is "production ready" for more
> > than three years I am not really sure the situation is all that bad.
> 
> cgroup2 uptake hasn't progressed that fast.  None of the major distros
> or container frameworks are currently shipping with it although many
> are evaluating switching.  I don't think I'm too mistaken in that we
> (FB) are at the bleeding edge in terms of adopting cgroup2 and its
> various new features and are hitting these corner cases and oversights
> in the process.  If there are noticeable breakages arising from this
> change, we sure can backpaddle but I think the better course of action
> is fixing them up while we can.

I do not really think you can go back. You cannot simply change semantic
back and forth because you just break new users.

Really, I do not see the semantic changing after more than 3 years of
production ready interface. If you really believe we need a hierarchical
notification mechanism for the reclaim activity then add a new one.
-- 
Michal Hocko
SUSE Labs
