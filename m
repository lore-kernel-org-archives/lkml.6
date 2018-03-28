Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522208479; cv=none;
        d=google.com; s=arc-20160816;
        b=WQXtaPc3ZsswoBb3HHVnSpM6S2UGdBdxskbq44rXcXIFtv8c1+EKyktEvtdi/FOJ8f
         H7eFL4U6HxxuaTTe2TlMxIDWzrVIZotS0Dfv7pH3HpPYLwNS4S8kXb2JiUZ/oLweZxWZ
         tRpH5Z6Gmj/0qyny7E2FBk38ms7Mug0mPTizU6ip9C4JMgHtbXPYqCzYMkbMw8KM5Yj4
         XzeAwpumqviv7U1j+HwEaqWLt1V+5xMHdMg9j3jRBYJe0ifp+SyS9Bukpjf3O+1LqZ2H
         H6DxxDu6TousvnbZsPh0CzVqCJotdglV3QH922SqJ+MqGiw6Bp0lS3/LNeYEi+eA53KL
         JOVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=/IJKYrUhR5ieU9b/mUouTnAYyuyTb3PLEXpEDNy3dS8=;
        b=m1Xf09xeinrBwEjASWNno7y6C4IS3zOQE8iKX1n9KmwFK9G/S9h8YbOb2rhWZhlNOs
         AfSWzKVlvOUcUqtfFMACRqy/XkXGDjxvZTSTW3hJ2oFVaIlNyXOeYZFjkLVZ50s6yEb9
         JmH5WDLpxT0Y01Nygjnm9XKQknPYdEmgPaX0+gOGfDeCckJWC8/Wn/7dOfUhq73i9qx9
         +HGOAlgT9Hg4EzuT+UJSUrDjLB9CQBB1tmUDR2zyEd+MsZQuNmlafpLVbvXZ5ZQ2t9Ly
         e8DsyVjEjD93o8XfUi5468EmmZA0IAOOFeQU28WVH82Mt753S7xZSLPqRFq4yzkrdiAK
         kOjg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=mA4vd0Br;
       dkim=pass header.i=@chromium.org header.s=google header.b=EJNV75DS;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=mA4vd0Br;
       dkim=pass header.i=@chromium.org header.s=google header.b=EJNV75DS;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx4+rQuZk4izIXY5hfEWALfNed+joKtPVmDK+1p+OEdO5x4o72YYaYqXwD6POh0F+Zw6CtzBByulVzZlr4nSEvDU=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1522128575-5326-8-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com> <1522128575-5326-8-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Mar 2018 20:41:18 -0700
X-Google-Sender-Auth: me81P8u1bJj0BB1Z15TtSsMFuOQ
Message-ID: <CAGXu5jKmnO3o4dwWXrizKCeVpj3RCzw_zsHPseZrLXAgGb0YdQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/21] kconfig: add function support and implement
 'shell' function
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Ulf Magnusson <ulfalizer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067538101341662?=
X-GMAIL-MSGID: =?utf-8?q?1596151279134059135?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
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

Yeah, this needs to be included here, especially given the "cannot
pass symbols" aspect which might surprise people.

> [...]
> +/* built-in functions */
> +static char *do_shell(struct function *f, int argc, char *argv[])
> +{
> +       static const char *pre = "(";
> +       static const char *post = ") 2>/dev/null";

Right now the search and help screens in menuconfig just show the line
a config is defined and nothing more. I think it would be extremely
handy to include shell output here in some way. Especially when trying
to answer questions like "why aren't GCC plugins available?" it's got
quite a bit harder to debug.

Could we capture the output (especially stderr) for these kinds of hints?

Beyond that, looks good!

-Kees

-- 
Kees Cook
Pixel Security
