Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8FDC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8158F20819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8158F20819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbeKEXrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:47:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:2490 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbeKEXrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:47:36 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 06:27:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,468,1534834800"; 
   d="scan'208";a="86795185"
Received: from aaronlu.sh.intel.com (HELO intel.com) ([10.239.159.44])
  by orsmga007.jf.intel.com with ESMTP; 05 Nov 2018 06:27:27 -0800
Date:   Mon, 5 Nov 2018 22:27:27 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vasily Averin <vvs@virtuozzo.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: use kvzalloc for swap_info_struct allocation
Message-ID: <20181105142727.GB6203@intel.com>
References: <20181105061016.GA4502@intel.com>
 <fc23172d-3c75-21e2-d551-8b1808cbe593@virtuozzo.com>
 <20181105141156.GB10132@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105141156.GB10132@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 03:11:56PM +0100, Michal Hocko wrote:
> On Mon 05-11-18 14:17:01, Vasily Averin wrote:
> > commit a2468cc9bfdf ("swap: choose swap device according to numa node")
> > changed 'avail_lists' field of 'struct swap_info_struct' to an array.
> > In popular linux distros it increased size of swap_info_struct up to
> > 40 Kbytes and now swap_info_struct allocation requires order-4 page.
> > Switch to kvzmalloc allows to avoid unexpected allocation failures.
> 
> While this fixes the most visible issue is this a good long term
> solution? Aren't we wasting memory without a good reason? IIRC our limit

That's right, we need a better way of handling this in the long term.

> for swap files/devices is much smaller than potential NUMA nodes numbers
> so we can safely expect that would be only few numa affine nodes. I am
> not really familiar with the rework which has added numa node awareness
> but I wouls assueme that we should either go with one global table with
> a linked list of possible swap_info structure per numa node or use a
> sparse array.

There is a per-numa-node plist of available swap devices, so every swap
device needs an entry on those per-numa-node plist.

I think we can convert avail_lists from array to pointer and use vzalloc
to allocate the needed memory. MAX_NUMANODES can be used for a simple
implementation, or use the precise online node number but then we will
need to handle node online/offline events.

sparse array sounds promising, I'll take a look, thanks for the pointer.

> That being said I am not really objecting to this patch as it is simple
> and backportable to older (stable kernels).
>  
> I would even dare to add
> Fixes: a2468cc9bfdf ("swap: choose swap device according to numa node")
> 
> because not being able to add a swap space on a fragmented system looks
> like a regression to me.

Agree, especially it used to work.

Regards,
Aaron

> > Acked-by: Aaron Lu <aaron.lu@intel.com>
> > Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  mm/swapfile.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 644f746e167a..8688ae65ef58 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -2813,7 +2813,7 @@ static struct swap_info_struct *alloc_swap_info(void)
> >  	unsigned int type;
> >  	int i;
> >  
> > -	p = kzalloc(sizeof(*p), GFP_KERNEL);
> > +	p = kvzalloc(sizeof(*p), GFP_KERNEL);
> >  	if (!p)
> >  		return ERR_PTR(-ENOMEM);
> >  
> > @@ -2824,7 +2824,7 @@ static struct swap_info_struct *alloc_swap_info(void)
> >  	}
> >  	if (type >= MAX_SWAPFILES) {
> >  		spin_unlock(&swap_lock);
> > -		kfree(p);
> > +		kvfree(p);
> >  		return ERR_PTR(-EPERM);
> >  	}
> >  	if (type >= nr_swapfiles) {
> > @@ -2838,7 +2838,7 @@ static struct swap_info_struct *alloc_swap_info(void)
> >  		smp_wmb();
> >  		nr_swapfiles++;
> >  	} else {
> > -		kfree(p);
> > +		kvfree(p);
> >  		p = swap_info[type];
> >  		/*
> >  		 * Do not memset this entry: a racing procfs swap_next()
> > -- 
> > 2.17.1
> 
> -- 
> Michal Hocko
> SUSE Labs
> 
