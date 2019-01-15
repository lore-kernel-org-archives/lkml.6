Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B163CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D95F20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="w4PgFaTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfAOKre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:47:34 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46544 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbfAOKre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:47:34 -0500
Received: by mail-oi1-f193.google.com with SMTP id x202so1711509oif.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 02:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VmKR26I0RhPcilqP8dcitp/GQkeN8w0FsdZU3BWnzS0=;
        b=w4PgFaTJZOyBWyv9OqAt47MhMxJfJOcNavuxCuOYP1Lhfbj6/SEfWQ85sxYepeL/sr
         h/GMnuvSNsMv7i+vgrXpGYWX6uJbNWzPYqXnG8hyJp11g2D3fNBGYTg/q5bWX2UYzVeg
         usgyUeX9ACAN6vHErz9CyP2UK8hZmGZ2t6ZUsN/xmf6hGEn0NnTQcm+GLriJ+h6lEWLi
         QxAnkeUbM2SvlvxwbQet/soMZG8Fj9UY4ZGYzbhUdviwqcHSd+Tfyg1AjNNDJCYzTwp/
         iFttawjbVLzm4R8r/HPLtdWY5vk30FB1u1uLhteZ7Qo1dxjBxb7zQRtVPsHEdA/GIeMi
         z6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VmKR26I0RhPcilqP8dcitp/GQkeN8w0FsdZU3BWnzS0=;
        b=Bk4s3dnCiiZLMW5GNb8aRQ3KyfJlnrLZ/h96VvZgETWQQdl1C2KjBchdy/n5SFWSKO
         r+ZHx3VnThMpjnpsltQUhMg/lh2laAhnOVao6DfVINWSV+BS3LYq2439+oLY/OvY5eU7
         w5gWGVvByfWNDqqJx4wNsRQNBs0CGsmYjqjNEVgCAp52P7BkRhzC+JRqXx8C9TV7zaR+
         T4S1Mij4qaQc5jeV4DvcTZw0TCi/scswSPIwWg/Db9xuOGGu9y9X1Av28arLWPgmeyN4
         9yqGnoygUZnjHwUJu+jNHxNzg72cFr0E0TTm7+D6AU/MQxacP5uRvxvnBzwDSGSOtGvj
         /qVA==
X-Gm-Message-State: AJcUukci1Hi+7L7Wuou1Rxl1kDgce0bLkLhyXsWAOa9Cn1W8BxT+h1Dp
        bQPUUwqbJQvMuqi5fFCLFU9aAacYpQARK8Djg0eAbgiI
X-Google-Smtp-Source: ALg8bN6Rqqnb8MBDuxZRNcqhfexklDhiuyB0oylRKDrBYE5qPAj1cBm0R9mzG0mDDo6r5HCpksSB4lDMyIP9V1JqqUo=
X-Received: by 2002:aca:1e17:: with SMTP id m23mr1720987oic.332.1547549252952;
 Tue, 15 Jan 2019 02:47:32 -0800 (PST)
MIME-Version: 1.0
References: <732ea4f8ff1bf3ad28bda543ae8e1727c78f8b3b.1547538574.git.baolin.wang@linaro.org>
In-Reply-To: <732ea4f8ff1bf3ad28bda543ae8e1727c78f8b3b.1547538574.git.baolin.wang@linaro.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 15 Jan 2019 11:47:22 +0100
Message-ID: <CAMpxmJVyMd=rebK2h=uC_Cu_KXivRpCDCxzrneig0eZnK=wXpQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: sprd: Fix the incorrect data register
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, neo.hou@unisoc.com,
        Mark Brown <broonie@kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 15 sty 2019 o 08:53 Baolin Wang <baolin.wang@linaro.org> napisa=C5=82(=
a):
>
> From: Neo Hou <neo.hou@unisoc.com>
>
> Since differnt type EICs have its own data register to read, thus fix the
> incorrect data register.
>
> Signed-off-by: Neo Hou <neo.hou@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/gpio/gpio-eic-sprd.c |   13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index e0d6a0a..257df59 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
> @@ -180,7 +180,18 @@ static void sprd_eic_free(struct gpio_chip *chip, un=
signed int offset)
>
>  static int sprd_eic_get(struct gpio_chip *chip, unsigned int offset)
>  {
> -       return sprd_eic_read(chip, offset, SPRD_EIC_DBNC_DATA);
> +       struct sprd_eic *sprd_eic =3D gpiochip_get_data(chip);
> +
> +       switch (sprd_eic->type) {
> +       case SPRD_EIC_DEBOUNCE:
> +               return sprd_eic_read(chip, offset, SPRD_EIC_DBNC_DATA);
> +       case SPRD_EIC_ASYNC:
> +               return sprd_eic_read(chip, offset, SPRD_EIC_ASYNC_DATA);
> +       case SPRD_EIC_SYNC:
> +               return sprd_eic_read(chip, offset, SPRD_EIC_SYNC_DATA);
> +       default:
> +               return -ENOTSUPP;
> +       }
>  }
>
>  static int sprd_eic_direction_input(struct gpio_chip *chip, unsigned int=
 offset)
> --
> 1.7.9.5
>

I guess both this and the second patch should go into stable and have
a Fixes: tag?

Bart
