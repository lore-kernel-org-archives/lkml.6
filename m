Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeBZIqL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 03:46:11 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33894 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeBZIqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 03:46:10 -0500
X-Google-Smtp-Source: AG47ELuMgDYEZvCw723daFZ9y4Ya06Qiewdz1FCDsQzS4Pi4N1NYd+bU+wvh/vwl3FjHAzhMnLf9lTMSrP4EZRKo9CE=
MIME-Version: 1.0
In-Reply-To: <20180225235432.31209-4-rabel@robertabel.eu>
References: <9ec3c54c-f8fe-22d7-783e-8cf9862405bb@robertabel.eu>
 <20180225235432.31209-1-rabel@robertabel.eu> <20180225235432.31209-2-rabel@robertabel.eu>
 <20180225235432.31209-3-rabel@robertabel.eu> <20180225235432.31209-4-rabel@robertabel.eu>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2018 09:46:08 +0100
X-Google-Sender-Auth: -5YqLas176jUPT0dOcOi0SVY1N4
Message-ID: <CAMuHMdW4i0-22zakETxEaio9rvVNuvvbQEwwehBfze=jeQLnHQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] auxdisplay: charlcd: fix x/y address commands
To: Robert Abel <rabel@robertabel.eu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <w@1wt.eu>, Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Mon, Feb 26, 2018 at 12:54 AM, Robert Abel <rabel@robertabel.eu> wrote:
> NUL-terminate each individual number to be parsed.
> To do this, the next command character and a pointer to its argument
> are found and stored. The command character is then overwritten by NUL
> before kstr* functions are called on the buffer.
>
> Signed-off-by: Robert Abel <rabel@robertabel.eu>

Thanks for your patch!

> --- a/drivers/auxdisplay/charlcd.c
> +++ b/drivers/auxdisplay/charlcd.c
> @@ -471,28 +471,63 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
>                 break;
>         }
>         case 'x':       /* gotoxy : LxXXX[yYYY]; */
> -       case 'y':       /* gotoxy : LyYYY[xXXX]; */
> +       case 'y': {     /* gotoxy : LyYYY[xXXX]; */
> +
> +               char* nxt_esc;
> +               char  nxt_cmd;
> +               char  cmd;
> +               struct charlcd_priv_addr tmp_addr;
> +
>                 if (!strchr(esc, ';'))
>                         break;
>
> -               while (*esc) {
> -                       if (*esc == 'x') {
> -                               esc++;
> -                               if (kstrtoul(esc, 10, &priv->addr.x) < 0)
> +               /* sequence is processed whether legal or illegal */
> +               processed = 1;
> +
> +               /* copy current address to temporary buffer */
> +               tmp_addr = priv->addr;
> +
> +               nxt_cmd = *esc++;
> +               nxt_esc = esc;
> +
> +               while ('\0' != *esc) {
> +
> +                       cmd = nxt_cmd;
> +                       esc = nxt_esc;
> +                       nxt_esc = strpbrk(esc, "xy;");
> +                       if (NULL != nxt_esc) {
> +                               nxt_cmd = *nxt_esc;
> +                               /* terminate current sequence with NUL */
> +                               *nxt_esc++ = '\0';
> +                       }

So if none of "x", "y", or ";" is found, nxt_cmd will still contain
the current command?
Shouldn't it be reset to '\0' or so?

> +
> +                       if ('x' == cmd) {
> +                               if (kstrtoul(esc, 10, &tmp_addr.x) < 0)
>                                         break;
> -                       } else if (*esc == 'y') {
> -                               esc++;
> -                               if (kstrtoul(esc, 10, &priv->addr.y) < 0)
> +                       } else if ('y' == cmd) {
> +                               if (kstrtoul(esc, 10, &tmp_addr.y) < 0)
>                                         break;
>                         } else {
> +                               /* break on unknown command or ';' */
>                                 break;
>                         }
> +
>                 }
>
> +               /* unknown commands in sequence will be followed by at least ';' */
> +               if ('\0' != *esc)
> +                       break;
> +
> +               /* clamp new x/y coordinates */
> +               if (tmp_addr.x >= lcd->width)
> +                       tmp_addr.x = lcd->width - 1;
> +               tmp_addr.y %= lcd->height;
> +
> +               priv->addr = tmp_addr;
>                 charlcd_gotoxy(lcd);
> -               processed = 1;
>                 break;
>         }
> +       }
>
>         /* TODO: This indent party here got ugly, clean it! */
>         /* Check whether one flag was changed */

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
