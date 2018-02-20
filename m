Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x2277ere0S++C4Xh79JIsCNQvyJy/Ir3Li9wgLG10ddkhTeeKKZLWsjho16hfl2ZX0RfmEKMA
ARC-Seal: i=1; a=rsa-sha256; t=1519119222; cv=none;
        d=google.com; s=arc-20160816;
        b=uRuH+I6v5kGx0w2XMtRGCcW2NeLtCP1k0EuDI72ipH+EC3RJZEyjec3Q1VjxtbOpEE
         ZmSmC+UYaehqd+nwa5OAfJ2Le55bsSsKdBqOqaaV10AQ/i67lX1KPAE3YVHXbN0UHAyr
         T/gdNzDRug2JM9boeAhCtv83INGOl4sP2yAY5lX+tNXi8dKmaX2IPKcjOQCDoHxe2FUA
         4tCxj/Hn6gmi2sf8grI+q0JjmQYQkSDuTbYmg5U2f1l/PJllG4C1fwRitD978TnqAPY3
         jPs9dUWV2ioA3zH13+twVbrnNw/m4mIFB6Fih8Vb8mG218GV1dDbl3hpqNQKWuZEMb5R
         U/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=DTBsovxgyhka0TtlrhsWY/9JG6dyNPcM3+AQrTpMTEE=;
        b=xG1gMnss/9QOwwf0yGNAUqCXuisJLgv49nu44X56gR0GfOeo0rOfYG6NiL+fcpaynb
         4k4EE4ODPZaLD1exYfANBa06Kg0zGkMc3OOnZrWFcIYe1aFRtUe+en8wn/wBxKyO7NwO
         2Volbpb+Ffci9kYtd/XBUdhxx/DiRfDqW7ow9+d/0QTaC7SHe384krsW06gV26ikYmUc
         gkWBpb7e3eaQ/olWM4KvUsOI6qOqj4E18WH5Y6Ovso1QyI19o5AoOMUemcJ2PZ+0tZfx
         piEVsNGxsea8tOf9ZXEsWN4I0h+cBkkmdxjICT/fkujekYMTcRnoBPUKRO3na9BHDP9i
         gWhg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=kdBDSJDA;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.83 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=kdBDSJDA;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.83 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w1K9XC1e016412
X-Nifty-SrcIP: [209.85.217.170]
MIME-Version: 1.0
In-Reply-To: <20180216214117.1947175-2-arnd@arndb.de>
References: <20180216214117.1947175-1-arnd@arndb.de> <20180216214117.1947175-2-arnd@arndb.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 20 Feb 2018 18:32:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNASG34OhzKbMLUdTU_hjcD4598m9k01cVEGPjTeJO5YLgA@mail.gmail.com>
Message-ID: <CAK7LNASG34OhzKbMLUdTU_hjcD4598m9k01cVEGPjTeJO5YLgA@mail.gmail.com>
Subject: Re: [PATCH 1/3] Kconfig: disable PROFILE_ALL_BRANCHES for compile testing
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "Yann E . MORIN" <yann.morin.1998@free.fr>,
        Michal Marek <mmarek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592595400950841912?=
X-GMAIL-MSGID: =?utf-8?q?1592911957851075936?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-17 6:41 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> This can easily double the time for compiling a driver but does not
> provide any benefit for the compile tester, so it's better left disabled.
>
> In addition, any 'inline' function that is not also 'static' and that
> contains an 'if' causes a warning like
>
> include/linux/string.h:212:2: note: in expansion of macro 'if'
>   if (strscpy(p, q, p_size < q_size ? p_size : q_size) < 0)
>   ^~
> include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'strcpy' which is not static
>
> without this patch, and I could not come up with a nice fix for that.
> In combination with my patch to always enable 'CONFIG_COMPILE_TEST'
> during 'randconfig' builds, we can at least hide these warnings for
> most users.
>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


I took a look at this just in case
because the subject is prefixed with "Kconfig:",
but it is actually "trace:".

I expect "Kconfig:" for core changes of Kconfig.

Using precise patch prefix would get more attention from
right people.




> ---
>  kernel/trace/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 434c840e2d82..faaf687b13b1 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -345,6 +345,7 @@ config PROFILE_ANNOTATED_BRANCHES
>  config PROFILE_ALL_BRANCHES
>         bool "Profile all if conditionals"
>         select TRACE_BRANCH_PROFILING
> +       depends on !COMPILE_TEST
>         help
>           This tracer profiles all branch conditions. Every if ()
>           taken in the kernel is recorded whether it hit or miss.
> --
> 2.9.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
