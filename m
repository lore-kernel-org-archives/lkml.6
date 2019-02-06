Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF41CC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61EC206C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbfBFKfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:35:18 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58418 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbfBFKfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:35:17 -0500
Received: from 79.184.254.36.ipv4.supernova.orange.pl (79.184.254.36) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id d97ed51e97c75656; Wed, 6 Feb 2019 11:35:15 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ladislav Michl <ladis@linux-mips.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] PM/runtime: Optimize pm_runtime_autosuspend_expiration()
Date:   Wed, 06 Feb 2019 11:34:03 +0100
Message-ID: <4091828.IqCJ3qcF9B@aspire.rjw.lan>
In-Reply-To: <20190130214017.GA5038@lenoch>
References: <20190130214017.GA5038@lenoch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, January 30, 2019 10:40:17 PM CET Ladislav Michl wrote:
> pm_runtime_autosuspend_expiration calls ktime_get_mono_fast_ns
> even when its returned value may be unused. Therefore get
> current time later and remove gotos while there.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  This patch is based on top of bleeding-edge branch, where
>  "[PATCH v2 ] PM-runtime: fix deadlock with ktime" is sitting.
>  I expect v3 of that patch, which should not harm this one.
>  It is meant to replace "PM/runtime: Do not needlessly call ktime_get"
>  sent earlier.
> 
>  drivers/base/power/runtime.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 65e2b5f48e0c..7bbe28faca8d 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -145,24 +145,21 @@ static void pm_runtime_cancel_pending(struct device *dev)
>  u64 pm_runtime_autosuspend_expiration(struct device *dev)
>  {
>  	int autosuspend_delay;
> -	u64 last_busy, expires = 0;
> -	u64 now = ktime_get_mono_fast_ns();
> +	u64 expires;
>  
>  	if (!dev->power.use_autosuspend)
> -		goto out;
> +		return 0;
>  
>  	autosuspend_delay = READ_ONCE(dev->power.autosuspend_delay);
>  	if (autosuspend_delay < 0)
> -		goto out;
> -
> -	last_busy = READ_ONCE(dev->power.last_busy);
> +		return 0;
>  
> -	expires = last_busy + (u64)autosuspend_delay * NSEC_PER_MSEC;
> -	if (expires <= now)
> -		expires = 0;	/* Already expired. */
> +	expires  = READ_ONCE(dev->power.last_busy);
> +	expires += (u64)autosuspend_delay * NSEC_PER_MSEC;
> +	if (expires > ktime_get_mono_fast_ns())
> +		return expires;	/* Expires in the future */
>  
> - out:
> -	return expires;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_autosuspend_expiration);
>  
> 

Applied, thanks!


