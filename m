Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbeBWNhb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:37:31 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38453 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751766AbeBWNh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:37:27 -0500
X-Google-Smtp-Source: AG47ELtKIKX4HxwFJ8jWFYwFCN7W6psx1AdQwoMDN50//DFkFqpVxV4ap2YGHQvs8O4/pE5zIH0OjeosJ08AvOo9+Wg=
MIME-Version: 1.0
In-Reply-To: <20170708005624.GA17338@embeddedgus>
References: <20170708005624.GA17338@embeddedgus>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 23 Feb 2018 14:37:06 +0100
Message-ID: <CANiq72=m-CC5=uFYHona1cx3nFMi_wwz8ue0cg3AwsehA2Ob1A@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: ht16k33: constify fb_fix_screeninfo and
 fb_var_screeninfo structures
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Robin van der Gracht <robin@protonic.nl>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On Sat, Jul 8, 2017 at 2:56 AM, Gustavo A. R. Silva
<garsilva@embeddedor.com> wrote:
> These structures are only used to copy into other structures,
> so declare them as const.
>
> This issue was detected using Coccinelle and the following semantic patch:
>
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct fb_fix_screeninfo i@p = { ... };
>
> @ok@
> identifier r.i;
> expression e;
> position p;
> @@
> e = i@p
>
> @bad@
> position p != {r.p,ok.p};
> identifier r.i;
> struct fb_fix_screeninfo e;
> @@
> e@i@p
>
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>  struct fb_fix_screeninfo i = { ... };
>
> The semantic patch for fb_var_screeninfo is analogous.
>
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  drivers/auxdisplay/ht16k33.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
> index fbfa5b4..a0162b5 100644
> --- a/drivers/auxdisplay/ht16k33.c
> +++ b/drivers/auxdisplay/ht16k33.c
> @@ -82,7 +82,7 @@ struct ht16k33_priv {
>         struct ht16k33_fbdev fbdev;
>  };
>
> -static struct fb_fix_screeninfo ht16k33_fb_fix = {
> +static const struct fb_fix_screeninfo ht16k33_fb_fix = {
>         .id             = DRIVER_NAME,
>         .type           = FB_TYPE_PACKED_PIXELS,
>         .visual         = FB_VISUAL_MONO10,
> @@ -93,7 +93,7 @@ static struct fb_fix_screeninfo ht16k33_fb_fix = {
>         .accel          = FB_ACCEL_NONE,
>  };
>
> -static struct fb_var_screeninfo ht16k33_fb_var = {
> +static const struct fb_var_screeninfo ht16k33_fb_var = {
>         .xres = HT16K33_MATRIX_LED_MAX_ROWS,
>         .yres = HT16K33_MATRIX_LED_MAX_COLS,
>         .xres_virtual = HT16K33_MATRIX_LED_MAX_ROWS,

I will pick this up for 4.17.

Thank you for the patch!
Miguel

> --
> 2.5.0
>
