Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE62CC41518
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC8C218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548345085;
	bh=RLB9RNlhOM/NiplUKHKYmnmvZACGRQI0IrxwPzUW1yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uG8auLib8huGgVhpqMXu2miGqmhVEgIOaG+Gbz/bXU5x9FZQJpi+shhoMSn4XzAZN
	 kW2GHNqK74NxgJEdnuY0GnFY61ipMBQ5UHLvOfOdpCM7znCKnCeJIAasUCRj3CmTwu
	 e7pTkXOWcwT9Kvm68L05MX65tXzi8YUAEQUCmcfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbfAXPvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:51:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:58834 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727566AbfAXPvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:51:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6AF6AB009;
        Thu, 24 Jan 2019 15:51:22 +0000 (UTC)
Date:   Thu, 24 Jan 2019 16:51:21 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190124155121.GQ4087@dhcp22.suse.cz>
References: <20190123223144.GA10798@chrisdown.name>
 <20190124082252.GD4087@dhcp22.suse.cz>
 <20190124152122.GG50184@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124152122.GG50184@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24-01-19 07:21:22, Tejun Heo wrote:
> Hello, Michal.
> 
> On Thu, Jan 24, 2019 at 09:22:52AM +0100, Michal Hocko wrote:
> > I do not think we can do that for two reasons. It breaks the existing
> > semantic userspace might depend on and more importantly this is not a
> > correct behavior IMO.
> 
> This is a valid concern but I'll come back to this later.
> 
> > You have to realize that stats are hierarchical because that is how we
> > account. Events represent a way to inform that something has happened at
> > the specific level of the tree though. If you do not setup low/high/max
> 
> This isn't true.  e.g. cgroup.events's populated event is
> hierarchical.  Everything in cgroup should be hierarchical by default.
> 
> > limit then you simply cannot expect to be informed those get hit because
> > they cannot by definition. Or put it other way, if you are waiting for
> > those events you really want to know the (sub)tree they happened and if
> > you propagate the event up the hierarchy you have hard time to tell that
> > (you would basically have to exclude all but the lowest one and that is
> > an awkward semantic at best.
> 
> I don't think it's a good idea to argue this for each piece of
> information.  Again, everything should be hierarchical unless there
> are clear and strong reasons against;

And I would argue that cgroups.events with its populated event is a
different thing because that is inherently a hierarchical property.  If
you compare that to low, min, max and oom those are events very specific
to the particular level of the hierarchy because it is an action at that
level that the event informs about. E.g. max event down the hierarchy is
a completely different thing from the upper level.  That sounds like a
pretty solid reason to differentiate here.

> otherwise, we end up with random
> mix of hierarchical and flat behaviors, something that we want to
> avoid the most - remember .use_hierarchy?.
> 
> > Maybe we want to document this better but I do not see we are going to
> > change the behavior.
> 
> I beg you to reconsider.  This was a clear oversight and the cgroup2
> usage is still relatively limited.  We sure can add local-specific
> counters if needed but must not mix local and hierarchical counters
> without a clear way to tell what's what.

If you really have a usecase for hierarchical events then I think the
only way without breaking existing userspace is to add a new set of
events. But I still believe that the current behavior makes a lot of
sense.
-- 
Michal Hocko
SUSE Labs
