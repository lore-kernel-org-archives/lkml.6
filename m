Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D89C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6940220836
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IXyzo/q6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6940220836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbeHST0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 15:26:02 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:39050 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbeHST0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 15:26:01 -0400
Received: by mail-yb0-f195.google.com with SMTP id c4-v6so3717949ybl.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 09:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ojDNy5MTJo8R2b/T3LTLNvg33KfjisOj3M1Z7X6cfSQ=;
        b=IXyzo/q6kROfMDuxID5ZPonxTwbXvGRemLKMwmnYOh7gAS1gUKdQMvuKusyKjo+Xy5
         8Ss88h91yCOUtrmGRzOY072XhZC8vsD2qRm8KpVo/jGoPDtPgzjj4RIJ2Yyvpfn5VLyM
         ND27MwO7EAZWPRE0FNwTxgU3IZ/sMWfAdO7wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ojDNy5MTJo8R2b/T3LTLNvg33KfjisOj3M1Z7X6cfSQ=;
        b=GOhZVbdb0EiAxyK98Hx3hh+4bkgnEUIBzi0dBFkcM9xviIcXGTBInp8yj1AIUSdIKO
         L8kPxw5WFrl4HQADTVUGtS7EDJ3Qsu0IvEQbbeL0rWY+Wfd+fELTUDxdVVCS1rwKdnmV
         JEKUwECk09vAkgl2LbtdQ8YRNawNB1pCP5xY/a/UC4x5Xf51yBnKIr3ehCYShu0YogXS
         xsUst+jfKplPCQ/7fehJuyhDuWwBgjQUpfiq9AqAXvKtMvFIhiE3oQm+rPOahyANirZ+
         8ZxzqZUSEimFS9gVHVMN4RR59wSDwoezjATu/nQa5LpoolMJ/FeLvMk2d7nCMV1iC5h2
         dkeg==
X-Gm-Message-State: AOUpUlGmYGFuOVZLABTIGCCYBBdPpacuA9omjB6+/espnJ62NYqODZC/
        +c86eSE98saAG1xLyqbzCw8NdYV/HfE=
X-Google-Smtp-Source: AA+uWPxFTXj9/ET86T5SnFLd2E4/M8XDHum9Dtlo7lVbItgfSt/E1oWBZMJoc1NSVApRP1cn/CxoxQ==
X-Received: by 2002:a25:ac1b:: with SMTP id w27-v6mr22956802ybi.279.1534695242460;
        Sun, 19 Aug 2018 09:14:02 -0700 (PDT)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id 79-v6sm3568476ywp.71.2018.08.19.09.13.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Aug 2018 09:14:00 -0700 (PDT)
Received: by mail-yw1-f52.google.com with SMTP id q129-v6so6024804ywg.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 09:13:59 -0700 (PDT)
X-Received: by 2002:a0d:cf86:: with SMTP id r128-v6mr22064701ywd.353.1534695239276;
 Sun, 19 Aug 2018 09:13:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:aa31:0:0:0:0:0 with HTTP; Sun, 19 Aug 2018 09:13:58
 -0700 (PDT)
In-Reply-To: <1534657880-11573-1-git-send-email-yamada.masahiro@socionext.com>
References: <1534657880-11573-1-git-send-email-yamada.masahiro@socionext.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 19 Aug 2018 09:13:58 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+t7c31xVXD+pu3Xhv10Nj0rWsGW=H1OgXh+uKGJRicnA@mail.gmail.com>
Message-ID: <CAGXu5j+t7c31xVXD+pu3Xhv10Nj0rWsGW=H1OgXh+uKGJRicnA@mail.gmail.com>
Subject: Re: [RFC PATCH] compiler.h: give up __compiletime_assert_fallback()
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Hogan <james.hogan@imgtec.com>,
        Joe Stringer <joe@ovn.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Christopher Li <sparse@chrisli.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 10:51 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> __compiletime_assert_fallback() is supposed to stop building earlier
> by using the negative-array-size method in case the compiler does not
> support "error" attribute, but has never worked like that.
>
> You can try this simple code:
>
>     #include <linux/build_bug.h>
>     void foo(void)
>     {
>             BUILD_BUG_ON(1);
>     }
>
> GCC (precisely, GCC 4.3 or later) immediately terminates the build,
> but Clang does not report anything because Clang does not support the
> "error" attribute now.  It will eventually fail in the link stage,
> but at least __compiletime_assert_fallback() is not working.
>
> The root cause is commit 1d6a0d19c855 ("bug.h: prevent double evaluation
> of `condition' in BUILD_BUG_ON").  Prior to that commit, BUILD_BUG_ON()
> was checked by the negative-array-size method *and* the link-time trick.
> Since that commit, the negative-array-size is not effective because
> '__cond' is no longer constant.  As the comment in <linux/build_bug.h>
> says, GCC (and Clang as well) only emits the error for obvious cases.
>
> When '__cond' is a variable,
>
>     ((void)sizeof(char[1 - 2 * __cond]))
>
> ... is not obvious for the compiler to know the array size is negative.
>
> One way to fix this is to stop the variable assignment, i.e. to pass
> '!(condition)' directly to __compiletime_error_fallback() at the cost
> of the double evaluation of 'condition'.  However, all calls of
> BUILD_BUG() would be turned into errors even if they are called from
> dead-code.
>
> This commit does not change the current behavior since it just rips
> off the code that has not been effective for some years.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Yeah, Clang would only complain about the VLA (and not error) and then
later fail at link time. This seems like a reasonable change to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>
>  include/linux/compiler.h | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
>
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 42506e4..c062238f4 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -295,29 +295,14 @@ unsigned long read_word_at_a_time(const void *addr)
>  #endif
>  #ifndef __compiletime_error
>  # define __compiletime_error(message)
> -/*
> - * Sparse complains of variable sized arrays due to the temporary variable in
> - * __compiletime_assert. Unfortunately we can't just expand it out to make
> - * sparse see a constant array size without breaking compiletime_assert on old
> - * versions of GCC (e.g. 4.2.4), so hide the array from sparse altogether.
> - */
> -# ifndef __CHECKER__
> -#  define __compiletime_error_fallback(condition) \
> -       do { ((void)sizeof(char[1 - 2 * condition])); } while (0)
> -# endif
> -#endif
> -#ifndef __compiletime_error_fallback
> -# define __compiletime_error_fallback(condition) do { } while (0)
>  #endif
>
>  #ifdef __OPTIMIZE__
>  # define __compiletime_assert(condition, msg, prefix, suffix)          \
>         do {                                                            \
> -               bool __cond = !(condition);                             \
>                 extern void prefix ## suffix(void) __compiletime_error(msg); \
> -               if (__cond)                                             \
> +               if (!(condition))                                       \
>                         prefix ## suffix();                             \
> -               __compiletime_error_fallback(__cond);                   \
>         } while (0)
>  #else
>  # define __compiletime_assert(condition, msg, prefix, suffix) do { } while (0)
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
