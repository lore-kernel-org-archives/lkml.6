Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2B3C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21AC520652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kmgjf8Mi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21AC520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbeJDWol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:44:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39256 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeJDWol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:44:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id q8-v6so9528962wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 08:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5FFu4ET6l4IifrAl3Pkq/yUBIsveZ6KHcIx0C4CGJDQ=;
        b=Kmgjf8MiWwstKsccBnj0JAWKtFkuDjOMjG22F3LZb6Cjl+feZfjlCQD0KkwmQjbDwI
         +62FNslW+hls9ilVed78rfEHyNDKHi7bicHWO0w5jrTnxyvF6eOq0g7JCj+M0o0zDrpW
         34S3k+h77ElV/gWQZO0IdnpP/tU96wcqDHQ+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5FFu4ET6l4IifrAl3Pkq/yUBIsveZ6KHcIx0C4CGJDQ=;
        b=f1BKz5cfm7obWyFYH26k6v5kG3GWNI2cgu6DbAyXFxJJeoWAyxxEayuFilmWR+REie
         DeQdGcI7PrO4BuWggF0YCLZgkbymVpYrvz8w8gE7ZCLmDGC8Y7LA2sr2wS7S9ad/G8mM
         PUK8yeJgSGwc342qLzyfTxIu1yoS8XTk7w4GZgfqSgDljLG+fmPDMa4adx2lxsddVVCC
         y1eAkkJ9u6uw1Umwjr9bskmrieLaUF7ZBVrq7d9U8uDBiTciZ9dDBOCS0DkaQprORSnG
         4kZuLgWWcISD6fN4HKr94dEffqtMdrRieXH5L0jbT1x8NBsMIGgZxn38i/MmPTMzMmYM
         Uv1Q==
X-Gm-Message-State: ABuFfohs0zJYqyF7VenZqkpvsR8gw9CoNd2aSYjDTG/VKhHyXobikuaV
        mGMRIsZnqQN0uEY7TOwa9c31TA==
X-Google-Smtp-Source: ACcGV6176bBnZhYyR4zJ4M12swGG1LaGYTKD5Cuej67hE/nQR3umvto6RbOBrk7sf1e5lmt/eOsPeQ==
X-Received: by 2002:a1c:b402:: with SMTP id d2-v6mr4893275wmf.37.1538668248129;
        Thu, 04 Oct 2018 08:50:48 -0700 (PDT)
Received: from mai (101.142.88.92.rev.sfr.net. [92.88.142.101])
        by smtp.gmail.com with ESMTPSA id t24-v6sm8530277wra.5.2018.10.04.08.50.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 08:50:47 -0700 (PDT)
Date:   Thu, 4 Oct 2018 17:50:44 +0200
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] cpuidle: menu: Avoid computations for very close
 timers
Message-ID: <20181004155044.GD1881@mai>
References: <3510260.hvypppS8Bs@aspire.rjw.lan>
 <2753018.aK9edJ7Dvu@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2753018.aK9edJ7Dvu@aspire.rjw.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 11:46:28PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the next timer event (with the tick excluded) is closer than the
> target residency of the second state or the PM QoS latency constraint
> is below its exit latency, state[0] will be used regardless of any
> other factors, so skip the computations in menu_select() then and
> return 0 straight away from it.
> 
> Still, do that after the bucket has been determined to avoid
> disturbing the wakeup statistics in general.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/menu.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> Index: linux-pm/drivers/cpuidle/governors/menu.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> +++ linux-pm/drivers/cpuidle/governors/menu.c
> @@ -309,6 +309,18 @@ static int menu_select(struct cpuidle_dr
>  	get_iowait_load(&nr_iowaiters, &cpu_load);
>  	data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
>  
> +	if (unlikely(drv->state_count <= 1) ||

I'm not sure this test is necessary.

If state_count == 0, we don't have to select anything as the cpuidle can't register because of:

static int __cpuidle_register_driver(struct cpuidle_driver *drv)
{
        int ret;

        if (!drv || !drv->state_count)
                return -EINVAL;

	[ ... ]
}

If state_count == 1, then there is nothing to select, it is always the state 0.

> +	    ((data->next_timer_us < drv->states[1].target_residency ||
> +	      latency_req < drv->states[1].exit_latency) &&
> +	     !drv->states[0].disabled && !dev->states_usage[0].disable)) {
> +		/*
> +		 * In this case state[0] will be used no matter what, so return
> +		 * it right away and keep the tick running.
> +		 */
> +		*stop_tick = false;
> +		return 0;
> +	}
> +
>  	/*
>  	 * Force the result of multiplication to be 64 bits even if both
>  	 * operands are 32 bits.
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
