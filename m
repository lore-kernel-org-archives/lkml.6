Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522564102; cv=none;
        d=google.com; s=arc-20160816;
        b=LoLTmybRPHRDUYTKag3TBegU9qHr0LQfi3MqwVy+8BIDOdKvMbOAKSqYr+qMEi+jWr
         66MgktVlIXMRbm0EBnpeBvgZdYQWalDZQKdF5QYjeYvCn4TbqjGI+jdP/B5YNccLtFpc
         EDCUGw8BE8wXmF7EEP5tw2GxXEy6nXVb/R0KsOb/6JMJQnEm6asX3cmMxReuxZJIR8Cu
         3mrVD0ly2mqkRRYWbdATBYykV9720rN0iOhcZMKAYmUGutEJqxz/xp7A6Wx76xbuZz7l
         LQ29OhkrjKzifNuH3zHXfKqv011vxjpBA3UvCI5dybiUWG/WMhbC/xFzFqIsW/EFhohD
         agbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=0EtwHZEbNn654nEz4V5++0fYftXS+w/B6lpjlcKhzaU=;
        b=J9/cw+w9Uaegqx/02AYt4TDKyMuebmd3CPjJksbydqz4Dvbj+LAdfqT2byUzacu5qJ
         DwEsCQc2LPBhSSgPSpoqMEdJafvI9mZ9F4q2Wu664O92+WYQjqBnXz8W+CKWqNWvjC5e
         07lM5x4gyJaVyb1gk37tflcRK1meFjn8rDXV8rwz6kGEV4gOETLKctxw89cV1JhfsbMv
         sFHSMp84ygaaYGJrnOP8mk0H7Q5AAk51q25QE4ydQhXy1XhSHMopoaR99Jl4vlHYsDCK
         PVv3VyX1KCo/lX6J1+TK3lJXJahGP2Pyf8lBqlyh32mdRqaqhkLhYwIVDk8UFr7hW68q
         okFg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tVdLMqJJ;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tVdLMqJJ;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48jbhIeZyBgxsxAmwVVtz0bzLLQmXu9xvjryh4scHbF8BNNCmL4QyxC+QRIyCusokOhCplnM9EYcrTy+N06Rpc=
MIME-Version: 1.0
In-Reply-To: <1522128575-5326-11-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com> <1522128575-5326-11-git-send-email-yamada.masahiro@socionext.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Sun, 1 Apr 2018 08:28:21 +0200
Message-ID: <CAFkk2KRexq4Up1roVj_KY-ONohYbG2V8K0cm-jO-1ucCCVxv+A@mail.gmail.com>
Subject: Re: [PATCH v2 10/21] kconfig: add 'success' and 'cc-option' macros
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067537959344954?=
X-GMAIL-MSGID: =?utf-8?q?1596524176799259389?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 7:29 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 'cc-option' will be the most frequently used macro.  It evaluates to 'y'
> if the given argument is supported by the compiler, or 'n' otherwise.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2:
>   - Implement 'success' as a macro
>
>  init/Kconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 0d6fe20..c456030 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -8,6 +8,12 @@ config DEFCONFIG_LIST
>         default ARCH_DEFCONFIG
>         default "arch/$ARCH/defconfig"
>
> +# expanded to y if the command exits with 0, n otherwise
> +macro success $(shell ($(1) && echo y) || echo n)
> +
> +# expanded to y if the given compiler flag is supported, n otherwise
> +macro cc-option $(success $CC -Werror $(1) -c -x c /dev/null -o /dev/null)
> +
>  config CONSTRUCTORS
>         bool
>         depends on !UML
> --
> 2.7.4
>

Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>

Some other tests (e.g. scripts/*-stack-protector.sh) also pass -S and
-O0 and stuff to speed things up. Feels like that could lead to
gotchas though.

-S does help a bit at least:

    $ time gcc -c -x c /dev/null -o /dev/null
    real 0m0.020s
    user 0m0.013s
    sys 0m0.007s

    $ time gcc -S -x c /dev/null -o /dev/null
    real 0m0.012s
    user 0m0.009s
    sys 0m0.003s
