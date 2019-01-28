Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A937C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3872175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695134;
	bh=Slc0GygXz7bhDEF+cjhGw8sft9IbUOKiEex54hKi6F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SslsXx7OO//sch97S99mcOsoMfH1aklzRCKhObGsZ08xj/IRiwJSVT1f08LPnRoxK
	 CtjhsJRqPRLYIeIQqaW+bsOn2HqveUkN0K/F4Vfnoy7Eyn9t9SSgcU+AU9IYoPlNQP
	 WQnIFVYB3GDIgMtzkK5eVLLOMRLVKchoXntKOsBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388031AbfA1RFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:05:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:35868 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730743AbfA1RF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:05:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 95488AFCC;
        Mon, 28 Jan 2019 17:05:27 +0000 (UTC)
Date:   Mon, 28 Jan 2019 18:05:26 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190128170526.GQ18811@dhcp22.suse.cz>
References: <20190125074824.GD3560@dhcp22.suse.cz>
 <20190125165152.GK50184@devbig004.ftw2.facebook.com>
 <20190125173713.GD20411@dhcp22.suse.cz>
 <20190125182808.GL50184@devbig004.ftw2.facebook.com>
 <20190128125151.GI18811@dhcp22.suse.cz>
 <20190128142816.GM50184@devbig004.ftw2.facebook.com>
 <20190128145210.GM18811@dhcp22.suse.cz>
 <20190128145407.GP50184@devbig004.ftw2.facebook.com>
 <20190128151859.GO18811@dhcp22.suse.cz>
 <20190128154150.GQ50184@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128154150.GQ50184@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28-01-19 07:41:50, Tejun Heo wrote:
> Hello, Michal.
> 
> On Mon, Jan 28, 2019 at 04:18:59PM +0100, Michal Hocko wrote:
> > How do you make an atomic snapshot of the hierarchy state? Or you do
> > not need it because event counters are monotonic and you are willing to
> > sacrifice some lost or misinterpreted events? For example, you receive
> > an oom event while the two children increase the oom event counter. How
> > do you tell which one was the source of the event and which one is still
> > pending? Or is the ordering unimportant in general?
> 
> Hmm... This is straightforward stateful notification.  Imagine the
> following hierarchy.  The numbers are the notification counters.
> 
>      A:0
>    /   \
>   B:0  C:0
> 
> Let's say B generates an event, soon followed by C.  If A's counter is
> read after both B and C's events, nothing is missed.
> 
> Let's say it ends up generating two notifications and we end up
> walking down inbetween B and C's events.  It would look like the
> following.
> 
>      A:1
>    /   \
>   B:1  C:0
> 
> We first see A's 0 -> 1 and then start scanning the subtrees to find
> out the origin.  We will notice B but let's say we visit C before C's
> event gets registered (otherwise, nothing is missed).

Yeah, that is quite clear. But it also assumes that the hierarchy is
pretty stable but cgroups might go away at any time. I am not saying
that the aggregated events are not useful I am just saying that it is
quite non-trivial to use and catch all potential corner cases. Maybe I
am overcomplicating it but one thing is quite clear to me. The existing
semantic is really useful to watch for the reclaim behavior at the
current level of the tree. You really do not have to care what is
happening in the subtree when it is clear that the workload itself
is underprovisioned etc. Considering that such a semantic already
existis, somebody might depend on it and we likely want also aggregated
semantic then I really do not see why to risk regressions rather than
add a new memory.hierarchy_events and have both.

-- 
Michal Hocko
SUSE Labs
