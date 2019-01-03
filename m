Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A40C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C20217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546541627;
	bh=DQDF3jKF8fdNGBlQpm3U7kPBpjQHeZRdpKrbZzma2Io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ig/z9G7G92N4NAVEDc7wkPQv3voEYHxxjLWFUNl5FOIvTSyXoWlaD9+qWB1FaLuJ/
	 ZZTd67ItGczE1uGa4Lcme83u83avDYuU/uX63wlPd9U1bv8791vkC0pN5tNnzzXqbx
	 4VqHU0dz+DjJQAyBZePLZpZxi1CAWqz+JOc/rlIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfACSxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 13:53:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:37586 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726154AbfACSxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 13:53:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9226CAF8D;
        Thu,  3 Jan 2019 18:53:34 +0000 (UTC)
Date:   Thu, 3 Jan 2019 19:53:33 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] mm: memcontrol: delayed force empty
Message-ID: <20190103185333.GX31793@dhcp22.suse.cz>
References: <1546459533-36247-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190103101215.GH31793@dhcp22.suse.cz>
 <b3ad06ed-f620-7aa0-5697-a1bbe2d7bfe1@linux.alibaba.com>
 <20190103181329.GW31793@dhcp22.suse.cz>
 <6f43e926-3bb5-20d1-2e39-1d30bf7ad375@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f43e926-3bb5-20d1-2e39-1d30bf7ad375@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-01-19 10:40:54, Yang Shi wrote:
> 
> 
> On 1/3/19 10:13 AM, Michal Hocko wrote:
> > On Thu 03-01-19 09:33:14, Yang Shi wrote:
> > > 
> > > On 1/3/19 2:12 AM, Michal Hocko wrote:
> > > > On Thu 03-01-19 04:05:30, Yang Shi wrote:
> > > > > Currently, force empty reclaims memory synchronously when writing to
> > > > > memory.force_empty.  It may take some time to return and the afterwards
> > > > > operations are blocked by it.  Although it can be interrupted by signal,
> > > > > it still seems suboptimal.
> > > > Why it is suboptimal? We are doing that operation on behalf of the
> > > > process requesting it. What should anybody else pay for it? In other
> > > > words why should we hide the overhead?
> > > Please see the below explanation.
> > > 
> > > > > Now css offline is handled by worker, and the typical usecase of force
> > > > > empty is before memcg offline.  So, handling force empty in css offline
> > > > > sounds reasonable.
> > > > Hmm, so I guess you are talking about
> > > > echo 1 > $MEMCG/force_empty
> > > > rmdir $MEMCG
> > > > 
> > > > and you are complaining that the operation takes too long. Right? Why do
> > > > you care actually?
> > > We have some usecases which create and remove memcgs very frequently, and
> > > the tasks in the memcg may just access the files which are unlikely accessed
> > > by anyone else. So, we prefer force_empty the memcg before rmdir'ing it to
> > > reclaim the page cache so that they don't get accumulated to incur
> > > unnecessary memory pressure. Since the memory pressure may incur direct
> > > reclaim to harm some latency sensitive applications.
> > Yes, this makes sense to me.
> > 
> > > And, the create/remove might be run in a script sequentially (there might be
> > > a lot scripts or applications are run in parallel to do this), i.e.
> > > mkdir cg1
> > > do something
> > > echo 0 > cg1/memory.force_empty
> > > rmdir cg1
> > > 
> > > mkdir cg2
> > > ...
> > > 
> > > The creation of the afterwards memcg might be blocked by the force_empty for
> > > long time if there are a lot page caches, so the overall throughput of the
> > > system may get hurt.
> > Is there any reason for your scripts to be strictly sequential here? In
> > other words why cannot you offload those expensive operations to a
> > detached context in _userspace_?
> 
> I would say it has not to be strictly sequential. The above script is just
> an example to illustrate the pattern. But, sometimes it may hit such pattern
> due to the complicated cluster scheduling and container scheduling in the
> production environment, for example the creation process might be scheduled
> to the same CPU which is doing force_empty. I have to say I don't know too
> much about the internals of the container scheduling.

In that case I do not see a strong reason to implement the offloding
into the kernel. It is an additional code and semantic to maintain.

I think it is more important to discuss whether we want to introduce
force_empty in cgroup v2.
-- 
Michal Hocko
SUSE Labs
