Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AIpwx4+HdtnN2Y79tUEwKLG69x/fVYgZSFg2nqA2JRc0zI4RDV0iy6s7f/XdP+lcWu+wIP4l2LrH
ARC-Seal: i=1; a=rsa-sha256; t=1523597599; cv=none;
        d=google.com; s=arc-20160816;
        b=WPG+SK2Bq05uH/yYAk2hAhDPyhRh+H6KIN8G6qzvoiJ8EVa4lM8YQauiRINUo5EjxK
         i3sQ9D+IctgujcoO9hmF4qFyqS3Xmk/XNuHQP665AHVyqwrOOjMhe8Exkccn0k78KelC
         dSyjenTYXDaZVvtXoYyN8OaohDlE9kJWl11CF/+l9gGHpv1QV2xStDy/lXNlZ1Jdl0q6
         bWDmzlBgWl4uRpl1PXJAT5dyj1JVe631lNSqwFBYv6FX8VsdvX1m+7mOpj57meUomXHS
         AytABbzxYDC53O54XVfcpBzK876WUZqH9w2A7VzX9kO7aqA7iZwPShsaeL1qsgje08hK
         n45g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=cqRIlU67AzjPleraSReUpt1bgj6A9wYd5JzK3OqeOuc=;
        b=B6Op4o9lSuewlOI2bCPkrIojvQrKZDUPdMrXfSeCzhZcENZIQg7G64fwncsee6r7Lf
         Cp6AcFk0XVEaeXOXOcumRJb0h+rmHvuoXVUyInzLpJZH0DdimWCGwOrp6usFYetwubWB
         QiqhO/RB+2F5exvYCErOV2EmeBrVG58ZNtMQUQTS6Cpa0Q+i4QbNkunxHCqvX/uUV/xU
         4mlDlE8mzpF59R0xl/GTq2SpEzuuutfsOJbKHLHEqxf0vF85X0XlT4zz8nLTdwIaIJ81
         5rNjpUU9RBeOj0+7JrlGQukKXHZfId0eU3oEOWovpl872F1gCapefcPl92G7OZCHnBc7
         qaZg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=se7O8vd5;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.82 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=se7O8vd5;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.82 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w3D5X1pf002809
X-Nifty-SrcIP: [209.85.217.182]
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKmnO3o4dwWXrizKCeVpj3RCzw_zsHPseZrLXAgGb0YdQ@mail.gmail.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
 <1522128575-5326-8-git-send-email-yamada.masahiro@socionext.com> <CAGXu5jKmnO3o4dwWXrizKCeVpj3RCzw_zsHPseZrLXAgGb0YdQ@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 13 Apr 2018 14:32:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNARr1bHkub1kOaa1ep72Tth8HJocr5dS0TFx7+L7VyFH6A@mail.gmail.com>
Message-ID: <CAK7LNARr1bHkub1kOaa1ep72Tth8HJocr5dS0TFx7+L7VyFH6A@mail.gmail.com>
Subject: Re: [PATCH v2 07/21] kconfig: add function support and implement
 'shell' function
To: Kees Cook <keescook@chromium.org>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ulf Magnusson <ulfalizer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Nicolas Pitre <nico@linaro.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067538101341662?=
X-GMAIL-MSGID: =?utf-8?q?1597607876851606314?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-28 12:41 GMT+09:00 Kees Cook <keescook@chromium.org>:
> On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> This commit adds a new concept 'function' to do more text processing
>> in Kconfig.
>>
>> A function call looks like this:
>>
>>   $(function arg1, arg2, arg3, ...)
>>
>> (Actually, this syntax was inspired by make.)
>>
>> Real examples will look like this:
>>
>>   $(shell echo hello world)
>>   $(cc-option -fstackprotector)
>>
>> This commit adds the basic infrastructure to add, delete, evaluate
>> functions, and also the first built-in function $(shell ...).  This
>> accepts a single command to execute.  It returns the standard output
>> from it.
>>
>> [Example code]
>>
>>   config HELLO
>>           string
>>           default "$(shell echo hello world)"
>>
>>   config Y
>>           def_bool $(shell echo y)
>>
>> [Result]
>>
>>   $ make -s alldefconfig && tail -n 2 .config
>>   CONFIG_HELLO="hello world"
>>   CONFIG_Y=y
>>
>> Caveat:
>> Like environments, functions are expanded in the lexer.  You cannot
>> pass symbols to function arguments.  This is a limitation to simplify
>> the implementation.  I want to avoid the dynamic function evaluation,
>> which would introduce much more complexity.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>> Reminder for myself:
>> Update Documentation/kbuild/kconfig-language.txt
>
> Yeah, this needs to be included here, especially given the "cannot
> pass symbols" aspect which might surprise people.
>
>> [...]
>> +/* built-in functions */
>> +static char *do_shell(struct function *f, int argc, char *argv[])
>> +{
>> +       static const char *pre = "(";
>> +       static const char *post = ") 2>/dev/null";
>
> Right now the search and help screens in menuconfig just show the line
> a config is defined and nothing more. I think it would be extremely
> handy to include shell output here in some way.


The current implementation cannot do this.

The $(shell ...) has already expanded
before the parser receives tokens.

There is no way to know whether a token came from a source file as-is,
or it was derived from textual substitution.




> Especially when trying
> to answer questions like "why aren't GCC plugins available?" it's got
> quite a bit harder to debug.
> Could we capture the output (especially stderr) for these kinds of hints?


For example, it would be possible to dump the result of $(shell ...)
evaluation into the console in debug mode.



> Beyond that, looks good!
>
> -Kees
>
> --
> Kees Cook
> Pixel Security
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
