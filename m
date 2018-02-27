Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeB0Uw1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 15:52:27 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:42226 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbeB0Uw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 15:52:26 -0500
X-Google-Smtp-Source: AG47ELt7rdUzVEiG4SOn8Kf3wdX/KC8aY4TozdLnAqjazakP+XEkahjM6W3hriTF435XMqyHiVdrb4U/ZM7mcL17lWQ=
MIME-Version: 1.0
In-Reply-To: <20180227193118.n33bkbrqxybfhgdc@gmail.com>
References: <20180227193118.n33bkbrqxybfhgdc@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 27 Feb 2018 22:52:24 +0200
Message-ID: <CAHp75VctsM0F4Ldf1zr4CJ2gF3ku3ejTHPYrUQKQ-rJVeX2Wog@mail.gmail.com>
Subject: Re: [PATCH RFC] auxdisplay: charlcd: Fix and clean up handling of x/y commands
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>,
        Robert Abel <rabel@robertabel.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 9:32 PM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> The current version is not parsing multiple x/y commands as the code
> originally intended. On top of that, kstrtoul() expects
> NULL-terminated strings. Finally, the code had to do two passes over
> the string, while now only one is done.
>
> Some explanations about the supported syntax are added as well.

Something like this would work, but see my comments below.

> +/*
> + * Parses a base 10 number from a string, until a non-digit number is found or
> + * until PARSE_N_MAX_SIZE digits.
> + *
> + * See kstrtoul() for the meaning of the return value.
> + * It also returns the next character in the string, i.e. the first non-digit.
> + */
> +#define PARSE_N_MAX_SIZE (3)
> +static unsigned long parse_n(const char *s, unsigned long *res,
> +       const char **next_s)

static int parse_n(const char *s, unsigned long *res, const char **next_s)

> +{
> +       char tmp[PARSE_N_MAX_SIZE + 1];
> +       int i;
> +

First of all you need

unsigned int i = 0;

while (s[i] == '0')
 i++;

> +       for (i = 0; ; ++i) {
> +               if (!isdigit(s[i]))
> +                       break;
> +               if (i >= PARSE_N_MAX_SIZE)
> +                       return -EINVAL;
> +               tmp[i] = s[i];
> +       }

And here you partially open coded what simple_strto*() does.

> +
> +       tmp[i] = 0;
> +       *next_s = &s[i];
> +       return kstrtoul(tmp, 10, res);
> +}

It's over engineered. Just simple use simple_strto*() and that's all.
Do you really care about overflows? Is those numbers somehow critical?
What will go wrong?

-- 
With Best Regards,
Andy Shevchenko
