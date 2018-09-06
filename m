Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE45FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926CA20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LBKTv3xw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926CA20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeIFQXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:23:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53170 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeIFQXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=97GecBZi3XVt6eSOAwOOVz56Ze0RZwYXDHaeSwcvDHo=; b=LBKTv3xwlZXUYSYX5ZgBps8yl
        O4sPEh65X1X7BlplCxVPokLFaAk4P43dMQmhmneQmmf2uXZylDxTBvkEEaxs5a/vQH77bIVtgZB6F
        jN6utooAiWaafmBn/HBMoQvhdvDrvIhdScblgp7etqOGxDIhOr5pz64txCvBL2lyGhv1LEffCh8Ji
        yjgdB55/LzKh4Sy95eOl2bntVOehVncvzyN4E++b/aq5r8dmAv0cyqJ71XdH0z5l0BT3f+C4KvDeJ
        yEseIj7ttAW3iePWTX8dZsCtFfd/DXKqDtxpn0Mz8NxwrePLlqIshiylB6Lz5PGsfPlhy9hh79+r9
        Az/YqbqtA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxslg-00015H-8J; Thu, 06 Sep 2018 11:48:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 97860201F9C3F; Thu,  6 Sep 2018 13:48:10 +0200 (CEST)
Date:   Thu, 6 Sep 2018 13:48:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/6] mm/migrate: Use trylock while resetting rate limit
Message-ID: <20180906114810.GH24082@hirez.programming.kicks-ass.net>
References: <1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1533276841-16341-3-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533276841-16341-3-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 11:43:57AM +0530, Srikar Dronamraju wrote:
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 8c0af0f..dbc2cb7 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1868,16 +1868,24 @@ static struct page *alloc_misplaced_dst_page(struct page *page,
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
> -	if (time_after(jiffies, next_window)) {
> -		spin_lock(&pgdat->numabalancing_migrate_lock);
> +	if (time_after(jiffies, next_window) &&
> +			spin_trylock(&pgdat->numabalancing_migrate_lock)) {

This patch doesn't apply cleanly; also you introduce @next_window with
this patch, so how can it remove a user of it.

I fixed this up, still weird.
