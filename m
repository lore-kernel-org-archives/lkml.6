Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED781C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 19:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C1220854
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 19:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gy8JWsRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C1220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbeKQFPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 00:15:08 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45872 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbeKQFPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 00:15:08 -0500
Received: by mail-yw1-f65.google.com with SMTP id p18-v6so10456768ywg.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 11:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4AYGeaWa6i+JNpi+TyxAIosr4WOo3bTeAHYBkctwvLo=;
        b=Gy8JWsRUvel9IFCMw2IZrQqJ+NVl/cfcVfjMOPI9SnwkwRfe7mxw26HdICOsSmO+25
         M9kr4f1oufD24aJWabhie9Ob5Pjj9dhdQ+6KK79aT+qoMLKhyrkYPeJzR6D+Evy0TF5w
         n7Y6sGW4DTgYIPFG/RfDjfSRrN9f6RUQuAmlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4AYGeaWa6i+JNpi+TyxAIosr4WOo3bTeAHYBkctwvLo=;
        b=I+gFi3G2vBzzupA9plXvAh7GUDDCPKUTmOlTnyuwTJNfD0WSn90ij8s3SsXzpAgqLH
         eKqjG/MGXYfpTjAk4faUfYIa7hxqkLZzNTqc0MCprXlI2PO0ZknixcFgCVM3haSc4aY2
         sAlxpR2+/fmwIJbCw1H0884jypqTCrVvwgg2zV6er+qLGYKmD0Haki4eHTcAC/UFvzQ5
         aIrtR0iPH4qTUEEvbgLguJCBvJHA8jg5Tgj1F/fEi4Sa9pWz5SN4/6Lnd0eq/QUmvmuQ
         T8Udv+JMUBM8RYic4UA3d3WAXwqxKeFYh8CFu99nEtfxwgWN84z2JvSNL/AD1uIIaXJa
         zH9A==
X-Gm-Message-State: AGRZ1gLuR9vMOQGNiN0L+dUVvTKymUkV9wQvnWzb+Q5d+aFT+cFuXkFh
        bzjzr35aH19WQVLTXQI5dnOcP6fGmWI=
X-Google-Smtp-Source: AJdET5fLoz1Yx1jds0g1tqKMK8NMY1FZR5RCYqC7AWVokkAF8CuoJV5tsUeUPLqLvgq8KYni0mpI8A==
X-Received: by 2002:a81:4a42:: with SMTP id x63-v6mr11790161ywa.3.1542394891513;
        Fri, 16 Nov 2018 11:01:31 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id h82-v6sm12946041ywh.17.2018.11.16.11.01.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 11:01:30 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id i17-v6so10141417ybp.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 11:01:30 -0800 (PST)
X-Received: by 2002:a25:7643:: with SMTP id r64-v6mr11512126ybc.403.1542394889964;
 Fri, 16 Nov 2018 11:01:29 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Fri, 16 Nov 2018 11:01:29
 -0800 (PST)
In-Reply-To: <1542349645-8852-2-git-send-email-yamada.masahiro@socionext.com>
References: <1542349645-8852-1-git-send-email-yamada.masahiro@socionext.com> <1542349645-8852-2-git-send-email-yamada.masahiro@socionext.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 16 Nov 2018 13:01:29 -0600
X-Gmail-Original-Message-ID: <CAGXu5jJ4oA0E3kVVKVk4rriHQMRj21h657rWhn5J7jX03kxDUQ@mail.gmail.com>
Message-ID: <CAGXu5jJ4oA0E3kVVKVk4rriHQMRj21h657rWhn5J7jX03kxDUQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] build_bug.h: remove all dummy BUILD_BUG_ON stubs
 for sparse
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

On Fri, Nov 16, 2018 at 12:27 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> The introduction of these dummy BUILD_BUG_ON stubs dates back to
> commit 903c0c7cdc21 ("sparse: define dummy BUILD_BUG_ON definition
> for sparse"). At that time, BUILD_BUG_ON() was implemented with the
> negative array trick, which Sparse complains about even if the
> condition can be optimized and evaluated to 0 at compile-time.
>
> With the previous commit, the leftover negative array trick is gone.
> Sparse is happy with the current BUILD_BUG_ON(), which is implemented
> by using the 'error' attribute.
>
> There might be a little room for argument about BUILD_BUG_ON_ZERO().
> Sparse reports 'invalid bitfield width, -1' for non-zero value,
> and 'bad integer constant expression' for non-constant value.
> This is the same criteria as GCC uses. So, if those Sparse errors
> occurred, they would cause errors for GCC as well. (Hence, such
> errors would have been detected by the normal compile test process.)
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>
> Changes in v2:
>  - Fix a coding style error (two consecutive blank lines)
>
>  include/linux/build_bug.h | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
> index d415c64..6625c88 100644
> --- a/include/linux/build_bug.h
> +++ b/include/linux/build_bug.h
> @@ -4,16 +4,6 @@
>
>  #include <linux/compiler.h>
>
> -#ifdef __CHECKER__
> -#define __BUILD_BUG_ON_NOT_POWER_OF_2(n) (0)
> -#define BUILD_BUG_ON_NOT_POWER_OF_2(n) (0)
> -#define BUILD_BUG_ON_ZERO(e) (0)
> -#define BUILD_BUG_ON_INVALID(e) (0)
> -#define BUILD_BUG_ON_MSG(cond, msg) (0)
> -#define BUILD_BUG_ON(condition) (0)
> -#define BUILD_BUG() (0)
> -#else /* __CHECKER__ */
> -
>  /* Force a compilation error if a constant expression is not a power of 2 */
>  #define __BUILD_BUG_ON_NOT_POWER_OF_2(n)       \
>         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
> @@ -64,6 +54,4 @@
>   */
>  #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>
> -#endif /* __CHECKER__ */
> -
>  #endif /* _LINUX_BUILD_BUG_H */
> --
> 2.7.4
>



-- 
Kees Cook
