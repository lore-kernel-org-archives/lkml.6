Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491E9C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6E220874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="sUOSe9/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6E220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754106AbeFTPQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:16:01 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:48578 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754075AbeFTPP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cmpxchg.org
        ; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=jqxkfFwEagfA+T/8RI6lT964JvR/FbmhSgMXvlcheCQ=; b=sUOSe9/+fr5WQDsouugLrcuPgA
        +rOOUNqs4gvJUB/+RYkttzzs7H451Rc3x+ez4h474n/BcwapnmOx/fjXtWi7aCMY1z3xyfhDm2Rzv
        UaIv60wkdWp521UzpV9FxmTRswLZJdVsin/gq3wDzdwJg3RctypCK4/44UHvuIUVQ39o=;
Date:   Wed, 20 Jun 2018 11:18:12 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] memcg, oom: move out_of_memory back to the charge
 path
Message-ID: <20180620151812.GA2441@cmpxchg.org>
References: <20180620103736.13880-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620103736.13880-1-mhocko@kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 12:37:36PM +0200, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> 3812c8c8f395 ("mm: memcg: do not trap chargers with full callstack on OOM")
> has changed the ENOMEM semantic of memcg charges. Rather than invoking
> the oom killer from the charging context it delays the oom killer to the
> page fault path (pagefault_out_of_memory). This in turn means that many
> users (e.g. slab or g-u-p) will get ENOMEM when the corresponding memcg
> hits the hard limit and the memcg is is OOM. This is behavior is
> inconsistent with !memcg case where the oom killer is invoked from the
> allocation context and the allocator keeps retrying until it succeeds.
> 
> The difference in the behavior is user visible. mmap(MAP_POPULATE) might
> result in not fully populated ranges while the mmap return code doesn't
> tell that to the userspace. Random syscalls might fail with ENOMEM etc.
> 
> The primary motivation of the different memcg oom semantic was the
> deadlock avoidance. Things have changed since then, though. We have
> an async oom teardown by the oom reaper now and so we do not have to
> rely on the victim to tear down its memory anymore. Therefore we can
> return to the original semantic as long as the memcg oom killer is not
> handed over to the users space.
> 
> There is still one thing to be careful about here though. If the oom
> killer is not able to make any forward progress - e.g. because there is
> no eligible task to kill - then we have to bail out of the charge path
> to prevent from same class of deadlocks. We have basically two options
> here. Either we fail the charge with ENOMEM or force the charge and
> allow overcharge. The first option has been considered more harmful than
> useful because rare inconsistencies in the ENOMEM behavior is hard to
> test for and error prone. Basically the same reason why the page
> allocator doesn't fail allocations under such conditions. The later
> might allow runaways but those should be really unlikely unless somebody
> misconfigures the system. E.g. allowing to migrate tasks away from the
> memcg to a different unlimited memcg with move_charge_at_immigrate
> disabled.

This is more straight-forward than I thought it would be. I have no
objections to this going forward, just a couple of minor notes.

> @@ -1483,28 +1483,54 @@ static void memcg_oom_recover(struct mem_cgroup *memcg)
>  		__wake_up(&memcg_oom_waitq, TASK_NORMAL, 0, memcg);
>  }
>  
> -static void mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
> +enum oom_status {
> +	OOM_SUCCESS,
> +	OOM_FAILED,
> +	OOM_ASYNC,
> +	OOM_SKIPPED

Either SUCCESS & FAILURE, or SUCCEEDED & FAILED ;)

We're not distinguishing ASYNC and SKIPPED anywhere below, but I
cannot think of a good name to communicate them both without this
function making assumptions about the charge function's behavior.
So it's a bit weird, but probably the best way to go.

> +static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
>  {
> -	if (!current->memcg_may_oom || order > PAGE_ALLOC_COSTLY_ORDER)
> -		return;
> +	if (order > PAGE_ALLOC_COSTLY_ORDER)
> +		return OOM_SKIPPED;
>  	/*
>  	 * We are in the middle of the charge context here, so we
>  	 * don't want to block when potentially sitting on a callstack
>  	 * that holds all kinds of filesystem and mm locks.
>  	 *
> -	 * Also, the caller may handle a failed allocation gracefully
> -	 * (like optional page cache readahead) and so an OOM killer
> -	 * invocation might not even be necessary.
> +	 * cgroup1 allows disabling the OOM killer and waiting for outside
> +	 * handling until the charge can succeed; remember the context and put
> +	 * the task to sleep at the end of the page fault when all locks are
> +	 * released.
> +	 *
> +	 * On the other hand, in-kernel OOM killer allows for an async victim
> +	 * memory reclaim (oom_reaper) and that means that we are not solely
> +	 * relying on the oom victim to make a forward progress and we can
> +	 * invoke the oom killer here.
>  	 *
> -	 * That's why we don't do anything here except remember the
> -	 * OOM context and then deal with it at the end of the page
> -	 * fault when the stack is unwound, the locks are released,
> -	 * and when we know whether the fault was overall successful.
> +	 * Please note that mem_cgroup_oom_synchronize might fail to find a
> +	 * victim and then we have rely on mem_cgroup_oom_synchronize otherwise
> +	 * we would fall back to the global oom killer in pagefault_out_of_memory
>  	 */
> +	if (!memcg->oom_kill_disable) {
> +		if (mem_cgroup_out_of_memory(memcg, mask, order))
> +			return OOM_SUCCESS;
> +
> +		WARN(!current->memcg_may_oom,
> +				"Memory cgroup charge failed because of no reclaimable memory! "
> +				"This looks like a misconfiguration or a kernel bug.");
> +		return OOM_FAILED;
> +	}
> +
> +	if (!current->memcg_may_oom)
> +		return OOM_SKIPPED;

memcg_may_oom was introduced to distinguish between userspace faults
that can OOM and contexts that return -ENOMEM. Now we're using it
slightly differently and it's confusing.

1) Why warn for kernel allocations, but not userspace ones? This
should have a comment at least.

2) We invoke the OOM killer when !memcg_may_oom. We want to OOM kill
in either case, but only set up the mem_cgroup_oom_synchronize() for
userspace faults. So the code makes sense, but a better name would be
in order -- current->in_user_fault?

>  	css_get(&memcg->css);
>  	current->memcg_in_oom = memcg;
>  	current->memcg_oom_gfp_mask = mask;
>  	current->memcg_oom_order = order;
> +
> +	return OOM_ASYNC;

In terms of code flow, it would be much clearer to handle the
memcg->oom_kill_disable case first, as a special case with early
return, and make the OOM invocation the main code of this function,
given its name.

> @@ -1994,8 +2024,23 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  
>  	memcg_memory_event(mem_over_limit, MEMCG_OOM);
>  
> -	mem_cgroup_oom(mem_over_limit, gfp_mask,
> +	/*
> +	 * keep retrying as long as the memcg oom killer is able to make
> +	 * a forward progress or bypass the charge if the oom killer
> +	 * couldn't make any progress.
> +	 */
> +	oom_status = mem_cgroup_oom(mem_over_limit, gfp_mask,
>  		       get_order(nr_pages * PAGE_SIZE));
> +	switch (oom_status) {
> +	case OOM_SUCCESS:
> +		nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
> +		oomed = true;
> +		goto retry;
> +	case OOM_FAILED:
> +		goto force;
> +	default:
> +		goto nomem;
> +	}
>  nomem:
>  	if (!(gfp_mask & __GFP_NOFAIL))
>  		return -ENOMEM;
> -- 
> 2.17.1
> 
