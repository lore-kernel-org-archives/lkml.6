Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522207715; cv=none;
        d=google.com; s=arc-20160816;
        b=yINPzx7RzNyNxKtw39mkBMe2RfP7SuW0YFmegwZ+HWXePL2+zG41KHNAXKYcXL4/q7
         T3yCF9CstA+VqxJkdGFYA4zqX6byjsmiIuLqLA2+XruiMv9AoLcho3LDV5jp3Rh8s8ye
         Kr9JiNxlPWhyrDJJiibqjqVeiAJ9ib95qJ3kO7Ekzt0Cmp4ftkX8D7qfx7wU3DWpYkTZ
         zM/0/PbjgUpa6iGnukJwBkcKsYYpTEKHtwb8DTJF+xm/TId+LNb4DRR9Vwgm2TSQUY3w
         5aB9Z8nd0RHyctqqDdg3oMGGooTf7pc+81bgD+uGvbHkSz4EiTkdi7NwRX+9VQKB4HX7
         5epA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=DrZZ/fIH3rLIhcB8YhMt9P61hvG+gGp24bPujcrCFjI=;
        b=KeHZEMGe8UXdx6NEDqnKet2U09TEb1cIAwTX3TyoRI2altioTyfn7+/GlT1q8d1O7o
         Lg1PPYhTX3nF76jVHUbFW9L66LgB0pgKrbN8hfRw2n1qDBxaKzIlL6eN41iwj7k+JV/H
         p6QLgrvx3QGCpqNoD1Ywn7x/CHfNDHxwIwy+c+mkZa+wVGgF83r7SH+pgpuSKhFMx2n/
         j46u08PRLyMwFpYODWoEeg33ea7cJVpKmdwbLY3YRglw2EYuR9FS2jfLhl3I0GC4+G8b
         IaFKJGx5A8I1S6qeVhYZTDKnAvMZYXNfbQ25Bfd+eFpLQy6gbHgIxWDtgWo4g2wPdUcl
         uK+g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Ljj1ncpL;
       dkim=pass header.i=@chromium.org header.s=google header.b=OVyR2jU3;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Ljj1ncpL;
       dkim=pass header.i=@chromium.org header.s=google header.b=OVyR2jU3;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx493K1lb+wzz8zpH8w41FUaOToxxZZPHRprSghA51QLnVKoWwaxw038nkH/lATtXRpAgbKVTMMUM8HzGY5FKp3Q=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1522128575-5326-3-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com> <1522128575-5326-3-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Mar 2018 20:28:34 -0700
X-Google-Sender-Auth: 1IBWeZlPWLq3YmuI7BoEqOUj3N4
Message-ID: <CAGXu5jLYVspSAYHpATmND8HpYY+2+y_U7vrhGsjMcZQ-WRMpbg@mail.gmail.com>
Subject: Re: [PATCH v2 02/21] kbuild: remove CONFIG_CROSS_COMPILE support
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Ulf Magnusson <ulfalizer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067537535425960?=
X-GMAIL-MSGID: =?utf-8?q?1596150478307798431?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Kbuild provides a couple of ways to specify CROSS_COMPILE:
>
> [1] Command line
> [2] Environment
> [3] arch/*/Makefile (only some architectures)
> [4] CONFIG_CROSS_COMPILE
>
> [4] is problematic for the compiler capability tests in Kconfig.
> CONFIG_CROSS_COMPILE allows users to change the compiler prefix from
> 'make menuconfig', etc.  It means, the compiler options would have
> to be all re-calculated everytime CONFIG_CROSS_COMPILE is changed.
>
> To avoid complexity and performance issues, I'd like to evaluate
> the shell commands statically, i.e. only parsing Kconfig files.
>
> I guess the majority is [1] or [2].  Currently, there are only
> 4 defconfig files that specify CONFIG_CROSS_COMPILE.
>   arch/arm/configs/lpc18xx_defconfig
>   arch/hexagon/configs/comet_defconfig
>   arch/openrisc/configs/or1ksim_defconfig
>   arch/openrisc/configs/simple_smp_defconfig
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
