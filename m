Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA33DC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9262920658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9262920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbeICWvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:51:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:35310 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727430AbeICWvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:51:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C0549AF7A;
        Mon,  3 Sep 2018 18:30:06 +0000 (UTC)
Date:   Mon, 3 Sep 2018 20:29:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Josef Bacik <jbacik@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: slowly shrink slabs with a relatively small number
 of objects
Message-ID: <20180903182956.GE15074@dhcp22.suse.cz>
References: <20180831203450.2536-1-guro@fb.com>
 <3b05579f964cca1d44551913f1a9ee79d96f198e.camel@surriel.com>
 <20180831213138.GA9159@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831213138.GA9159@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 31-08-18 14:31:41, Roman Gushchin wrote:
> On Fri, Aug 31, 2018 at 05:15:39PM -0400, Rik van Riel wrote:
> > On Fri, 2018-08-31 at 13:34 -0700, Roman Gushchin wrote:
> > 
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index fa2c150ab7b9..c910cf6bf606 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -476,6 +476,10 @@ static unsigned long do_shrink_slab(struct
> > > shrink_control *shrinkctl,
> > >  	delta = freeable >> priority;
> > >  	delta *= 4;
> > >  	do_div(delta, shrinker->seeks);
> > > +
> > > +	if (delta == 0 && freeable > 0)
> > > +		delta = min(freeable, batch_size);
> > > +
> > >  	total_scan += delta;
> > >  	if (total_scan < 0) {
> > >  		pr_err("shrink_slab: %pF negative objects to delete
> > > nr=%ld\n",
> > 
> > I agree that we need to shrink slabs with fewer than
> > 4096 objects, but do we want to put more pressure on
> > a slab the moment it drops below 4096 than we applied
> > when it had just over 4096 objects on it?
> > 
> > With this patch, a slab with 5000 objects on it will
> > get 1 item scanned, while a slab with 4000 objects on
> > it will see shrinker->batch or SHRINK_BATCH objects
> > scanned every time.
> > 
> > I don't know if this would cause any issues, just
> > something to ponder.
> 
> Hm, fair enough. So, basically we can always do
> 
>     delta = max(delta, min(freeable, batch_size));
> 
> Does it look better?

Why don't you use the same heuristic we use for the normal LRU raclaim?

		/*
		 * If the cgroup's already been deleted, make sure to
		 * scrape out the remaining cache.
		 */
		if (!scan && !mem_cgroup_online(memcg))
			scan = min(size, SWAP_CLUSTER_MAX);

-- 
Michal Hocko
SUSE Labs
