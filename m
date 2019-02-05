Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CD3C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F332073D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfBENYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:24:48 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41135 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfBENYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:24:47 -0500
Received: by mail-vs1-f66.google.com with SMTP id t17so2108581vsc.8;
        Tue, 05 Feb 2019 05:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mH2jC//BX4csPlxzLWPxIbl/VLPdX2MNzc/nlQzQz8Q=;
        b=g3YaCJcISPixq7aUuf35LNeOkryoASZsaYYP4JnvgSu6j8PtbZJj79oe743QGuXlM8
         pSyh6fsgRGsh2/A6gIPEIWbTjIcZiKYnZdFGIwndaGo6vZA2JkwpU3rXX0mQjuKbJENA
         w9JEfYl/F8wPwKBVTCfeaCIleLQiUliSRuVV9Zu9+8dd8i9nshnEA8hKJbdFwN0PMy+A
         EUd6k0mcnsolXK80Dkgw2ISGJ0CgphTpWGvQkzHgui+43WmHPhOgp+L0ca5En/vgvr8N
         YF1CC1OgCBfwK19kOLJYXZ7eNuOpGHMpoDv2AQR0oUMLT/phHOTDsS4bfiWBuzkZgziY
         brAA==
X-Gm-Message-State: AHQUAua3qL84bJA7OJQh2VJzz3L/kqfB8ikbELQqlPgIM7gp5h6nYNMR
        XWlcsWDxoFNY9PKyeP1tBvgr+D0MmqyRuEiK5cA=
X-Google-Smtp-Source: AHgI3IZGiOTTw8sZiDzZNxEUVJfcek13r1NV7ffeSdfvgl9Jp03HBQFnX+NKK7wxVbto9ZhTYk3nwT3JsD0+hzp5ILU=
X-Received: by 2002:a67:d119:: with SMTP id u25mr1891966vsi.63.1549373086077;
 Tue, 05 Feb 2019 05:24:46 -0800 (PST)
MIME-Version: 1.0
References: <1548846984-2044-1-git-send-email-vincent.guittot@linaro.org> <CAPDyKFpyg7oGoDZA+=SG7R3yL874Geeqs5LWrsAf50csxsE05A@mail.gmail.com>
In-Reply-To: <CAPDyKFpyg7oGoDZA+=SG7R3yL874Geeqs5LWrsAf50csxsE05A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Feb 2019 14:24:33 +0100
Message-ID: <CAMuHMdWdbRpA_M4V1kigab6U8rSDgGYXtidiSU4MVdj5xarK8g@mail.gmail.com>
Subject: Re: [PATCH v2 ] PM-runtime: fix deadlock with ktime
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On Wed, Jan 30, 2019 at 1:15 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Wed, 30 Jan 2019 at 12:16, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > A deadlock has been seen when swicthing clocksources which use PM runtime.
> > The call path is:
> > change_clocksource
> >     ...
> >     write_seqcount_begin
> >     ...
> >     timekeeping_update
> >         ...
> >         sh_cmt_clocksource_enable
> >             ...
> >             rpm_resume
>
> Hmm, isn't this already a problem in genpd then?
>
> In genpd's ->runtime_resume() callback (genpd_runtime_resume()) we
> call ktime_get() to measure the latency of running the callback.
>
> Or, perhaps irq_safe_dev_in_no_sleep_domain() returns true for the
> genpd + device in question, which means the ktime thingy is skipped.
>
> Geert?

Correct. After adding

    dev_info(dev, "%s: pm_runtime_is_irq_safe = %d,
genpd_is_irq_safe(%s) = %d => %s\n", __func__,
pm_runtime_is_irq_safe(dev), genpd->name, genpd_is_irq_safe(genpd),
ret ? "true" : "false");

I see on R-Car M2-W:

    sh_cmt ffca0000.timer: irq_safe_dev_in_no_sleep_domain:
pm_runtime_is_irq_safe = 1, genpd_is_irq_safe(always-on) = 0 => true

For all other devices, the result is false.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
