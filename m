Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF358C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CE92098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7CE92098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeJCQdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 12:33:37 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51108 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeJCQdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 12:33:37 -0400
Received: from 79.184.253.194.ipv4.supernova.orange.pl (79.184.253.194) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 4e9d75db0ffee1b0; Wed, 3 Oct 2018 11:45:57 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Fieah Lim <kw@fieahl.im>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:CPUIDLE DRIVERS" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] cpuidle: enter_state: Don't needlessly calculate diff time
Date:   Wed, 03 Oct 2018 11:42:56 +0200
Message-ID: <1604543.39SsmLJHeg@aspire.rjw.lan>
In-Reply-To: <20180910214725.19525-1-kw@fieahl.im>
References: <20180910214725.19525-1-kw@fieahl.im>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 10, 2018 11:47:25 PM CEST Fieah Lim wrote:
> Currently we use ktime_us_delta() to calculate last residency and
> state usage unconditionally, it makes no sense to do this calculation
> when we fails to enter any idle state.
> It can be optimize by moving the calculation after entered_state >= 0
> 
> While at it, merge those comment blocks into one and remove a
> space between type casting of diff.
> 
> This patch has no functional changes.
> 
> Signed-off-by: Fieah Lim <kw@fieahl.im>
> ---
> Changes from v1:
>  - Rewrite changelog as Rafael J. Wysocki suggested
> Changes from v2:
>  - Minor adjustment
> ---
>  drivers/cpuidle/cpuidle.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 6df894d65d9e..40442c3631ce 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -247,17 +247,16 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>  	if (!cpuidle_state_is_coupled(drv, index))
>  		local_irq_enable();
>  
> -	diff = ktime_us_delta(time_end, time_start);
> -	if (diff > INT_MAX)
> -		diff = INT_MAX;
> -
> -	dev->last_residency = (int) diff;
> -
>  	if (entered_state >= 0) {
> -		/* Update cpuidle counters */
> -		/* This can be moved to within driver enter routine
> +		/* Update cpuidle counters
> +		 * This can be moved to within driver enter routine,
>  		 * but that results in multiple copies of same code.
>  		 */
> +		diff = ktime_us_delta(time_end, time_start);
> +		if (diff > INT_MAX)
> +			diff = INT_MAX;
> +
> +		dev->last_residency = (int)diff;
>  		dev->states_usage[entered_state].time += dev->last_residency;
>  		dev->states_usage[entered_state].usage++;
>  	} else {
> 

Applied, thanks!


