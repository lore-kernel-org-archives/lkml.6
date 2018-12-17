Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EDEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143882146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbeLQQ7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:59:43 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60142 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbeLQQ7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:59:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 452CAA78;
        Mon, 17 Dec 2018 08:59:42 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54C263F575;
        Mon, 17 Dec 2018 08:59:41 -0800 (PST)
Subject: Re: [PATCH v2 2/3] sched/fair: trigger asym_packing during idle load
 balance
To:     Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     Morten.Rasmussen@arm.com
References: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
 <1544803317-7610-3-git-send-email-vincent.guittot@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <ff8844de-8dd7-c5b8-a90e-e15899d081af@arm.com>
Date:   Mon, 17 Dec 2018 16:59:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544803317-7610-3-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 14/12/2018 16:01, Vincent Guittot wrote:
> newly idle load balance is not always triggered when a cpu becomes idle.
> This prevent the scheduler to get a chance to migrate task for asym packing.
> Enable active migration because of asym packing during idle load balance too.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c215f7a..9591e7a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8861,7 +8861,7 @@ static int need_active_balance(struct lb_env *env)
>  {
>  	struct sched_domain *sd = env->sd;
>  
> -	if (env->idle == CPU_NEWLY_IDLE) {
> +	if (env->idle != CPU_NOT_IDLE) {
>  
>  		/*
>  		 * ASYM_PACKING needs to force migrate tasks from busy but
> 

That change looks fine. However, you're mentioning newidle load_balance()
not being triggered - you'd want to set root_domain->overload for any
newidle pull to happen, probably with something like this:

-----8<-----
@@ -8398,6 +8408,9 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
                sg = sg->next;
        } while (sg != env->sd->groups);
 
+       if (check_asym_packing(env, sds))
+               sg_status |= SG_OVERLOAD;
+
 #ifdef CONFIG_NO_HZ_COMMON
        if ((env->flags & LBF_NOHZ_AGAIN) &&
            cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(env->sd))) {
----->8-----

It's similar to what is done for misfit, although that's yet another
'twisted' use of that flag which we might want to rename (I suggested
something like 'need_idle_balance' a while back but it wasn't really
popular).
