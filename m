Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EDD2BC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6C720660
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6C720660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935334AbeFMRBb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:01:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934802AbeFMRBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:01:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8FC89401EF30;
        Wed, 13 Jun 2018 17:01:29 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CDE177C41;
        Wed, 13 Jun 2018 17:01:24 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w5DH1O1q007626;
        Wed, 13 Jun 2018 13:01:24 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w5DH1M4c007614;
        Wed, 13 Jun 2018 13:01:22 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 13 Jun 2018 13:01:22 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Christopher Lameter <cl@linux.com>
cc:     Mike Snitzer <snitzer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
        dm-devel@redhat.com, David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] slab: introduce the flag SLAB_MINIMIZE_WASTE
In-Reply-To: <alpine.LRH.2.02.1804271513320.16558@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.1806131300370.1012@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1803201740280.21066@file01.intranet.prod.int.rdu2.redhat.com> <ee8807ff-d650-0064-70bf-e1d77fa61f5c@suse.cz> <20180416142703.GA22422@redhat.com> <alpine.LRH.2.02.1804161031300.24222@file01.intranet.prod.int.rdu2.redhat.com>
 <20180416144638.GA22484@redhat.com> <alpine.LRH.2.02.1804161530360.19492@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.20.1804170940340.17557@nuc-kabylake> <alpine.LRH.2.02.1804171454020.26973@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.DEB.2.20.1804180952580.1334@nuc-kabylake> <alpine.LRH.2.02.1804251702250.9428@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.1804251917460.2429@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.20.1804261354230.6674@nuc-kabylake>
 <alpine.LRH.2.02.1804261508430.26980@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.20.1804271136390.11686@nuc-kabylake> <alpine.LRH.2.02.1804271513320.16558@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 13 Jun 2018 17:01:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 13 Jun 2018 17:01:29 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'd like to ask about this patch - will you commit it, or do you want to 
make some more changes to it?

Mikulas




On Fri, 27 Apr 2018, Mikulas Patocka wrote:

> 
> 
> On Fri, 27 Apr 2018, Christopher Lameter wrote:
> 
> > On Thu, 26 Apr 2018, Mikulas Patocka wrote:
> > 
> > > > Hmmm... order 4 for these caches may cause some concern. These should stay
> > > > under costly order I think. Otherwise allocations are no longer
> > > > guaranteed.
> > >
> > > You said that slub has fallback to smaller order allocations.
> > 
> > Yes it does...
> > 
> > > The whole purpose of this "minimize waste" approach is to use higher-order
> > > allocations to use memory more efficiently, so it is just doing its job.
> > > (for these 3 caches, order-4 really wastes less memory than order-3 - on
> > > my system TCPv6 and sighand_cache have size 2112, task_struct 2752).
> > 
> > Hmmm... Ok if the others are fine with this as well. I got some pushback
> > there in the past.
> > 
> > > We could improve the fallback code, so that if order-4 allocation fails,
> > > it tries order-3 allocation, and then falls back to order-0. But I think
> > > that these failures are rare enough that it is not a problem.
> > 
> > I also think that would be too many fallbacks.
> 
> You are right - it's better to fallback to the minimum possible size, so 
> that the allocation is faster.
> 
> > The old code uses the concept of a "fraction" to calculate overhead. The
> > code here uses absolute counts of bytes. Fraction looks better to me.
> 
> OK - I reworked the patch using the same "fraction" calculation as before.  
> The existing logic targets 1/16 wasted space, so I used this target in 
> this patch too.
> 
> This patch increases only the order of task_struct (from 3 to 4), all the 
> other caches have the same order as before.
> 
> Mikulas
> 
> 
> 
> From: Mikulas Patocka <mpatocka@redhat.com>
> Subject: [PATCH] slub: use higher order to reduce wasted space
> 
> If we create a slub cache with large object size (larger than
> slub_max_order), the slub subsystem currently rounds up the object size to
> the next power of two.
> 
> This is inefficient, because it wastes too much space. We use the slab
> cache as a buffer cache in dm-bufio, in order to use the memory
> efficiently, we need to reduce wasted space.
> 
> This patch reworks the slub order calculation algorithm, so that it uses
> higher order allocations if it would reduce wasted space. The slub
> subsystem has fallback if the higher-order allocations fails, so using
> order higher than PAGE_ALLOC_COSTLY_ORDER is ok.
> 
> The new algorithm first calculates the minimum order that can be used for
> a give object size and then increases the order according to these
> conditions:
> * if we would overshoot MAX_OBJS_PER_PAGE, don't increase
> * if we are below slub_min_order, increase
> * if we are below slub_max_order and below min_objects, increase
> * we increase above slub_max_order only if it reduces wasted space and if
>   we alrady waste at least 1/16 of the compound page
> 
> The new algorithm gives very similar results to the old one, all the
> caches on my system have the same order as before, only the order of
> task_struct (size 2752) is increased from 3 to 4.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> ---
>  mm/slub.c |   82 +++++++++++++++++++++++---------------------------------------
>  1 file changed, 31 insertions(+), 51 deletions(-)
> 
> Index: linux-2.6/mm/slub.c
> ===================================================================
> --- linux-2.6.orig/mm/slub.c	2018-04-27 19:30:34.000000000 +0200
> +++ linux-2.6/mm/slub.c	2018-04-27 21:05:53.000000000 +0200
> @@ -3224,34 +3224,10 @@ static unsigned int slub_min_objects;
>   * requested a higher mininum order then we start with that one instead of
>   * the smallest order which will fit the object.
>   */
> -static inline unsigned int slab_order(unsigned int size,
> -		unsigned int min_objects, unsigned int max_order,
> -		unsigned int fract_leftover, unsigned int reserved)
> +static int calculate_order(unsigned int size, unsigned int reserved)
>  {
> -	unsigned int min_order = slub_min_order;
> -	unsigned int order;
> -
> -	if (order_objects(min_order, size, reserved) > MAX_OBJS_PER_PAGE)
> -		return get_order(size * MAX_OBJS_PER_PAGE) - 1;
> -
> -	for (order = max(min_order, (unsigned int)get_order(min_objects * size + reserved));
> -			order <= max_order; order++) {
> -
> -		unsigned int slab_size = (unsigned int)PAGE_SIZE << order;
> -		unsigned int rem;
> -
> -		rem = (slab_size - reserved) % size;
> -
> -		if (rem <= slab_size / fract_leftover)
> -			break;
> -	}
> -
> -	return order;
> -}
> -
> -static inline int calculate_order(unsigned int size, unsigned int reserved)
> -{
> -	unsigned int order;
> +	unsigned int best_order;
> +	unsigned int test_order;
>  	unsigned int min_objects;
>  	unsigned int max_objects;
>  
> @@ -3269,34 +3245,38 @@ static inline int calculate_order(unsign
>  	max_objects = order_objects(slub_max_order, size, reserved);
>  	min_objects = min(min_objects, max_objects);
>  
> -	while (min_objects > 1) {
> -		unsigned int fraction;
> +	/* Get the minimum acceptable order for one object */
> +	best_order = get_order(size + reserved);
> +
> +	for (test_order = best_order + 1; test_order < MAX_ORDER; test_order++) {
> +		unsigned best_order_obj = order_objects(best_order, size, reserved);
> +		unsigned test_order_obj = order_objects(test_order, size, reserved);
> +
> +		unsigned best_order_slab_size = (unsigned int)PAGE_SIZE << best_order;
> +		unsigned best_order_rem = (best_order_slab_size - reserved) % size;
> +
> +		/* If there would be too many objects, stop searching */
> +		if (test_order_obj > MAX_OBJS_PER_PAGE)
> +			break;
>  
> -		fraction = 16;
> -		while (fraction >= 4) {
> -			order = slab_order(size, min_objects,
> -					slub_max_order, fraction, reserved);
> -			if (order <= slub_max_order)
> -				return order;
> -			fraction /= 2;
> -		}
> -		min_objects--;
> +		/* Always increase up to slub_min_order */
> +		if (test_order <= slub_min_order)
> +			best_order = test_order;
> +
> +		/* If we are below min_objects and slub_max_order, increase the order */
> +		if (best_order_obj < min_objects && test_order <= slub_max_order)
> +			best_order = test_order;
> +
> +		/* Increase the order even more, but only if it reduces waste */
> +		/* If we already waste less than 1/16, don't increase it */
> +		if (best_order_rem >= (best_order_slab_size / 16) &&
> +		    test_order_obj > (best_order_obj << (test_order - best_order)))
> +			best_order = test_order;
>  	}
>  
> -	/*
> -	 * We were unable to place multiple objects in a slab. Now
> -	 * lets see if we can place a single object there.
> -	 */
> -	order = slab_order(size, 1, slub_max_order, 1, reserved);
> -	if (order <= slub_max_order)
> -		return order;
> +	if (best_order < MAX_ORDER)
> +		return best_order;
>  
> -	/*
> -	 * Doh this slab cannot be placed using slub_max_order.
> -	 */
> -	order = slab_order(size, 1, MAX_ORDER, 1, reserved);
> -	if (order < MAX_ORDER)
> -		return order;
>  	return -ENOSYS;
>  }
>  
> 
