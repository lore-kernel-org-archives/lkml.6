Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752932AbeCVJut (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 05:50:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:46523 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752463AbeCVJur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 05:50:47 -0400
Date: Thu, 22 Mar 2018 10:50:44 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Nick Desaulniers <nick.desaulniers@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, mgorman@techsingularity.net,
        vbabka@suse.cz, Minchan Kim <minchan@kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        paullawrence@google.com
Subject: Re: [PATCH] mm/vmscan: fix unsequenced modification and access
 warning
Message-ID: <20180322095044.GA23100@dhcp22.suse.cz>
References: <20170510065328.9215-1-nick.desaulniers@gmail.com>
 <20170510071511.GA31466@dhcp22.suse.cz>
 <CAH7mPvh0qG2R30ToKV=dX3YNc+0BQtnCH3cQUANJWmVdbn6sXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH7mPvh0qG2R30ToKV=dX3YNc+0BQtnCH3cQUANJWmVdbn6sXw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-03-18 14:37:04, Nick Desaulniers wrote:
> Sorry to dig up an old thread but a coworker was asking about this
> patch. This is essentially the code that landed in commit
> f2f43e566a02a3bdde0a65e6a2e88d707c212a29 "mm/vmscan.c: fix unsequenced
> modification and access warning".
> 
> Is .reclaim_idx still correct in the case of try_to_free_pages()?

Yes, it gets initialized from the given gfp_mask. sc.gfp_mask might be
sllightly different but that doesn't change the reclaim_idx because we
only drop __GFP_{FS,IO} which do not have any zone modification effects.

> It
> looks like reclaim_idx is based on the original gfp_mask in
> __node_reclaim(), but in try_to_free_pages() it looks like it may have
> been based on current_gfp_context()? (The sequencing is kind of
> ambiguous, thus fixed in my patch)
> 
> Was there a bug in the original try_to_free_pages() pre commit
> f2f43e566a0, or is .reclaim_idx supposed to be different between
> try_to_free_pages() and __node_reclaim()?

I do not think there was any real bug.
-- 
Michal Hocko
SUSE Labs
