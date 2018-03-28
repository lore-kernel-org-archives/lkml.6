Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522208035; cv=none;
        d=google.com; s=arc-20160816;
        b=bdZeDl3PGn0AVeY/ubHwEHH9rlRgMwuoUzHSRORaWsC5l00xQ508XtPhwoX84rGfLB
         gHo+gM+EOHhKDbXIMutXAMECwkrFj8F0qetsI/ZFNFVkN/p+REu1U3qnwhnZRyD/W1zh
         DmV/qprKopp4BU9BO0CYK3Wqwv2RPjCDXQ1lyGqw3vUfBdNjX/hCD44DnC/6tjJC/JR3
         e1OEvXB6vAH6K3ms5fR6nooRtC5qGOGN1pEgAAWpXcHsR0fDgDCJKOgEg5auexoSvFfN
         pBvbdtlqWups0Wn24iwKbL+YiLpnOS44mQgLVa8Qenrs4T/TAQwf1KYP4AQioVFn5zyz
         lCrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=R53ac+YG9eGsavk1O/uXCKuTO10ROlgzoAzMiev7iGU=;
        b=XYLc1BbDZ3FXLGCrVnodC3qaXveillV1Xj9AWWrn71tS885tF6VIs4sWBzHFwkakIz
         tjs8X1rRyNtNeslQQRsUY+EeUO6lmgjWZSAezmfP8AEvgUD2yuLIZu6dA/kqUmu1FDy+
         vegp54QPQg+9CQqXSPR1BbrqnaWa6he1sz48RSIqzQbNGkpa4lOjTH2pChamM+btmKhD
         2irFNNfwNWakK97rXAG2dfqoBg4fxgE3ylm0So93vmuS77NOuK/sqIytpnSR1anl8dSD
         REOGMDycIELl8QHXN+Ik9WTbtTxa+1K8gLWQJw0tLB7Sx0qsRuPrP4+qCFZlpnm2mdFi
         fitg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=NhFdrqSV;
       dkim=pass header.i=@chromium.org header.s=google header.b=ZMR1amzH;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=NhFdrqSV;
       dkim=pass header.i=@chromium.org header.s=google header.b=ZMR1amzH;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx4/C4lZU6PJz3bpcdmvv+T06fLPM+jqAsFJtRP8ra0ziKU3B74i2Ca6fzdR9EyE8bdscwgOEa1gsr88+HE9EU9g=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1522128575-5326-5-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com> <1522128575-5326-5-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Mar 2018 20:33:54 -0700
X-Google-Sender-Auth: rQHAEFjisRRFl5M-Oc5QNib_6No
Message-ID: <CAGXu5jJRQfBWQ7Mx+dp_sMYiaLUs=yCVMKz0220aTNRdsZk3nQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/21] kconfig: reference environments directly and
 remove 'option env=' syntax
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Ulf Magnusson <ulfalizer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>, LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067538224428128?=
X-GMAIL-MSGID: =?utf-8?q?1596150813056328350?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> To get an environment value, Kconfig needs to define a symbol using
> "option env=" syntax.  It is tedious to add a config entry for each
> environment given that we need more environments such as 'CC', 'AS',
> 'srctree' etc. to evaluate the compiler capability in Kconfig.
>
> Adding '$' to symbols is weird.  Kconfig can reference symbols directly
> like this:
>
>   config FOO
>           string
>           default BAR
>
> So, I want to use the following syntax to get environment 'BAR' from
> the system:
>
>   config FOO
>           string
>           default $BAR
>
> Looking at the code, the symbols prefixed with 'S' are expanded by:
>  - conf_expand_value()
>    This is used to expand 'arch/$ARCH/defconfig' and 'defconfig_list'
>  - expand_string_value()
>    This is used to expand strings in 'source' and 'mainmenu'
>
> All of them are fixed values independent of user configuration.  So,
> this kind of syntax should be moved to simply take the environment.
>
> This change makes the code much cleaner.  The bounce symbols 'SRCARCH',
> 'ARCH', 'SUBARCH', 'KERNELVERSION' are gone.
>
> sym_init() hard-coding 'UNAME_RELEASE' is also gone.  'UNAME_RELEASE'
> should be be given from the environment.
>
> ARCH_DEFCONFIG is a normal symbol, so it should be simply referenced
> by 'default ARCH_DEFCONFIG'.
>
> The environments are expanding in the lexer; when '$' is encountered,
> it is expanded, and resulted strings are pushed back to the input
> stream.  This makes the implementation simpler.
>
> For example, the following code works.
>
> [Example code]
>
>   config TOOLCHAIN_LIST
>           string
>           default "My tools: CC=$CC, AS=$AS, CPP=$CPP"
>
> [Result]
>
>   $ make -s alldefconfig && tail -n 1 .config
>   CONFIG_TOOLCHAIN_LIST="My tools: CC=gcc, AS=as, CPP=gcc -E"
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

For easier review this patch could maybe get split into a couple (i.e.
refactoring of things like env_write_dep()) but it's probably fine
as-is. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
