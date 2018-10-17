Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C556EECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AA32152C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AA32152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeJQRJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:09:24 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42804 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbeJQRJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:09:24 -0400
Received: by mail-vs1-f65.google.com with SMTP id e126so20299625vsc.9;
        Wed, 17 Oct 2018 02:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOccUAVcVkNzlXmTRY4wm+RqsEHWMwp2HLJtYgzj3wQ=;
        b=TGhLDNVvEwBzYEWdKwOkS0O5lNnrAy5UoVcyw7xQV8ICkEYMKYZdFd/BBE8JqvC46G
         ppjFyFCkcbHQOmIlgE31sk4WcEBbuwx+VR1laTBKYjkLQmVCBLLYjFaUwF5TPILnmV0B
         HwnUv3rJL2x6ZszJRE3VMcdiee8wUOmStA9s0EVYG5N9ymhUXQzF0kCrLikgOknFrRAx
         CBWNzxnExnjDvJoMinpiSPATYdHgXMvzI7QRI33vjKqLY7LlBx9rKz5DNAEPfvmtnShw
         OLwVaDjld/uM/+LSOvooQAFlvbLcXczJqMbOuFXprznd/SYXOniIEGxVdupBSmUvfCnJ
         fXZQ==
X-Gm-Message-State: ABuFfoik7Y9IfJ06vTIByljg+rbb8NZDIIR/tCg6PxvJLRX0tcHowQdv
        izQR0xsI0VuOXJXQXhjQbEBhXWTpC1npe8CZXTY=
X-Google-Smtp-Source: ACcGV60mRNidMavLokVI+t9HwXuP6hUzTZ6ZKITDO255eB+Wm42CO0mZnQ/4UIO5/9KHumbbwLq/2ap5wrLG+goR8r0=
X-Received: by 2002:a67:f3cc:: with SMTP id j12mr8728300vsn.96.1539767676582;
 Wed, 17 Oct 2018 02:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181012072017.10765-1-geert+renesas@glider.be>
 <20181012072017.10765-4-geert+renesas@glider.be> <6ED8E3B22081A4459DAC7699F3695FB7021C4CCFCB@SW-EX-MBX02.diasemi.com>
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7021C4CCFCB@SW-EX-MBX02.diasemi.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 Oct 2018 11:14:24 +0200
Message-ID: <CAMuHMdWEzDenwgT8gkK7+_rEyjeVBCKrLaML5sMRkiZkzJN8jg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] thermal: da9062/61: Prevent hardware access during
 system suspend
To:     Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, Oct 17, 2018 at 10:57 AM Steve Twiss
<stwiss.opensource@diasemi.com> wrote:
> On 12 October 2018 08:20 Geert Uytterhoeven wrote:
> > Subject: [PATCH v2 3/3] thermal: da9062/61: Prevent hardware access during
> > system suspend
> >
> > The workqueue used for monitoring the hardware may run while the device
> > is already suspended.  Fix this by using the freezable system workqueue
> > instead, cfr. commit 51e20d0e3a60cf46 ("thermal: Prevent polling from
> > happening during system suspend").
>
> My thinking was:  this device is a PMIC and it will power the system. So when
> the device is turned off, the S/W will also not be running.
>
> Although my assumption only works if the PMIC device is the primary system
> power -- this has always been the case so far. And although I don't have any
> evidence this will change, it may become untrue in the future of course.

This is not about powering off the system, but about suspending the system,
which suspends all drivers.

The issue is that the normal workqueue may run while the system is being
suspended.  Accessing the DA9062 may or may not work at that time,
depending on the i2c controller being usable or not.

Due to the DA9062 being an i2c device, I agree this is different than
for rcar-thermal, where the rcar-thermal device itself cannot be
accessed because it is suspended.

> > Fixes: 608567aac3206ae8 ("thermal: da9062/61: Thermal junction temperature
> > monitoring driver")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Untested due to lack of hardware.
>
> So, I have not been able to make any time to test this patch yet -- and with
> current workloads this might take a bit of time before I get to it.

The main thing to test is what happens when da9062_thermal_poll_on() is
called while the i2c controller is already suspended, and whether that
is mitigated by my patch.
Looking at the function, I guess it starts spewing error messages, and
will continue triggering itself, by virtue of enabling the interrupt again,
without having been able to disable its cause.

> > --- a/drivers/thermal/da9062-thermal.c
> > +++ b/drivers/thermal/da9062-thermal.c
> > @@ -106,7 +106,7 @@ static void da9062_thermal_poll_on(struct work_struct
> > *work)
> >                                          THERMAL_EVENT_UNSPECIFIED);
> >
> >               delay = msecs_to_jiffies(thermal->zone->passive_delay);
> > -             schedule_delayed_work(&thermal->work, delay);
> > +             queue_delayed_work(system_freezable_wq, &thermal->work,
> > delay);
> >               return;
> >       }
> >
> > @@ -125,7 +125,7 @@ static irqreturn_t da9062_thermal_irq_handler(int irq,
> > void *data)
> >       struct da9062_thermal *thermal = data;
> >
> >       disable_irq_nosync(thermal->irq);
> > -     schedule_delayed_work(&thermal->work, 0);
> > +     queue_delayed_work(system_freezable_wq, &thermal->work, 0);
> >
> >       return IRQ_HANDLED;
> >  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
