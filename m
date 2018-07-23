Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7906ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3A620854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mjf4ib2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3A620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387992AbeGWLzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:55:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38752 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387801AbeGWLzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QsU0yKFH7At7hP+lISpjE0Ae0SU2/R2fOhR9dRRtT9w=; b=mjf4ib2x3JPrJe+N+L0000pVj
        fAh76WiHDEOzjdBmywb9amDdmGhAHE/ei+qOdR/vVk0gnoJX9mWxyuZ1uP4mI7DgyWEbzm6Ik3r0m
        r/ztXb8DmXTiJTfbWVK2y7JETv+lCHAbAfVqHkpXTMGJ0cXZt81nMnreAz5Rcfgk7X3ii/ZcF2vPN
        Yb/NCmKGqKlYV1YAFxouJzNW/buV3Y6oBKiBdbQR5p24mOog1YKHjzdL3fL+04NwrWzx4MyiH4jod
        7wGbIBdDi6GO4bH/aDDdWIS004zODhy2CZ4AaB2of+mOHkM0h7IdE3vAwKWSBZKglie2pCVtIt6Jx
        9dtdbO+Jg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhYUC-0005nJ-AY; Mon, 23 Jul 2018 10:54:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D294E20275F53; Mon, 23 Jul 2018 12:54:38 +0200 (CEST)
Date:   Mon, 23 Jul 2018 12:54:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 13/19] mm/migrate: Use xchg instead of spinlock
Message-ID: <20180723105438.GD2494@hirez.programming.kicks-ass.net>
References: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1529514181-9842-14-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529514181-9842-14-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 10:32:54PM +0530, Srikar Dronamraju wrote:
> Currently resetting the migrate rate limit is under a spinlock.
> The spinlock will only serialize the migrate rate limiting and something
> similar can actually be achieved by a simpler xchg.

You're again not explaining things right. The xchg isn't simpler in any
way. It just happens to be faster, esp. so on PPC.

> diff --git a/mm/migrate.c b/mm/migrate.c
> index 8c0af0f..c774990 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1868,17 +1868,25 @@ static struct page *alloc_misplaced_dst_page(struct page *page,
>  static bool numamigrate_update_ratelimit(pg_data_t *pgdat,
>  					unsigned long nr_pages)
>  {
> +	unsigned long next_window, interval;
> +
> +	next_window = READ_ONCE(pgdat->numabalancing_migrate_next_window);
> +	interval = msecs_to_jiffies(migrate_interval_millisecs);
> +
>  	/*
>  	 * Rate-limit the amount of data that is being migrated to a node.
>  	 * Optimal placement is no good if the memory bus is saturated and
>  	 * all the time is being spent migrating!
>  	 */
> +	if (time_after(jiffies, next_window)) {
> +		if (xchg(&pgdat->numabalancing_migrate_nr_pages, 0)) {
> +			do {
> +				next_window += interval;
> +			} while (unlikely(time_after(jiffies, next_window)));
> +
> +			WRITE_ONCE(pgdat->numabalancing_migrate_next_window,
> +							       next_window);
> +		}
>  	}
>  	if (pgdat->numabalancing_migrate_nr_pages > ratelimit_pages) {
>  		trace_mm_numa_migrate_ratelimit(current, pgdat->node_id,

If you maybe write that like:

	if (time_after(jiffies, next_window) &&
	    xchg(&pgdat->numabalancing_migrate_nr_pages, 0UL)) {

		do {
			next_window += interval;
		} while (unlikely(time_after(jiffies, next_window)));

		WRITE_ONCE(pgdat->numabalancing_migrate_next_window, next_window);
	}

Then you avoid an indent level and line-wrap, resulting imo easier to
read code.
