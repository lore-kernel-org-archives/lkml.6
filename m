Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B82C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B08620818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbfBLKm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:42:58 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34529 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbfBLKm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:42:57 -0500
Received: by mail-vs1-f66.google.com with SMTP id e10so1296904vsp.1;
        Tue, 12 Feb 2019 02:42:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yinInWx7C2gTA9xmosl7id2N31ckf3xE3/uIqjaIeks=;
        b=DD0R+BxvTSvjttf3Y8sE4JvuF14Th8vSfNKT+viROaVb/NizLffLicJTlbgDi+rLJM
         IzBt5v71NUKycM7LSCWhCv91mFhS7AXrSVpoLdh0bAiSBmuQkGCLh45OQfMhV5VtewUI
         H+bFtjlq4T6p75AwGJ5PYPep6JEEqXDOD/gAVitHgV3yH9JGzKSaSqzlcDM3ny1g8Df+
         IzilRK4LiksoZxKok/pG6OdPfEnMM+TdLgx7+exCmRwfG0tYhb1i+tA3vIKOrc9ON8Ef
         yV2vZzYH/slkhfp/U4eA4rQFxqs+//hNe+UeQU1gYn1b3YcjlB/1eUtcU4b11wIHkcKe
         8Gsg==
X-Gm-Message-State: AHQUAuYMdpBhsz9ULTN8ppprECS1tb9kX7I4lZQX/4VXiNxJTJCGHnUu
        Gnj0t7vsqpYefvsX2RTaQJig7vvqfb8zFWp4JVlu77Rn
X-Google-Smtp-Source: AHgI3IYck9jeWGME+YaA3w25V6NZKry7GYHxF76gl/lCp1ylLbAGeOdLJUPI5SDH04wjlbWxoWKVPf6k6saKXvhXfqo=
X-Received: by 2002:a67:f43:: with SMTP id 64mr1275587vsp.166.1549968176318;
 Tue, 12 Feb 2019 02:42:56 -0800 (PST)
MIME-Version: 1.0
References: <20190211174544.4302-1-will.deacon@arm.com> <20190211174544.4302-3-will.deacon@arm.com>
In-Reply-To: <20190211174544.4302-3-will.deacon@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Feb 2019 11:42:44 +0100
Message-ID: <CAMuHMdWFOvrZ5JwgWnx9ujg3dS-75PnjGRqn-vzGmFi295Sb=A@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: io: Hook up __io_par() for inX() ordering
To:     Will Deacon <will.deacon@arm.com>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andrew.murray@arm.com, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Mon, Feb 11, 2019 at 9:34 PM Will Deacon <will.deacon@arm.com> wrote:
> Ensure that inX() provides the same ordering guarantees as readX()
> by hooking up __io_par() so that it maps directly to __iormb().
>
> Reported-by: Andrew Murray <andrew.murray@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Thanks for your patch!

> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -121,6 +121,7 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
>                      : "memory");                                       \
>  })
>
> +#define __io_par               __iormb

I think it makes sense to make the parameter passing explicit, for
documentation purposes:

    #define __io_par(v)        __iormb(v)

>  #define __iowmb()              wmb()
>
>  #define mmiowb()               do { } while (0)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
