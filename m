Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F76C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1464420880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550741745;
	bh=8Nix8uxa0PRZE03MofpnF/rC2WAvncIcdk/HKAA101w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=U1ujy4/NzNoRizytqAQh5TBEhhqR6sIYb8jG69pRWJOEAcFiln2BVd00g0R27rKx1
	 jZUmJV9oInlMB2PzUJC7uBcLyBHiC9uDvj5XQAMnjKhgwc5nA4KVbwCYEb4nmMf2ca
	 D3dW51K/VResqoeAETLpI3TPhDJjBqpwNK8Uy0xo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfBUJfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:35:43 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43090 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUJfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:35:43 -0500
Received: by mail-oi1-f194.google.com with SMTP id i8so887671oib.10;
        Thu, 21 Feb 2019 01:35:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o9hOMFcRs9ElWYh2qkLTKPzYO4tg8kl1dNzFbX6vymE=;
        b=gqpzFIG61QmCtJLlT1ZKu8QQzL91cwDtYC5kcgxm8C5ullP6F/uUdv7zmCg2UWwHmg
         UEKNxUT5GfsWY/Whj4DMI5ikkseGAwACW4erA6xr6VuxMF/xrgl9ikqf9Aox6BGoY3Ju
         tIc3vjrX5mhYHHGrzRJ9nd01uiPu3KqjBBdhDDNbnYDBI9p+bs+b+segRlr8bYuZ2AmU
         CZfTx92PNoBDWvKO8Pp6cdeeUh0rz/ksVvCAjKCjqAs815wa4W2hx9SdSA1H9Uo65LIH
         ZCNjWO+JrMTMfUd3Jv9RYsKjuBKqKHgeoWKS37lbHoK1gda0RWWjDqm8WWDoYTlWSrfA
         NgGw==
X-Gm-Message-State: AHQUAua8EkalMI7GBpuT5TvnDgmDe1bCkx0FJOP6O6PlqnwKZPn514+w
        Cu8zpJMYc44m7mNnTjWF9D6N7hqVe/7uy/hB/Mk=
X-Google-Smtp-Source: AHgI3IYzvSauU76yZPQLBTMDY5HyMahxOdNk/iafHIcD7dPpw6ohASiM4noKNpJzp5Anagbpk5xFAnQ+KTdWe5oB5vU=
X-Received: by 2002:aca:88b:: with SMTP id 133mr3627431oii.95.1550741742044;
 Thu, 21 Feb 2019 01:35:42 -0800 (PST)
MIME-Version: 1.0
References: <1550735942-3569-1-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1550735942-3569-1-git-send-email-vincent.guittot@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Feb 2019 10:35:30 +0100
Message-ID: <CAJZ5v0jEF2=etp=gLY4dchhB5pRjf8NAUnUt4oyC63pCsd1jqQ@mail.gmail.com>
Subject: Re: [PATCH] PM-runtime: fix deadlock when canceling hrtimer
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Zhaosheng Sun <sunzhaosheng@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 8:59 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> When rpm_resume() desactivates the autosuspend timer, it should only try
> to cancel hrtimer but not wait for the handler to finish because both
> rpm_resume() and pm_suspend_timer_fn() are taking the power.lock.
> We can have the deadlock sequence:
> CPU0                              CPU1
> rpm_resume()
>   spin_lock_irqsave
>                                   pm_suspend_timer_fn()
>                                     spin_lock_irqsave
>   pm_runtime_deactivate_timer()
>     hrtimer_cancel()

Everybody has missed this, not good.

> hrtimer_try_to_cancel() is enough because dev->power.timer_expires is also
> set to 0.
>
> Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> Reported-by: Sunzhaosheng Sun(Zhaosheng) <sunzhaosheng@hisilicon.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  drivers/base/power/runtime.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 04407d9..78937c4 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -121,7 +121,7 @@ EXPORT_SYMBOL_GPL(pm_runtime_suspended_time);
>  static void pm_runtime_deactivate_timer(struct device *dev)
>  {
>         if (dev->power.timer_expires > 0) {
> -               hrtimer_cancel(&dev->power.suspend_timer);
> +               hrtimer_try_to_cancel(&dev->power.suspend_timer);
>                 dev->power.timer_expires = 0;
>         }
>  }
> --

Applied with some changelog modifications, thanks!
