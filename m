Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D864CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A975621738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548687134;
	bh=m/mm1BJO4BgxHB4S0LsQCBlCh3wBU/A6rrGDYXlhn9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jquo9C5Jt9a0rB/SZoZc4WHN//bG6TqujgSpz7kaKDpAhQ1PO0ZwixU3SsaAJutnB
	 0JMNt+JDHdSMOnabEJJv78ZlaNI3txVG9KnFDDQZek60kDLBFuqQ0cBbSlFJYMosRZ
	 +0B1yvzh+gPa2iaibd4AE8LEnO1a+i1weHfXyQNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfA1OwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:52:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:57570 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726678AbfA1OwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:52:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3AF52AEF3;
        Mon, 28 Jan 2019 14:52:11 +0000 (UTC)
Date:   Mon, 28 Jan 2019 15:52:10 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190128145210.GM18811@dhcp22.suse.cz>
References: <20190124082252.GD4087@dhcp22.suse.cz>
 <20190124160009.GA12436@cmpxchg.org>
 <20190124170117.GS4087@dhcp22.suse.cz>
 <20190124182328.GA10820@cmpxchg.org>
 <20190125074824.GD3560@dhcp22.suse.cz>
 <20190125165152.GK50184@devbig004.ftw2.facebook.com>
 <20190125173713.GD20411@dhcp22.suse.cz>
 <20190125182808.GL50184@devbig004.ftw2.facebook.com>
 <20190128125151.GI18811@dhcp22.suse.cz>
 <20190128142816.GM50184@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128142816.GM50184@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28-01-19 06:28:16, Tejun Heo wrote:
> Hello, Michal.
> 
> On Mon, Jan 28, 2019 at 01:51:51PM +0100, Michal Hocko wrote:
> > > For example, a workload manager watching over a subtree for a job with
> > > nested memory limits set by the job itself.  It wants to take action
> > > (reporting and possibly other remediative actions) when something goes
> > > wrong in the delegated subtree but isn't involved in how the subtree
> > > is configured inside.
> > 
> > Yes, I understand this part, but it is not clear to me, _how_ to report
> > anything sensible without knowing _what_ has caused the event. You can
> > walk the cgroup hierarchy and compare cached results with new ones but
> > this is a) racy and b) clumsy.
> 
> All .events files generate aggregated stateful notifications.  For
> anyone to do anything, they'd have to remember the previous state to
> identify what actually happened.  Being hierarchical, it'd of course
> need to walk down when an event triggers.

And how do you do that in a raceless fashion?

> > > That sure is an option for use cases like above but it has the
> > > downside of carrying over the confusing interface into the indefinite
> > > future.
> > 
> > I actually believe that this is not such a big deal. For one thing the
> > current events are actually helpful to watch the reclaim/setup behavior.
> 
> Sure, it isn't something critical.  It's just confusing and I think
> it'd be better to improve.
> 
> > I do not really think you can go back. You cannot simply change semantic
> > back and forth because you just break new users.
> > 
> > Really, I do not see the semantic changing after more than 3 years of
> > production ready interface. If you really believe we need a hierarchical
> > notification mechanism for the reclaim activity then add a new one.
> 
> I don't see it as black and white as you do.  Let's agree to disagree.
> I'll ack the patch and note the disagreement.

Considering the justification behhind this change I really do not see
other option than nack this change. There is simply no _strong_ reason
to change the behavior. Even if the current behavior is confusing, the
documentation can be improved to be more specific. If there is a strong
demand for hierarchical reporting then add a new interface. But I have
to say that I would consider such a reporting clumsy at best.
-- 
Michal Hocko
SUSE Labs
