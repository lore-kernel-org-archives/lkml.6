Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48DDC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F20B21855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733224AbfBKPov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:44:51 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46639 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732766AbfBKPou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:44:50 -0500
Received: by mail-vs1-f65.google.com with SMTP id n10so6474684vso.13;
        Mon, 11 Feb 2019 07:44:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PPZgkIAjB4Z4Na98Ahql3kzmPMGHUQYFtXacLoG4tAI=;
        b=P+yuFaSRW6U+O2BXBBh/pQn7zJt/jUPpfSLl2U3q4BYVbzd6/PMjfDd4xe7Gxdmwop
         mToDHC4q/YIy7spEvO/Fzcl7VrpnV8qpeHBx6hDYTAT2CdXrO2Orh/H2tZwz4FuVzc7u
         qJfT5mQ2hPplhFQfMs2kEa7J/Az9hYGsYbqwbYqB0B9ehNMbO0DwF5MQuNelrtx4RRrF
         doipbJ497Ab/Vgmm9MpVaihdK2hr7QyDx9lA4qAtAp9VByYfpGHDLCMOxMgdi6kKCVBY
         hxTAAUuP+mZDLX2HP3BGYom0ERVyviS1w8Qe/4sycExrghhtJ2lFRh6EXlxUjEc6fS5p
         Cg5g==
X-Gm-Message-State: AHQUAubU0JnaTgRhLWnajW1clc31qNLB0kzEABwwgi9TqKtxM+vvh1mI
        kj4f5xXeIl5dRJuyeD3q0Fgj/HnEKRG66O6CEGE=
X-Google-Smtp-Source: AHgI3IZPLHNfc3VZVtnwi9qj2yAmA80JFYtLpyN3wd3kz9t3ZQT5A0Q7hnz9hr/JVOmr1Qhv8S+s2nyCk0cgaU5KdAY=
X-Received: by 2002:a67:3885:: with SMTP id n5mr13222764vsi.96.1549899888964;
 Mon, 11 Feb 2019 07:44:48 -0800 (PST)
MIME-Version: 1.0
References: <20190211135858.23635-1-horms+renesas@verge.net.au>
 <20190211135858.23635-4-horms+renesas@verge.net.au> <0b9e3ba7-2b84-7621-78f9-9b22cb4f2bd6@cogentembedded.com>
In-Reply-To: <0b9e3ba7-2b84-7621-78f9-9b22cb4f2bd6@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Feb 2019 16:44:37 +0100
Message-ID: <CAMuHMdV_tcsOZCBRWxbRwdfBeeh1-MJSNqw4U6YLnjOznLUQnA@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] math64: New DIV64_U64_ROUND_CLOSEST helper
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 4:22 PM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 02/11/2019 04:58 PM, Simon Horman wrote:
> > Provide DIV64_U64_ROUND_CLOSEST helper which performs division rounded to
> > the closes integer using an unsigned 64bit dividend and divisor.
>
>    Closest?
>
> > This will be used in a follow-up patch to allow calculation of clock
> > divisors with high frequency parents in the R-Car Gen3 CPG MSSR driver
> > where ovefolow occurs if either the dividend or divisor is 32bit.

overflow

> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Note that I can fix the above while applying to my clk-renesas branch.

Andrew: an Acked-by would be appreciated.
Thanks!

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
