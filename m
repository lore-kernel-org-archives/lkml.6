Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752872AbeBZLor (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:44:47 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:47050 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbeBZLoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 06:44:44 -0500
X-Google-Smtp-Source: AG47ELvkArATBzWDlSmeqxULc4tIIZRlzH+QiVzo5X0TkbBb9J12KnxmrJi83AvY9cGGAJVgCxpnu5GcZnmJKBxDCC4=
MIME-Version: 1.0
In-Reply-To: <20180225235432.31209-4-rabel@robertabel.eu>
References: <9ec3c54c-f8fe-22d7-783e-8cf9862405bb@robertabel.eu>
 <20180225235432.31209-1-rabel@robertabel.eu> <20180225235432.31209-2-rabel@robertabel.eu>
 <20180225235432.31209-3-rabel@robertabel.eu> <20180225235432.31209-4-rabel@robertabel.eu>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Feb 2018 13:44:43 +0200
Message-ID: <CAHp75Vcrx2rLDsJduWx75Wa57yTRqtQ1dqZMkCGv64K0bOYLiQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] auxdisplay: charlcd: fix x/y address commands
To: Robert Abel <rabel@robertabel.eu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 1:54 AM, Robert Abel <rabel@robertabel.eu> wrote:
> NUL-terminate each individual number to be parsed.
> To do this, the next command character and a pointer to its argument
> are found and stored. The command character is then overwritten by NUL
> before kstr* functions are called on the buffer.

Can we avoid yoda style of programming?

>         case 'x':       /* gotoxy : LxXXX[yYYY]; */
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
> +
> +                       if ('x' == cmd) {
> +                               if (kstrtoul(esc, 10, &tmp_addr.x) < 0)
>                                         break;

> +                       } else if ('y' == cmd) {
> +                               if (kstrtoul(esc, 10, &tmp_addr.y) < 0)
>                                         break;

Perhaps instead of dancing around kstrtox() better to switch to
simple_strtoul() ?

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
>                 break;

>         }
> +       }

Same indentation level or my mailer hides this from me?

-- 
With Best Regards,
Andy Shevchenko
