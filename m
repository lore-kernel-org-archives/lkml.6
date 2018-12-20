Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9FFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229BD21773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbeLTLTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 06:19:55 -0500
Received: from foss.arm.com ([217.140.101.70]:52500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728172AbeLTLTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 06:19:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D24B6A78;
        Thu, 20 Dec 2018 03:19:53 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D55603F5C0;
        Thu, 20 Dec 2018 03:19:52 -0800 (PST)
Subject: Re: [PATCH 2/3] sched/fair: trigger asym_packing during idle load
 balance
To:     Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     Morten.Rasmussen@arm.com
References: <1545292547-18770-1-git-send-email-vincent.guittot@linaro.org>
 <1545292547-18770-3-git-send-email-vincent.guittot@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <edd9f36f-7826-11db-94ff-1604a4be11d0@arm.com>
Date:   Thu, 20 Dec 2018 11:19:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545292547-18770-3-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2018 07:55, Vincent Guittot wrote:
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
> index 9b31247..487c73e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8853,7 +8853,7 @@ static int need_active_balance(struct lb_env *env)
>  {
>  	struct sched_domain *sd = env->sd;
>  
> -	if (env->idle == CPU_NEWLY_IDLE) {
> +	if (env->idle != CPU_NOT_IDLE) {
>  
>  		/*
>  		 * ASYM_PACKING needs to force migrate tasks from busy but
> 

Regarding just extending the condition to include idle balance:

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>


As in the previous thread, I'll still argue that if you want to *reliably*
exploit newidle balances to do asym packing active balancing, you should
add some logic to raise rq->rd->overload when we notice some asym packing
could be done, so that it can be leveraged by a higher-priority CPU doing
a newidle balance.

Otherwise the few newidle asym-packing active balances you'll get will be
due to somewhat random luck because we happened to set that overload flag
at some point.
