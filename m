Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933265AbeBVQaT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:30:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:46839 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932942AbeBVQaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:30:17 -0500
Date: Thu, 22 Feb 2018 17:30:15 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>, Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v5 2/2] mm/memcontrol.c: Reduce reclaim retries in
 mem_cgroup_resize_limit()
Message-ID: <20180222163015.GQ30681@dhcp22.suse.cz>
References: <CALvZod7HS6P0OU6Rps8JeMJycaPd4dF5NjxV8k1y2-yosF2bdA@mail.gmail.com>
 <20180119151118.GE6584@dhcp22.suse.cz>
 <20180221121715.0233d34dda330c56e1a9db5f@linux-foundation.org>
 <f3893181-67a4-aec2-9514-f141fa78a6c0@virtuozzo.com>
 <20180222140932.GL30681@dhcp22.suse.cz>
 <e0705720-0909-e224-4bdd-481660e516f2@virtuozzo.com>
 <20180222153343.GN30681@dhcp22.suse.cz>
 <0927bcab-7e2c-c6f9-d16a-315ac436ba98@virtuozzo.com>
 <20180222154435.GO30681@dhcp22.suse.cz>
 <bf4a40fb-0a24-bfcb-124f-15e5e2f87b67@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf4a40fb-0a24-bfcb-124f-15e5e2f87b67@virtuozzo.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 22-02-18 19:01:58, Andrey Ryabinin wrote:
> 
> 
> On 02/22/2018 06:44 PM, Michal Hocko wrote:
> > On Thu 22-02-18 18:38:11, Andrey Ryabinin wrote:
> 
> >>>>
> >>>> with the patch:
> >>>> best: 1.04  secs, 9.7G reclaimed
> >>>> worst: 2.2 secs, 16G reclaimed.
> >>>>
> >>>> without:
> >>>> best: 5.4 sec, 35G reclaimed
> >>>> worst: 22.2 sec, 136G reclaimed
> >>>
> >>> Could you also compare how much memory do we reclaim with/without the
> >>> patch?
> >>>
> >>
> >> I did and I wrote the results. Please look again.
> > 
> > I must have forgotten. Care to point me to the message-id?
> 
> The results are quoted right above, literally above. Raise your eyes
> up. message-id 0927bcab-7e2c-c6f9-d16a-315ac436ba98@virtuozzo.com

OK, I see. We were talking about 2 different things I guess.

> I write it here again:
> 
> with the patch:
>  best: 9.7G reclaimed
>  worst: 16G reclaimed
> 
> without:
>  best: 35G reclaimed
>  worst: 136G reclaimed
> 
> Or you asking about something else? If so, I don't understand what you
> want.

Well, those numbers do not tell us much, right? You have 4 concurrent
readers each an own 1G file in a loop. The longer you keep running that
the more pages you are reclaiming of course. But you are not comparing
the same amount of work.

My main concern about the patch is that it might over-reclaim a lot if
we have workload which also frees memory rahther than constantly add
more easily reclaimable page cache. I realize such a test is not easy
to make.

I have already said that I will not block the patch but it should be at
least explained why a larger batch makes a difference.
-- 
Michal Hocko
SUSE Labs
