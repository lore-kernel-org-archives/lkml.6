Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00984C282CC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4C421904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfBGPGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:06:13 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:39210 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfBGPGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:06:13 -0500
Received: by mail-vk1-f195.google.com with SMTP id f206so37182vke.6;
        Thu, 07 Feb 2019 07:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bRxqLmSiVMVfTFow+KTqyKL7tJcuX/SG1WPQvuQHrSk=;
        b=RzrX6ljHroasnAN/7P83sjy5QqoBIoCGUlAJWuvuZP2/fGPajNxhWtipFcdWJVDXdB
         rttQoru/IG1vjkAxDOWw+rtP5ojhud4/JPxDQXObMERNRj2WaYUacaUoai2WOJGUjqzw
         +3P6uM/2UMEYinQO5rxInJ30dVp6PVoQbd97EnzY8RiJR2gVJiVU9cHHYibBeTwzGDaq
         kAJpXYjLae2DcQ3AtoUtXDmeCVLp3ApHedMmhCkttDG+gVdKo1eMv+GwqiXk6jkxqGxc
         Ex5AmjKAXgFbGr4KdRIC2O7qLJr/KrSZc2tIDt4cGFd5LlgFNZ+czGn0PmxW9hlyXmzc
         oUYQ==
X-Gm-Message-State: AHQUAuawsonqkGj7qR56dwmNzxe7/3dTjBcBocG5xbyD8+QCUa3fZcDC
        jXz89GX+DXYiSYfPDC1CxErSGy3TpCgobJBMLxQ=
X-Google-Smtp-Source: AHgI3IY67Fsz+ha+/WL4Zi7wnLLDw+Mt1S3Q99JHFeY2aWFJksNpoQ+8Rm7975dqI8z0emmkiruCvMUZLJNHakKBWqM=
X-Received: by 2002:a1f:8614:: with SMTP id i20mr3388951vkd.74.1549551971404;
 Thu, 07 Feb 2019 07:06:11 -0800 (PST)
MIME-Version: 1.0
References: <20190207133550.13967-1-horms+renesas@verge.net.au> <20190207133550.13967-4-horms+renesas@verge.net.au>
In-Reply-To: <20190207133550.13967-4-horms+renesas@verge.net.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 7 Feb 2019 16:05:58 +0100
Message-ID: <CAMuHMdUMeGEnkVDvVk=NZMrnNXDUxDOgcqfORf+My8jkCza3SA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] clk: renesas: rcar-gen3: Support Z and Z2 clocks
 with high frequency parents
To:     Simon Horman <horms+renesas@verge.net.au>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On Thu, Feb 7, 2019 at 2:36 PM Simon Horman <horms+renesas@verge.net.au> wrote:
> Support Z and Z2 clocks with parent frequencies greater than UINT32_MAX Hz
> (~4.29GHz).
>
> The DIV_ROUND_CLOSEST_ULL() macro accepts a 64bit dividend and 32bit
> divisor. This leads to truncation of the dividend, which is the Z or Z2

truncation of the divisor.

> parent clock frequency in HZ, on platforms where frequency of that clock is
> greater than UINT32_MAX Hz.
>
> To resolve this problem the DIV64_U64_ROUND_CLOSEST() macro, which an

which takes an

> unsigned 32bit dividend and divisor, is introduced.

64-bit

> An earlier version of this patch made use of the existing
> DIV_ROUND_CLOSEST() macro, which accepts the prevailing type of the
> dividend and divisor. However, this does not compile on 32bit systems, such
> as i386 and mips, when called with the types used at this callsite, an
> unsigned long long dividend and unsigned long divisor.

Thanks for fixing this!

> This work is in preparation for supporting the Z2 cloco on the R-Car Gen3
> E3 (r8a77990) SoC which has a 4.8GHz parent clock.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
> v4: Add and use DIV64_U64_ROUND_CLOSEST
>
> v2: New patch
> ---
>  drivers/clk/renesas/rcar-gen3-cpg.c |  4 ++--
>  include/linux/math64.h              | 13 +++++++++++++

While I have no issue taking this change through the clk-renesas tree if
Andrew provides his Acked-by, I think the introduction of
DIV64_U64_ROUND_CLOSEST() should be a separate patch.

However, given commit 68600f623d69da42 ("mm: don't miss the last page
because of round-off error") added both DIV64_U64_ROUND_UP() and its
user under mm/, there's precedence for not splitting it off...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
