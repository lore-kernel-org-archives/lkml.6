Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B75C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1E725C27
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L8B+g6id"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1E725C27
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934135AbeGBMED (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:04:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42528 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753269AbeGBMEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wEFkXFWTsIbgDU1KgirDRbWQl2B9HIpHVgo3mtiQ20Y=; b=L8B+g6idPlNrEPtAsFJg0SANp5
        b6FrQFfKmQGPjZtFJq2dBMKnk1nS5eYPDClPDZmiheyanDe8+jT9W50GsVUOfZbKIOhHRuNWZx/30
        bf138/hPBpO/DzEeszUYANehWeci4qG462E8M1WVjblcRNK/31yuWcEefaFDTK2bjGGbvCiaUjzxI
        OQ+Fm/YRDIF0KDhMLdA4hHNyxYWY7vz4abQEEO8CsglNRBUArc/vnKgbWH/ict94zO9GeE1Bl5o1y
        0xdu2LDcCeoaJv9ZYpie3jpblpQKzvn0LvrFam/sGjItH3sUj682v8uh3xxgl23LFxFqxjAxXDLk1
        qnwxrlVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fZxYk-0005lj-UV; Mon, 02 Jul 2018 12:03:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A5A5B20289CE4; Mon,  2 Jul 2018 14:03:56 +0200 (CEST)
Date:   Mon, 2 Jul 2018 14:03:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tg: count the sum wait time of an task group
Message-ID: <20180702120356.GJ2494@hirez.programming.kicks-ass.net>
References: <5c4c978d-e8fb-4bcb-b942-3c6d3dcfc13e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c4c978d-e8fb-4bcb-b942-3c6d3dcfc13e@linux.alibaba.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 03:29:39PM +0800, 王贇 wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1866e64..ef82ceb 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -862,6 +862,7 @@ static void update_curr_fair(struct rq *rq)
>  static inline void
>  update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
> +	struct task_group *tg;
>  	struct task_struct *p;
>  	u64 delta;
> 
> @@ -882,6 +883,9 @@ static void update_curr_fair(struct rq *rq)
>  			return;
>  		}
>  		trace_sched_stat_wait(p, delta);
> +	} else {
> +		tg = group_cfs_rq(se)->tg;
> +		__schedstat_add(tg->wait_sum, delta);
>  	}

You're joking right? This patch is both broken and utterly insane.

You're wanting to update an effectively global variable for every
schedule action (and its broken because it is without any serialization
or atomics).

NAK
