Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA561C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 19:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4C620854
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 19:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4C620854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeIJAbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 20:31:25 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38666 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeIJAbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 20:31:25 -0400
Received: by mail-oi0-f68.google.com with SMTP id x197-v6so36297828oix.5;
        Sun, 09 Sep 2018 12:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gSYORtRbh28CvZHLcFWHaJcDEtM+zIgifNx2TjhO/aI=;
        b=HTXxnu/nZfcebLybrdACrM9owYArFk5tggx9gwjGJz0nhrDaXtSL3ee24Nfap92bFC
         VZb4bWq60hTbbA0WLHfLF9eWYfz7RUeNxhavIrIS93pRxVP+Qzdzh88tR1dMI6V4w0AV
         JWRi5xyG4bSpcpgp49FA26oY6Lx8fLUXq8zBIIX1C6VoDnbQs7kPQGd+IkNijk+t1BMA
         1buAXHLLCTsqj3FgcuJX13dpBd4K+VCRwvEIMB/c/k7ZCbS8B1BxIKD3vG+3x2cetKZk
         asKkrgyMEX5PoWKRiZ+kfy1UJ/xQ9OiwkmsTXT32y8OvbFE9Jx3ekcG9YlAQUNd0kxlG
         zQzA==
X-Gm-Message-State: APzg51Aubm14zEpBMBUHRLHnjtImLiXWBouQy92T5/+fub45gMMW7V8E
        5vEqJprw0V0hg7fa7ahFpXESU+RSFERAZrdhYuUhMQ==
X-Google-Smtp-Source: ANB0VdYw0bBVmv+T71HeNOEp+8n1VqAHRi/G+7Le+r3UNHERWBCHgtlA+4VJm29ksX85Rp95WfQvROEtJqzx+lSjEuY=
X-Received: by 2002:aca:d098:: with SMTP id j24-v6mr18836417oiy.72.1536522041572;
 Sun, 09 Sep 2018 12:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180907185448.30987-1-kw@fieahl.im>
In-Reply-To: <20180907185448.30987-1-kw@fieahl.im>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 9 Sep 2018 21:40:25 +0200
Message-ID: <CAJZ5v0jwQBWu_Vw=Wmao3BDgCnutsLTq68Niyb46Y9wZ6DZb+A@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: enter_state: Don't needlessly calculate diff time
To:     kw@fieahl.im
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 8:55 PM Fieah Lim <kw@fieahl.im> wrote:
>
> ktime_us_delta() is not that cheap on some platform,
> and I think this is also the right thing to do.
> While at it, fix some coding style as well.
>
> Signed-off-by: Fieah Lim <kw@fieahl.im>

Fix your changelog at least to say that you optimize the code without
changing its functionality.

> ---
>  drivers/cpuidle/cpuidle.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 6df894d65d9e..5f6b2c9b6555 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -247,21 +247,20 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>         if (!cpuidle_state_is_coupled(drv, index))
>                 local_irq_enable();
>
> -       diff = ktime_us_delta(time_end, time_start);
> -       if (diff > INT_MAX)
> -               diff = INT_MAX;
> -
> -       dev->last_residency = (int) diff;
> +       dev->last_residency = 0;
>
>         if (entered_state >= 0) {
> -               /* Update cpuidle counters */
> -               /* This can be moved to within driver enter routine
> +               /* Update cpuidle counters
> +                * This can be moved to within driver enter routine,
>                  * but that results in multiple copies of same code.
>                  */
> +               diff = ktime_us_delta(time_end, time_start);
> +               if (diff > INT_MAX)
> +                       diff = INT_MAX;
> +
> +               dev->last_residency = (int)diff;
>                 dev->states_usage[entered_state].time += dev->last_residency;
>                 dev->states_usage[entered_state].usage++;
> -       } else {
> -               dev->last_residency = 0;
>         }
>
>         return entered_state;
> --
> 2.18.0
>
