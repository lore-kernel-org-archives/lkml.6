Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5CEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1697F20892
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F9BTq7W5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1697F20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731391AbeKHDDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:03:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39034 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKHDDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EjPK04htkFwM+XtPQCTvkqIFD6XiX9zdo24MJaDCnhw=; b=F9BTq7W5fqcHsl7EH5akGI85M
        +MnhFKjFUbsTH1ASxlAQcQukVX0XLe3D8FKwIWF2eM9vR6MFOvE0S7mJL8CzvewITfLY7jkoDW5g3
        SyQ4TJqaQYyHOeBIkMkqmvJmpj3nFp8vrPLqMfFZcKU9FnWjpeo4xvecNEYLihYTfNTBgp4OcOJgW
        fVHz98J1QYSzknOt2NpHwet1eXfD3xrzqDxK4bR50v7m34mPC/dQCSzp82TUDSwgf26CVNUVPizs5
        ETdjXAoT4ICv/jVzm3xvXT1C9Zp2KryrnbFXL79UwbfR5zxARZhyDc6v+CYmUGQmjg3VPFN0JeYAS
        dpFk9CN5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKRg7-0005s2-7P; Wed, 07 Nov 2018 17:31:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CFD8620284F96; Wed,  7 Nov 2018 18:31:40 +0100 (CET)
Date:   Wed, 7 Nov 2018 18:31:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Muchun Song <smuchun@gmail.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/rt: Introduce prio_{higher,lower}() helper for
 comparing RT task prority
Message-ID: <20181107173140.GK9761@hirez.programming.kicks-ass.net>
References: <20181107161505.42769-1-smuchun@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107161505.42769-1-smuchun@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 12:15:05AM +0800, Muchun Song wrote:
> We use a value to represent the priority of the RT task. But a smaller
> value corresponds to a higher priority. If there are two RT task A and B,
> their priorities are prio_a and prio_b, respectively. If prio_a is larger
> than prio_b, which means that the priority of RT task A is lower than RT
> task B. It may seem a bit strange.
> 
> In rt.c, there are many if condition of priority comparison. We need to
> think carefully about which priority is higher because of this opposite
> logic when read those code. So we introduce prio_{higher,lower}() helper
> for comparing RT task prority, which can make code more readable.
> 
> Signed-off-by: Muchun Song <smuchun@gmail.com>
> ---
>  kernel/sched/rt.c | 68 ++++++++++++++++++++++++++++++++---------------
>  1 file changed, 46 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 9aa3287ce301..adf0f653c963 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -101,6 +101,28 @@ void init_rt_rq(struct rt_rq *rt_rq)
>  	raw_spin_lock_init(&rt_rq->rt_runtime_lock);
>  }
>  
> +/**
> + * prio_higher(a, b) returns true if the priority a
> + * is higher than the priority b.
> + */
> +static inline bool prio_higher(int a, int b)
> +{
> +	return a < b;
> +}
> +
> +#define prio_lower(a, b)	prio_higher(b, a)
> +
> +/**
> + * prio_higher_eq(a, b) returns true if the priority a
> + * is higher than or equal to the priority b.
> + */
> +static inline bool prio_higher_eq(int a, int b)
> +{
> +	return a <= b;
> +}
> +
> +#define prio_lower_eq(a, b)	prio_higher_eq(b, a)

I think you only need the less thing, because:

static inline bool prio_lower(int a, int b)
{
	return a > b;
}

prio_higher(a,b) := prio_lower(b,a)
prio_higher_eq(a,b) := !prio_lower(a,b)
prio_lower_eq(a,b) := !prio_lower(b,a)

Now, I'm not sure if that actually improves readability if you go around
and directly substitute those identities instead of doing those defines.

The other option is of course to flip the in-kernel priority range the
right way up, but that's a much more difficult patch and will terminally
confuse people for a while.
