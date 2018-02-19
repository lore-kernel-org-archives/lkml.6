Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753493AbeBSSkn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 13:40:43 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34504 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753423AbeBSSkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 13:40:42 -0500
X-Google-Smtp-Source: AH8x226Lc85fWPLfZsANQ0WIjKniMInHg81x3NCQ/wiaW2DpnuPZC77tyFgZB4gzwQaTchO/v/UQyM2iCzC1LOhPYUc=
MIME-Version: 1.0
In-Reply-To: <20180219160956.6uky4zxlnn5kas2t@gmail.com>
References: <20180219160956.6uky4zxlnn5kas2t@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Feb 2018 19:40:40 +0100
X-Google-Sender-Auth: t9JOZtNO-SVqING3xA0PrGcnc0o
Message-ID: <CAMuHMdWogcBuVC0PzviJ31w29L5QLYKVoiOtCtvu5Rc88f06oA@mail.gmail.com>
Subject: Re: [PATCH 3/3] auxdisplay: img-ascii-lcd: Silence 2 uninitialized warnings
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel,

On Mon, Feb 19, 2018 at 5:09 PM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> The warnings are:
>
>   drivers/auxdisplay/img-ascii-lcd.c: warning: 'err' may be used
>   uninitialized in this function [-Wuninitialized]
>
> At lines 109 and 207. Reported by Geert using the build service
> several times, e.g.:
>
>   https://lkml.org/lkml/2018/2/19/303
>
> They are two false positives, since num_chars > 0 in the three present
> configurations (boston, malta, sead3). Initializing to an error state by
> default silences the warning and makes the code print an error in case a
> num_chars == 0 happens in the future (unlikely, since it does not make
> sense currently).
>
> The warnings seem to disappear starting with gcc >= 4.9
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Thanks for your patch!

I would initialize err to zero, though, as there is no real error condition if
called with num_char == 0.

> ---
> I will queue it up for 4.17.
>
> drivers/auxdisplay/img-ascii-lcd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/auxdisplay/img-ascii-lcd.c b/drivers/auxdisplay/img-ascii-lcd.c
> index d8133024fd5d..bd5ebb5c516c 100644
> --- a/drivers/auxdisplay/img-ascii-lcd.c
> +++ b/drivers/auxdisplay/img-ascii-lcd.c
> @@ -97,7 +97,7 @@ static struct img_ascii_lcd_config boston_config = {
>  static void malta_update(struct img_ascii_lcd_ctx *ctx)
>  {
>         unsigned int i;
> -       int err;
> +       int err = 1;
>
>         for (i = 0; i < ctx->cfg->num_chars; i++) {
>                 err = regmap_write(ctx->regmap,
> @@ -180,7 +180,7 @@ static int sead3_wait_lcd_idle(struct img_ascii_lcd_ctx *ctx)
>  static void sead3_update(struct img_ascii_lcd_ctx *ctx)
>  {
>         unsigned int i;
> -       int err;
> +       int err = 1;
>
>         for (i = 0; i < ctx->cfg->num_chars; i++) {
>                 err = sead3_wait_lcd_idle(ctx);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
