Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAD0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F66208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F66208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbeH1Aww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 20:52:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49606 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbeH1Aww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 20:52:52 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 552A2C74;
        Mon, 27 Aug 2018 21:04:33 +0000 (UTC)
Date:   Mon, 27 Aug 2018 14:04:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 3/3] mm: don't miss the last page because of
 round-off error
Message-Id: <20180827140432.b3c792f60235a13739038808@linux-foundation.org>
In-Reply-To: <20180827162621.30187-3-guro@fb.com>
References: <20180827162621.30187-1-guro@fb.com>
        <20180827162621.30187-3-guro@fb.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2018 09:26:21 -0700 Roman Gushchin <guro@fb.com> wrote:

> I've noticed, that dying memory cgroups are  often pinned
> in memory by a single pagecache page. Even under moderate
> memory pressure they sometimes stayed in such state
> for a long time. That looked strange.
> 
> My investigation showed that the problem is caused by
> applying the LRU pressure balancing math:
> 
>   scan = div64_u64(scan * fraction[lru], denominator),
> 
> where
> 
>   denominator = fraction[anon] + fraction[file] + 1.
> 
> Because fraction[lru] is always less than denominator,
> if the initial scan size is 1, the result is always 0.
> 
> This means the last page is not scanned and has
> no chances to be reclaimed.
> 
> Fix this by rounding up the result of the division.
> 
> In practice this change significantly improves the speed
> of dying cgroups reclaim.
> 
> ...
>
> --- a/include/linux/math64.h
> +++ b/include/linux/math64.h
> @@ -281,4 +281,6 @@ static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 divisor)
>  }
>  #endif /* mul_u64_u32_div */
>  
> +#define DIV64_U64_ROUND_UP(ll, d)	div64_u64((ll) + (d) - 1, (d))

This macro references arg `d' more than once.  That can cause problems
if the passed expression has side-effects and is poor practice.  Can
we please redo this with a temporary?

>  #endif /* _LINUX_MATH64_H */
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d649b242b989..2c67a0121c6d 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2446,9 +2446,11 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
>  			/*
>  			 * Scan types proportional to swappiness and
>  			 * their relative recent reclaim efficiency.
> +			 * Make sure we don't miss the last page
> +			 * because of a round-off error.
>  			 */
> -			scan = div64_u64(scan * fraction[file],
> -					 denominator);
> +			scan = DIV64_U64_ROUND_UP(scan * fraction[file],
> +						  denominator);
>  			break;
>  		case SCAN_FILE:
>  		case SCAN_ANON:

