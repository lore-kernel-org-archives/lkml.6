Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbeEDOWm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:22:42 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:34925 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbeEDOWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:22:40 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w44EMWCk016220
X-Nifty-SrcIP: [209.85.213.51]
X-Google-Smtp-Source: AB8JxZqioFev/NWrt0LsE3BcEVF2XQA3qFzX20qccKgEvGiV5iOsYpR8VLfTEXEUnj2aFZy/0FI+VX7Hn/O2jcyTTjU=
MIME-Version: 1.0
In-Reply-To: <1523595999-27433-2-git-send-email-yamada.masahiro@socionext.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com> <1523595999-27433-2-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 4 May 2018 23:21:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNATV==PWHd2M63X+SMchRoTqtbnnSFSZM1bQnjCRfRrRKg@mail.gmail.com>
Message-ID: <CAK7LNATV==PWHd2M63X+SMchRoTqtbnnSFSZM1bQnjCRfRrRKg@mail.gmail.com>
Subject: Re: [PATCH 01/30] gcc-plugins: fix build condition of SANCOV plugin
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Emese Revfy <re.emese@gmail.com>,
        X86 ML <x86@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,


2018-04-13 14:06 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Since commit d677a4d60193 ("Makefile: support flag
> -fsanitizer-coverage=trace-cmp"), you miss to build the SANCOV
> plugin under some circumstances.
>
>   CONFIG_KCOV=y
>   CONFIG_KCOV_ENABLE_COMPARISONS=y
>   Your compiler does not support -fsanitize-coverage=trace-pc
>   Your compiler does not support -fsanitize-coverage=trace-cmp
>
> Under this condition, $(CFLAGS_KCOV) is not empty but contains a
> space, so the following ifeq-conditional is false.
>
>     ifeq ($(CFLAGS_KCOV),)
>
> Then, scripts/Makefile.gcc-plugins misses to add sancov_plugin.so to
> gcc-plugin-y while the SANCOV plugin is necessary as an alternative
> means.
>
> Fixes: d677a4d60193 ("Makefile: support flag -fsanitizer-coverage=trace-cmp")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


I am planning to queue this up to the fixes branch
since this is a bug fix.

Do you have any comment on this?





> Changes in v3:
>   - newly added
>
> Changes in v2: None
>
>  scripts/Makefile.gcc-plugins | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
> index b2a95af..7f5c862 100644
> --- a/scripts/Makefile.gcc-plugins
> +++ b/scripts/Makefile.gcc-plugins
> @@ -14,7 +14,7 @@ ifdef CONFIG_GCC_PLUGINS
>    endif
>
>    ifdef CONFIG_GCC_PLUGIN_SANCOV
> -    ifeq ($(CFLAGS_KCOV),)
> +    ifeq ($(strip $(CFLAGS_KCOV)),)
>        # It is needed because of the gcc-plugin.sh and gcc version checks.
>        gcc-plugin-$(CONFIG_GCC_PLUGIN_SANCOV)           += sancov_plugin.so
>
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
