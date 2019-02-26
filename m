Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90026C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C5621874
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551219485;
	bh=HDa/ptpbA7FOQQPBvC4Dp/ILmzgJ+DifAfs5Neb6F6E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Fvk62pfl8MnUTWx6ha71NrN4TQabPLH0bWJ04I41cFT7X4Ud+fqZ6fog48HsrOKnL
	 Y0Jp/P2eP/YZhy5CSmQXAY103SwqpTMq09zaXpHeg1YkZG6SKaNgTPfLvm/1OsM6Ow
	 e3jfYqz/fdJlSTS+Fw2C2GNvxb5ypIjjS4FMYQF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbfBZWSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:18:03 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35389 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbfBZWSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 17:18:03 -0500
Received: by mail-oi1-f194.google.com with SMTP id u128so11777672oie.2;
        Tue, 26 Feb 2019 14:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HDa/ptpbA7FOQQPBvC4Dp/ILmzgJ+DifAfs5Neb6F6E=;
        b=YbGSbxFlaZ043+Fc60x+1dKFTzWiSoLuTvCQ+oji2Z1/NMDaYaKZb5RK9fB+Biav7L
         RlVvA75j0MV+wG8AGJ/1saHbql+prut/R/1H4hpwWTeyTWajWSTVdBH7qP9Hn3W27U7C
         xfPTucVMoV+BQOjK/+aGhcIgaQHdFhgqHc2cBM6/5HmAnbsPOa5uOwhhRw1TgMi62HI1
         qRjSI8CqyPNbBr0kFNZ9D+6RULNn94jEL4iEj8HgjNayLxIGZV8D+TXYtWTb10g6kWiA
         LkNaehnKs0Ej2xwPhbucbr6Hmq4t7EuCwMKavuHoshGbfgE4FTntQ4iWOwd1QLzavq6u
         Tllw==
X-Gm-Message-State: AHQUAuaj6lLUYY8rGQaifdThijJuvmKz8jkd4cBWIr3SGGaq1EBqVBAc
        x/UnrYvHru4L/bkL1KXx/Eukq0kSz79hYwabh5s=
X-Google-Smtp-Source: AHgI3IZz657IyniTaNC/i3jZGnKN4wLb8EEzLCFTcKbZbncwkAb+Ox9U1LH5y3d3Xkjzv6349PjrMjgbDBiMwtXrav8=
X-Received: by 2002:aca:88b:: with SMTP id 133mr3884939oii.95.1551219482652;
 Tue, 26 Feb 2019 14:18:02 -0800 (PST)
MIME-Version: 1.0
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
 <20190226145415.19411-8-ulf.hansson@linaro.org> <CAJZ5v0j=ddMEwvr8rt=PxxPpxoAHary7cYLYgTBbcuBuiGbTZA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j=ddMEwvr8rt=PxxPpxoAHary7cYLYgTBbcuBuiGbTZA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Feb 2019 23:17:51 +0100
Message-ID: <CAJZ5v0icO1VUm7bFLA+3=zLF2BpbP5QC=evS9b0LAbWAC+SqhQ@mail.gmail.com>
Subject: Re: [PATCH v11 7/8] cpuidle: Pre-store next timer/tick before
 selecting an idle state
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 11:08 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Feb 26, 2019 at 3:54 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > A common piece of data used by cpuidle governors, is the information about
> > when the next timer/tick is going to fire. Rather than having each governor
> > calling tick_nohz_get_next_timer|hrtimer() separately, let's consolidate
> > the code by calling these functions before invoking the ->select() callback
> > of the governor - and store the output data in the struct cpuidle_device.
>
> That misses the point IMO.
>
> You don't need to store two values in struct cpuidle_device, but just
> one, and not before running ->select(), but before invoking the
> driver's ->enter() callback.
>
> At that point, the decision on whether or not to stop the scheduler
> tick has been made already and it should be sufficient to store the
> return value of tick_nohz_get_next_hrtimer() introduced by patch
> [3/8],

Or the difference between in and ts->idle_entrytime for that matter,
whichever is more useful.

> because that value represents the next timer regardless of what
> has been decided with respect to the tick.
>
> And you won't need the tick_nohz_get_next_timer() any more then.
