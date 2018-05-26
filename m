Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032440AbeEZUrw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 16:47:52 -0400
Received: from mail-ot0-f172.google.com ([74.125.82.172]:42123 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032376AbeEZUru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 16:47:50 -0400
X-Google-Smtp-Source: ADUXVKIG7KPjMFkYSBTara+d39qvTC/ovvqLDXvTa1WR3v71V6VqOFenn+qKUuo8FL8FzTlgAq4WcmUsophkEyKlfBM=
MIME-Version: 1.0
In-Reply-To: <CAK7LNARMMWj+z_E7urs4kOFMC4+1NiCYt4ueB6gVFr86vgiVKg@mail.gmail.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
 <1526537830-22606-4-git-send-email-yamada.masahiro@socionext.com>
 <CAFkk2KQUps1rhjxdOVz5Mkt+p7VkHX+o5aHvP3u0Hka0_ULcow@mail.gmail.com>
 <CAK7LNARP2b=jN_ioj3dT=3yiSTv7Ezu-MSPuh0vO30irN5D1nA@mail.gmail.com>
 <CAFkk2KT0PAS8=bqHeSux3XwUx4fwKKqQoJkGeXRo8DHtEQNrDQ@mail.gmail.com> <CAK7LNARMMWj+z_E7urs4kOFMC4+1NiCYt4ueB6gVFr86vgiVKg@mail.gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Sat, 26 May 2018 22:47:49 +0200
Message-ID: <CAFkk2KQZV35nQFALHz4ADrrBXOaLirVEf1Z5TAU3zuHDPL1SWw@mail.gmail.com>
Subject: Re: [PATCH v4 03/31] kconfig: reference environment variables
 directly and remove 'option env='
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 6:45 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-05-21 20:06 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
>
>>>
>>> static char *__expand_string(const char **str, bool (*is_end)(const char *))
>>> {
>>>         const char *in, *prev_in, *p;
>>>         char *new, *out;
>>>         size_t outlen;
>>>
>>>         out = xmalloc(1);
>>>         *out = 0;
>>>
>>>         p = in = *str;
>>>
>>>         while (1) {
>>>                 if (*p == '$') {
>>>                         prev_in = in;
>>>                         in = p + 1;
>>>                         new = expand_dollar(&in);
>>>                         outlen = strlen(out) + (p - prev_in) + strlen(new) + 1;
>>>                         out = xrealloc(out, outlen);
>>>                         strncat(out, prev_in, p - prev_in);
>>>                         strcat(out, new);
>>>                         free(new);
>>>                         p = in;
>>>                         continue;
>>>                 }
>>>
>>>                 if (is_end(p))
>>>                         break;
>>>
>>>                 p++;
>>>         }
>>>
>>>         outlen = strlen(out) + (p - in) + 1;
>>>         out = xrealloc(out, outlen);
>>>         strncat(out, in, p - in);
>>>
>>>         *str = p;
>>>
>>>         return out;
>>> }
>>>
>>> static bool is_end_of_str(const char *s)
>>> {
>>>         return !*s;
>>> }
>>>
>>> char *expand_string(const char *in)
>>> {
>>>         return __expand_string(&in, is_end_of_str);
>>> }
>>>
>>> static bool is_end_of_token(const char *s)
>>> {
>>>         return !(isalnum(*s) || *s == '_' || *s == '-' || *s == '.' ||
>>> *s == '/');
>>> }
>>>
>>> char *expand_one_token(const char **str)
>>> {
>>>         return __expand_string(str, is_end_of_token);
>>> }
>>
>> Yep, something like that would be nicer I think.
>>
>> This variant might work too (untested):
>>
>>   dollar_i = p;
>>   p++;
>>   expansion = expand_dollar(&p);
>>
>>   out = xrealloc(out, strlen(out) + (dollar_i - in)
>>                       + strlen(expansion) + 1);
>>   strncat(out, in, dollar_i - in);
>>   strcat(out, expansion);
>>   free(expansion);
>>
>>   in = p;
>>
>>   continue;
>>
>> The p++ would disappear if expand_dollar() took a pointer to the '$'.
>>
>
>
> I took the variable name "expansion" because
> it is more descriptive than "new".
>
>
> I rewrote like follows:
>
>
> static char *__expand_string(const char **str, bool (*is_end)(const char *))
> {
>         const char *in, *p;
>         char *expansion, *out;
>         size_t in_len, out_len;
>
>         out = xmalloc(1);
>         *out = 0;
>         out_len = 1;
>
>         p = in = *str;
>
>         while (1) {
>                 if (*p == '$') {
>                         in_len = p - in;
>                         p++;
>                         expansion = expand_dollar(&p);
>                         out_len += in_len + strlen(expansion);
>                         out = xrealloc(out, out_len);
>                         strncat(out, in, in_len);
>                         strcat(out, expansion);
>                         free(expansion);
>                         in = p;
>                         continue;
>                 }
>
>                 if (is_end(p))
>                         break;
>
>                 p++;
>         }
>
>         in_len = p - in;
>         out_len += in_len;
>         out = xrealloc(out, out_len);
>         strncat(out, in, in_len);
>
>         /* Advance 'str' to the end character */
>         *str = p;
>
>         return out;
> }
>
>
>
> I used "out_len" to remember the length of "out"
> instead of calculating strlen(out) every time.
>
> I do not need dollar_p.
>
>
>
>
> --
> Best Regards
> Masahiro Yamada

Looks good to me.

Could keep some 'out' pointer to avoid the str(n)cat()s too, but
pretty sure it's overkilling it. Should have some general string
buffer helpers at that point I think. :)

Cheers,
Ulf
