Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED66C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A37D2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731933AbfAKKlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:41:35 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61395 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbfAKKle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:41:34 -0500
Received: from 79.184.254.168.ipv4.supernova.orange.pl (79.184.254.168) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id dbb598f996a4f868; Fri, 11 Jan 2019 11:41:32 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ladislav Michl <ladis@linux-mips.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2] PM/runtime: Fix 'jiffies' in comments after move to hrtimers
Date:   Fri, 11 Jan 2019 11:40:44 +0100
Message-ID: <1861668.sGDoxnQT1I@aspire.rjw.lan>
In-Reply-To: <20190109231944.GA21177@lenoch>
References: <20190109172336.GA1711@lenoch> <CAJZ5v0iZRUaAb-eiodgByZiEAe8AWxk9G2p8zHK45J-LuXgaAA@mail.gmail.com> <20190109231944.GA21177@lenoch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, January 10, 2019 12:19:44 AM CET Ladislav Michl wrote:
> PM-runtime now uses the hrtimers infrastructure for autosuspend, however
> comments still reference 'jiffies'.
> 
> Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>  Changes:
>  -v2: Reword comment accoring to Rafael's suggestion
> 
>  drivers/base/power/runtime.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 70624695b6d5..a282e74d1a16 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -121,7 +121,7 @@ static void pm_runtime_cancel_pending(struct device *dev)
>   * Compute the autosuspend-delay expiration time based on the device's
>   * power.last_busy time.  If the delay has already expired or is disabled
>   * (negative) or the power.use_autosuspend flag isn't set, return 0.
> - * Otherwise return the expiration time in jiffies (adjusted to be nonzero).
> + * Otherwise return the expiration time in nanoseconds (adjusted to be nonzero).
>   *
>   * This function may be called either with or without dev->power.lock held.
>   * Either way it can be racy, since power.last_busy may be updated at any time.
> @@ -905,7 +905,10 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
>  	spin_lock_irqsave(&dev->power.lock, flags);
>  
>  	expires = dev->power.timer_expires;
> -	/* If 'expire' is after 'jiffies' we've been called too early. */
> +	/*
> +	 * If 'expires' is after the current time, we've been called
> +	 * too early.
> +	 */
>  	if (expires > 0 && expires < ktime_to_ns(ktime_get())) {
>  		dev->power.timer_expires = 0;
>  		rpm_suspend(dev, dev->power.timer_autosuspends ?
> 

Applied, thanks!


