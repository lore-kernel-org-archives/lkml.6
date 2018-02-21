Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752535AbeBUIin (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 03:38:43 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:35987 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752442AbeBUIil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 03:38:41 -0500
X-Google-Smtp-Source: AH8x227u4f/R91VIKt8n2tdQJdtw3drpfzoWNLVrNgevKkIJ1H+xNfswIpdRDJ9B40O8WjH2DMgYwvLCvN5iuzgsBDU=
MIME-Version: 1.0
In-Reply-To: <20180213060814.18165-1-wens@csie.org>
References: <20180213060814.18165-1-wens@csie.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Feb 2018 09:38:40 +0100
Message-ID: <CACRpkdZ9L+Ssd9_Vcj2HwOpuYaX2_2MzAv8W+OWq+YEDi=-uMg@mail.gmail.com>
Subject: Re: [PATCH] gpio: Handle deferred probing in of_find_gpio() properly
To: Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-gpio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 7:08 AM, Chen-Yu Tsai <wens@csie.org> wrote:

> of_get_named_gpiod_flags() used directly in of_find_gpio() or indirectly
> through of_find_spi_gpio() or of_find_regulator_gpio() can return
> -EPROBE_DEFER. This gets overwritten by the subsequent of_find_*_gpio()
> calls.
>
> This patch fixes this by trying of_find_spi_gpio() or
> of_find_regulator_gpio() only if deferred probing was not requested by
> the previous of_get_named_gpiod_flags() call.
>
> Fixes: 6a537d48461d ("gpio: of: Support regulator nonstandard GPIO properties")
> Fixes: c85823390215 ("gpio: of: Support SPI nonstandard GPIO properties")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Patch applied,

>         /* Special handling for SPI GPIOs if used */
> -       if (IS_ERR(desc))
> +       if (IS_ERR(desc) && PTR_ERR(desc) != -EPROBE_DEFER)
>                 desc = of_find_spi_gpio(dev, con_id, &of_flags);

Dropped this hunk since Maxime's patch handles that.

>         /* Special handling for regulator GPIOs if used */
> -       if (IS_ERR(desc))
> +       if (IS_ERR(desc) && PTR_ERR(desc) != -EPROBE_DEFER)
>                 desc = of_find_regulator_gpio(dev, con_id, &of_flags);

Kept this.

Yours,
Linus Walleij
