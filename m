Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462B4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03981216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mkEuU66F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03981216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeKLSUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:20:30 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40126 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbeKLSUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:20:30 -0500
Received: by mail-yw1-f65.google.com with SMTP id l66-v6so4047910ywl.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 00:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DbWE9S7+9Ef6pe5Sil/2By4EXNuOj2gmcIgnYBwYWgw=;
        b=mkEuU66FnSqqxvRfDQmEXH+Qy4faJ9BXy8hi4GRGrYk/Ao1vuoieUYGilZkELrZwG5
         t8RtjtvEj6DMPGmzN+L5bwRa1bbbzsxYb1Zm0lL1JFPWutm0M0SfxmvfNhXcqGLvpfc9
         cLCSxKgrCNUj9pOTJMvRE2Q9lxcduSrvMUEGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DbWE9S7+9Ef6pe5Sil/2By4EXNuOj2gmcIgnYBwYWgw=;
        b=jVm1zQa0HltXeN72fIZAjdSELUuHddTjEUumBdVmo7nrrQSeOZqF2QmG/us359wC3j
         NZFrV4bqWHcqLoKNXUVWuODmxUY5U2xY7j+dahqkQnrVXMF6e2wVIWAasTRJLrsSXnqp
         vf7G7h0zakmH0SU+uSN/AphAbOXJcSh1Cyuc+KvMksIFOyXXJ2wr+IIQsiWJB2duQMG3
         gFpnZwlMVrEy4p8Y7AhzjfrJ/swLe6uriblWv7L3+yB/CJksO4XnVXT4LsMaIfO8EtJR
         yvsHCCOE7eJAvApeTiz0IqD3PQX8eSwbU7Uu12Ze5ekhh+CxutznVTgmQnE96HNA4i1N
         gOrQ==
X-Gm-Message-State: AGRZ1gLLwSkpLf9OstaF/xSJuojLpLeYfw8vMsJJsL8BOs8t3xzeWf6m
        YDh5vD/x75l5U+xnGSnheNl+oCdTAgk=
X-Google-Smtp-Source: AJdET5dBErM2fnVNNQox7Ni2YAUIj4bplsh7gmT1dbySRrFVRti1P9CeJ/al56L2RZN/2Q8raBjjRw==
X-Received: by 2002:a81:3597:: with SMTP id c145-v6mr20502ywa.432.1542011301343;
        Mon, 12 Nov 2018 00:28:21 -0800 (PST)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id z11-v6sm4726435ywl.36.2018.11.12.00.28.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 00:28:20 -0800 (PST)
Received: by mail-yw1-f42.google.com with SMTP id i65-v6so4059956ywc.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 00:28:19 -0800 (PST)
X-Received: by 2002:a81:98cf:: with SMTP id p198-v6mr5405ywg.353.1542011299473;
 Mon, 12 Nov 2018 00:28:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Mon, 12 Nov 2018 00:28:18
 -0800 (PST)
In-Reply-To: <1541992013-18657-1-git-send-email-yamada.masahiro@socionext.com>
References: <1541992013-18657-1-git-send-email-yamada.masahiro@socionext.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 12 Nov 2018 02:28:18 -0600
X-Gmail-Original-Message-ID: <CAGXu5j+Otsyy3g6BotjzAR3Ek1cTd8uspCqcR7-EpqPJ5xHawA@mail.gmail.com>
Message-ID: <CAGXu5j+Otsyy3g6BotjzAR3Ek1cTd8uspCqcR7-EpqPJ5xHawA@mail.gmail.com>
Subject: Re: [PATCH] x86: remove gcc-x86_*-has-stack-protector.sh checks
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Sven Joachim <svenjoac@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 9:06 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> gcc-x86_64-has-stack-protector.sh was introduced by commit 4f7fd4d7a791
> ("[PATCH] Add the -fstack-protector option to the CFLAGS") in 2006
> to work around buggy compilers.
>
> gcc-x86_32-has-stack-protector.sh was introduced by commit 60a5317ff0f4
> ("x86: implement x86_32 stack protector"), which did not clearly state
> whether compilers were still producing broken code at that time.
>
> Now, the minimum reuquired GCC version is 4.6, which was released in
> 2011. Probably, we can dump these old compiler checks.

NAK. We need to keep this because we've seen recent regressions with
stack protection (e.g. gcc briefly used global instead of tls for the
canary, which silently broke the use of stack protectors). Since the
gcc/kernel "API" for the canary is so fragile we need to keep these
tests to make sure things end up where they're expected.

-Kees

>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/x86/Kconfig                          | 10 +---------
>  scripts/gcc-x86_32-has-stack-protector.sh |  4 ----
>  scripts/gcc-x86_64-has-stack-protector.sh |  4 ----
>  3 files changed, 1 insertion(+), 17 deletions(-)
>  delete mode 100755 scripts/gcc-x86_32-has-stack-protector.sh
>  delete mode 100755 scripts/gcc-x86_64-has-stack-protector.sh
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 9d734f3..7240d50 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -187,7 +187,7 @@ config X86
>         select HAVE_REGS_AND_STACK_ACCESS_API
>         select HAVE_RELIABLE_STACKTRACE         if X86_64 && (UNWINDER_FRAME_POINTER || UNWINDER_ORC) && STACK_VALIDATION
>         select HAVE_FUNCTION_ARG_ACCESS_API
> -       select HAVE_STACKPROTECTOR              if CC_HAS_SANE_STACKPROTECTOR
> +       select HAVE_STACKPROTECTOR
>         select HAVE_STACK_VALIDATION            if X86_64
>         select HAVE_RSEQ
>         select HAVE_SYSCALL_TRACEPOINTS
> @@ -352,14 +352,6 @@ config PGTABLE_LEVELS
>         default 3 if X86_PAE
>         default 2
>
> -config CC_HAS_SANE_STACKPROTECTOR
> -       bool
> -       default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC)) if 64BIT
> -       default $(success,$(srctree)/scripts/gcc-x86_32-has-stack-protector.sh $(CC))
> -       help
> -          We have to make sure stack protector is unconditionally disabled if
> -          the compiler produces broken code.
> -
>  menu "Processor type and features"
>
>  config ZONE_DMA
> diff --git a/scripts/gcc-x86_32-has-stack-protector.sh b/scripts/gcc-x86_32-has-stack-protector.sh
> deleted file mode 100755
> index f5c1194..0000000
> --- a/scripts/gcc-x86_32-has-stack-protector.sh
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -
> -echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m32 -O0 -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
> diff --git a/scripts/gcc-x86_64-has-stack-protector.sh b/scripts/gcc-x86_64-has-stack-protector.sh
> deleted file mode 100755
> index 75e4e22..0000000
> --- a/scripts/gcc-x86_64-has-stack-protector.sh
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -
> -echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m64 -O0 -mcmodel=kernel -fno-PIE -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
> --
> 2.7.4
>



-- 
Kees Cook
