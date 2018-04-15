Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeDOHlK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 03:41:10 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:39017 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbeDOHlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 03:41:08 -0400
X-Google-Smtp-Source: AIpwx487WDo8VvDOirJy3W0JTJ6CJdBn3A4zdtZJKwChjMQAELDpsV6GwSZoZRM+mQS2yK932pOLcOn2r0PvII33/FM=
MIME-Version: 1.0
In-Reply-To: <1523595999-27433-21-git-send-email-yamada.masahiro@socionext.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com> <1523595999-27433-21-git-send-email-yamada.masahiro@socionext.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Sun, 15 Apr 2018 09:41:07 +0200
Message-ID: <CAFkk2KRTan6BLJEtLaa+6eFhTEQOJqDkQaKpKtVwd8iCvLuFMw@mail.gmail.com>
Subject: Re: [PATCH 20/30] kconfig: add basic helper macros to scripts/Kconfig.include
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Nicholas Piggin <npiggin@gmail.com>,
        Kees Cook <keescook@chromium.org>, Emese Revfy <re.emese@gmail.com>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 7:06 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Kconfig got text processing tools like we see in Make.  Add Kconfig
> helper macros to scripts/Kconfig.include like we collect Makefile
> macros in scripts/Kbuild.include.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---
>
> Changes in v3:
>   - Move helpers to scripts/Kconfig.include
>
> Changes in v2: None
>
>  Kconfig                 |  2 ++
>  MAINTAINERS             |  1 +
>  scripts/Kconfig.include | 17 +++++++++++++++++
>  3 files changed, 20 insertions(+)
>  create mode 100644 scripts/Kconfig.include
>
> diff --git a/Kconfig b/Kconfig
> index 5b55d87..a90d9f9 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -7,4 +7,6 @@ mainmenu "Linux/$(ARCH) $(KERNELVERSION) Kernel Configuration"
>
>  comment "Compiler: $(CC_VERSION_TEXT)"
>
> +source "scripts/Kconfig.include"
> +
>  source "arch/$(SRCARCH)/Kconfig"
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b9dab38..d962f4a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7624,6 +7624,7 @@ L:        linux-kbuild@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/kbuild/kconfig*
>  F:     scripts/kconfig/
> +F:     scripts/Kconfig.include
>
>  KDUMP
>  M:     Dave Young <dyoung@redhat.com>
> diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
> new file mode 100644
> index 0000000..cac7a81
> --- /dev/null
> +++ b/scripts/Kconfig.include
> @@ -0,0 +1,17 @@
> +# Kconfig helper macros
> +
> +# Convenient variables
> +comma   := ,
> +quote   := "
> +squote  := '
> +empty   :=
> +space   := $(empty) $(empty)
> +
> +# y if the command exits with 0, n otherwise
> +success = $(shell ($(1)) >/dev/null 2>&1 && echo y || echo n)

'{ $(1); }' might work here, to avoid the extra subshell.

Shaves 20-30% off the runtime here in a silly
system("(true) >/dev/null 2>&1 && echo y || echo n") vs.
system("{ true; } >/dev/null 2>&1 && echo y || echo n")
comparison.

> +
> +# y if the given compiler flag is supported, n otherwise
> +cc-option = $(success $(CC) -Werror $(1) -c -x c /dev/null -o /dev/null)
> +
> +# y if the given linker flag is supported, n otherwise
> +ld-option = $(success $(LD) -v $(1))
> --
> 2.7.4
>

Cheers,
Ulf
