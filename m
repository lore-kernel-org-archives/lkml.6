Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E42C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FF520861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kYL9UYUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbfAUItM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:49:12 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:43938 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbfAUItL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:49:11 -0500
Received: by mail-vk1-f195.google.com with SMTP id o130so4404053vke.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 00:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c+9cA8JT0ead3Uudm6rJptJL7nogvAmv8BUGGtAKAr0=;
        b=kYL9UYUV5lclIrOE6uh0Yc19JiTPgUL3WL99XG4LsMnCtQD0PahggNMnuU4QJaoCZx
         0RrcfoyvjRAdNHfhJfkUAr04k//Xyx39YAZSrVChXD1JPvv2DpYAR9j/hG2x0brqKZKA
         DWvu8j6wtXqQb/DUkUGFIrQd5yGx4LKRZXMgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+9cA8JT0ead3Uudm6rJptJL7nogvAmv8BUGGtAKAr0=;
        b=VSULTGpHxSuEg18XCGA0o+bTygecl1U/L1TEXV8BXCAvJEQOLzBvH8Oayj7Vc0PclS
         bB9lgyAiq8IYC9Rg3WnM4nvA+fPL1gk7Tvw1v1XCLyysUhK0YRcCq+qk2F7CQWNI5xIk
         6alU7q+LLHLddJsUkUWEsGcVKnJkFDncBobIHBiE96YqIH1rqWkzZXjHO9LYfycm8EyT
         D4Ze46PCHIKwkv36nfMyXcUBniPJPf4+/sc5UxRoaip0i1K6Z+c0IGz2LuhhylnbVQBG
         z2cZwhXWXb7njegXGtcvwrozILgPYaUept0rloQ3ySnG4mW8HYFy08x/CceUjk3wSKob
         lL4w==
X-Gm-Message-State: AJcUukcsMpEsyrN55WhESFdBgG7W8akY58zUtcONVYOpK/f6FhrcEfzB
        PqeO+vZbr8ja1up7kH4/L8ZAZZMqik8mrUIbZMYylQ==
X-Google-Smtp-Source: ALg8bN4VJ+j41Ba49fa9rSmQrz3ayeNgpg8kdOM+QrbDB+rXB/V08rRQSa+2CWajbFdYMGmJ+xfMYBx+yGre7oFtJoI=
X-Received: by 2002:a1f:a8c5:: with SMTP id r188mr11764670vke.44.1548060550308;
 Mon, 21 Jan 2019 00:49:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547481320.git.amit.kucheria@linaro.org>
 <e1984eedda04ca44a44b4972708855702f5d91e4.1547481320.git.amit.kucheria@linaro.org>
 <2392396.AI7Hxg4e4v@aspire.rjw.lan>
In-Reply-To: <2392396.AI7Hxg4e4v@aspire.rjw.lan>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 21 Jan 2019 14:18:59 +0530
Message-ID: <CAHLCerP0SieD_4X_ZOxogxOsdFZSRO-B_2cDnR8fpJYFdEUTvw@mail.gmail.com>
Subject: Re: [PATCH v1 03/10] cpufreq: Replace open-coded << with BIT()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 4:26 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Monday, January 14, 2019 5:34:55 PM CET Amit Kucheria wrote:
> > Minor clean-up to use BIT() and keep checkpatch happy. Clean up the
> > comment formatting while we're at it to make it easier to read.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>
> Can you please do this cleanup as the first patch in the series, so it
> doesn't depend on the other patches in it, which isn't necessary IMO?

I've sent it out separately now, unconnected to the series.

Thanks.

Regards,
Amit

> > ---
> >  include/linux/cpufreq.h | 27 ++++++++++++++-------------
> >  1 file changed, 14 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index 70ad02088825..ea303dfd5f05 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -351,14 +351,15 @@ struct cpufreq_driver {
> >  };
> >
> >  /* flags */
> > -#define CPUFREQ_STICKY               (1 << 0)        /* driver isn't removed even if
> > -                                                all ->init() calls failed */
> > -#define CPUFREQ_CONST_LOOPS  (1 << 1)        /* loops_per_jiffy or other
> > -                                                kernel "constants" aren't
> > -                                                affected by frequency
> > -                                                transitions */
> > -#define CPUFREQ_PM_NO_WARN   (1 << 2)        /* don't warn on suspend/resume
> > -                                                speed mismatches */
> > +
> > +/* driver isn't removed even if all ->init() calls failed */
> > +#define CPUFREQ_STICKY                               BIT(0)
> > +
> > +/* loops_per_jiffy or other kernel "constants" aren't affected by frequency transitions */
> > +#define CPUFREQ_CONST_LOOPS                  BIT(1)
> > +
> > +/* don't warn on suspend/resume speed mismatches */
> > +#define CPUFREQ_PM_NO_WARN                   BIT(2)
> >
> >  /*
> >   * This should be set by platforms having multiple clock-domains, i.e.
> > @@ -366,14 +367,14 @@ struct cpufreq_driver {
> >   * be created in cpu/cpu<num>/cpufreq/ directory and so they can use the same
> >   * governor with different tunables for different clusters.
> >   */
> > -#define CPUFREQ_HAVE_GOVERNOR_PER_POLICY (1 << 3)
> > +#define CPUFREQ_HAVE_GOVERNOR_PER_POLICY     BIT(3)
> >
> >  /*
> >   * Driver will do POSTCHANGE notifications from outside of their ->target()
> >   * routine and so must set cpufreq_driver->flags with this flag, so that core
> >   * can handle them specially.
> >   */
> > -#define CPUFREQ_ASYNC_NOTIFICATION  (1 << 4)
> > +#define CPUFREQ_ASYNC_NOTIFICATION           BIT(4)
> >
> >  /*
> >   * Set by drivers which want cpufreq core to check if CPU is running at a
> > @@ -382,19 +383,19 @@ struct cpufreq_driver {
> >   * from the table. And if that fails, we will stop further boot process by
> >   * issuing a BUG_ON().
> >   */
> > -#define CPUFREQ_NEED_INITIAL_FREQ_CHECK      (1 << 5)
> > +#define CPUFREQ_NEED_INITIAL_FREQ_CHECK      BIT(5)
> >
> >  /*
> >   * Set by drivers to disallow use of governors with "dynamic_switching" flag
> >   * set.
> >   */
> > -#define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING (1 << 6)
> > +#define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING    BIT(6)
> >
> >  /*
> >   * Set by drivers that want the core to automatically register the cpufreq
> >   * driver as a thermal cooling device
> >   */
> > -#define CPUFREQ_AUTO_REGISTER_COOLING_DEV (1 << 7)
> > +#define CPUFREQ_AUTO_REGISTER_COOLING_DEV    BIT(7)
> >
> >  int cpufreq_register_driver(struct cpufreq_driver *driver_data);
> >  int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
> >
>
>
