Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbeB0VMv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 16:12:51 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:39602 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751518AbeB0VMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 16:12:50 -0500
X-Google-Smtp-Source: AG47ELvpUCZRIxpUL1pmncz4PyIxqaASPNPy1lTidn5eTREW1906Cnp96c5mztlAQQe2c6V3HIsEyGNyJkHFyCZzxcs=
MIME-Version: 1.0
In-Reply-To: <CAHp75VctsM0F4Ldf1zr4CJ2gF3ku3ejTHPYrUQKQ-rJVeX2Wog@mail.gmail.com>
References: <20180227193118.n33bkbrqxybfhgdc@gmail.com> <CAHp75VctsM0F4Ldf1zr4CJ2gF3ku3ejTHPYrUQKQ-rJVeX2Wog@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 27 Feb 2018 22:12:29 +0100
Message-ID: <CANiq72nxBSXXq1KbKVExTNTpo8kS_-dso429dzGHwzVD+5dLtw@mail.gmail.com>
Subject: Re: [PATCH RFC] auxdisplay: charlcd: Fix and clean up handling of x/y commands
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>,
        Robert Abel <rabel@robertabel.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 9:52 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Feb 27, 2018 at 9:32 PM, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>> The current version is not parsing multiple x/y commands as the code
>> originally intended. On top of that, kstrtoul() expects
>> NULL-terminated strings. Finally, the code had to do two passes over
>> the string, while now only one is done.
>>
>> Some explanations about the supported syntax are added as well.
>
> Something like this would work, but see my comments below.
>
>> +/*
>> + * Parses a base 10 number from a string, until a non-digit number is found or
>> + * until PARSE_N_MAX_SIZE digits.
>> + *
>> + * See kstrtoul() for the meaning of the return value.
>> + * It also returns the next character in the string, i.e. the first non-digit.
>> + */
>> +#define PARSE_N_MAX_SIZE (3)
>> +static unsigned long parse_n(const char *s, unsigned long *res,
>> +       const char **next_s)
>
> static int parse_n(const char *s, unsigned long *res, const char **next_s)

Oops, thanks!

>
>> +{
>> +       char tmp[PARSE_N_MAX_SIZE + 1];
>> +       int i;
>> +
>
> First of all you need
>
> unsigned int i = 0;
>
> while (s[i] == '0')
>  i++;

Why?

>
>> +       for (i = 0; ; ++i) {
>> +               if (!isdigit(s[i]))
>> +                       break;
>> +               if (i >= PARSE_N_MAX_SIZE)
>> +                       return -EINVAL;
>> +               tmp[i] = s[i];
>> +       }
>
> And here you partially open coded what simple_strto*() does.
>
>> +
>> +       tmp[i] = 0;
>> +       *next_s = &s[i];
>> +       return kstrtoul(tmp, 10, res);
>> +}
>
> It's over engineered. Just simple use simple_strto*() and that's all.
> Do you really care about overflows? Is those numbers somehow critical?
> What will go wrong?

We shouldn't use simple_strto*() since it is deprecated. So parse_n()
can be either this wrapper to call kstrto*() (which indeed is
overengineered, but easier to understand than Robert's patch that
modified the original sequence, and can be replaced by an inplace
version whenever we have one) or we just put a simple loop for the
moment (like the one Willy coded in 2008). Both are fine with me.

Cheers,
Miguel

>
> --
> With Best Regards,
> Andy Shevchenko
