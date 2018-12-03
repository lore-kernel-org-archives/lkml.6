Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2199C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7264206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7264206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbeLCLzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:55:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:59758 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbeLCLzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:55:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 79AEBAC66;
        Mon,  3 Dec 2018 11:54:54 +0000 (UTC)
Date:   Mon, 3 Dec 2018 12:54:53 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] mm/memcg: Fix min/low usage in
 propagate_protected_usage()
Message-ID: <20181203115453.GO31738@dhcp22.suse.cz>
References: <20181203080119.18989-1-xlpang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203080119.18989-1-xlpang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 03-12-18 16:01:17, Xunlei Pang wrote:
> When usage exceeds min, min usage should be min other than 0.
> Apply the same for low.

Why? What is the actual problem.

> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
> ---
>  mm/page_counter.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/page_counter.c b/mm/page_counter.c
> index de31470655f6..75d53f15f040 100644
> --- a/mm/page_counter.c
> +++ b/mm/page_counter.c
> @@ -23,11 +23,7 @@ static void propagate_protected_usage(struct page_counter *c,
>  		return;
>  
>  	if (c->min || atomic_long_read(&c->min_usage)) {
> -		if (usage <= c->min)
> -			protected = usage;
> -		else
> -			protected = 0;
> -
> +		protected = min(usage, c->min);
>  		old_protected = atomic_long_xchg(&c->min_usage, protected);
>  		delta = protected - old_protected;
>  		if (delta)
> @@ -35,11 +31,7 @@ static void propagate_protected_usage(struct page_counter *c,
>  	}
>  
>  	if (c->low || atomic_long_read(&c->low_usage)) {
> -		if (usage <= c->low)
> -			protected = usage;
> -		else
> -			protected = 0;
> -
> +		protected = min(usage, c->low);
>  		old_protected = atomic_long_xchg(&c->low_usage, protected);
>  		delta = protected - old_protected;
>  		if (delta)
> -- 
> 2.13.5 (Apple Git-94)
> 

-- 
Michal Hocko
SUSE Labs
