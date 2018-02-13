Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934159AbeBMQCa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:02:30 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36326 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933698AbeBMQC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:02:28 -0500
X-Google-Smtp-Source: AH8x224+lRAM9CMpujkMLl5xyNupdTtjofPwTdD45GQhDW6j1B8M1jvLgAu/6uA7vZ5ctuks/yVwan1YNXKjJ/Yyi1k=
MIME-Version: 1.0
In-Reply-To: <20180210211110.GA24324@avx2>
References: <20180210211110.GA24324@avx2>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Feb 2018 18:02:27 +0200
Message-ID: <CAHp75VcQf-8RUP+bjej5dGJ+s2-hW9=51NVkvhYE6mUO3dY1Cg@mail.gmail.com>
Subject: Re: [PATCH] kstrtox: make kstrtobool_from_user() very strict
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 11:11 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> Once upon a time module parameter parsing code accepted
> 0, 1, y, n, Y and N for boolean values. Gratituous but contained
> to module code and thus tolerable.
>
> Commit ef951599074ba4fad2d0efa0a977129b41e6d203
> ("lib: move strtobool() to kstrtobool()") promoted that ugly wart
> to kstrtobool() and, more importantly, kstrtobool_from_user().
>
> Later set of accepted values was expanded to "on" and "of".
> Now there are 6+8=14(!) valid strings for a boolean.
>
> This patch reduces set of accepted values to "0" and "1"
> (with optional newline) in spirit with other kstrto*() functions.
>
> I'm starting with kstrtobool_from_user() as it is explicitly designed
> to be used for interacting with userspace. Currently there are 9 users
> all debug code, so there is hope.
>
> Please send before 4.16 so no real users start to depend on verbose behaviour.
>

NACK.
You basically are breaking ABI here. I don't see a zillion patches
which adds a tons of duplicate code to the corresponding users.

> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>
>  lib/kstrtox.c |   32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
>
> --- a/lib/kstrtox.c
> +++ b/lib/kstrtox.c
> @@ -368,19 +368,41 @@ int kstrtobool(const char *s, bool *res)
>  EXPORT_SYMBOL(kstrtobool);
>
>  /*
> - * Since "base" would be a nonsense argument, this open-codes the
> - * _from_user helper instead of using the helper macro below.
> + * Convert string to boolean:
> + *       0 => false
> + *       1 => true
> + *     0\n => false
> + *     1\n => true
> + *
> + * Return 0 on success or -E otherwise.
>   */
>  int kstrtobool_from_user(const char __user *s, size_t count, bool *res)
>  {
> -       /* Longest string needed to differentiate, newline, terminator */
> -       char buf[4];
> +       /* 0|1, newline, terminator */
> +       char buf[3], *p;
> +       bool val;
>
>         count = min(count, sizeof(buf) - 1);
>         if (copy_from_user(buf, s, count))
>                 return -EFAULT;
>         buf[count] = '\0';
> -       return kstrtobool(buf, res);
> +
> +       p = buf;
> +       if (*p == '0')
> +               val = false;
> +       else if (*p == '1')
> +               val = true;
> +       else
> +               return -EINVAL;
> +       p++;
> +
> +       if (*p == '\n')
> +               p++;
> +       if (*p)
> +               return -EINVAL;
> +
> +       *res = val;
> +       return 0;
>  }
>  EXPORT_SYMBOL(kstrtobool_from_user);
>



-- 
With Best Regards,
Andy Shevchenko
