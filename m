Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436A7C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED1A206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="Ce+liFcy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbeLNSGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:06:52 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34843 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbeLNSGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:06:51 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so3045548pgs.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 10:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cy4O51U6sVKnzFN/6ke4qYh7v4hI4QhoyMWNCm0wQE8=;
        b=Ce+liFcy4uFeF0BWhPZ3BY+DUPR2jfXXz+X54VAidhl/1FjP8KzSPRrZrwaooTDFTw
         T9q8do3gOhXpAqCqms0pVviqvegPiUfggWGsaB29abh0f1OnAi+12r3nJ8khy7h9nOP1
         zBkDVF9Q1qACOHJrswLmPCFyrs58XLXOlJZkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cy4O51U6sVKnzFN/6ke4qYh7v4hI4QhoyMWNCm0wQE8=;
        b=llIF+6WCytH2PrsvycCKUDlS8L1CwTHjlXH4R0QfIehwLYqah+V5YijoKsqcTMlhBN
         HL/M1RRWmEHorxSZ3W9ry3mtQIrWfZky/+Im37kl3J+F8y/FRNmFAmXdLSY7QtEYn8A9
         qflx4pF6ND28C1LEwR5D7J1XtV+RzrTKn8vIxHumHktgGCh5q+VlNmOGkWhvn2d0DHK5
         kjoImwQYdeACd+GEjlM5UyKE7G4zLV+G+swZLxhgeetHMNypf7jtiypnXgDvwiY7pNuA
         TDc077N4cOQLRET42g9BFMH7FqlqLmxCr0Mrxcg+2diD4OfLXdsNI6f6JY2vL9BlJdLb
         nF+Q==
X-Gm-Message-State: AA+aEWatfppSufQT7QddbLmGQjEph0eb934hCHFbAh6u4Gfq6wAirPNe
        xfcgMp3ZWMu7taXBjxtsfdkgFjbldgMtfvXm4VGzqg==
X-Google-Smtp-Source: AFSGD/VwXC07Np+ksEj4O63MNPhb9c34xg941XA1sn9LbtLqy8amjMUw6my12ndaji/CrsncVt8QnEmjJLHdnTARn+0=
X-Received: by 2002:a63:8043:: with SMTP id j64mr3622647pgd.405.1544810810547;
 Fri, 14 Dec 2018 10:06:50 -0800 (PST)
MIME-Version: 1.0
References: <20181213144323.24820-2-andreas.brauchli@sensirion.com>
In-Reply-To: <20181213144323.24820-2-andreas.brauchli@sensirion.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Fri, 14 Dec 2018 10:06:39 -0800
Message-ID: <CAJCx=g=ut+mWUfW=H3AorQiWXSpSd_GgyzV1F4CBatSKhh6qHA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iio: Add modifiers for ethanol and H2 gases
To:     Andreas Brauchli <a.brauchli@elementarea.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Andreas Brauchli <andreas.brauchli@sensirion.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 6:44 AM Andreas Brauchli
<a.brauchli@elementarea.net> wrote:
>
> Add ethanol and H2 gas modifiers:
> * IIO_MOD_ETHANOL

Was going to ask why this wasn't a chemical formula like the rest of
the modifiers, but C2H6O would be a bit wordy/unclear :).

> * IIO_MOD_H2
>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> Signed-off-by: Andreas Brauchli <andreas.brauchli@sensirion.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 4 ++++
>  include/uapi/linux/iio/types.h          | 2 ++
>  tools/iio/iio_event_monitor.c           | 4 ++++
>  3 files changed, 10 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 8127a08e366d..6d64521bf565 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1554,6 +1554,10 @@ What:            /sys/bus/iio/devices/iio:deviceX/in_concentration_raw
>  What:          /sys/bus/iio/devices/iio:deviceX/in_concentrationX_raw
>  What:          /sys/bus/iio/devices/iio:deviceX/in_concentration_co2_raw
>  What:          /sys/bus/iio/devices/iio:deviceX/in_concentrationX_co2_raw
> +What:          /sys/bus/iio/devices/iio:deviceX/in_concentration_ethanol_raw
> +What:          /sys/bus/iio/devices/iio:deviceX/in_concentrationX_ethanol_raw
> +What:          /sys/bus/iio/devices/iio:deviceX/in_concentration_h2_raw
> +What:          /sys/bus/iio/devices/iio:deviceX/in_concentrationX_h2_raw
>  What:          /sys/bus/iio/devices/iio:deviceX/in_concentration_voc_raw
>  What:          /sys/bus/iio/devices/iio:deviceX/in_concentrationX_voc_raw
>  KernelVersion: 4.3
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 92baabc103ac..04a6649fa442 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -87,6 +87,8 @@ enum iio_modifier {
>         IIO_MOD_VOC,
>         IIO_MOD_LIGHT_UV,
>         IIO_MOD_LIGHT_DUV,
> +       IIO_MOD_ETHANOL,
> +       IIO_MOD_H2,
>  };
>
>  enum iio_event_type {
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index ac2de6b7e89f..f29c885f4b28 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -114,6 +114,8 @@ static const char * const iio_modifier_names[] = {
>         [IIO_MOD_I] = "i",
>         [IIO_MOD_Q] = "q",
>         [IIO_MOD_CO2] = "co2",
> +       [IIO_MOD_ETHANOL] = "ethanol",
> +       [IIO_MOD_H2] = "h2",
>         [IIO_MOD_VOC] = "voc",
>  };
>
> @@ -199,6 +201,8 @@ static bool event_is_known(struct iio_event_data *event)
>         case IIO_MOD_I:
>         case IIO_MOD_Q:
>         case IIO_MOD_CO2:
> +       case IIO_MOD_ETHANOL:
> +       case IIO_MOD_H2:
>         case IIO_MOD_VOC:
>                 break;
>         default:
> --
> 2.17.1
>
