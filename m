Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3ADC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 13:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD86F20868
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 13:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="MknwthOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD86F20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbeKZAmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 19:42:52 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45336 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbeKZAmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 19:42:52 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so12569559plm.12
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 05:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FL3+rvWoZZIsDU7zxGJ6hJUjKKtuvmMh3wxombHXmDQ=;
        b=MknwthOXyn1QcFtpJzIIErvqovM+1HbLm9Y5cR9x9/s8BrRYuaf+ILMlA4oYskbFE0
         F6gl6P968r9etwMglImZpUqrBoZJOAsFzP+vYT8BYFxQUYX1U0NAoBNaKM+j2VAa0Zr9
         u9xFXfhUdf54AT4EV0Xj3SYbtbSUWitMP7SL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FL3+rvWoZZIsDU7zxGJ6hJUjKKtuvmMh3wxombHXmDQ=;
        b=MT8V5MtanGjcvzORuHilxfdUDQOPnDMIGgwKzey1d/QHCD8vctLZJ2nXSeilzn2514
         D1+Zy6bfmZvB/BvfdumV9/MNv2MqTHEXrTaxuVLYp9tE+oTdK+A8KnindJEz2PxYLo9C
         sHZl0wryEGcwrEVFg2B7BOpV+MK6l4YMmVJlwoTmjLl/O0+8ysIcynpXeoFTqTQZULk9
         c5LYErBNZ8zWtWxgbcgWG2l0J6Zx68hAZcuFKWBUipoS1UajwO4dhZryXKi+FWADO1pM
         13CP77+7JXZkwJCWWyijOxnXhfPiELw/9ZGlxMW67p7C9O48Y24W379pgRd/lrpA9CTY
         U8aQ==
X-Gm-Message-State: AA+aEWbpeTOY0UNxHY9EJ7DPRvi1B+bxGkMpmJwQHpct5HdDsVDr7SxO
        VgRgybmnRUyyM5U/zH9Ge0bIkBtq3NoMJkSSvRT3Rw==
X-Google-Smtp-Source: AFSGD/VAh+8b3yH3xHta9k3QMd/wYFazE6eL4FmxyPt72o+KRzC2qmz0Pkmez2gzO0KIXpRFpBzq+dbKssGM2RADzfA=
X-Received: by 2002:a17:902:4d46:: with SMTP id o6mr22539199plh.302.1543153904286;
 Sun, 25 Nov 2018 05:51:44 -0800 (PST)
MIME-Version: 1.0
References: <20181124221415.10081-1-tduszyns@gmail.com> <20181124221415.10081-2-tduszyns@gmail.com>
In-Reply-To: <20181124221415.10081-2-tduszyns@gmail.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sun, 25 Nov 2018 05:51:32 -0800
Message-ID: <CAJCx=g=H6Zp4AtWPpC-KdZmyOxTymtdgf+Hx8VvThLFg0bjYVQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: add IIO_MASSCONCENTRATION channel type
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 2:14 PM Tomasz Duszynski <tduszyns@gmail.com> wrote:
>
> Measuring particulate matter in ug / m3 (micro-grams per cubic meter)
> is de facto standard. Existing air quality sensors usually follow
> this convention and are capable of returning measurements using
> this unit.
>
> IIO currently does not offer suitable channel type for this
> type of measurements hence this patch adds this.
>
> In addition, two modifiers are introduced used for distinguishing
> between coarse (PM10) and fine particles (PM2p5) measurements, i.e
> IIO_MOD_PM10 and IIO_MOD_PM2p5.
>
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 11 ++++++++++-
>  drivers/iio/industrialio-core.c         |  3 +++
>  include/uapi/linux/iio/types.h          |  3 +++
>  tools/iio/iio_event_monitor.c           |  6 ++++++
>  4 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 8127a08e366d..ce0ed140660d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1684,4 +1684,13 @@ KernelVersion:   4.18
>  Contact:       linux-iio@vger.kernel.org
>  Description:
>                 Raw (unscaled) phase difference reading from channel Y
> -               that can be processed to radians.
> \ No newline at end of file
> +               that can be processed to radians.
> +
> +What:          /sys/bus/iio/devices/iio:deviceX/in_massconcentration_pm2p5_input
> +What:          /sys/bus/iio/devices/iio:deviceX/in_massconcentrationY_pm2p5_input
> +What:          /sys/bus/iio/devices/iio:deviceX/in_massconcentration_pm10_input
> +What:          /sys/bus/iio/devices/iio:deviceX/in_massconcentrationY_pm10_input
> +KernelVersion: 4.21
> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               Mass concentration reading of particulate matter in ug / m3.
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index a062cfddc5af..2a9ef600c1fb 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -87,6 +87,7 @@ static const char * const iio_chan_type_name_spec[] = {
>         [IIO_GRAVITY]  = "gravity",
>         [IIO_POSITIONRELATIVE]  = "positionrelative",
>         [IIO_PHASE] = "phase",
> +       [IIO_MASSCONCENTRATION] = "massconcentration",
>  };
>
>  static const char * const iio_modifier_names[] = {
> @@ -127,6 +128,8 @@ static const char * const iio_modifier_names[] = {
>         [IIO_MOD_Q] = "q",
>         [IIO_MOD_CO2] = "co2",
>         [IIO_MOD_VOC] = "voc",
> +       [IIO_MOD_PM2p5] = "pm2p5",
> +       [IIO_MOD_PM10] = "pm10",
>  };
>
>  /* relies on pairs of these shared then separate */
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 92baabc103ac..465044b42af5 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -46,6 +46,7 @@ enum iio_chan_type {
>         IIO_GRAVITY,
>         IIO_POSITIONRELATIVE,
>         IIO_PHASE,
> +       IIO_MASSCONCENTRATION,

So I'm guessing IIO_CONCENTRATION can't be scaled to the micro-grams
per cubic meter?

>  };
>
>  enum iio_modifier {
> @@ -87,6 +88,8 @@ enum iio_modifier {
>         IIO_MOD_VOC,
>         IIO_MOD_LIGHT_UV,
>         IIO_MOD_LIGHT_DUV,
> +       IIO_MOD_PM2p5,

I know this is unit of measure but the lowercase p in IIO_MOD_PM2p5 is
a bit non-standard for iio defines/enum.

- Matt

> +       IIO_MOD_PM10,
>  };
>
>  enum iio_event_type {
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index ac2de6b7e89f..f0fcfeddba2b 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -60,6 +60,7 @@ static const char * const iio_chan_type_name_spec[] = {
>         [IIO_GRAVITY] = "gravity",
>         [IIO_POSITIONRELATIVE] = "positionrelative",
>         [IIO_PHASE] = "phase",
> +       [IIO_MASSCONCENTRATION] = "massconcentration",
>  };
>
>  static const char * const iio_ev_type_text[] = {
> @@ -115,6 +116,8 @@ static const char * const iio_modifier_names[] = {
>         [IIO_MOD_Q] = "q",
>         [IIO_MOD_CO2] = "co2",
>         [IIO_MOD_VOC] = "voc",
> +       [IIO_MOD_PM2p5] = "pm2p5",
> +       [IIO_MOD_PM10] = "pm10",
>  };
>
>  static bool event_is_known(struct iio_event_data *event)
> @@ -156,6 +159,7 @@ static bool event_is_known(struct iio_event_data *event)
>         case IIO_GRAVITY:
>         case IIO_POSITIONRELATIVE:
>         case IIO_PHASE:
> +       case IIO_MASSCONCENTRATION:
>                 break;
>         default:
>                 return false;
> @@ -200,6 +204,8 @@ static bool event_is_known(struct iio_event_data *event)
>         case IIO_MOD_Q:
>         case IIO_MOD_CO2:
>         case IIO_MOD_VOC:
> +       case IIO_MOD_PM2p5:
> +       case IIO_MOD_PM10:
>                 break;
>         default:
>                 return false;
> --
> 2.19.2
>
