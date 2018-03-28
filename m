Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522238020; cv=none;
        d=google.com; s=arc-20160816;
        b=SR8n+88Rnhw55FFibA8hbvGadKJ2jFveHybt97ahU8M/ELaKNdg9gRpdLtIIVu2ma+
         nQ1xR+eeuMDJFxIeQ2nUSojd5fsIsj+gSzNU+w1vSgm51SAyVmIDSQsyqDjc6R0Rd9UY
         xHF6KF+ElTzwJTf75ivp1iWTrXIvQT4Yd1fkARitGEwpn2EujCa3kk/UtActty2SXJzE
         locD2YYwqVk9TUFeUs//epy+6b1vZq10++CREh2QjeThCHy+8W7KgLhTbSVC1+Ss5rZR
         CcdRgcmreo0k1eosMt/C1udyvLmDeFel7EAyY2RBdX9n4aR3G8mU5TwIo79ws3Gyj2gc
         LhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=neTLX9TJ3Y/23DwulWJd/uhd3H8p1pj3OCcfcaUpExg=;
        b=ubQ6ndHSfaQeoo8Yp6j88PcVPfxmCAs+SH8nGSfV8MUUFMI2KVFecaaDrwmzNSvGTY
         l1WJ7j2WecfqyPbvEoNMMQmEgydPp1bmzdlVx8F/JowzpVXEHxLjWEVwP/zBZ/h3HEsc
         ORvIRmOyvgrEMCAk/vrhDpiDTH07lXChSR68THnZHaMoBN9LDMzbTHc9nQ/DLQdnmhzl
         xbaXThvyihMBH+lBdtxYRlnWsSBkW95aszM9NNObKcG7zLyWpZBiAywQHommvBjMfUlz
         VWWACk2i5BWD1bGG1wnK5WkCw3893IVjpzg7FRac3vIr0WASIu8C7x5fBUc9bhzWg+uj
         eWYw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=fdF4iPNj;
       dkim=pass header.i=@chromium.org header.s=google header.b=WE6HLXiD;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=fdF4iPNj;
       dkim=pass header.i=@chromium.org header.s=google header.b=WE6HLXiD;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx48tW9LS/d/Wu6+N5Zokp3qhuKxLY2zO3+QTPjeWwFifxWqPGy9lwMzr/TMhahC2kV8ZIogPlk14GW+cpyv6d0c=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1522128575-5326-17-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com> <1522128575-5326-17-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 28 Mar 2018 04:53:39 -0700
X-Google-Sender-Auth: UN2Fizw7S_FS-yJUyHYrTOlzgqQ
Message-ID: <CAGXu5jKXtGgyP8zh0Gg1k-U=A4KYEuyPsxiXxtFeaNJPn+metg@mail.gmail.com>
Subject: Re: [PATCH v2 16/21] kcov: imply GCC_PLUGINS and GCC_PLUGIN_SANCOV
 instead of select'ing them
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Ulf Magnusson <ulfalizer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067544988572436?=
X-GMAIL-MSGID: =?utf-8?q?1596182255155852087?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> As Documentation/kbuild/kconfig-language.txt notes, 'select' should be
> used with care - it forces a lower limit of another symbol, ignoring
> the dependency.  In this case, KCOV can select GCC_PLUGINS even if
> 'depends on HAVE_GCC_PLUGINS' is unmet.
>
> 'imply' is modest enough to observe the dependency, and this makes
> sense.  If you enable KCOV, you will probably want to enable
> GCC_PLUGIN_SANCOV, but it should not break the dependency.
>
> I also remove unneeded code, I just happened to notice.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>   - Drop depends on GCC_VERSION
>
> ---
>
> Changes in v2: None
>
>  lib/Kconfig.debug | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 5be22e4..8243c9d 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -743,8 +743,8 @@ config KCOV
>         bool "Code coverage for fuzzing"
>         depends on ARCH_HAS_KCOV
>         select DEBUG_FS
> -       select GCC_PLUGINS if !COMPILE_TEST
> -       select GCC_PLUGIN_SANCOV if !COMPILE_TEST
> +       imply GCC_PLUGINS
> +       imply GCC_PLUGIN_SANCOV
>         help
>           KCOV exposes kernel code coverage information in a form suitable
>           for coverage-guided fuzzing (randomized testing).

Actually, I think this can be improved, as KCOV should depend on either:

-fsanitize-coverage=trace-pc support (in gcc 6+, see scripts/Makefile.kcov)

or

GCC_PLUGIN_SANCOV (which provides the trace-pc support via the plugin
for gcc before 6)

> @@ -758,7 +758,6 @@ config KCOV
>  config KCOV_ENABLE_COMPARISONS
>         bool "Enable comparison operands collection by KCOV"
>         depends on KCOV
> -       default n
>         help
>           KCOV also exposes operands of every comparison in the instrumented
>           code along with operand sizes and PCs of the comparison instructions.

Similarly, this depends on -fsanitize-coverage=trace-cmp

> @@ -768,7 +767,7 @@ config KCOV_ENABLE_COMPARISONS
>  config KCOV_INSTRUMENT_ALL
>         bool "Instrument all code by default"
>         depends on KCOV
> -       default y if KCOV
> +       default y
>         help
>           If you are doing generic system call fuzzing (like e.g. syzkaller),
>           then you will want to instrument the whole kernel and you should
> --
> 2.7.4
>

-Kees

-- 
Kees Cook
Pixel Security
