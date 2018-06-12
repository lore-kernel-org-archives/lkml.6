Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7D54CC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BAB208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BAB208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933353AbeFLHZS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:25:18 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:46584 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932637AbeFLHZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:25:17 -0400
Received: by mail-ua0-f195.google.com with SMTP id d7-v6so674310uam.13;
        Tue, 12 Jun 2018 00:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hpuW02e5fz01lQPIGRKiow8oWEu7hE5cx8eVLMb8WYQ=;
        b=YP+ew1A6jsYlqnbVCRpopX8OhLW+650FEhzmruSrO/libjIAM/Du/ip6eBJUhDaWnX
         EXjaJQ5zVugAnVL4ntibrXq3MYEJZ6bLDlENGtZ2hNioYu10zYcMXJeS0dx+a/bJmVJj
         ZBeH8yfCi8ijVYegy02zdpXCu1Z4QIqxuO20Q6oIOZ3DngzNzrScya4dyGLQjusoQrfk
         GW8LEk9x1pwTMx84yjJ3ufu7et7rDkEBCXUgWp9amIXxdKaChO44WzSjyjHD1UhxqZer
         WdHFy4AWe+OfdJ/ne57GK5kqY/IqDkROyhrFJ2qLeOahi0fVmc68ZvPvmNZjeLhD0DhD
         F/1w==
X-Gm-Message-State: APt69E1/zn3o2Rd2GGqbmIvhxQyp0sg1BP33tEMyPfB5U0qRsVDjbaU2
        prgFB6yViQVmQEgoUUum14m4Jg3rWuxMsFFuSQo=
X-Google-Smtp-Source: ADUXVKL+QAY83ps7pBhUfPy/eWZhjJGxAxlWeO5RbhDLavBED+KX5beoeJEPpbqAT6yZ7qW4V7zYCEXgZ8G8YZeseO8=
X-Received: by 2002:ab0:265:: with SMTP id 92-v6mr1741926uas.26.1528788316119;
 Tue, 12 Jun 2018 00:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180525210843.1821071-1-arnd@arndb.de>
In-Reply-To: <20180525210843.1821071-1-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Jun 2018 09:25:05 +0200
Message-ID: <CAMuHMdXJg0mYbs=e0QJMDb=A+bRbPsNF=TJzSumSjjOK3yJw2Q@mail.gmail.com>
Subject: Re: [PATCH] pwm: stm32: fix build warning with CONFIG_DMA_ENGINE disabled
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        fabrice.gasnier@st.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, May 25, 2018 at 11:09 PM Arnd Bergmann <arnd@arndb.de> wrote:
> Without dmaengine support, we get a harmless warning about an
> unused function:
>
> drivers/pwm/pwm-stm32.c:166:12: error: 'stm32_pwm_capture' defined but not used [-Werror=unused-function]
>
> Changing the #ifdef to an IS_ENABLED() check shuts up that warning
> and is slightly nicer to read.
>
> Fixes: 53e38fe73f94 ("pwm: stm32: Add capture support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -484,9 +484,7 @@ static int stm32_pwm_apply_locked(struct pwm_chip *chip, struct pwm_device *pwm,
>  static const struct pwm_ops stm32pwm_ops = {
>         .owner = THIS_MODULE,
>         .apply = stm32_pwm_apply_locked,
> -#if IS_ENABLED(CONFIG_DMA_ENGINE)
> -       .capture = stm32_pwm_capture,
> -#endif
> +       .capture = IS_ENABLED(CONFIG_DMA_ENGINE) ? stm32_pwm_capture : NULL,

Cool, I didn't know IS_ENABLED() can be used in static initializers.
I guess it's too late/much work to use this trick in e.g. SET_*_PM_OPS(),
as there are lots of places protecting the functions by #ifdefs?

>  };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
