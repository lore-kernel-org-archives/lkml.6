Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE9AC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340FB217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548245463;
	bh=63FdjGxriYSBkfHDCBwcWoGSDK85biVMPwupFi8Mi+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H/tYIwRvRHhUP25Jm99YzBw5l3r5IJ8u+VtmnSblsp0bqp3jIkt0HGnEKpvztgU0D
	 yN8ei/9eWeYTNlz8V19MymRkZ7x2z2IT2kAYcaIi5lel+g9cNDv2gS2v8xdKDT4QXD
	 FXth2kuQlU4jB4W0bCH1HvDR8ldHKxQ37eHExSqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfAWMLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:11:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:36548 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725991AbfAWMLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:11:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 41466B0E7;
        Wed, 23 Jan 2019 12:11:00 +0000 (UTC)
Date:   Wed, 23 Jan 2019 13:10:58 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: vmscan: do not iterate all mem cgroups for
 global direct reclaim
Message-ID: <20190123121058.GW4087@dhcp22.suse.cz>
References: <1548187782-108454-1-git-send-email-yang.shi@linux.alibaba.com>
 <fa1d9a1f-99c8-a4ae-da7f-ed90336497e9@virtuozzo.com>
 <20190123110254.GU4087@dhcp22.suse.cz>
 <9bd4044b-63d0-b24f-a108-3061c00ed131@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bd4044b-63d0-b24f-a108-3061c00ed131@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-01-19 14:05:28, Kirill Tkhai wrote:
> On 23.01.2019 14:02, Michal Hocko wrote:
> > On Wed 23-01-19 13:28:03, Kirill Tkhai wrote:
> >> On 22.01.2019 23:09, Yang Shi wrote:
> >>> In current implementation, both kswapd and direct reclaim has to iterate
> >>> all mem cgroups.  It is not a problem before offline mem cgroups could
> >>> be iterated.  But, currently with iterating offline mem cgroups, it
> >>> could be very time consuming.  In our workloads, we saw over 400K mem
> >>> cgroups accumulated in some cases, only a few hundred are online memcgs.
> >>> Although kswapd could help out to reduce the number of memcgs, direct
> >>> reclaim still get hit with iterating a number of offline memcgs in some
> >>> cases.  We experienced the responsiveness problems due to this
> >>> occassionally.
> >>>
> >>> Here just break the iteration once it reclaims enough pages as what
> >>> memcg direct reclaim does.  This may hurt the fairness among memcgs
> >>> since direct reclaim may awlays do reclaim from same memcgs.  But, it
> >>> sounds ok since direct reclaim just tries to reclaim SWAP_CLUSTER_MAX
> >>> pages and memcgs can be protected by min/low.
> >>
> >> In case of we stop after SWAP_CLUSTER_MAX pages are reclaimed; it's possible
> >> the following situation. Memcgs, which are closest to root_mem_cgroup, will
> >> become empty, and you will have to iterate over empty memcg hierarchy long time,
> >> just to find a not empty memcg.
> >>
> >> I'd suggest, we should not lose fairness. We may introduce
> >> mem_cgroup::last_reclaim_child parameter to save a child
> >> (or its id), where the last reclaim was interrupted. Then
> >> next reclaim should start from this child:
> > 
> > Why is not our reclaim_cookie based caching sufficient?
> 
> Hm, maybe I missed them. Do cookies already implement this functionality?

Have a look at mem_cgroup_iter

-- 
Michal Hocko
SUSE Labs
