Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F75C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E7A2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfAYK6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:58:39 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43387 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfAYK6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:58:39 -0500
Received: by mail-qk1-f193.google.com with SMTP id z18so5109140qkj.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 02:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QhMlnLD0pk6GIylS5p9law6MXy/6JZ38l1Eb/BKJuB4=;
        b=gN90EvGtab6FiNCB70inhtDgZT1fTKpfflYLTkM7zkjCPHjums9LrhpJK+OJ0Pgm4e
         dSxj2WRJ/TLjiEmSgooj2uxCVCzguKK3/wN8SUiySN212UrB1vXLMXLYPlNczl/InibR
         4+MGNTxAgMH/LSWb/ukkVmgd4ToTVvUlIVomLgnpKczsmpmUMtVTxdRRa0u7a1taUDbp
         TB+Xo52ibQ9tM0l8AKLOkHrTVNTSA1zrDsY/c1OcpX8WmsYc3/EAEeIuVxszenLw8vQs
         IFtHl9EHIkEgyQ3Ng08NUZ6tteXSn1ElNNysYkJb37lLT13VoTM/O/fyz3EFo2exdr/d
         nxKA==
X-Gm-Message-State: AJcUukfKlbrFSc89FNX+4QLu2/A2/l7NXS0TzR0f1PvjkRJ/42AYe3IM
        abrTcxcJOZN+vXB1aVbYqgsLvv2OTlO8x9/njOs=
X-Google-Smtp-Source: ALg8bN5uGZz2Fmrk/d6J0okEcyDnkLf2i9N4hm4eKWru+fDrDFu4XNErdL2BPKAsmoWn2Z4UDRjXhUmXQtltyTeXwCs=
X-Received: by 2002:ae9:e102:: with SMTP id g2mr8697888qkm.343.1548413917620;
 Fri, 25 Jan 2019 02:58:37 -0800 (PST)
MIME-Version: 1.0
References: <20190125104353.2791-1-labbott@redhat.com>
In-Reply-To: <20190125104353.2791-1-labbott@redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 25 Jan 2019 11:58:21 +0100
Message-ID: <CAK8P3a0xnc7RNbGhG7-hj+ay2keR7dh7MmDiUNKxfewsnatsgA@mail.gmail.com>
Subject: Re: [RFC][PATCH] Update -Wattribute-alias for gcc9
To:     Laura Abbott <labbott@redhat.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Martin Sebor <msebor@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 11:43 AM Laura Abbott <labbott@redhat.com> wrote:
>
> Commit bee20031772a ("disable -Wattribute-alias warning for
> SYSCALL_DEFINEx()") disabled -Wattribute-alias with gcc8.
> gcc9 changed the format of -Wattribute-alias to take a parameter.
> This doesn't quite match with the existing disabling mechanism
> so update for gcc9 to match with the default (-Wattribute-alias=1).
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> This is RFC because it feels ugly. I went ahead and did the obvious fixup
> but it's worth discussing if we're going to end up with an explosion or
> if there's a better way to handle this in one macro.

Bernd Edlinger has sent a patch to gcc for this:
https://gcc.gnu.org/ml/gcc-patches/2019-01/msg01120.html

and Miguel Ojeda said he wanted to send a patch for it to the
kernel as well, not sure if he wanted to take a different
approach there, so adding both to Cc here.

        Arnd




> ---
>  include/linux/compat.h       | 2 ++
>  include/linux/compiler-gcc.h | 7 ++++++-
>  include/linux/syscalls.h     | 2 ++
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index 056be0d03722..d5d7700f26a6 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -75,6 +75,8 @@
>         __diag_push();                                                          \
>         __diag_ignore(GCC, 8, "-Wattribute-alias",                              \
>                       "Type aliasing is used to sanitize syscall arguments");\
> +       __diag_ignore(GCC, 9, "-Wattribute-alias=1",                            \
> +                     "Type aliasing is used to sanitize syscall arguments");\
>         asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));       \
>         asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))        \
>                 __attribute__((alias(__stringify(__se_compat_sys##name))));     \
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index e8579412ad21..75079668344c 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -165,8 +165,13 @@
>  #define __diag_str(s)          __diag_str1(s)
>  #define __diag(s)              _Pragma(__diag_str(GCC diagnostic s))
>
> -#if GCC_VERSION >= 80000
> +#if GCC_VERSION >= 90000
> +#define __diag_GCC_8(s)
> +#define __diag_GCC_9(s)                __diag(s)
> +#elif GCC_VERSION >= 80000
>  #define __diag_GCC_8(s)                __diag(s)
> +#define __diag_GCC_9(s)
>  #else
>  #define __diag_GCC_8(s)
> +#define __diag_GCC_9(s)
>  #endif
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 257cccba3062..a08059e1ccf4 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -236,6 +236,8 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
>         __diag_push();                                                  \
>         __diag_ignore(GCC, 8, "-Wattribute-alias",                      \
>                       "Type aliasing is used to sanitize syscall arguments");\
> +       __diag_ignore(GCC, 9, "-Wattribute-alias=1",                    \
> +                     "Type aliasing is used to sanitize syscall arguments");\
>         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
>                 __attribute__((alias(__stringify(__se_sys##name))));    \
>         ALLOW_ERROR_INJECTION(sys##name, ERRNO);                        \
> --
> 2.20.1
>
