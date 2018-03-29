Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522291363; cv=none;
        d=google.com; s=arc-20160816;
        b=AWe294Ij1MmrmiD7fLf1lSi++6QZajgeBEHBnTcEI8msZPw2+gch51atTQ5+H/lASf
         RP+BF4dLy2FWX5ha8Oj5+sdZ55jxQaqIHCI3184lg8NQx3Zyu+VEUByJ1r6Z6arX928s
         5BWGK9GldewPxky/ucsmWodCTxuchIWTnKJnYvt/+XvkPtobH7uXKWlJ/eXNnVmsm+iT
         b9f4F2zzcEbFRlur/lxXf1UOrjHtbl9mb4oD9uZLjH/dV7hvTWxeND5JLwanJpiDst92
         2oM3xHDpaXx7eLoN2azM/bAl0O4FBegJqsMp117BKXvn5qRdSniO02hYUdPBQ4yy52tr
         k99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=1qtvs/spKjdZyIHnqRMR0TbQlPPIlx4KyxUwXwcqHP0=;
        b=NtS8m5VBygJCMpys6OBVAu8g2OZo+jieoai38ctFaxC0fpog5o7l0FO6Vd1o55i9jJ
         lCrIWUaiDPId9iXDqp3wqbULq6UJkl6mJciJsvHkEna9Fb+XsDAqbvCdJ+pVTfUlEmwx
         7qdTQeOnmDOzIG+mqzoFrOUGPoPMu5BnXfcVw/2FKDRZywcwJL7CYw7W4ePDel7F5zWa
         hxUXkmpo3wBz/BOxtz3gDCZ8OpT1SRFWqbjMtUHuqOJrPv+/G5AeN6CtUl2y+v5nDRC2
         LbZMweF5kT1tj3Kuzee2q0Z8DcElnVtubgJBzPEK0HeH3Zno1ZT2iS/JQT+hMSwFgYxd
         jBwA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IOFgozOf;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IOFgozOf;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48bDh7+8KXqmEo6unpAXfEn+xZe95hXzfw97WmXb4es/dwHDsRe+jRnSMxSoTOWsnBRWH5BrOqfYomGq+p3AZ8=
MIME-Version: 1.0
In-Reply-To: <1522128575-5326-8-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com> <1522128575-5326-8-git-send-email-yamada.masahiro@socionext.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Thu, 29 Mar 2018 04:42:42 +0200
Message-ID: <CAFkk2KQjBO=ck6i-L2h2XWehQrJotbzPv66JH+stZ7Q6M5YXTw@mail.gmail.com>
Subject: Re: [PATCH v2 07/21] kconfig: add function support and implement
 'shell' function
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067538101341662?=
X-GMAIL-MSGID: =?utf-8?q?1596238188867927004?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 7:29 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> This commit adds a new concept 'function' to do more text processing
> in Kconfig.
>
> A function call looks like this:
>
>   $(function arg1, arg2, arg3, ...)
>
> (Actually, this syntax was inspired by make.)
>
> Real examples will look like this:
>
>   $(shell echo hello world)
>   $(cc-option -fstackprotector)
>
> This commit adds the basic infrastructure to add, delete, evaluate
> functions, and also the first built-in function $(shell ...).  This
> accepts a single command to execute.  It returns the standard output
> from it.
>
> [Example code]
>
>   config HELLO
>           string
>           default "$(shell echo hello world)"
>
>   config Y
>           def_bool $(shell echo y)
>
> [Result]
>
>   $ make -s alldefconfig && tail -n 2 .config
>   CONFIG_HELLO="hello world"
>   CONFIG_Y=y
>
> Caveat:
> Like environments, functions are expanded in the lexer.  You cannot
> pass symbols to function arguments.  This is a limitation to simplify
> the implementation.  I want to avoid the dynamic function evaluation,
> which would introduce much more complexity.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Reminder for myself:
> Update Documentation/kbuild/kconfig-language.txt
>
>
> Changes in v2:
>   - Use 'shell' for getting stdout from the comment.
>     It was 'shell-stdout' in the previous version.
>   - Symplify the implementation since the expansion has been moved to
>     lexer.
>
>  scripts/kconfig/function.c  | 170 ++++++++++++++++++++++++++++++++++++++++++++
>  scripts/kconfig/lkc_proto.h |   5 ++
>  scripts/kconfig/util.c      |  46 +++++++++---
>  scripts/kconfig/zconf.y     |   9 +++
>  4 files changed, 222 insertions(+), 8 deletions(-)
>  create mode 100644 scripts/kconfig/function.c
>

The gotcha from 04/21 ("kconfig: reference environments directly and
remove 'option env=' syntax") applies here too. For example, the
following will work:

    config A
        bool "A"
        default $(shell echo "B && C")

Some people might argue that that's a feature (I sense a mess down the
road if people start depending on it), but just in case you hadn't
thought of it.

Similarly, the following will only work as expected if 'cmd' outputs
the name of an undefined Kconfig symbol:

    config A
        string
        default $(shell cmd)

You could argue that people should add quotes there though (though
that's broken at the moment if the output from 'cmd' includes a
quote).

Quotes in Kconfig speak just mean "constant value". Problem is it's
undocumented, and no one would intuitively expect it.

Cheers,
Ulf
