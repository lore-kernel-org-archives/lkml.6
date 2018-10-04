Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E09C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D8C2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D8C2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeJEAGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:06:06 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34720 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbeJEAGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:06:06 -0400
Received: by mail-ot1-f68.google.com with SMTP id i12-v6so9960443otl.1;
        Thu, 04 Oct 2018 10:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=77zgEKOszdVaqrclJTVBGM3sXOUiejLJo61I9DYgGEo=;
        b=hC/mfwBuoEH8rUAViy1t1fPRT3SDSbuj3X5159Eh1OFVFgAY0N7//ENDUPvmP+Bnq6
         lhn+iIwBqMHcGxiUK4avqdFM6uBdP9eKcw7b4gVnh355KN9iv8XLtrYQmbnfoijJ47NB
         vZ8qp3LHX0jWjv/imO41/VynVm6nsJ0iQrp7vwYew8v9A4BCgKIMRHj5ceiRJJIpYWpB
         ZMsT/ObujYGyNbxmdGAX/AsbTL339IJX6QA5xm5TixZudUZoJD1WHMX+4yRt3Sh50lyV
         WiDBzAVaY8eQ6braM1S1gDorNiC0bkjaaDBotzXHwOum9LTgdVYiZKc5aar+MKyx114E
         WXQA==
X-Gm-Message-State: ABuFfojMQAIi8PVFPV8aVZDfwG5+h2wibF4lEGrt7hNjKAZb2eb7aGlT
        LMjKKXaWyuVrxcUm15Ecxoy2C77aMaXLDSR0t6s=
X-Google-Smtp-Source: ACcGV6189eGtnYVq12JoBZjqRHhkeqrcbZjl4FpXSyJw6ltvWqQXpxbM2jjY6P5Wuyg9E9vygJt1JBKVMEOeOynJ0wU=
X-Received: by 2002:a9d:2b4a:: with SMTP id f10-v6mr4427755otd.139.1538673115701;
 Thu, 04 Oct 2018 10:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <3510260.hvypppS8Bs@aspire.rjw.lan> <2753018.aK9edJ7Dvu@aspire.rjw.lan>
 <20181004155044.GD1881@mai>
In-Reply-To: <20181004155044.GD1881@mai>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Oct 2018 19:11:44 +0200
Message-ID: <CAJZ5v0iqXLZoZ03Hqi-3h_txtnGnDLMYP5K4vtdp+JcJ97P2eg@mail.gmail.com>
Subject: Re: [PATCH 5/6] cpuidle: menu: Avoid computations for very close timers
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 5:50 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On Tue, Oct 02, 2018 at 11:46:28PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If the next timer event (with the tick excluded) is closer than the
> > target residency of the second state or the PM QoS latency constraint
> > is below its exit latency, state[0] will be used regardless of any
> > other factors, so skip the computations in menu_select() then and
> > return 0 straight away from it.
> >
> > Still, do that after the bucket has been determined to avoid
> > disturbing the wakeup statistics in general.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpuidle/governors/menu.c |   12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > Index: linux-pm/drivers/cpuidle/governors/menu.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> > +++ linux-pm/drivers/cpuidle/governors/menu.c
> > @@ -309,6 +309,18 @@ static int menu_select(struct cpuidle_dr
> >       get_iowait_load(&nr_iowaiters, &cpu_load);
> >       data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
> >
> > +     if (unlikely(drv->state_count <= 1) ||
>
> I'm not sure this test is necessary.

Yes, it is IMO.

Strictly speaking it prevents state[1] from being accessed if the
count is not 2 at least.

> If state_count == 0, we don't have to select anything as the cpuidle can't register because of:
>
> static int __cpuidle_register_driver(struct cpuidle_driver *drv)
> {
>         int ret;
>
>         if (!drv || !drv->state_count)
>                 return -EINVAL;
>
>         [ ... ]
> }
>
> If state_count == 1, then there is nothing to select, it is always the state 0.

Which is why it is better to simply return 0 right away in this case. :-)

I guess I could compare state_count just to 1, but <= 1 works too.
