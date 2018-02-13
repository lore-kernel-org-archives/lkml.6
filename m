Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933544AbeBMHRC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 02:17:02 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:52515 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933428AbeBMHQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 02:16:59 -0500
X-Google-Smtp-Source: AH8x225xOCjM04SDwcbx2WPP20Ytx0BiSzYnvFtNFiOF40D5U4+zdwh3iP/os0jyP8ZAup8IY6nTdvMn+grqLWWWV8k=
MIME-Version: 1.0
In-Reply-To: <1518502848-7694-1-git-send-email-shunyong.yang@hxt-semitech.com>
References: <1518502848-7694-1-git-send-email-shunyong.yang@hxt-semitech.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Tue, 13 Feb 2018 08:16:57 +0100
Message-ID: <CAKwiHFiLQjFc3x9Q9=GEgnuiDPH_aBf7P1-=wPB7WtTo2ExDaA@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: replace space with readable '=' before crng is ready
To: Shunyong Yang <shunyong.yang@hxt-semitech.com>
Cc: me@tobin.cc, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 February 2018 at 07:20, Shunyong Yang
<shunyong.yang@hxt-semitech.com> wrote:

>
> This patch replaces space with readable "=" when output needs padding.
> Following is the output after applying the patch,

> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>
>         if (unlikely(!have_filled_random_ptr_key)) {
> +               char *ptrval_str = "(ptrval)";
> +               char str[default_width + 1];
> +               int len = strlen(ptrval_str);
> +
> +               if (default_width > len) {
> +                       int pos;
> +
> +                       pos = (default_width - len) / 2;
> +                       memset(str, '=', default_width);
> +                       memcpy(str + pos + 1, ptrval_str + 1, len - 2);
> +                       str[0] = '(';
> +                       str[default_width - 1] = ')';
> +                       str[default_width] = 0;
> +                       ptrval_str = str;
> +               }
> +

I'm sorry, but that's way too convoluted.

>                 spec.field_width = default_width;
>                 /* string length must be less than default_width */
> -               return string(buf, end, "(ptrval)", spec);
> +               return string(buf, end, ptrval_str, spec);
>         }

I was thinking of just doing something like

-               return string(buf, end, "(ptrval)", spec);
+               return string(buf, end, sizeof(void *) == 8 ?
"(====ptrval====)" : "(ptrval)", spec);

Rasmus
