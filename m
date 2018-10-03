Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E25C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A07C2082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A07C2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeJCVfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:35:41 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40075 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbeJCVfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:35:41 -0400
Received: by mail-vs1-f65.google.com with SMTP id z130-v6so3379103vsc.7;
        Wed, 03 Oct 2018 07:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D0WrXct1p/zBVaCXPydYmAL3GOAEbKeyt7p65REjrPo=;
        b=rJ5HcHyejLzusST2GDZYgStS8GhjCHBuykn2CMW0aGXW/LnmyQHvnToeWETYTycRbQ
         0P+nk1ny8jNZT2+F861la5S8Dw/OiBQ47EuzpguxOwaAgR4BzMSX/xl60r14X8WBKY87
         l6BpdfjMV/FHgy772frXqXKjGnaMDIQFQRhX3kFEETjM3HfQYZ1Dufc+p+drBRIQCH/w
         sb3YCWxbv6wvQiJapwqvKJNB8yS5U7Eao6/W8biRdlQJUTrBJTvp5Bp6pl3p5zqd49c9
         leJGy9jfrsk4RdFFMMFEhuY1+4AMiZfJ3HRTln7uzXAXnwEDVY83pzoqYfxpPwWJl637
         Phdw==
X-Gm-Message-State: ABuFfoh5Lwak5tiaDsf+q1VqBsxrvxlv42979tZUrHLBUPflUz8NcWoT
        D8m3EC1F2lKsQn3LIdeuIyUrXyl0PclBf3GWcvc=
X-Google-Smtp-Source: ACcGV61T5ADH+583BNMb1fw8B0z92kUNaXTGhI/Z9eAjCRPrDT86GZ/xGNbv2jCMMLinzu2Kf9L5yw+OW7K9oI0K01g=
X-Received: by 2002:a67:d19b:: with SMTP id w27-v6mr693879vsi.166.1538578017999;
 Wed, 03 Oct 2018 07:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181003123328.GA29471@embeddedor.com>
In-Reply-To: <20181003123328.GA29471@embeddedor.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 Oct 2018 16:46:45 +0200
Message-ID: <CAMuHMdX2YL2PG390ej0WMct7DciAbzO=66z7TJ-VnS8_phjdaQ@mail.gmail.com>
Subject: Re: [PATCH] spi: slave: Fix missing break in switch
To:     gustavo@embeddedor.com
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On Wed, Oct 3, 2018 at 2:57 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Apparently, this code does not actually fall through to the next case
> because the machine restarts before it has a chance. However, for the
> sake of maintenance and readability, we better add the missing break
> statement.
>
> Addresses-Coverity-ID: 1437892 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/spi/spi-slave-system-control.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/spi/spi-slave-system-control.c b/drivers/spi/spi-slave-system-control.c
> index c0257e9..169f3d5 100644
> --- a/drivers/spi/spi-slave-system-control.c
> +++ b/drivers/spi/spi-slave-system-control.c
> @@ -60,6 +60,7 @@ static void spi_slave_system_control_complete(void *arg)
>         case CMD_REBOOT:
>                 dev_info(&priv->spi->dev, "Rebooting system...\n");
>                 kernel_restart(NULL);
> +               break;
>
>         case CMD_POWEROFF:
>                 dev_info(&priv->spi->dev, "Powering off system...\n");

Alternatively, kernel_restart() and friends could be marked __noreturn.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
