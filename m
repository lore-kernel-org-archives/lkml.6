Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BBEC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 23:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C63208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 23:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WKEc4E6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C63208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeJPHPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 03:15:13 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41527 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeJPHPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 03:15:13 -0400
Received: by mail-qt1-f195.google.com with SMTP id l41-v6so23574780qtl.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 16:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=NBmtvMpYbuz0jIwV8xUc52SQ96VDN6aRJ1rFqvFpDoU=;
        b=WKEc4E6lNu+gVzsu0tPeDKBKawh0mhIOdl6tIicPPYDfYKTbzuKLGGRShvi1sR3RrJ
         LGZEFdLTJWMAeahZbif4WKb03G95pvhd4/EpSaqYX+xNGKq11QsMIImoL2hTS0P2+4NU
         tPmQFQuMzUT5bD0ARqsZXq2nrmJs3pRxkItsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=NBmtvMpYbuz0jIwV8xUc52SQ96VDN6aRJ1rFqvFpDoU=;
        b=PxMC0oipTQWjKlwWomTvBp1vKQmxsuNUslNzvSzDJDNFlpJPImwerUa1qLX1njjO1D
         34hqXzsKOOQihBG6YwCrJ4j7SzbYbnCoE9lG15V2vTIgKO53EfBHuhC+hUWR91waxLO+
         lF6U9HbbroQioP9cLX47bUf0o4RGx7Nvvzky6gvwsZRvT3ZbgV0kgrT+txqAScqTqAu1
         bTeO7yiWew6fd58qfZWpl3UIeJBVshenOXDASn77gCPO3m9pP+7QWSf4djRLUWolwyPw
         lm9ORwDkfC8cZLg4EbQ8Qvjm1Pb/GG9EaUU259f8smfpPLdrtaZrm0ZDAJt8ydgLwhtU
         tOZw==
X-Gm-Message-State: ABuFfoiY/IilWVfFVloBdqqJvxlzgBTLbJRAP/+EY5uhd8IuP9Q8vhnO
        tv2E9m2LKoI8Fkaid+sEH7Et3g==
X-Google-Smtp-Source: ACcGV61nKhI+4LcPLKqdSXOduevBahp7tkw5qP19ebAtI7XJRJxGFSoMq8144TIBmj8rskKd0yCLwg==
X-Received: by 2002:aed:2d86:: with SMTP id i6-v6mr18199271qtd.279.1539646065325;
        Mon, 15 Oct 2018 16:27:45 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id 35-v6sm8334197qtr.91.2018.10.15.16.27.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 16:27:44 -0700 (PDT)
Date:   Mon, 15 Oct 2018 19:27:43 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Stefan Agner <stefan@agner.ch>
cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        ulli.kroll@googlemail.com, joel@jms.id.au, arnd@arndb.de,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: copypage: do not use naked functions
In-Reply-To: <4e598f27e3dc7ae9fd96a6cf097d1154@agner.ch>
Message-ID: <nycvar.YSQ.7.76.1810151908450.1498@knanqh.ubzr>
References: <20181015222621.14673-1-stefan@agner.ch> <nycvar.YSQ.7.76.1810151831040.1498@knanqh.ubzr> <20181015224152.GA30658@n2100.armlinux.org.uk> <4e598f27e3dc7ae9fd96a6cf097d1154@agner.ch>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018, Stefan Agner wrote:

> On 16.10.2018 00:41, Russell King - ARM Linux wrote:
> > On Mon, Oct 15, 2018 at 06:35:33PM -0400, Nicolas Pitre wrote:
> >> On Tue, 16 Oct 2018, Stefan Agner wrote:
> >>
> >> > GCC documentation says naked functions should only use basic ASM
> >> > syntax. The extended ASM or mixture of basic ASM and "C" code is
> >> > not guaranteed. Currently it seems to work though.
> >> >
> >> > Furthermore with Clang using parameters in extended asm in a
> >> > naked function is not supported:
> >> >   arch/arm/mm/copypage-v4wb.c:47:9: error: parameter references not
> >> >   allowed in naked functions
> >> >         : "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64));
> >> >                ^
> >> >
> >> > Use a regular function to be more portable. Also use volatile asm
> >> > to avoid unsolicited optimizations.
> >> >
> >> > Tested with qemu versatileab machine and versatile_defconfig and
> >> > qemu mainstone machine using pxa_defconfig compiled with GCC 7.2.1
> >> > and Clang 7.0.
> >> >
> >> > Link: https://github.com/ClangBuiltLinux/linux/issues/90
> >> > Reported-by: Joel Stanley <joel@jms.id.au>
> >> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> > ---
> >> >  arch/arm/mm/copypage-fa.c       | 17 +++++++++++------
> >> >  arch/arm/mm/copypage-feroceon.c | 17 +++++++++++------
> >> >  arch/arm/mm/copypage-v4mc.c     | 14 +++++++++-----
> >> >  arch/arm/mm/copypage-v4wb.c     | 17 +++++++++++------
> >> >  arch/arm/mm/copypage-v4wt.c     | 17 +++++++++++------
> >> >  arch/arm/mm/copypage-xsc3.c     | 17 +++++++++++------
> >> >  arch/arm/mm/copypage-xscale.c   | 13 ++++++++-----
> >> >  7 files changed, 72 insertions(+), 40 deletions(-)
> >> >
> >> > diff --git a/arch/arm/mm/copypage-fa.c b/arch/arm/mm/copypage-fa.c
> >> > index ec6501308c60..33ccd396bf99 100644
> >> > --- a/arch/arm/mm/copypage-fa.c
> >> > +++ b/arch/arm/mm/copypage-fa.c
> >> > @@ -17,11 +17,16 @@
> >> >  /*
> >> >   * Faraday optimised copy_user_page
> >> >   */
> >> > -static void __naked
> >> > -fa_copy_user_page(void *kto, const void *kfrom)
> >> > +static void fa_copy_user_page(void *kto, const void *kfrom)
> >> >  {
> >> > -	asm("\
> >> > -	stmfd	sp!, {r4, lr}			@ 2\n\
> >> > +	register void *r0 asm("r0") = kto;
> >> > +	register const void *r1 asm("r1") = kfrom;
> >> > +
> >> > +	asm(
> >> > +	__asmeq("%0", "r0")
> >> > +	__asmeq("%1", "r1")
> >> > +	"\
> >> > +	stmfd	sp!, {r4}			@ 2\n\
> >> >  	mov	r2, %2				@ 1\n\
> >> >  1:	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
> >> >  	stmia	r0, {r3, r4, ip, lr}		@ 4\n\
> >> > @@ -34,9 +39,9 @@ fa_copy_user_page(void *kto, const void *kfrom)
> >> >  	subs	r2, r2, #1			@ 1\n\
> >> >  	bne	1b				@ 1\n\
> >> >  	mcr	p15, 0, r2, c7, c10, 4		@ 1   drain WB\n\
> >> > -	ldmfd	sp!, {r4, pc}			@ 3"
> >> > +	ldmfd	sp!, {r4}			@ 3"
> >> >  	:
> >> > -	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 32));
> >> > +	: "r" (r0), "r" (r1), "I" (PAGE_SIZE / 32));
> >>
> >> This is still wrong as you list r0 and r1 in the input operand list
> >> where they must remain constant but the code does modify them. You
> >> should list them in the output operand list with the "&" attribute. Also
> >> r2 should be listed in the clobbered list.
> > 
> > Either we keep these as naked functions (and, if Clang wants to
> > try to inline naked functions which makes no sense, also mark them
> > as noinline) or we make them proper functions and also add (eg) r4
> > to the clobber list and get rid of the stacking of that register
> > along with LR/PC.
> 
> Clang does not inline naked functions, at least that is what a quick
> look at the disassembled code shows when compiling with 9a40ac86152c
> reverted.

It's hard to see what that commit was actually fixing, but the operands 
usage is wrong as explained already. Maybe the generated code has been 
OK for all those years but that is due to luck rather than correctness.

> > Having this half-way house which will generate worse code is not
> > acceptable.
> 
> For Clang reverting 9a40ac86152c ("ARM: 6164/1: Add kto and kfrom to
> input operands list.") is a solution...
> 
> I guess the question is why that commit was necessary back then... Do we
> break something by reverting it?

No idea. Maybe Russell remembers?
Maybe digging into the mailing list archive might tell.


Nicolas
