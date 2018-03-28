Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522208709; cv=none;
        d=google.com; s=arc-20160816;
        b=BfFBthdUbFJ3U/F+IfkCuheBYW8RziJlkI2F0pu1HxIDgg8lXc3Wz3nVtfYJU5ldUI
         0WpqQ6v+ZiNJG4Gzcpxjt5JzIaMNmheqJkjDDF9VZRN18Skut00vHNAiujpawU7RvgaY
         kiUDeaW6O4MR2VUp/0OGtBBD1gXKso+qXndcVVaty/+udQJ71mSpSrvP3IOFir/cW9Oa
         VVpqx2RaxU06fQEk8gVQ32AVfqKv2iJHDDJjlE06tqzFp1mbPFirNkhi9zMP63EpMzHY
         FL1xt3aLammAbRJ/UyNpVNp9efoVUzFKbmLceoK1hzF2lt9hzatl63wulCK92GXlBc6P
         9iiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=jGY+BEZSL6KAYqWFkRcpOrc871Fc42fDs2OAwCP0xIA=;
        b=glUNzsODwPYOEVN60KHTDb64yGbGXP6EWBqOdUmSYvEeBf78UhEgz+YCTl55gGT19c
         CVGaQ9xZbzvgOUf5tFaKgxTx9cn8JOFYz6giQxQrq17j5hCvzNbauHDpogIziPIsyswr
         r2LqHE6bLTJD4DaTAiyj8Z8S5HXUaSHWUBMEd9UwOaOJzdzTkidsWrt2TGgtyJEm7eoz
         8B782CfHtWb/FacWdk6BUOLmFc4dbAbNZf3t1eX8Z4QMxdOULACw2bwxIKL9kpaqkHN3
         mu8eTQVkxWT5gkOpjNDQVnHZOkSEkASa/cgEGVIJdh/RsjpiDVBDCQTS6PyJdwQWwOfA
         Xw2g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=CkYoWXqR;
       dkim=pass header.i=@chromium.org header.s=google header.b=VzoVqWRR;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=CkYoWXqR;
       dkim=pass header.i=@chromium.org header.s=google header.b=VzoVqWRR;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx4/4xiAnWvXMAXqEq21IJ+Cde0pvn5fU0mgdT42oQpPpJBBrXHbAl814DJZNJr9LP4tKBI3/JG9z/wJLXfCqQ5k=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1522128575-5326-10-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com> <1522128575-5326-10-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Mar 2018 20:45:08 -0700
X-Google-Sender-Auth: DIvAiYJa0u2d8zZw-7evGhhVkXA
Message-ID: <CAGXu5jJkqgAYexAq27fK75cLRaWaHwac9oTMWqgqbDVZxApVFA@mail.gmail.com>
Subject: Re: [PATCH v2 09/21] kconfig: add 'macro' keyword to support
 user-defined function
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Ulf Magnusson <ulfalizer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067537988116489?=
X-GMAIL-MSGID: =?utf-8?q?1596151520181338292?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Now, we got a basic ability to test compiler capability in Kconfig.
>
> config CC_HAS_STACKPROTECTOR
>         def_bool $(shell (($CC -Werror -fstack-protector -c -x c /dev/null -o /dev/null) && echo y) || echo n)
>
> This works, but it is ugly to repeat this long boilerplate.
>
> We want to describe like this:
>
> config CC_HAS_STACKPROTECTOR
>         bool
>         default $(cc-option -fstack-protector)
>
> It is straight-forward to add a new function, but I do not like to
> hard-code specialized functions like this.  Hence, here is another
> feature to add functions from Kconfig files.
>
> A user-defined function is defined with a special keyword 'macro'.
> It can be referenced in the same way as built-in functions.  This
> feature was also inspired by Makefile where user-defined functions
> are referenced by $(call func-name, args...), but I omitted the 'call'
> to makes it shorter.
>
> The macro definition can contain $(1), $(2), ... which will be replaced
> with arguments from the caller.  The macro works just as a textual
> shorthand, which is also expanded in the lexer phase.
>
> [Example Code]
>
>   macro success $(shell ($(1) && echo y) || echo n)
>
>   config TRUE
>           bool "true"
>           default $(success true)
>
>   config FALSE
>           bool "false"
>           default $(success false)
>
> [Result]
>
>   $ make -s alldefconfig
>   $ tail -n 2 .config
>   CONFIG_TRUE=y
>   # CONFIG_FALSE is not set
>
> [Example Code]
>
>   macro success $(shell ($(1) && echo y) || echo n)
>
>   macro cc-option $(success $CC -Werror $(1) -c -x c /dev/null -o /dev/null)
>
>   config CC_HAS_STACKPROTECTOR
>           def_bool $(cc-option -fstack-protector)
>
> [Result]
>   $ make -s alldefconfig
>   $ tail -n 1 .config
>   CONFIG_CC_HAS_STACKPROTECTOR=y
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Cool, I like this "macro" idea for keeping this clean.

> ---
>
> Reminder for myself:
> Update Documentation/kbuild/kconfig-language.txt

Yes please. :)

Otherwise, looks good!

-Kees

-- 
Kees Cook
Pixel Security
