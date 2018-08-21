Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0472C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2577C216C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2577C216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbeHULxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 07:53:46 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43455 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeHULxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 07:53:46 -0400
Received: from 79.184.253.33.ipv4.supernova.orange.pl (79.184.253.33) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 90be5fd06e6eea36; Tue, 21 Aug 2018 10:34:30 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1 1/5] cpuidle: menu: Clean up variables usage in menu_select()
Date:   Tue, 21 Aug 2018 10:32:14 +0200
Message-ID: <2838787.qSB1WlRZH1@aspire.rjw.lan>
In-Reply-To: <1534090171-14464-2-git-send-email-leo.yan@linaro.org>
References: <1534090171-14464-1-git-send-email-leo.yan@linaro.org> <1534090171-14464-2-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, August 12, 2018 6:09:27 PM CEST Leo Yan wrote:
> The usage for two variables 'data->predicted_us' and 'expected_interval'
> in menu_select() are confused, especially these two variables are
> assigned with each other: firstly 'data->predicted_us' is assigned to
> the minimum value between 'data->predicted_us' and 'expected_interval',
> so it presents the prediction period for taking account different
> factors and include consideration for expected interval; but later
> 'data->predicted_us' is assigned back to 'expected_interval' and from
> then on the function uses 'expected_interval' to select idle state; this
> results in 'expected_interval' has two different semantics between the
> top half and the bottom half of the same function.
> 
> This patch is to clean up the usage of these two variables, we always
> use 'data->predicted_us' to present the idle duration predictions and
> it can be used to compare with idle state target residency or tick
> boundary for choosing idle state; we purely use 'expected_interval' to
> record the expected interval value, which is mainly for interval
> interrupt estimation.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/cpuidle/governors/menu.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index 5eb7d6f..b972db1 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -363,7 +363,6 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  		latency_req = interactivity_req;
>  
>  select:
> -	expected_interval = data->predicted_us;
>  	/*
>  	 * Find the idle state with the lowest power while satisfying
>  	 * our constraints.
> @@ -386,7 +385,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  			 * expected idle duration so that the tick is retained
>  			 * as long as that target residency is low enough.
>  			 */
> -			expected_interval = drv->states[idx].target_residency;
> +			data->predicted_us = drv->states[idx].target_residency;

This is not what is predicted though, so the name of the field isn't quite
adequate for this use IMO.

Besides, I'm not sure in what way using a structure field is simpler than
using a local variable.

>  			break;
>  		}
>  		idx = i;
> @@ -400,7 +399,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  	 * expected idle duration is shorter than the tick period length.
>  	 */
>  	if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
> -	    expected_interval < TICK_USEC) && !tick_nohz_tick_stopped()) {
> +	    data->predicted_us < TICK_USEC) && !tick_nohz_tick_stopped()) {
>  		unsigned int delta_next_us = ktime_to_us(delta_next);
>  
>  		*stop_tick = false;
> 

Yes, it can be simplified along these lines, but then please note that
data->predicted_us is only used in menu_select(), so it doesn't even need to
be there in struct menu_device.  And if you make it a local variable and
call it something like duration_us, then yes, it will be fine to use it like
in this patch in my view.

Thanks,
Rafael

