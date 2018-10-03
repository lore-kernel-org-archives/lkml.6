Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2854C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749DE2098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749DE2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbeJCQds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 12:33:48 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42582 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeJCQds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 12:33:48 -0400
Received: from 79.184.253.194.ipv4.supernova.orange.pl (79.184.253.194) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 40a6ac4bace627b0; Wed, 3 Oct 2018 11:46:08 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Fieah Lim <kw@fieahl.im>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CPUIDLE DRIVERS" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2] cpuidle: Remove unnecessary wrapper cpuidle_get_last_residency()
Date:   Wed, 03 Oct 2018 11:43:08 +0200
Message-ID: <43967378.Cn3UgLrHJv@aspire.rjw.lan>
In-Reply-To: <20180910195901.15200-1-kw@fieahl.im>
References: <20180910195901.15200-1-kw@fieahl.im>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 10, 2018 9:59:01 PM CEST Fieah Lim wrote:
> cpuidle_get_last_residency() is just a wrapper for retrieves
> device's last_residency, it's also weirdly the only
> wrapper function for accessing cpuidle_* struct member,
> and my best guess is it could be a leftover from v2.x
> 
> Anyhow, since the only two users(ladder and menu governor)
> can access dev->last_residency directly, and it's more intuitive,
> let's just get rid of it.
> 
> This patch tidies up CPU idle driver a bit without functional changes.
> 
> Signed-off-by: Fieah Lim <kw@fieahl.im>
> ---
> Changes from v1:
>  - Rewrite changelog as Rafael J. Wysocki suggested
> ---
>  drivers/cpuidle/governors/ladder.c |  2 +-
>  drivers/cpuidle/governors/menu.c   |  2 +-
>  include/linux/cpuidle.h            | 10 ----------
>  3 files changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
> index 704880a6612a..f0dddc66af26 100644
> --- a/drivers/cpuidle/governors/ladder.c
> +++ b/drivers/cpuidle/governors/ladder.c
> @@ -80,7 +80,7 @@ static int ladder_select_state(struct cpuidle_driver *drv,
>  
>  	last_state = &ldev->states[last_idx];
>  
> -	last_residency = cpuidle_get_last_residency(dev) - drv->states[last_idx].exit_latency;
> +	last_residency = dev->last_residency - drv->states[last_idx].exit_latency;
>  
>  	/* consider promotion */
>  	if (last_idx < drv->state_count - 1 &&
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index 1aef60d160eb..715520e339da 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -492,7 +492,7 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>  		measured_us = 9 * MAX_INTERESTING / 10;
>  	} else {
>  		/* measured value */
> -		measured_us = cpuidle_get_last_residency(dev);
> +		measured_us = dev->last_residency;
>  
>  		/* Deduct exit latency */
>  		if (measured_us > 2 * target->exit_latency)
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 4325d6fdde9b..d262f620890e 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -99,16 +99,6 @@ struct cpuidle_device {
>  DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
>  DECLARE_PER_CPU(struct cpuidle_device, cpuidle_dev);
>  
> -/**
> - * cpuidle_get_last_residency - retrieves the last state's residency time
> - * @dev: the target CPU
> - */
> -static inline int cpuidle_get_last_residency(struct cpuidle_device *dev)
> -{
> -	return dev->last_residency;
> -}
> -
> -
>  /****************************
>   * CPUIDLE DRIVER INTERFACE *
>   ****************************/
> 

Applied, thanks!


