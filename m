Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5304C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0F720866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0F720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeIKBNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 21:13:53 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35596 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeIKBNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 21:13:53 -0400
Received: by mail-oi0-f65.google.com with SMTP id m11-v6so42800953oic.2;
        Mon, 10 Sep 2018 13:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EVHgpSuDaoY3JrD6vuGvga+HYBnCkjRqx9mV9SBUtCs=;
        b=i/XQBstpJH/LG6krPwIhvZqlYpgbIfDgolTTam9jTtRj67NcCJQlpZLl03Aww+zTFb
         al4tTtY4mfdNSFuiHqws44OmiRB05YfFqC0VO1TyNUnvqTi75uFqsgFTG77py0yUmJlB
         mr564bDEH2WuiTUmdXNLi307xMGCUalIJuRoUPSGvpwom01hpLKSW44RmdIDWpMdzr3z
         8tkufZIPMzYdcMwO3fEhCQCe+GJh0PEtMDte9tk3tHnBpi6u41XuVv5tKjApRsbNHqj6
         c4ueClB+LfQlOwil0bcuGvTdZOTMle0nAv4l0FWFVKZZH0KhxvecccxbV2ffPR2VAe+N
         pMhA==
X-Gm-Message-State: APzg51A/75GiJXCRSxqi1dKHUGpJRBuBKOb2vZQe+fED5LgKA+EZD4Bq
        uiEO2Lf1jw5z77dTmhByeRGlfhL/2ZntTQ5lILY=
X-Google-Smtp-Source: ANB0Vdb7CucpeiAZwWX61o1BjEa62QMPpidtaNbZAg6ZgX0MyMG+G4QlAMNaerI1yAZKJRNFOuAEDqbPAFCxWU2yGX4=
X-Received: by 2002:aca:fd4f:: with SMTP id b76-v6mr24515006oii.307.1536610686390;
 Mon, 10 Sep 2018 13:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180910173953.10113-1-kw@fieahl.im>
In-Reply-To: <20180910173953.10113-1-kw@fieahl.im>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 Sep 2018 22:17:55 +0200
Message-ID: <CAJZ5v0ijVnhZ52GrVbCeRQMCTBzgpBgB7AYoqJegjSBEcXamSA@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: enter_state: Don't needlessly calculate diff time
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

On Mon, Sep 10, 2018 at 7:40 PM Fieah Lim <kw@fieahl.im> wrote:
>
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

You don't need this line if you retain the "else" branch below, do you?

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
