Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228D8C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E296D21873
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FT5AXaAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbfA3JOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:14:24 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:37645 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730525AbfA3JOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:14:23 -0500
Received: by mail-io1-f68.google.com with SMTP id g8so18802680iok.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 01:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7inwf88cJRcfDvtFYb4nhiHFyYrUFeMVx/Nfb8s/mDk=;
        b=FT5AXaAXfXtRDfMZj0oO+Efr7rG8gsAAdpmcHzCf8CKbR+a1cz5eh2VZotCPFPZjLk
         680Pyz+0OYHptrJ51KyjiwaYJ78QcwQetD9aN27OUiTK1HYITlS8nyLOKCayB8MH/khk
         L2aMTpUvqib4EcXqoNOiK9WP/MqTiLcLdfSLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7inwf88cJRcfDvtFYb4nhiHFyYrUFeMVx/Nfb8s/mDk=;
        b=dRLtkevofneltmn74zEvPAVPXmQCHNwU1UJ4xqthBqpDzZazuJIJInydc7UWCCdI9V
         RiTUzRgzQtZC0noq5HcFdITcwmC2TgGSYXz4c/Zj8WmHz3aANJ7Je6DP12DBg/ZlWnsM
         QWgpAWbYFD5mBmtKcTpdnAmRPV1dd5Eoe5fFq5DYGVy7uLlmeCi1gormLzVsAmp6pSdQ
         X0OWQsrmmo9ALE8ZvGCPM8mzp0RbVSIxAkUrzazn/9Qpx7F3ZNM1DU/SDfIpo39hJBTf
         Dx1s+O0lRd2QJNKxtLa1bMOhEjPTDDXo0arbPPTQ7tAJElhOWdg3jkQXLPmLpCgW6WLL
         8zdw==
X-Gm-Message-State: AHQUAuY2BbN617IO8YJH4WR05tSNboOsP8LmDyFRq4i5SGunuJsmbmYX
        RARpYwqK1GFrzwJ+ZufaFdww+rVWfWOKa+0VZ7py8Q==
X-Google-Smtp-Source: AHgI3IapTk6Cx+uKKxCvydUS5H0/P4+4cDs6ruKPWKS7IWgP3w5ITA1qsYh6ugiAg8mMMKjKnJhewyU+QSpiMRSqeDo=
X-Received: by 2002:a6b:c8c9:: with SMTP id y192mr16194143iof.183.1548839661820;
 Wed, 30 Jan 2019 01:14:21 -0800 (PST)
MIME-Version: 1.0
References: <1548836194-15264-1-git-send-email-vincent.guittot@linaro.org> <CAMuHMdWYV-tDD2osdvs4yhD-mu2n8-JSC7rV8Zt5vW4kr8hdWQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWYV-tDD2osdvs4yhD-mu2n8-JSC7rV8Zt5vW4kr8hdWQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 30 Jan 2019 10:14:10 +0100
Message-ID: <CAKfTPtBiWunvVHv=tpq7CPqAX+54d_dyPt6BME_m1_Wz+qPaTA@mail.gmail.com>
Subject: Re: [PATCH] PM-runtime: fix deadlock with ktime
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Wed, 30 Jan 2019 at 09:21, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Vincent,
>
> On Wed, Jan 30, 2019 at 9:16 AM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
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
> >                 pm_runtime_mark_last_busy
> >                     ktime_get
> >                         do
> >                             read_seqcount_begin
> >                         while read_seqcount_retry
> >     ....
> >     write_seqcount_end
> >
> > Although we should be safe because we haven't yet changed the clocksource
> > at that time, we can't because of seqcount protection.
> >
> > Use ktime_get_mono_fast_ns instead which is lock safe for such case
> >
> > Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> > Reported-by: Biju Das <biju.das@bp.renesas.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> Thanks for your patch!
>
> /**
>  * ktime_get_mono_fast_ns - Fast NMI safe access to clock monotonic
>  *
>  * This timestamp is not guaranteed to be monotonic across an update.
>  * The timestamp is calculated by:
>  *
>  *      now = base_mono + clock_delta * slope
>  *
>  * So if the update lowers the slope, readers who are forced to the
>  * not yet updated second array are still using the old steeper slope.
>  *
>  * tmono
>  * ^
>  * |    o  n
>  * |   o n
>  * |  u
>  * | o
>  * |o
>  * |12345678---> reader order
>  *
>  * o = old slope
>  * u = update
>  * n = new slope
>  *
>  * So reader 6 will observe time going backwards versus reader 5.
>  *
>  * While other CPUs are likely to be able observe that, the only way
>  * for a CPU local observation is when an NMI hits in the middle of
>  * the update. Timestamps taken from that NMI context might be ahead
>  * of the following timestamps. Callers need to be aware of that and
>  * deal with it.
>  */
>
> As this function is not guaranteed to be monotonic, have you checked how
> the Runtime PM code behaves if time goes backwards? Does it just make
> a suboptimal decision or does it crash?

As a worst case this will generate a suboptimal decision around the update

Regards,
Vincent

>
> Thanks!
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
