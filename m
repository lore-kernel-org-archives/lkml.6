Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751712AbeBZWbo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 17:31:44 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42441 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbeBZWbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 17:31:43 -0500
X-Google-Smtp-Source: AG47ELsx+7WfyMWn6pvg3yNkKm37oSDKKOYLeU3s9h1LHelDz3Ee1qO2SWJDfAMNcfHoqQAbSbQGTp4mS2i4K/NyhAY=
MIME-Version: 1.0
In-Reply-To: <20180226175532.70556-1-andriy.shevchenko@linux.intel.com>
References: <20180226175532.70556-1-andriy.shevchenko@linux.intel.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 26 Feb 2018 23:31:21 +0100
Message-ID: <CANiq72nsPasAxZBkHW0fNcTMj3Vp_QdT3VABs9-mHKe4RHS9KA@mail.gmail.com>
Subject: Re: [PATCH v1] kernel.h: Update comment about simple_strto<foo>() functions
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 6:55 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> There were discussions in the past about use cases for
> simple_strto<foo>() functions and in some rare cases they have a benefit
> on kstrto<foo>() ones.
>
> Update a comment to reduce confusing about special use cases.
>
> Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

I am not sure we should just go back to the old ones, though. Maybe it
is better to create a new set of kstrto*_inplace() or some other name,
safer than the old ones and following kstrto*()'s interface regarding
returned errors, overflow checking, etc. There are two variations that
can be useful:

  * A strict version taking a (start, end) range or (start, size) pair
which contains the number to be converted. If there is any problem
parsing it (e.g. invalid characters, extra characters, ...), fail.

  * A less strict version taking an extra end pointer (or size
parameter) which is not allowed to be surpassed, and any non-digit
character means successful stop.

The old behavior (simple_*()) can still be achieved (almost) with the
second version with an "infinite" end pointer if one really needs it.

In any case, if you want to go forward with the old ones, we would
also have to change the comments inside lib/vsprintf.c and possibly
checkpatch :-)

Cheers,
Miguel

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/kernel.h | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 207b0702fad1..07ad6f36b17d 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -326,8 +326,7 @@ int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
>   * @res: Where to write the result of the conversion on success.
>   *
>   * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> - * Used as a replacement for the obsolete simple_strtoull. Return code must
> - * be checked.
> + * Used as a replacement for the simple_strtoull. Return code must be checked.
>  */
>  static inline int __must_check kstrtoul(const char *s, unsigned int base, unsigned long *res)
>  {
> @@ -355,8 +354,7 @@ static inline int __must_check kstrtoul(const char *s, unsigned int base, unsign
>   * @res: Where to write the result of the conversion on success.
>   *
>   * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> - * Used as a replacement for the obsolete simple_strtoull. Return code must
> - * be checked.
> + * Used as a replacement for the simple_strtoull. Return code must be checked.
>   */
>  static inline int __must_check kstrtol(const char *s, unsigned int base, long *res)
>  {
> @@ -432,7 +430,15 @@ static inline int __must_check kstrtos32_from_user(const char __user *s, size_t
>         return kstrtoint_from_user(s, count, base, res);
>  }
>
> -/* Obsolete, do not use.  Use kstrto<foo> instead */
> +/*
> + * Use kstrto<foo> instead.
> + *
> + * NOTE: The simple_strto<foo> do not check for overflow and depending
> + *       on the input may give interesting results.
> + *
> + * Use these functions if and only if the code will need in place
> + * conversion and otherwise looks very ugly. Keep in mind above caveat.
> + */
>
>  extern unsigned long simple_strtoul(const char *,char **,unsigned int);
>  extern long simple_strtol(const char *,char **,unsigned int);
> --
> 2.16.1
>
