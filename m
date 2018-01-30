Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751770AbeA3MLU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 07:11:20 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33437 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbeA3MLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 07:11:18 -0500
X-Google-Smtp-Source: AH8x227W4Ovsa15lRMBMOGExEWSulDYGl/HC18jlRbbb1gnMGv5XmXStNRU4J+U6XcFRdV3bqfcpRI8Wt5GQ+15c+1g=
MIME-Version: 1.0
In-Reply-To: <20180130120340.GB10525@sirena.org.uk>
References: <1517308346-25299-1-git-send-email-geert+renesas@glider.be> <20180130120340.GB10525@sirena.org.uk>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jan 2018 13:11:16 +0100
X-Google-Sender-Auth: is54jdrleacekzR1ooLWGtNgCIg
Message-ID: <CAMuHMdWgxyEfooAo1c8yKNrHijhbccV41Q=PEkoGoNbZ7sN5NA@mail.gmail.com>
Subject: Re: [PATCH] regulator: core: Fix s2idle
To: Mark Brown <broonie@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, Jan 30, 2018 at 1:03 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jan 30, 2018 at 11:32:26AM +0100, Geert Uytterhoeven wrote:
>> But I have no idea what impact it has.  So far it doesn't seem to hurt,
>> though.
>
> I suspect that instead what we should be doing is changing the
> set_suspend_state() check to the below - if we don't have any
> constraints or there's otherwise nothing to do just let the suspend
> proceed.
>
> Can you give this a spin and confirm if it fixes things?

Sure. Works, too.

> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 42681c10cbe4..dd4708c58480 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -758,7 +758,7 @@ static int suspend_set_state(struct regulator_dev *rdev,
>
>         rstate = regulator_get_suspend_state(rdev, state);
>         if (rstate == NULL)
> -               return -EINVAL;
> +               return 0;
>
>         /* If we have no suspend mode configration don't set anything;
>          * only warn if the driver implements set_suspend_voltage or

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
