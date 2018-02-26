Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbeBZQto (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 11:49:44 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46514 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750986AbeBZQtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 11:49:43 -0500
X-Google-Smtp-Source: AG47ELsezu8y/7AZCnHOqIGcOpT7IS7z8u1uEnOtTKdDrRa8xYgNYF6b7N7IBddxB4t0ZlOn8+yHZvA5HBDeQEOtgxo=
MIME-Version: 1.0
In-Reply-To: <20180225235432.31209-4-rabel@robertabel.eu>
References: <9ec3c54c-f8fe-22d7-783e-8cf9862405bb@robertabel.eu>
 <20180225235432.31209-1-rabel@robertabel.eu> <20180225235432.31209-2-rabel@robertabel.eu>
 <20180225235432.31209-3-rabel@robertabel.eu> <20180225235432.31209-4-rabel@robertabel.eu>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 26 Feb 2018 17:49:22 +0100
Message-ID: <CANiq72mu2NkDx4XqXzcO39N8AZg50h+BxrONJ3eCc7LjJ0rJKg@mail.gmail.com>
Subject: Re: [PATCH 3/4] auxdisplay: charlcd: fix x/y address commands
To: Robert Abel <rabel@robertabel.eu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 12:54 AM, Robert Abel <rabel@robertabel.eu> wrote:
> NUL-terminate each individual number to be parsed.
> To do this, the next command character and a pointer to its argument
> are found and stored. The command character is then overwritten by NUL
> before kstr* functions are called on the buffer.

It would be useful to have this description in the code itself as a comment.

>
> Signed-off-by: Robert Abel <rabel@robertabel.eu>
> ---
>  drivers/auxdisplay/charlcd.c | 53 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 44 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
> index a3d364e6c666..24cabe88c7f0 100644
> --- a/drivers/auxdisplay/charlcd.c
> +++ b/drivers/auxdisplay/charlcd.c
> @@ -471,28 +471,63 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
>                 break;
>         }
>         case 'x':       /* gotoxy : LxXXX[yYYY]; */
> -       case 'y':       /* gotoxy : LyYYY[xXXX]; */
> +       case 'y': {     /* gotoxy : LyYYY[xXXX]; */
> +

Extra empty line.

> +               char* nxt_esc;
> +               char  nxt_cmd;

I think skipping the "e" in the names do not buy us much :)

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

Please do not change the style of the code w.r.t to the rest of the
file, which writes tests with the non-lvalue on the right-hand side
and do not compare against '\0'. Same for the rest.

> +

Extra empty line.

> +                       cmd = nxt_cmd;
> +                       esc = nxt_esc;
> +                       nxt_esc = strpbrk(esc, "xy;");
> +                       if (NULL != nxt_esc) {
> +                               nxt_cmd = *nxt_esc;
> +                               /* terminate current sequence with NUL */
> +                               *nxt_esc++ = '\0';
> +                       }
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

{ } not needed (your patch doesn't touch this -- just pointing it out).

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

tmp_addr.x = min(tmp_addr.x, lcd->width - 1);

> +               tmp_addr.y %= lcd->height;
> +
> +               priv->addr = tmp_addr;
>                 charlcd_gotoxy(lcd);
> -               processed = 1;
>                 break;
>         }
> +       }

On a general note, the code seems a bit convoluted for what it does,
specially without the comment written in the commit message :-) Isn't
it simpler to use a tiny array in the stack and put the numbers to be
converted instead of modifying the input sequence and dancing with
pointers?

Thanks for the patch!

Cheers,
Miguel

>
>         /* TODO: This indent party here got ugly, clean it! */
>         /* Check whether one flag was changed */
> --
> 2.11.0
>
