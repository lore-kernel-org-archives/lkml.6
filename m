Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7366C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 11:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D99214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 11:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545825246;
	bh=rRE2tNT2L2oOtOHPBrp2VGHMNqw0DflRfthfl3xfx7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jsOre/zLBJHgnW+t4Qks6AghS/Nev3ta1hFy05fhmXImAC3PHcnBwmBhUpQwu7fWE
	 cVLudC8iEiK40Tag+Jy4b05epLCPXojvYyT2f6PmyoK3LK6ZdTa1F4PWd7f5p/j5fq
	 IwT4dDSxbc0Dl83m99HaWCiy1SfZpwpWPqog8voE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeLZLyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 06:54:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:34534 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbeLZLyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 06:54:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A54BBAC5F;
        Wed, 26 Dec 2018 11:54:02 +0000 (UTC)
Date:   Wed, 26 Dec 2018 12:53:55 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khorenko <khorenko@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/1] mm/page_alloc: add a warning about high order
 allocations
Message-ID: <20181226115355.GJ16738@dhcp22.suse.cz>
References: <20181225153927.2873-1-khorenko@virtuozzo.com>
 <20181225153927.2873-2-khorenko@virtuozzo.com>
 <20181226084051.GH16738@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226084051.GH16738@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26-12-18 09:40:51, Michal Hocko wrote:
> Appart from general comments as a reply to the cover (btw. this all
> should be in the changelog because this is the _why_ part of the
> justification which should be _always_ part of the changelog).
> 
> On Tue 25-12-18 18:39:27, Konstantin Khorenko wrote:
> [...]
> > +config WARN_HIGH_ORDER
> > +	bool "Enable complains about high order memory allocations"
> > +	depends on !LOCKDEP
> 
> Why?
> 
> > +	default n
> > +	help
> > +	  Enables warnings on high order memory allocations. This allows to
> > +	  determine users of large memory chunks and rework them to decrease
> > +	  allocation latency. Note, some debug options make kernel structures
> > +	  fat.
> > +
> > +config WARN_HIGH_ORDER_LEVEL
> > +	int "Define page order level considered as too high"
> > +	depends on WARN_HIGH_ORDER
> > +	default 3
> > +	help
> > +	  Defines page order starting which the system to complain about.
> > +	  Default is current PAGE_ALLOC_COSTLY_ORDER.
> > +
> >  config HWPOISON_INJECT
> >  	tristate "HWPoison pages injector"
> >  	depends on MEMORY_FAILURE && DEBUG_KERNEL && PROC_FS
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index e95b5b7c9c3d..258892adb861 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -4341,6 +4341,30 @@ static inline void finalise_ac(gfp_t gfp_mask, struct alloc_context *ac)
> >  					ac->high_zoneidx, ac->nodemask);
> >  }
> >  
> > +#ifdef CONFIG_WARN_HIGH_ORDER
> > +int warn_order = CONFIG_WARN_HIGH_ORDER_LEVEL;
> > +
> > +/*
> > + * Complain if we allocate a high order page unless there is a __GFP_NOWARN
> > + * flag provided.
> > + *
> > + * Shuts up after 32 complains.
> > + */
> > +static __always_inline void warn_high_order(int order, gfp_t gfp_mask)
> > +{
> > +	static atomic_t warn_count = ATOMIC_INIT(32);
> > +
> > +	if (order >= warn_order && !(gfp_mask & __GFP_NOWARN))
> > +		WARN(atomic_dec_if_positive(&warn_count) >= 0,
> > +		     "order %d >= %d, gfp 0x%x\n",
> > +		     order, warn_order, gfp_mask);
> > +}
> 
> We do have ratelimit functionality, so why cannot you use it?
> 
> > +#else
> > +static __always_inline void warn_high_order(int order, gfp_t gfp_mask)
> > +{
> > +}
> > +#endif
> > +
> >  /*
> >   * This is the 'heart' of the zoned buddy allocator.
> >   */
> > @@ -4361,6 +4385,7 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
> >  		WARN_ON_ONCE(!(gfp_mask & __GFP_NOWARN));
> >  		return NULL;
> >  	}
> > +	warn_high_order(order, gfp_mask);
> >  
> >  	gfp_mask &= gfp_allowed_mask;
> >  	alloc_mask = gfp_mask;
> 
> Why do you warn about all allocations in the hot path? I thought you
> want to catch expensive allocations so I would assume that you would
> stick that into a slow path after we are not able to allocate anything
> after the first round of compaction.
> 
> Also do you want to warn about opportunistic GFP_NOWAIT allocations that
> have a reasonable fallback?

And forgot to mention other opportunistic allocations like THP of
course.
-- 
Michal Hocko
SUSE Labs
