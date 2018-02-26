Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbeBZXXM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 18:23:12 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33803 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeBZXXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 18:23:10 -0500
X-Google-Smtp-Source: AH8x2245Ty23az9xv0R1hA/G9LPoJSzHTv90THCEIJPJh5kcv/Eo7W3OgTpuQRjFckBuknhwLTFCoB4+kwAi7UyztKM=
MIME-Version: 1.0
References: <1519361813-8553-1-git-send-email-yamada.masahiro@socionext.com> <1519361813-8553-2-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1519361813-8553-2-git-send-email-yamada.masahiro@socionext.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 26 Feb 2018 23:22:58 +0000
Message-ID: <CAKwvOdmnzvqnt7eBPSvED45QBnU=ivv3VQek1g6QYTyU-+c_RQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kbuild: simplify ld-option implementation
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, sam@ravnborg.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Mark Charlebois <charlebm@gmail.com>, forney@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nice! Now we don't need to invoke $CC to find out info about linker support.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

On Thu, Feb 22, 2018 at 8:57 PM Masahiro Yamada <
yamada.masahiro@socionext.com> wrote:

> Currently, linker options are tested by the coordination of $(CC) and
> $(LD) because LD needs some object to link.

> As commit 86a9df597cdd ("kbuild: fix linker feature test macros when
> cross compiling with Clang") addressed, we need to make sure $(CC)
> and $(LD) agree the underlying architecture of the passed object.

> This could be a bit complex when we combine tools from different groups.
> For example, we can use clang for $(CC), but we still need to rely on
> GCC toolchain for $(LD).

> So, I was searching a way for standalone testing of linker options.
> A trick I found is to use '-v'.  This prints the version string, but
> also tests if the given option is recognized.

> If a given option is supported,

>    $ aarch64-linux-gnu-ld -v --fix-cortex-a53-843419
>    GNU ld (Linaro_Binutils-2017.11) 2.28.2.20170706
>    $ echo $?
>    0

> If unsupported,

>    $ aarch64-linux-gnu-ld -v --fix-cortex-a53-843419
>    GNU ld (crosstool-NG linaro-1.13.1-4.7-2013.04-20130415 - Linaro GCC
> 2013.04) 2.23.1
>    aarch64-linux-gnu-ld: unrecognized option '--fix-cortex-a53-843419'
>    aarch64-linux-gnu-ld: use the --help option for usage information
>    $ echo $?
>    1

> Gold works likewise.

>    $ aarch64-linux-gnu-ld.gold -v --fix-cortex-a53-843419
>    GNU gold (Linaro_Binutils-2017.11 2.28.2.20170706) 1.14
>    masahiro@pug:~/ref/linux$ echo $?
>    0
>    $ aarch64-linux-gnu-ld.gold -v --fix-cortex-a53-999999
>    GNU gold (Linaro_Binutils-2017.11 2.28.2.20170706) 1.14
>    aarch64-linux-gnu-ld.gold: --fix-cortex-a53-999999: unknown option
>    aarch64-linux-gnu-ld.gold: use the --help option for usage information
>    $ echo $?
>    1

> LLD too.

>    $ ld.lld -v --gc-sections
>    LLD 7.0.0 (http://llvm.org/git/lld.git
> 4a0e4190e74cea19f8a8dc625ccaebdf8b5d1585) (compatible with GNU linkers)
>    $ echo $?
>    0
>    $ ld.lld -v --fix-cortex-a53-843419
>    LLD 7.0.0 (http://llvm.org/git/lld.git
> 4a0e4190e74cea19f8a8dc625ccaebdf8b5d1585) (compatible with GNU linkers)
>    $ echo $?
>    0
>    $ ld.lld -v --fix-cortex-a53-999999
>    ld.lld: error: unknown argument: --fix-cortex-a53-999999
>    LLD 7.0.0 (http://llvm.org/git/lld.git
> 4a0e4190e74cea19f8a8dc625ccaebdf8b5d1585) (compatible with GNU linkers)
>    $ echo $?
>    1

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

>   scripts/Kbuild.include | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index 34cbd81..f9c2f07 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -237,9 +237,7 @@ cc-ldoption = $(call try-run-cached,\

>   # ld-option
>   # Usage: LDFLAGS += $(call ld-option, -X)
> -ld-option = $(call try-run-cached,\
> -       $(CC) $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -x c /dev/null -c -o
> "$$TMPO"; \
> -       $(LD) $(LDFLAGS) $(1) "$$TMPO" -o "$$TMP",$(1),$(2))
> +ld-option = $(call try-run-cached, $(LD) $(LDFLAGS) $(1) -v,$(1),$(2))

>   # ar-option
>   # Usage: KBUILD_ARFLAGS := $(call ar-option,D)
> --
> 2.7.4



-- 
Thanks,
~Nick Desaulniers
