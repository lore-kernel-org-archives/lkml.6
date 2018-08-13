Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FCDC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2292721829
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2292721829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbeHMKj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 06:39:28 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40554 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeHMKj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 06:39:28 -0400
Received: by mail-oi0-f68.google.com with SMTP id w126-v6so25712662oie.7;
        Mon, 13 Aug 2018 00:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wdG3fKYjIgkM+0L/vtTha++Ou+Z33xugEKRMSHwPJjs=;
        b=AVZNzwf04CPHSqXQjurGthLfdZmV02MUFoBKDRNaB5l/76iamGaXBW7P/XJgXaCiCV
         ViUCfLyk0mtdkECynCdpZLj9XiolDdyZNBQSJL8NIAi9G0rZrOed8U0ZcbuFpw7ApmPK
         cOJpi11jh+9iSiZ4glWD+BsHGndqFM1sFqkaJBQPkoUlwM8Rp2JCr4J2sXe8MQD06WC/
         5iMrsznGOZEsxGDo1hfdb43xp/34TCUidu3aJcDlqro/YKP9munEKD5CIOxZeQ33FDau
         Fd5YDQTfZAnNfXZN/I1460v+ZrsudaZrv1yb+vVZLmrtd6kpaEo5N4eE55nG6EqnoVpO
         Af7Q==
X-Gm-Message-State: AOUpUlH2B0lkkwC8H0/cAOZobcjcA54bDlOcfJefq6d0viihBr9rua4S
        W/9Om5jR0esgvF4C/IWdodhUXyXScdA45dAfhcBlQg==
X-Google-Smtp-Source: AA+uWPxE8wEtr/A5CWZFECMhW2L5lxn19ZR15HBU32HyjkF3ve1ir05lceelXxnYu+sgXHDXS2p7/8MSnR92OYnQCFY=
X-Received: by 2002:aca:ad4f:: with SMTP id w76-v6mr18355734oie.233.1534147101014;
 Mon, 13 Aug 2018 00:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <1951009.1jlQfyrxio@aspire.rjw.lan> <3174357.2tBMdxG3bF@aspire.rjw.lan>
 <20180810092034.GF11817@leoy-ThinkPad-X240s> <CAJZ5v0h8T99pqhNoj+V9Mb5yS621OT_=d05YbWtbCW5H362myA@mail.gmail.com>
 <20180810123143.GG11817@leoy-ThinkPad-X240s> <CAJZ5v0h5XWES6ye152MjijWKqTWBVO2mjo5Jz3MmMn+=7tRqWA@mail.gmail.com>
 <20180812134404.GA28966@leoy-ThinkPad-X240s>
In-Reply-To: <20180812134404.GA28966@leoy-ThinkPad-X240s>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Aug 2018 09:58:07 +0200
Message-ID: <CAJZ5v0jPfKd7BLWjLdLE_M4uJqDrmSgMWyypFB_+DVvAtr0etg@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: menu: Handle stopped tick more aggressively
To:     Leo Yan <leo.yan@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2018 at 3:44 PM <leo.yan@linaro.org> wrote:
>
> On Sun, Aug 12, 2018 at 12:07:45PM +0200, Rafael J. Wysocki wrote:
>
> [...]
>
> > > > > > --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> > > > > > +++ linux-pm/drivers/cpuidle/governors/menu.c
> > > > > > @@ -285,9 +285,8 @@ static int menu_select(struct cpuidle_dr
> > > > > >  {
> > > > > >       struct menu_device *data = this_cpu_ptr(&menu_devices);
> > > > > >       int latency_req = cpuidle_governor_latency_req(dev->cpu);
> > > > > > -     int i;
> > > > > > -     int first_idx;
> > > > > > -     int idx;
> > > > > > +     int first_idx = 0;
> > > > > > +     int idx, i;
> > > > > >       unsigned int interactivity_req;
> > > > > >       unsigned int expected_interval;
> > > > > >       unsigned long nr_iowaiters, cpu_load;
> > > > > > @@ -307,6 +306,18 @@ static int menu_select(struct cpuidle_dr
> > > > > >       /* determine the expected residency time, round up */
> > > > > >       data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length(&delta_next));
> > > > > >
> > > > > > +     /*
> > > > > > +      * If the tick is already stopped, the cost of possible short idle
> > > > > > +      * duration misprediction is much higher, because the CPU may be stuck
> > > > > > +      * in a shallow idle state for a long time as a result of it.  In that
> > > > > > +      * case say we might mispredict and use the known time till the closest
> > > > > > +      * timer event for the idle state selection.
> > > > > > +      */
> > > > > > +     if (tick_nohz_tick_stopped()) {
> > > > > > +             data->predicted_us = ktime_to_us(delta_next);
> > > > > > +             goto select;
> > > > > > +     }
> > > > > > +
> > > > >
> > > > > This introduce two potential issues:
> > > > >
> > > > > - This will totally ignore the typical pattern in idle loop; I
> > > > >   observed on the mmc driver can trigger multiple times (> 10 times)
> > > > >   with consistent interval;
> > > >
> > > > I'm not sure what you mean by "ignore".
> > >
> > > You could see after move code from blow to this position, the typical
> > > pattern interval will not be accounted; so if in the middle of idles
> > > there have a bunch of interrupts with fix pattern, the upper code
> > > cannot detect this pattern anymore.
> >
> > I'm not really following you here.
> >
> > The part of the code skipped for tick_nohz_tick_stopped() doesn't
> > update the data at all AFAICS.  It only computes some values that
> > would be discarded later anyway, so I'm not sure what the point of
> > running that computation is.
>
> Sorry I don't explain clearly, so try to rephrase:
>
> With your patch for the tick stopped case, it directly uses tick delta
> value as prediction and goto 'select' tag.  So it skips below code
> pieces, these codes have minor improvement for typical pattern which
> can be applied in the middle of idles, for example, the mmc driver
> triggers 16 interrupts with ~1500us interval, these interrupts are all
> handled within the idle loop, so the typical pattern can detect the mmc
> interrupts pattern and it will help idle governor to select a shallower
> idle state so can avoid to break the residency.
>
> You mentioned these computed values would be discarded later, this is
> true for most cases, but it isn't always true actually.  Without your
> patch, the governor will discard the computed values only when
> 'data->predicted_us < TICK_USEC', otherwise the interval pattern is
> still be applied in the prediction.

OK, right.

I'll fix that up in v4, thanks!
