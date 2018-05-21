Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753308AbeEUWX1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 18:23:27 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40114 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbeEUWXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 18:23:23 -0400
X-Google-Smtp-Source: AB8JxZrvAwpmmbh+zy2KUa1p+LQQcG+8xxL26pAh0Lic0KZAv9f+tPexP0vxtGPvuZZFYMQi+/5HkBMUAA1BWrtkYSE=
MIME-Version: 1.0
In-Reply-To: <1526903890-35761-31-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com> <1526903890-35761-31-git-send-email-xieyisheng1@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 May 2018 01:23:22 +0300
Message-ID: <CAHp75VfOWPjbmtE=zhmbd4wNsOjYF7ZVGkq9DeMpbtgXwa2DAA@mail.gmail.com>
Subject: Re: [PATCH 30/33] ALSA: oxygen: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 2:58 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.
>
> Cc: Clemens Ladisch <clemens@ladisch.de>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  sound/pci/oxygen/oxygen_mixer.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/sound/pci/oxygen/oxygen_mixer.c b/sound/pci/oxygen/oxygen_mixer.c
> index 4ca1266..fbd8f5e 100644
> --- a/sound/pci/oxygen/oxygen_mixer.c
> +++ b/sound/pci/oxygen/oxygen_mixer.c
> @@ -1052,10 +1052,9 @@ static int add_controls(struct oxygen *chip,
>                 [CONTROL_CD_CAPTURE_SWITCH] = "CD Capture Switch",
>                 [CONTROL_AUX_CAPTURE_SWITCH] = "Aux Capture Switch",
>         };
> -       unsigned int i, j;
>         struct snd_kcontrol_new template;
>         struct snd_kcontrol *ctl;
> -       int err;
> +       int i, j, err;

What's wrong with

unsigned int i;

?

>
>         for (i = 0; i < count; ++i) {
>                 template = controls[i];
> @@ -1086,11 +1085,11 @@ static int add_controls(struct oxygen *chip,
>                 err = snd_ctl_add(chip->card, ctl);
>                 if (err < 0)
>                         return err;
> -               for (j = 0; j < CONTROL_COUNT; ++j)
> -                       if (!strcmp(ctl->id.name, known_ctl_names[j])) {
> -                               chip->controls[j] = ctl;
> -                               ctl->private_free = oxygen_any_ctl_free;
> -                       }
> +               j = match_string(known_ctl_names, CONTROL_COUNT, ctl->id.name);
> +               if (j >= 0) {
> +                       chip->controls[j] = ctl;
> +                       ctl->private_free = oxygen_any_ctl_free;
> +               }
>         }
>         return 0;
>  }
> --
> 1.7.12.4
>



-- 
With Best Regards,
Andy Shevchenko
