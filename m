Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9615FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 19:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B42920854
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 19:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R1bjq7mn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B42920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeKQFOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 00:14:48 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39703 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbeKQFOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 00:14:48 -0500
Received: by mail-yw1-f67.google.com with SMTP id v8-v6so10508572ywh.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 11:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3Nx0BPMV9Nwl9Bym/8GK3DUvY1x5EbWNNBPIcBHbrik=;
        b=R1bjq7mnEr3s452JQmjQIN5GjPCv53GN467oXdTP+fjewbO0NWe2o4VcJek6MrUVkK
         na9+G6W8BcBDVyKW1zWie79nUpdwXqwhfvvoyEIv661xPkudIxc8x3/TMHnQs70Zep3y
         +powP9CCFj7xw/ru3yCTUtCr0CBwDTehBPeuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3Nx0BPMV9Nwl9Bym/8GK3DUvY1x5EbWNNBPIcBHbrik=;
        b=rr71J0DHR74XdoVqFIMOF9e03PulI/ADxmbpS223U4fMwZHIGOEVBc6GcTtRb1xxHi
         woVAJ5q0UGjkcy9ap48+U097OElEneob6tGO40STbxrEuAz3jehbTtd7mqIBiwKCXKg3
         /dOsVk2ghhhNbcuqOyjtr1oz6fnkTTlPb1EsIGtanB6mS2jk25PD1V43V79QZ7f8u2kq
         FwrVcWuEM1aeII2qNYTBUhcgfXMYM7sBxWjyZG7Bn+VJ/71UJqYnKf4AMtTtxFvlDdtI
         WMzLXYp0lOOXpB9+GvCB21vyZ11Y7Nrt0+QYMjSm0bUM8YDnqaae3Xqkk20/7kA/Nxz7
         Od7A==
X-Gm-Message-State: AGRZ1gKYGTwllJIs698fmzJn5btAsLCKqBUNKvp4yDfEPr8zb+BxypkL
        /eXUJ1TnE0MQ/MWTZZCf7qy8lGsb+HE=
X-Google-Smtp-Source: AJdET5cveKcsZEnfOa0Iazpqb7O6uzTZF8jRcMqoTwqTjNIowzqJbneqLTLeRj8/vNHd9mpp/L9Cig==
X-Received: by 2002:a81:a4d8:: with SMTP id b207-v6mr11749501ywh.261.1542394871772;
        Fri, 16 Nov 2018 11:01:11 -0800 (PST)
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id v70-v6sm3867796ywc.56.2018.11.16.11.01.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 11:01:10 -0800 (PST)
Received: by mail-yw1-f45.google.com with SMTP id g75so6054817ywb.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 11:01:10 -0800 (PST)
X-Received: by 2002:a0d:fec3:: with SMTP id o186-v6mr11945199ywf.237.1542394862112;
 Fri, 16 Nov 2018 11:01:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Fri, 16 Nov 2018 11:01:01
 -0800 (PST)
In-Reply-To: <1542349141-7229-1-git-send-email-yamada.masahiro@socionext.com>
References: <1542349141-7229-1-git-send-email-yamada.masahiro@socionext.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 16 Nov 2018 13:01:01 -0600
X-Gmail-Original-Message-ID: <CAGXu5jJn5xRW6EqnULVESy1UZKjzxrxRAcHb412smtjoTVmsEQ@mail.gmail.com>
Message-ID: <CAGXu5jJn5xRW6EqnULVESy1UZKjzxrxRAcHb412smtjoTVmsEQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] build_bug.h: remove negative-array fallback for BUILD_BUG_ON()
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 12:19 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> The kernel can only be compiled with an optimization option (-O2, -Os,
> or the currently proposed -Og). Hence, __OPTIMIZE__ is always defined
> in the kernel source.
>
> A fallback for -O0 case is just hypothetical and pointless. Moreover,
> commit 0bb95f80a38f ("Makefile: Globally enable VLA warning") enabled
> -Wvla warning. The use of variable length arrays is banned.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>
>  include/linux/build_bug.h | 14 --------------
>  1 file changed, 14 deletions(-)
>
> diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
> index 43d1fd5..d415c64 100644
> --- a/include/linux/build_bug.h
> +++ b/include/linux/build_bug.h
> @@ -51,23 +51,9 @@
>   * If you have some code which relies on certain constants being equal, or
>   * some other compile-time-evaluated condition, you should use BUILD_BUG_ON to
>   * detect if someone changes it.
> - *
> - * The implementation uses gcc's reluctance to create a negative array, but gcc
> - * (as of 4.4) only emits that error for obvious cases (e.g. not arguments to
> - * inline functions).  Luckily, in 4.3 they added the "error" function
> - * attribute just for this type of case.  Thus, we use a negative sized array
> - * (should always create an error on gcc versions older than 4.4) and then call
> - * an undefined function with the error attribute (should always create an
> - * error on gcc 4.3 and later).  If for some reason, neither creates a
> - * compile-time error, we'll still have a link-time error, which is harder to
> - * track down.
>   */
> -#ifndef __OPTIMIZE__
> -#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
> -#else
>  #define BUILD_BUG_ON(condition) \
>         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
> -#endif
>
>  /**
>   * BUILD_BUG - break compile if used.
> --
> 2.7.4
>



-- 
Kees Cook
