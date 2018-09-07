Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385E2C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D756F2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O8RGV3Rp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jsdfUhN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D756F2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeIHBRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:17:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54354 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeIHBRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:17:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 02D00601B4; Fri,  7 Sep 2018 20:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536352471;
        bh=1eK8AZnCjs06072r1eJ8BgRySHPeTXqwZKx4QMlPuVs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O8RGV3RpxJifLCTUfRQHHQBmcKhfEt4ga2DsuZzlwxJg5wadubDOYWh4IDbY8Rg75
         WfJKZS/kR7d39/5/th8PNKdLxwE1MYv+iaFQa1oWu/XLxgMMDM6i1OZIYAVuZzn8eO
         8FThQbhUIX7hR6smEDbvMa4sIIQ16jKmY+m2keGs=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 3995B601B4;
        Fri,  7 Sep 2018 20:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536352470;
        bh=1eK8AZnCjs06072r1eJ8BgRySHPeTXqwZKx4QMlPuVs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jsdfUhN0sIpyiLob5Ge8sE0agIXse/qzMa/SMrph+bR+y+MN7+oS25X0x8zP/kMkI
         kYAHYy9kuy7nV44IkzucXUiPZDDcNcx2il33KpDBXklmy2BBxIc+gsTIFLlnRuDfQN
         AxLMY9pAAAbx3u3csxC0K/hyx9hd6Xm+2W/vuUzA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 07 Sep 2018 13:34:30 -0700
From:   rishabhb@codeaurora.org
To:     rafael@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        psodagud@codeaurora.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, linux-pm@vger.kernel.org,
        Vikram Mulukutla <markivx@codeaurora.org>
Subject: Re: [PATCH v1] dd: Invoke one probe retry cycle after some initcall
 levels
In-Reply-To: <1534181989-22536-1-git-send-email-rishabhb@quicinc.com>
References: <1534181989-22536-1-git-send-email-rishabhb@quicinc.com>
Message-ID: <1dfc67f3d7ea8aa3cb556c853d29f822@codeaurora.org>
X-Sender: rishabhb@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-13 10:39, Rishabh Bhatnagar wrote:
> From: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> 
> Drivers that are registered at an initcall level may have to
> wait until late_init before the probe deferral mechanism can
> retry their probe functions. It is possible that their
> dependencies were resolved much earlier, in some cases even
> before the next initcall level. Invoke one probe retry cycle
> at every _sync initcall level after subsys initcall, allowing
> these drivers to be probed earlier.
> To give an example many Qualcomm drivers are dependent on the
> regulator and bus driver. Both the regulator and bus driver
> are probed in the subsys_initcall level. Now the probe of bus
> driver requires regulator to be working. If the probe of bus
> driver happens before regulator, then bus driver's probe will
> be deferred and all other device's probes which depend on bus
> driver will also be deferred.
> The impact of this problem is reduced if we have this patch.
> 
> Signed-off-by: Vikram Mulukutla <markivx@codeaurora.org>
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
> 
> Changes since v0:
>  * Remove arch_initcall_sync(deferred_probe_initcall) from patch. This 
> is not
>    really needed as none of the devices are re-probed in 
> arch_initcall_sync
>    level.
> 
>  drivers/base/dd.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 1435d72..9aa41aa 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -224,23 +224,43 @@ void device_unblock_probing(void)
>  	driver_deferred_probe_trigger();
>  }
> 
> +static void enable_trigger_defer_cycle(void)
> +{
> +	driver_deferred_probe_enable = true;
> +	driver_deferred_probe_trigger();
> +	/*
> +	 * Sort as many dependencies as possible before the next initcall
> +	 * level
> +	 */
> +	flush_work(&deferred_probe_work);
> +}
> +
>  /**
>   * deferred_probe_initcall() - Enable probing of deferred devices
>   *
>   * We don't want to get in the way when the bulk of drivers are 
> getting probed.
>   * Instead, this initcall makes sure that deferred probing is delayed 
> until
> - * late_initcall time.
> + * all the registered initcall functions at a particular level are 
> completed.
> + * This function is invoked at every *_initcall_sync level.
>   */
>  static int deferred_probe_initcall(void)
>  {
> -	driver_deferred_probe_enable = true;
> -	driver_deferred_probe_trigger();
> -	/* Sort as many dependencies as possible before exiting initcalls */
> -	flush_work(&deferred_probe_work);
> +	enable_trigger_defer_cycle();
> +	driver_deferred_probe_enable = false;
> +	return 0;
> +}
> +subsys_initcall_sync(deferred_probe_initcall);
> +fs_initcall_sync(deferred_probe_initcall);
> +device_initcall_sync(deferred_probe_initcall);
> +
> +static int deferred_probe_enable_fn(void)
> +{
> +	/* Enable deferred probing for all time */
> +	enable_trigger_defer_cycle();
>  	initcalls_done = true;
>  	return 0;
>  }
> -late_initcall(deferred_probe_initcall);
> +late_initcall(deferred_probe_enable_fn);
> 
>  /**
>   * device_is_bound() - Check if device is bound to a driver

Hi Rafael
Just a reminder about this patch. Let me know if you want me to add/edit 
anything else.
-Rishabh
