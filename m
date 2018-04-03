Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932199AbeDCMjx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 08:39:53 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43867 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932087AbeDCMjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 08:39:51 -0400
X-Google-Smtp-Source: AIpwx48ecREqhgB/HNUJe75bdpVbUcf11OiY33xYUgKmmG2qjJeX6byMuK7Nd+hihIAcj/4a6sp/Bw==
Date: Tue, 3 Apr 2018 13:39:48 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: peterz@infradead.org, mingo@kernel.org, efault@gmx.de,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] sched/rt: Fix rq->clock_update_flags < RQCF_ACT_SKIP
 warning
Message-ID: <20180403123948.GA4771@codeblueprint.co.uk>
References: <20180402164954.16255-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180402164954.16255-1-dave@stgolabs.net>
User-Agent: Mutt/1.5.24+42 (6e565710a064) (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Apr, at 09:49:54AM, Davidlohr Bueso wrote:
> 
> We can get rid of it be the "traditional" means of adding an update_rq_clock() call
> after acquiring the rq->lock in do_sched_rt_period_timer().
> 
> The case for the rt task throttling (which this workload also hits) can be ignored in
> that the skip_update call is actually bogus and quite the contrary (the request bits
> are removed/reverted). By setting RQCF_UPDATED we really don't care if the skip is
> happening or not and will therefore make the assert_clock_updated() check happy.
> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  kernel/sched/rt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 86b77987435e..ad13e6242481 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -839,6 +839,8 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
>  			continue;
>  
>  		raw_spin_lock(&rq->lock);
> +		update_rq_clock(rq);
> +
>  		if (rt_rq->rt_time) {
>  			u64 runtime;

Looks good to me.

Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
