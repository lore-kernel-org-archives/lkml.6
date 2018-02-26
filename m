Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751744AbeBZRQ4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:16:56 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36759 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751634AbeBZRQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:16:54 -0500
X-Google-Smtp-Source: AG47ELthmtQIFHKne0yXaVu4ZbF1DUPIwNmi526u+eGCzhCoRAjA5sqwnsIK9t85XT5PN6prl4daIWQ0Jcx0HgENC3s=
MIME-Version: 1.0
In-Reply-To: <20180225235432.31209-5-rabel@robertabel.eu>
References: <9ec3c54c-f8fe-22d7-783e-8cf9862405bb@robertabel.eu>
 <20180225235432.31209-1-rabel@robertabel.eu> <20180225235432.31209-2-rabel@robertabel.eu>
 <20180225235432.31209-3-rabel@robertabel.eu> <20180225235432.31209-4-rabel@robertabel.eu>
 <20180225235432.31209-5-rabel@robertabel.eu>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 26 Feb 2018 18:16:33 +0100
Message-ID: <CANiq72=Qj+dsWYb6pVtAH6DMbAndSOFO8EmQF3ncFZTo_0bNMQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] auxdisplay: charlcd: make home command unshift display
To: Robert Abel <rabel@robertabel.eu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 12:54 AM, Robert Abel <rabel@robertabel.eu> wrote:
> A user has no way of unshifting the display programmatically once shifted.
> Users cannot rely on ^[[H (home) to result in their message being seen either.
> Use the actual HOME command 0x02 instead of only returning to x0/y0.
> Users can still do ^[[Lx0y0; (go to x/y) if they wish to use the 'old' home
> function.
> Implement fast clearing of LCD by going to x0/y0 first, clearing display and
> then calling home to possibly unshift display possibly avoiding artifacts by
> not unshifting before clearing display.

Thanks for the patch! It seems reasonable. However, like in the
previous patch, I feel that these commit messages describe -- usefully
-- the current code and some of the decisions for its design, and as
such they should be part of the code. Could you please put some of
that reasoning in the actual code? i.e. as comments for the
charlcd_clear_fast() and charlcd_home() functions, explaining why each
of them is implemented the way it is. That would be great. Also
hinting that the users can also use the "old" home functionality (or
maybe implementing it as another third alternative). Then you can
leave the commit message explaining only why the change was done, i.e.
why it improves the previous situation, referring to the new
functions.

Cheers,
Miguel

>
> Signed-off-by: Robert Abel <rabel@robertabel.eu>
> ---
>  drivers/auxdisplay/charlcd.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
> index 24cabe88c7f0..41f9aa4a73d4 100644
> --- a/drivers/auxdisplay/charlcd.c
> +++ b/drivers/auxdisplay/charlcd.c
> @@ -43,6 +43,8 @@
>  /* LCD commands */
>  #define LCD_CMD_DISPLAY_CLEAR  0x01    /* Clear entire display */
>
> +#define LCD_CMD_HOME            0x02    /* Set DDRAM address to 0 and unshift display */
> +
>  #define LCD_CMD_ENTRY_MODE     0x04    /* Set entry mode */
>  #define LCD_CMD_CURSOR_INC     0x02    /* Increment cursor */
>
> @@ -182,7 +184,8 @@ static void charlcd_home(struct charlcd *lcd)
>
>         priv->addr.x = 0;
>         priv->addr.y = 0;
> -       charlcd_gotoxy(lcd);
> +       lcd->ops->write_cmd(lcd, LCD_CMD_HOME);
> +       long_sleep(2);
>  }
>
>  static void charlcd_print(struct charlcd *lcd, char c)
> @@ -202,9 +205,12 @@ static void charlcd_print(struct charlcd *lcd, char c)
>
>  static void charlcd_clear_fast(struct charlcd *lcd)
>  {
> +       struct charlcd_priv *priv = to_priv(lcd);
>         int pos;
>
> -       charlcd_home(lcd);
> +       priv->addr.x = 0;
> +       priv->addr.y = 0;
> +       charlcd_gotoxy(lcd);
>
>         if (lcd->ops->clear_fast)
>                 lcd->ops->clear_fast(lcd);
> --
> 2.11.0
>
