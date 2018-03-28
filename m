Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522206630; cv=none;
        d=google.com; s=arc-20160816;
        b=kJ3eZH+sfnfkiJIqzVlzGL/e4UeqO58ELDn6h08SMAcRzGehUYYk+ah9yrjlTK3RN9
         ZIPFA3VhgM79tQkaVX5yFH6JRhmy8PD+VgfeLpk1o6B3eqQUTcQZDI/961k1ZgWIOtLV
         Vwigan2bam5MXQ5ERWD3XM59cKxdROllVR3J4msag7NPzkP5fQZP9FvwmVwjcfwN48pg
         up8Cl1XrkCiV5EOQSHBM2nXlz1ZZ2GOD+SbqI65ePKUm+LEQt7nRYn3eYUQ8+ym4Swcf
         v4XJF7FkAIgcOatvBkuNumtTuwbnChnna2sjyHp6YwPOIpeYHPMs2gJ1MewGXx2gkFLs
         +DXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=v6+eliD2JUFFpSank8sNssQALSkxqHw6V95yc42/7zg=;
        b=sNAVV0jOW93K7RTbpPF5UGFWckf52OTZD0yQtg9av3TnTj49uSsmWOh3JuPwN4zKHY
         ZNqn7IYjM2OaPcyCjidUeIv84klXNNn4h6TzBeCH3utDyu7pmzu7uVIgPKX0UFuM9/yu
         rOO4QyNwg+c8Q/i6rcxnJA9bGpV0oDQNirApNkkHGzvretmm+KJvfzBmnDuQ7gNg8fdH
         8u5FV+QdZyrXD3fuinUWTtKCe0UUaLzz7Nfi7i+EG2Zz9uocAGLoF8UGa+hG0321EZrM
         wqhfNrJJDvdTWM0ZxNQ9xYg0inmHYvyI9ircIU3DUqDecv+7Im+9CT37D/lJnj3Ns2i4
         BSqg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=llExPhVJ;
       dkim=pass header.i=@chromium.org header.s=google header.b=LnKA9q0q;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=llExPhVJ;
       dkim=pass header.i=@chromium.org header.s=google header.b=LnKA9q0q;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx49OK4FF4TTRl4AkiW+CXUYWSmIH2KvWcF16CE23ZUbs2F7U8b/VbsNHNyu8er0ZaxuXwLe63cafz0HpDc0CCwA=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1522204848-11803-1-git-send-email-yamada.masahiro@socionext.com>
References: <1522204848-11803-1-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Mar 2018 20:10:28 -0700
X-Google-Sender-Auth: 7fFVj_mZeenwa-55HTUbipFkQOo
Message-ID: <CAGXu5jJMEG6WZo8qEjGpFBkU7FkjyFbjf5diZqa8sz+XqCxHuQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: move <linux/compiler_types.h> out of <linux/kconfig.h>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>,
	Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
	Philippe Ombredanne <pombredanne@nexb.com>, Michal Marek <michal.lkml@markovi.net>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596147516031704256?=
X-GMAIL-MSGID: =?utf-8?q?1596149339266202161?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 7:40 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Since commit 28128c61e08e ("kconfig.h: Include compiler types to avoid
> missed struct attributes"), <linux/kconfig.h> pulls in kernel-space
> headers to unrelated file.
>
> Commit 0f9da844d877 ("MIPS: boot: Define __ASSEMBLY__ for its.S build")
> suppressed the build error by defining __ASSEMBLY__, but ITS (i.e. DTS)
> is not assembly, and should not include <linux/compiler_types.h> in the
> first place.
>
> Looking at arch/s390/tools/Makefile, host programs gen_facilities and
> gen_opcode_table now pull in <linux/compiler_types.h> as well.
>
> The motivation for that commit was to define necessary attributes
> before any struct is defined.  Obviously, this happens only in C.
>
> It is enough to include <linux/compiler_types.h> only when compiling
> C files, and only when compiling kernel space.
>
> Move the <linux/compiler_types.h> inclusion to c_flags.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> I will also send a correct fix-up for MIPS Makefile later.

As long as the result is the same: it's impossible to define a
structure without defined attributes, I'm fine with it. :)

Question below...

>
>
>
>  include/linux/kconfig.h | 3 ---
>  scripts/Makefile.lib    | 1 +
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
> index dcde947..cc8fa10 100644
> --- a/include/linux/kconfig.h
> +++ b/include/linux/kconfig.h
> @@ -70,7 +70,4 @@
>   */
>  #define IS_ENABLED(option) __or(IS_BUILTIN(option), IS_MODULE(option))
>
> -/* Make sure we always have all types and struct attributes defined. */
> -#include <linux/compiler_types.h>
> -
>  #endif /* __LINUX_KCONFIG_H */
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index c114ce5..07d0740 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -152,6 +152,7 @@ __cpp_flags     = $(call flags,_cpp_flags)
>  endif
>
>  c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
> +                -include $(srctree)/include/linux/compiler_types.h       \

Why here instead of adding it to LINUXINCLUDE ?

>                  $(__c_flags) $(modkern_cflags)                           \
>                  $(basename_flags) $(modname_flags)
>
> --
> 2.7.4
>

-Kees

-- 
Kees Cook
Pixel Security
