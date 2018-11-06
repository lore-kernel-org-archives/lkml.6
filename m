Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B8DC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 04:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DB22083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 04:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WJhgQWyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DB22083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbeKFONS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 09:13:18 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35426 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeKFONR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 09:13:17 -0500
Received: by mail-qk1-f196.google.com with SMTP id v68-v6so17757502qka.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 20:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=6evZoO/oZ1QIiw8C4pKcogist4NTEPgfQPr4O8jCOiE=;
        b=WJhgQWyHaWGT8BJngIQ7VWC1W9Z08LSRUS6cX34K3dckwe8KbdgEyEVa6UfgiNmAkj
         P+41k1hbVJx2Bc12eYuZeg0bRHyg0KI1rP/dJFFB2LwRTayPHA0rO1z1xLlhpsYdwvCt
         Jpotb7AmEfqEdXtk35UPXoIN6UVBveteJ5jBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=6evZoO/oZ1QIiw8C4pKcogist4NTEPgfQPr4O8jCOiE=;
        b=TU+qVbhecwu+s2y8slnFHw1hn74FI9ktou5tfo1cnzQHdTl80oZHvXKG4FF1dEZ0w+
         0dK9IEaeKPtx7TwECRLMX00JsLwnVRK8yjBmk4tKjkLpMhRzmd18tMhAMnXRRmst8xbD
         Cxj2d7TWmWVPbWqydApXAxt+i4sQAcD7emd19pVfjUtc/TcstJZV4MCxn2tELlwHkC8j
         FWzvWf6yyn7kGyVImOUI+CWSKWyLz6NGKiGYHmZ6APCMgk3DdYnLbxccw0iOR+ZxGoUa
         YU/jXkKTtriUUlegPOBzZ5YgstahX2HY6WN0QpNPTwP9KYsqx5ocnRE8n5H7nXuJ9ah3
         jeQg==
X-Gm-Message-State: AGRZ1gKl/CWHtNmbZs/ia1YNHkvAycMrmRo/Uv3MG2Z4nJcmgClV+J66
        NU8Ur4JajML1zaBLDKUYoC1PVw==
X-Google-Smtp-Source: AJdET5fuJHatLXisTFU3f5ADOdC3ohkTdBqGCCiyS2yxl9pgagfy5Fxh5cTuqOdvuMFaBhOKjvs6bg==
X-Received: by 2002:a37:8141:: with SMTP id c62-v6mr22878402qkd.265.1541479794913;
        Mon, 05 Nov 2018 20:49:54 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id 5-v6sm31503387qtz.8.2018.11.05.20.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 20:49:53 -0800 (PST)
Date:   Mon, 5 Nov 2018 23:49:51 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Stefan Agner <stefan@agner.ch>
cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Roman Yeryomin <roman@advem.lv>
Subject: Re: [PATCH 1/2] ARM: copypage-fa: add kto and kfrom to input operands
 list
In-Reply-To: <fe7595f5d02424c9d92e437cd20361f9@agner.ch>
Message-ID: <nycvar.YSQ.7.76.1811052231220.1498@knanqh.ubzr>
References: <20181015221629.13924-1-stefan@agner.ch> <CACRpkdaVGKLtE-whhK3oFgY+4xoy1JqWkcBW4UO0-hJs2B-QGg@mail.gmail.com> <20181016084416.GF30658@n2100.armlinux.org.uk> <nycvar.YSQ.7.76.1810161357580.1498@knanqh.ubzr>
 <fe7595f5d02424c9d92e437cd20361f9@agner.ch>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2018, Stefan Agner wrote:

> On 16.10.2018 22:43, Nicolas Pitre wrote:
> > Subject: [PATCH] ARM: remove naked function usage
> > 
> > Convert page copy functions not to rely on the naked function attribute.
> > 
> > This attribute is known to confuse some gcc versions when function
> > arguments aren't explicitly listed as inline assembly operands despite
> > the gcc documentation. That resulted in commit 9a40ac86152c ("ARM:
> > 6164/1: Add kto and kfrom to input operands list.").
> > 
> > Yet that commit has problems of its own by having assembly operand
> > constraints completely wrong. If the generated code has been OK since
> > then, it is due to luck rather than correctness. So this patch provides
> > proper assembly operand usage, and removes two instances of redundant
> > register duplications in the implementation while at it.
> > 
> > Inspection of the generated code with this patch doesn't show any obvious
> > quality degradation either, so not relying on __naked at all will make
> > the code less fragile, and more likely to be compilable with clang.
> > 
> > The only remaining __naked instances (excluding the kprobes test cases)
> > are exynos_pm_power_up_setup() and tc2_pm_power_up_setup(). But in those
> > cases only the function address is used by the compiler with no chance of
> > inlining it by mistake.
> > 
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> 
> As mentioned a couple of weeks ago, I did test this patchset on two
> architectures (pxa_defconfig -> copypage-xscale.c and
> versatile_defconfig -> copypage-v4wb.c).
> 
> I really like this approach, can we move forward with this?

Yes, the patch was submitted to the patch tracker a few days later.

> A couple of comments below:
> 
> 
> > ---
> >  arch/arm/mm/copypage-fa.c       | 34 ++++++------
> >  arch/arm/mm/copypage-feroceon.c | 97 +++++++++++++++++------------------
> >  arch/arm/mm/copypage-v4mc.c     | 18 +++----
> >  arch/arm/mm/copypage-v4wb.c     | 40 +++++++--------
> >  arch/arm/mm/copypage-v4wt.c     | 36 ++++++-------
> >  arch/arm/mm/copypage-xsc3.c     | 70 +++++++++++--------------
> >  arch/arm/mm/copypage-xscale.c   | 70 ++++++++++++-------------
> >  7 files changed, 171 insertions(+), 194 deletions(-)
> > 
> > diff --git a/arch/arm/mm/copypage-fa.c b/arch/arm/mm/copypage-fa.c
> > index d130a5ece5..453a3341ca 100644
> > --- a/arch/arm/mm/copypage-fa.c
> > +++ b/arch/arm/mm/copypage-fa.c
> > @@ -17,26 +17,24 @@
> >  /*
> >   * Faraday optimised copy_user_page
> >   */
> > -static void __naked
> > -fa_copy_user_page(void *kto, const void *kfrom)
> > +static void fa_copy_user_page(void *kto, const void *kfrom)
> >  {
> > -	asm("\
> > -	stmfd	sp!, {r4, lr}			@ 2\n\
> > -	mov	r2, %0				@ 1\n\
> > -1:	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
> > -	stmia	r0, {r3, r4, ip, lr}		@ 4\n\
> > -	mcr	p15, 0, r0, c7, c14, 1		@ 1   clean and invalidate D line\n\
> > -	add	r0, r0, #16			@ 1\n\
> > -	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
> > -	stmia	r0, {r3, r4, ip, lr}		@ 4\n\
> > -	mcr	p15, 0, r0, c7, c14, 1		@ 1   clean and invalidate D line\n\
> > -	add	r0, r0, #16			@ 1\n\
> > -	subs	r2, r2, #1			@ 1\n\
> > +	int tmp;
> 
> There should be an empty line here.

Yeah... there should.

> > +	asm volatile ("\
> > +1:	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
> > +	stmia	%0, {r3, r4, ip, lr}		@ 4\n\
> > +	mcr	p15, 0, %0, c7, c14, 1		@ 1   clean and invalidate D line\n\
> > +	add	%0, %0, #16			@ 1\n\
> > +	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
> > +	stmia	%0, {r3, r4, ip, lr}		@ 4\n\
> > +	mcr	p15, 0, %0, c7, c14, 1		@ 1   clean and invalidate D line\n\
> > +	add	%0, %0, #16			@ 1\n\
> > +	subs	%2, %2, #1			@ 1\n\
> >  	bne	1b				@ 1\n\
> > -	mcr	p15, 0, r2, c7, c10, 4		@ 1   drain WB\n\
> > -	ldmfd	sp!, {r4, pc}			@ 3"
> > -	:
> > -	: "I" (PAGE_SIZE / 32));
> > +	mcr	p15, 0, %2, c7, c10, 4		@ 1   drain WB"
> > +	: "+&r" (kto), "+&r" (kfrom), "=&r" "tmp)
> 
> There is sneaked in a " before tmp instead of (.

Good catch.

I did compile-test all the existing defconfigs though. Apparently this 
file is not covered?

> > diff --git a/arch/arm/mm/copypage-feroceon.c b/arch/arm/mm/copypage-feroceon.c
> > index 49ee0c1a72..1349430c63 100644
> > --- a/arch/arm/mm/copypage-feroceon.c
> > +++ b/arch/arm/mm/copypage-feroceon.c
> > @@ -13,58 +13,55 @@
> >  #include <linux/init.h>
> >  #include <linux/highmem.h>
> >  
> > -static void __naked
> > -feroceon_copy_user_page(void *kto, const void *kfrom)
> > +static void feroceon_copy_user_page(void *kto, const void *kfrom)
> >  {
> > -	asm("\
> > -	stmfd	sp!, {r4-r9, lr}		\n\
> > -	mov	ip, %2				\n\
> > -1:	mov	lr, r1				\n\
> > -	ldmia	r1!, {r2 - r9}			\n\
> > -	pld	[lr, #32]			\n\
> > -	pld	[lr, #64]			\n\
> > -	pld	[lr, #96]			\n\
> > -	pld	[lr, #128]			\n\
> > -	pld	[lr, #160]			\n\
> > -	pld	[lr, #192]			\n\
> > -	pld	[lr, #224]			\n\
> > -	stmia	r0, {r2 - r9}			\n\
> > -	ldmia	r1!, {r2 - r9}			\n\
> > -	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
> > -	add	r0, r0, #32			\n\
> > -	stmia	r0, {r2 - r9}			\n\
> > -	ldmia	r1!, {r2 - r9}			\n\
> > -	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
> > -	add	r0, r0, #32			\n\
> > -	stmia	r0, {r2 - r9}			\n\
> > -	ldmia	r1!, {r2 - r9}			\n\
> > -	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
> > -	add	r0, r0, #32			\n\
> > -	stmia	r0, {r2 - r9}			\n\
> > -	ldmia	r1!, {r2 - r9}			\n\
> > -	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
> > -	add	r0, r0, #32			\n\
> > -	stmia	r0, {r2 - r9}			\n\
> > -	ldmia	r1!, {r2 - r9}			\n\
> > -	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
> > -	add	r0, r0, #32			\n\
> > -	stmia	r0, {r2 - r9}			\n\
> > -	ldmia	r1!, {r2 - r9}			\n\
> > -	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
> > -	add	r0, r0, #32			\n\
> > -	stmia	r0, {r2 - r9}			\n\
> > -	ldmia	r1!, {r2 - r9}			\n\
> > -	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
> > -	add	r0, r0, #32			\n\
> > -	stmia	r0, {r2 - r9}			\n\
> > -	subs	ip, ip, #(32 * 8)		\n\
> > -	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
> > -	add	r0, r0, #32			\n\
> > +	int tmp;
> 
> Newline here?
> 
> > +	asm volatile ("\
> > +1:	ldmia	%1!, {r2 - r7, ip, lr}		\n\
> > +	pld	[%1, #0]			\n\
> > +	pld	[%1, #32]			\n\
> > +	pld	[%1, #64]			\n\
> > +	pld	[%1, #96]			\n\
> > +	pld	[%1, #128]			\n\
> > +	pld	[%1, #160]			\n\
> > +	pld	[%1, #192]			\n\
> 
> I see you shifted this by 32 bytes, but the stmia/ldmia below actually
> move 256 bytes, so we probably should keep pld	[lr, #224] here?

No. If you look at the original code:

1:	mov     lr, r1                          # lr = r1 = start
	ldmia   r1!, {r2 - r9}                  # now r1 == lr + 32
	pld     [lr, #32]                       # [lr, #32] == [r1, #0]
	pld     [lr, #64]                       # [lr, #64] == [r1, #32]
	pld     [lr, #96]                       # [lr, #96] == [r1, #64]
	...
	pld     [lr, #224]                      # [lr, #224] == [r1, #192]

So the new code gets rid of lr.

> > +	stmia	%0, {r2 - r7, ip, lr}		\n\
> > +	ldmia	%1!, {r2 - r7, ip, lr}		\n\
> > +	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
> > +	add	%0, %0, #32			\n\
> > +	stmia	%0, {r2 - r7, ip, lr}		\n\
> > +	ldmia	%1!, {r2 - r7, ip, lr}		\n\
> > +	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
> > +	add	%0, %0, #32			\n\
> > +	stmia	%0, {r2 - r7, ip, lr}		\n\
> > +	ldmia	%1!, {r2 - r7, ip, lr}		\n\
> > +	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
> > +	add	%0, %0, #32			\n\
> > +	stmia	%0, {r2 - r7, ip, lr}		\n\
> > +	ldmia	%1!, {r2 - r7, ip, lr}		\n\
> > +	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
> > +	add	%0, %0, #32			\n\
> > +	stmia	%0, {r2 - r7, ip, lr}		\n\
> > +	ldmia	%1!, {r2 - r7, ip, lr}		\n\
> > +	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
> > +	add	%0, %0, #32			\n\
> > +	stmia	%0, {r2 - r7, ip, lr}		\n\
> > +	ldmia	%1!, {r2 - r7, ip, lr}		\n\
> > +	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
> > +	add	%0, %0, #32			\n\
> > +	stmia	%0, {r2 - r7, ip, lr}		\n\
> > +	ldmia	%1!, {r2 - r7, ip, lr}		\n\
> > +	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
> > +	add	%0, %0, #32			\n\
> > +	stmia	%0, {r2 - r7, ip, lr}		\n\
> > +	subs	%2, %2, #(32 * 8)		\n\
> > +	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
> > +	add	%0, %0, #32			\n\
> >  	bne	1b				\n\
> > -	mcr	p15, 0, ip, c7, c10, 4		@ drain WB\n\
> > -	ldmfd	sp!, {r4-r9, pc}"
> > -	:
> > -	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE));
> > +	mcr	p15, 0, %2, c7, c10, 4		@ drain WB"
> > +	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
> > +	: =2" (PAGE_SIZE),
> 
> That should be "2" I guess? Also the comma at the end should not be
> there.

Wow.  Something was odd with my compile-testing. That should have been 
caught.

> > +	asm volatile ("\
> > +	pld	[%1, #0]			\n\
> > +	pld	[%1, #32]			\n\
> > +1:	pld	[%1, #64]			\n\
> > +	pld	[%1, #96]			\n\
> >  						\n\
> > -2:	ldrd	r2, [r1], #8			\n\
> > -	mov	ip, r0				\n\
> > -	ldrd	r4, [r1], #8			\n\
> > -	mcr	p15, 0, ip, c7, c6, 1		@ invalidate\n\
> > -	strd	r2, [r0], #8			\n\
> > -	ldrd	r2, [r1], #8			\n\
> > -	strd	r4, [r0], #8			\n\
> > -	ldrd	r4, [r1], #8			\n\
> > -	strd	r2, [r0], #8			\n\
> > -	strd	r4, [r0], #8			\n\
> > -	ldrd	r2, [r1], #8			\n\
> > -	mov	ip, r0				\n\
> > -	ldrd	r4, [r1], #8			\n\
> > -	mcr	p15, 0, ip, c7, c6, 1		@ invalidate\n\
> > -	strd	r2, [r0], #8			\n\
> > -	ldrd	r2, [r1], #8			\n\
> > -	subs	lr, lr, #1			\n\
> > -	strd	r4, [r0], #8			\n\
> > -	ldrd	r4, [r1], #8			\n\
> > -	strd	r2, [r0], #8			\n\
> > -	strd	r4, [r0], #8			\n\
> > +2:	ldrd	r2, [%1], #8			\n\
> > +	ldrd	r4, [%1], #8			\n\
> > +	mcr	p15, 0, %0, c7, c6, 1		@ invalidate\n\
> > +	strd	r2, [%0], #8			\n\
> > +	ldrd	r2, [%1], #8			\n\
> > +	strd	r4, [%0], #8			\n\
> > +	ldrd	r4, [%1], #8			\n\
> > +	strd	r2, [%0], #8			\n\
> > +	strd	r4, [%0], #8			\n\
> > +	ldrd	r2, [%1], #8			\n\
> > +	ldrd	r4, [%1], #8			\n\
> > +	mcr	p15, 0, %0, c7, c6, 1		@ invalidate\n\
> > +	strd	r2, [%0], #8			\n\
> > +	ldrd	r2, [%1], #8			\n\
> > +	subs	%2, %2, #1			\n\
> > +	strd	r4, [%0], #8			\n\
> > +	ldrd	r4, [%1], #8			\n\
> > +	strd	r2, [%0], #8			\n\
> > +	strd	r4, [%0], #8			\n\
> >  	bgt	1b				\n\
> > -	beq	2b				\n\
> > -						\n\
> > -	ldmfd	sp!, {r4, r5, pc}"
> > -	:
> > -	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64 - 1));
> > +	beq	2b				"
> > +	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
> > +	: "2" (PAGE_SIZE / 64 - 1)
> > +	: "r2", "r3", "r4", "r5");
> 
> r3 and r5 are not used above, so no need to have them in the clobber
> list.

They are used. ldrd and strd instructions always use a pair of 
consecutive registers. So "ldrd r2, ..." loads into r2-r3 and "ldrd r4, ..." 
loads into r4-r5.

> > diff --git a/arch/arm/mm/copypage-xscale.c b/arch/arm/mm/copypage-xscale.c
> > index 97972379f4..fa0be66082 100644
> > --- a/arch/arm/mm/copypage-xscale.c
> > +++ b/arch/arm/mm/copypage-xscale.c
> > @@ -36,52 +36,50 @@ static DEFINE_RAW_SPINLOCK(minicache_lock);
> >   * Dcache aliasing issue.  The writes will be forwarded to the write buffer,
> >   * and merged as appropriate.
> >   */
> > -static void __naked
> > -mc_copy_user_page(void *from, void *to)
> > +static void mc_copy_user_page(void *from, void *to)
> >  {
> > +	int tmp;
> >  	/*
> >  	 * Strangely enough, best performance is achieved
> >  	 * when prefetching destination as well.  (NP)
> >  	 */
> > -	asm volatile(
> > -	"stmfd	sp!, {r4, r5, lr}		\n\
> > -	mov	lr, %2				\n\
> > -	pld	[r0, #0]			\n\
> > -	pld	[r0, #32]			\n\
> > -	pld	[r1, #0]			\n\
> > -	pld	[r1, #32]			\n\
> > -1:	pld	[r0, #64]			\n\
> > -	pld	[r0, #96]			\n\
> > -	pld	[r1, #64]			\n\
> > -	pld	[r1, #96]			\n\
> > -2:	ldrd	r2, [r0], #8			\n\
> > -	ldrd	r4, [r0], #8			\n\
> > -	mov	ip, r1				\n\
> > -	strd	r2, [r1], #8			\n\
> > -	ldrd	r2, [r0], #8			\n\
> > -	strd	r4, [r1], #8			\n\
> > -	ldrd	r4, [r0], #8			\n\
> > -	strd	r2, [r1], #8			\n\
> > -	strd	r4, [r1], #8			\n\
> > +	asm volatile ("\
> > +	pld	[%0, #0]			\n\
> > +	pld	[%0, #32]			\n\
> > +	pld	[%1, #0]			\n\
> > +	pld	[%1, #32]			\n\
> > +1:	pld	[%0, #64]			\n\
> > +	pld	[%0, #96]			\n\
> > +	pld	[%1, #64]			\n\
> > +	pld	[%1, #96]			\n\
> > +2:	ldrd	r2, [%0], #8			\n\
> > +	ldrd	r4, [%0], #8			\n\
> > +	mov	ip, %1				\n\
> > +	strd	r2, [%1], #8			\n\
> > +	ldrd	r2, [%0], #8			\n\
> > +	strd	r4, [%1], #8			\n\
> > +	ldrd	r4, [%0], #8			\n\
> > +	strd	r2, [%1], #8			\n\
> > +	strd	r4, [%1], #8			\n\
> >  	mcr	p15, 0, ip, c7, c10, 1		@ clean D line\n\
> 
> How about using %1 here directly and skip the move to ip, as you did in
> copypage-xsc3.c above?

No. The cache line that needs cleaning is the line that we just wrote 
to. %1 is now pointing at the next cache line at this point. That is why 
%1 needs to be preserved into ip before it is incremented.

So here's the revised patch. It now has full compile-test coverage for 
real this time. Would you mind reviewing it again before I resubmit it 
please?

----- >8
Subject: [PATCH] remove unneeded naked function usage

Convert page copy functions not to rely on the naked function attribute.

This attribute is known to confuse some old gcc versions when function
arguments aren't explicitly listed as inline assembly operands despite
the gcc documentation. That resulted in commit 9a40ac86152c ("ARM:
6164/1: Add kto and kfrom to input operands list.").

Yet that commit has problems of its own by having assembly operand
constraints completely wrong. If the generated code has been OK since
then, it is due to luck rather than correctness. So this patch also
provides proper assembly operand constraints, and removes two instances
of redundant register usages in the implementation while at it.

Inspection of the generated code with this patch doesn't show any obvious
quality degradation either, so not relying on __naked at all will make
the code less fragile, and avoid some issues with clang.

The only remaining __naked instances (excluding the kprobes test cases)
are exynos_pm_power_up_setup(), tc2_pm_power_up_setup() and
cci_enable_port_for_self(. But in the first two cases, only the function
address is used by the compiler with no chance of inlining it by 
mistake, and the third case is called from assembly code only.
And the fact that no stack is available when the corresponding code is
executed does warrant the __naked usage in those cases.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/arch/arm/mm/copypage-fa.c b/arch/arm/mm/copypage-fa.c
index d130a5ece5..bf24690ec8 100644
--- a/arch/arm/mm/copypage-fa.c
+++ b/arch/arm/mm/copypage-fa.c
@@ -17,26 +17,25 @@
 /*
  * Faraday optimised copy_user_page
  */
-static void __naked
-fa_copy_user_page(void *kto, const void *kfrom)
+static void fa_copy_user_page(void *kto, const void *kfrom)
 {
-	asm("\
-	stmfd	sp!, {r4, lr}			@ 2\n\
-	mov	r2, %0				@ 1\n\
-1:	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
-	stmia	r0, {r3, r4, ip, lr}		@ 4\n\
-	mcr	p15, 0, r0, c7, c14, 1		@ 1   clean and invalidate D line\n\
-	add	r0, r0, #16			@ 1\n\
-	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
-	stmia	r0, {r3, r4, ip, lr}		@ 4\n\
-	mcr	p15, 0, r0, c7, c14, 1		@ 1   clean and invalidate D line\n\
-	add	r0, r0, #16			@ 1\n\
-	subs	r2, r2, #1			@ 1\n\
+	int tmp;
+
+	asm volatile ("\
+1:	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
+	stmia	%0, {r3, r4, ip, lr}		@ 4\n\
+	mcr	p15, 0, %0, c7, c14, 1		@ 1   clean and invalidate D line\n\
+	add	%0, %0, #16			@ 1\n\
+	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
+	stmia	%0, {r3, r4, ip, lr}		@ 4\n\
+	mcr	p15, 0, %0, c7, c14, 1		@ 1   clean and invalidate D line\n\
+	add	%0, %0, #16			@ 1\n\
+	subs	%2, %2, #1			@ 1\n\
 	bne	1b				@ 1\n\
-	mcr	p15, 0, r2, c7, c10, 4		@ 1   drain WB\n\
-	ldmfd	sp!, {r4, pc}			@ 3"
-	:
-	: "I" (PAGE_SIZE / 32));
+	mcr	p15, 0, %2, c7, c10, 4		@ 1   drain WB"
+	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
+	: "2" (PAGE_SIZE / 32)
+	: "r3", "r4", "ip", "lr");
 }
 
 void fa_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-feroceon.c b/arch/arm/mm/copypage-feroceon.c
index 49ee0c1a72..cc819732d9 100644
--- a/arch/arm/mm/copypage-feroceon.c
+++ b/arch/arm/mm/copypage-feroceon.c
@@ -13,58 +13,56 @@
 #include <linux/init.h>
 #include <linux/highmem.h>
 
-static void __naked
-feroceon_copy_user_page(void *kto, const void *kfrom)
+static void feroceon_copy_user_page(void *kto, const void *kfrom)
 {
-	asm("\
-	stmfd	sp!, {r4-r9, lr}		\n\
-	mov	ip, %2				\n\
-1:	mov	lr, r1				\n\
-	ldmia	r1!, {r2 - r9}			\n\
-	pld	[lr, #32]			\n\
-	pld	[lr, #64]			\n\
-	pld	[lr, #96]			\n\
-	pld	[lr, #128]			\n\
-	pld	[lr, #160]			\n\
-	pld	[lr, #192]			\n\
-	pld	[lr, #224]			\n\
-	stmia	r0, {r2 - r9}			\n\
-	ldmia	r1!, {r2 - r9}			\n\
-	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
-	add	r0, r0, #32			\n\
-	stmia	r0, {r2 - r9}			\n\
-	ldmia	r1!, {r2 - r9}			\n\
-	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
-	add	r0, r0, #32			\n\
-	stmia	r0, {r2 - r9}			\n\
-	ldmia	r1!, {r2 - r9}			\n\
-	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
-	add	r0, r0, #32			\n\
-	stmia	r0, {r2 - r9}			\n\
-	ldmia	r1!, {r2 - r9}			\n\
-	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
-	add	r0, r0, #32			\n\
-	stmia	r0, {r2 - r9}			\n\
-	ldmia	r1!, {r2 - r9}			\n\
-	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
-	add	r0, r0, #32			\n\
-	stmia	r0, {r2 - r9}			\n\
-	ldmia	r1!, {r2 - r9}			\n\
-	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
-	add	r0, r0, #32			\n\
-	stmia	r0, {r2 - r9}			\n\
-	ldmia	r1!, {r2 - r9}			\n\
-	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
-	add	r0, r0, #32			\n\
-	stmia	r0, {r2 - r9}			\n\
-	subs	ip, ip, #(32 * 8)		\n\
-	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
-	add	r0, r0, #32			\n\
+	int tmp;
+
+	asm volatile ("\
+1:	ldmia	%1!, {r2 - r7, ip, lr}		\n\
+	pld	[%1, #0]			\n\
+	pld	[%1, #32]			\n\
+	pld	[%1, #64]			\n\
+	pld	[%1, #96]			\n\
+	pld	[%1, #128]			\n\
+	pld	[%1, #160]			\n\
+	pld	[%1, #192]			\n\
+	stmia	%0, {r2 - r7, ip, lr}		\n\
+	ldmia	%1!, {r2 - r7, ip, lr}		\n\
+	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
+	add	%0, %0, #32			\n\
+	stmia	%0, {r2 - r7, ip, lr}		\n\
+	ldmia	%1!, {r2 - r7, ip, lr}		\n\
+	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
+	add	%0, %0, #32			\n\
+	stmia	%0, {r2 - r7, ip, lr}		\n\
+	ldmia	%1!, {r2 - r7, ip, lr}		\n\
+	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
+	add	%0, %0, #32			\n\
+	stmia	%0, {r2 - r7, ip, lr}		\n\
+	ldmia	%1!, {r2 - r7, ip, lr}		\n\
+	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
+	add	%0, %0, #32			\n\
+	stmia	%0, {r2 - r7, ip, lr}		\n\
+	ldmia	%1!, {r2 - r7, ip, lr}		\n\
+	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
+	add	%0, %0, #32			\n\
+	stmia	%0, {r2 - r7, ip, lr}		\n\
+	ldmia	%1!, {r2 - r7, ip, lr}		\n\
+	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
+	add	%0, %0, #32			\n\
+	stmia	%0, {r2 - r7, ip, lr}		\n\
+	ldmia	%1!, {r2 - r7, ip, lr}		\n\
+	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
+	add	%0, %0, #32			\n\
+	stmia	%0, {r2 - r7, ip, lr}		\n\
+	subs	%2, %2, #(32 * 8)		\n\
+	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
+	add	%0, %0, #32			\n\
 	bne	1b				\n\
-	mcr	p15, 0, ip, c7, c10, 4		@ drain WB\n\
-	ldmfd	sp!, {r4-r9, pc}"
-	:
-	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE));
+	mcr	p15, 0, %2, c7, c10, 4		@ drain WB"
+	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
+	: "2" (PAGE_SIZE)
+	: "r2", "r3", "r4", "r5", "r6", "r7", "ip", "lr");
 }
 
 void feroceon_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-v4mc.c b/arch/arm/mm/copypage-v4mc.c
index 0224416cba..b03202cddd 100644
--- a/arch/arm/mm/copypage-v4mc.c
+++ b/arch/arm/mm/copypage-v4mc.c
@@ -40,12 +40,11 @@ static DEFINE_RAW_SPINLOCK(minicache_lock);
  * instruction.  If your processor does not supply this, you have to write your
  * own copy_user_highpage that does the right thing.
  */
-static void __naked
-mc_copy_user_page(void *from, void *to)
+static void mc_copy_user_page(void *from, void *to)
 {
-	asm volatile(
-	"stmfd	sp!, {r4, lr}			@ 2\n\
-	mov	r4, %2				@ 1\n\
+	int tmp;
+
+	asm volatile ("\
 	ldmia	%0!, {r2, r3, ip, lr}		@ 4\n\
 1:	mcr	p15, 0, %1, c7, c6, 1		@ 1   invalidate D line\n\
 	stmia	%1!, {r2, r3, ip, lr}		@ 4\n\
@@ -55,13 +54,13 @@ mc_copy_user_page(void *from, void *to)
 	mcr	p15, 0, %1, c7, c6, 1		@ 1   invalidate D line\n\
 	stmia	%1!, {r2, r3, ip, lr}		@ 4\n\
 	ldmia	%0!, {r2, r3, ip, lr}		@ 4\n\
-	subs	r4, r4, #1			@ 1\n\
+	subs	%2, %2, #1			@ 1\n\
 	stmia	%1!, {r2, r3, ip, lr}		@ 4\n\
 	ldmneia	%0!, {r2, r3, ip, lr}		@ 4\n\
-	bne	1b				@ 1\n\
-	ldmfd	sp!, {r4, pc}			@ 3"
-	:
-	: "r" (from), "r" (to), "I" (PAGE_SIZE / 64));
+	bne	1b				@ "
+	: "+&r" (from), "+&r" (to), "=&r" (tmp)
+	: "2" (PAGE_SIZE / 64)
+	: "r2", "r3", "ip", "lr");
 }
 
 void v4_mc_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-v4wb.c b/arch/arm/mm/copypage-v4wb.c
index 067d0fdd63..cd3e165afe 100644
--- a/arch/arm/mm/copypage-v4wb.c
+++ b/arch/arm/mm/copypage-v4wb.c
@@ -22,29 +22,28 @@
  * instruction.  If your processor does not supply this, you have to write your
  * own copy_user_highpage that does the right thing.
  */
-static void __naked
-v4wb_copy_user_page(void *kto, const void *kfrom)
+static void v4wb_copy_user_page(void *kto, const void *kfrom)
 {
-	asm("\
-	stmfd	sp!, {r4, lr}			@ 2\n\
-	mov	r2, %2				@ 1\n\
-	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
-1:	mcr	p15, 0, r0, c7, c6, 1		@ 1   invalidate D line\n\
-	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
-	ldmia	r1!, {r3, r4, ip, lr}		@ 4+1\n\
-	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
-	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
-	mcr	p15, 0, r0, c7, c6, 1		@ 1   invalidate D line\n\
-	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
-	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
-	subs	r2, r2, #1			@ 1\n\
-	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
-	ldmneia	r1!, {r3, r4, ip, lr}		@ 4\n\
+	int tmp;
+
+	asm volatile ("\
+	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
+1:	mcr	p15, 0, %0, c7, c6, 1		@ 1   invalidate D line\n\
+	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
+	ldmia	%1!, {r3, r4, ip, lr}		@ 4+1\n\
+	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
+	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
+	mcr	p15, 0, %0, c7, c6, 1		@ 1   invalidate D line\n\
+	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
+	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
+	subs	%2, %2, #1			@ 1\n\
+	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
+	ldmneia	%1!, {r3, r4, ip, lr}		@ 4\n\
 	bne	1b				@ 1\n\
-	mcr	p15, 0, r1, c7, c10, 4		@ 1   drain WB\n\
-	ldmfd	 sp!, {r4, pc}			@ 3"
-	:
-	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64));
+	mcr	p15, 0, %1, c7, c10, 4		@ 1   drain WB"
+	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
+	: "2" (PAGE_SIZE / 64)
+	: "r3", "r4", "ip", "lr");
 }
 
 void v4wb_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-v4wt.c b/arch/arm/mm/copypage-v4wt.c
index b85c5da2e5..8614572e12 100644
--- a/arch/arm/mm/copypage-v4wt.c
+++ b/arch/arm/mm/copypage-v4wt.c
@@ -20,27 +20,26 @@
  * dirty data in the cache.  However, we do have to ensure that
  * subsequent reads are up to date.
  */
-static void __naked
-v4wt_copy_user_page(void *kto, const void *kfrom)
+static void v4wt_copy_user_page(void *kto, const void *kfrom)
 {
-	asm("\
-	stmfd	sp!, {r4, lr}			@ 2\n\
-	mov	r2, %2				@ 1\n\
-	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
-1:	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
-	ldmia	r1!, {r3, r4, ip, lr}		@ 4+1\n\
-	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
-	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
-	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
-	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
-	subs	r2, r2, #1			@ 1\n\
-	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
-	ldmneia	r1!, {r3, r4, ip, lr}		@ 4\n\
+	int tmp;
+
+	asm volatile ("\
+	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
+1:	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
+	ldmia	%1!, {r3, r4, ip, lr}		@ 4+1\n\
+	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
+	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
+	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
+	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
+	subs	%2, %2, #1			@ 1\n\
+	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
+	ldmneia	%1!, {r3, r4, ip, lr}		@ 4\n\
 	bne	1b				@ 1\n\
-	mcr	p15, 0, r2, c7, c7, 0		@ flush ID cache\n\
-	ldmfd	sp!, {r4, pc}			@ 3"
-	:
-	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64));
+	mcr	p15, 0, %2, c7, c7, 0		@ flush ID cache"
+	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
+	: "2" (PAGE_SIZE / 64)
+	: "r3", "r4", "ip", "lr");
 }
 
 void v4wt_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-xsc3.c b/arch/arm/mm/copypage-xsc3.c
index 03a2042ace..55cbc3a89d 100644
--- a/arch/arm/mm/copypage-xsc3.c
+++ b/arch/arm/mm/copypage-xsc3.c
@@ -21,53 +21,46 @@
 
 /*
  * XSC3 optimised copy_user_highpage
- *  r0 = destination
- *  r1 = source
  *
  * The source page may have some clean entries in the cache already, but we
  * can safely ignore them - break_cow() will flush them out of the cache
  * if we eventually end up using our copied page.
  *
  */
-static void __naked
-xsc3_mc_copy_user_page(void *kto, const void *kfrom)
+static void xsc3_mc_copy_user_page(void *kto, const void *kfrom)
 {
-	asm("\
-	stmfd	sp!, {r4, r5, lr}		\n\
-	mov	lr, %2				\n\
-						\n\
-	pld	[r1, #0]			\n\
-	pld	[r1, #32]			\n\
-1:	pld	[r1, #64]			\n\
-	pld	[r1, #96]			\n\
+	int tmp;
+
+	asm volatile ("\
+	pld	[%1, #0]			\n\
+	pld	[%1, #32]			\n\
+1:	pld	[%1, #64]			\n\
+	pld	[%1, #96]			\n\
 						\n\
-2:	ldrd	r2, [r1], #8			\n\
-	mov	ip, r0				\n\
-	ldrd	r4, [r1], #8			\n\
-	mcr	p15, 0, ip, c7, c6, 1		@ invalidate\n\
-	strd	r2, [r0], #8			\n\
-	ldrd	r2, [r1], #8			\n\
-	strd	r4, [r0], #8			\n\
-	ldrd	r4, [r1], #8			\n\
-	strd	r2, [r0], #8			\n\
-	strd	r4, [r0], #8			\n\
-	ldrd	r2, [r1], #8			\n\
-	mov	ip, r0				\n\
-	ldrd	r4, [r1], #8			\n\
-	mcr	p15, 0, ip, c7, c6, 1		@ invalidate\n\
-	strd	r2, [r0], #8			\n\
-	ldrd	r2, [r1], #8			\n\
-	subs	lr, lr, #1			\n\
-	strd	r4, [r0], #8			\n\
-	ldrd	r4, [r1], #8			\n\
-	strd	r2, [r0], #8			\n\
-	strd	r4, [r0], #8			\n\
+2:	ldrd	r2, [%1], #8			\n\
+	ldrd	r4, [%1], #8			\n\
+	mcr	p15, 0, %0, c7, c6, 1		@ invalidate\n\
+	strd	r2, [%0], #8			\n\
+	ldrd	r2, [%1], #8			\n\
+	strd	r4, [%0], #8			\n\
+	ldrd	r4, [%1], #8			\n\
+	strd	r2, [%0], #8			\n\
+	strd	r4, [%0], #8			\n\
+	ldrd	r2, [%1], #8			\n\
+	ldrd	r4, [%1], #8			\n\
+	mcr	p15, 0, %0, c7, c6, 1		@ invalidate\n\
+	strd	r2, [%0], #8			\n\
+	ldrd	r2, [%1], #8			\n\
+	subs	%2, %2, #1			\n\
+	strd	r4, [%0], #8			\n\
+	ldrd	r4, [%1], #8			\n\
+	strd	r2, [%0], #8			\n\
+	strd	r4, [%0], #8			\n\
 	bgt	1b				\n\
-	beq	2b				\n\
-						\n\
-	ldmfd	sp!, {r4, r5, pc}"
-	:
-	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64 - 1));
+	beq	2b				"
+	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
+	: "2" (PAGE_SIZE / 64 - 1)
+	: "r2", "r3", "r4", "r5");
 }
 
 void xsc3_mc_copy_user_highpage(struct page *to, struct page *from,
@@ -85,8 +78,6 @@ void xsc3_mc_copy_user_highpage(struct page *to, struct page *from,
 
 /*
  * XScale optimised clear_user_page
- *  r0 = destination
- *  r1 = virtual user address of ultimate destination page
  */
 void xsc3_mc_clear_user_highpage(struct page *page, unsigned long vaddr)
 {
diff --git a/arch/arm/mm/copypage-xscale.c b/arch/arm/mm/copypage-xscale.c
index 97972379f4..b0ae8c7acb 100644
--- a/arch/arm/mm/copypage-xscale.c
+++ b/arch/arm/mm/copypage-xscale.c
@@ -36,52 +36,51 @@ static DEFINE_RAW_SPINLOCK(minicache_lock);
  * Dcache aliasing issue.  The writes will be forwarded to the write buffer,
  * and merged as appropriate.
  */
-static void __naked
-mc_copy_user_page(void *from, void *to)
+static void mc_copy_user_page(void *from, void *to)
 {
+	int tmp;
+
 	/*
 	 * Strangely enough, best performance is achieved
 	 * when prefetching destination as well.  (NP)
 	 */
-	asm volatile(
-	"stmfd	sp!, {r4, r5, lr}		\n\
-	mov	lr, %2				\n\
-	pld	[r0, #0]			\n\
-	pld	[r0, #32]			\n\
-	pld	[r1, #0]			\n\
-	pld	[r1, #32]			\n\
-1:	pld	[r0, #64]			\n\
-	pld	[r0, #96]			\n\
-	pld	[r1, #64]			\n\
-	pld	[r1, #96]			\n\
-2:	ldrd	r2, [r0], #8			\n\
-	ldrd	r4, [r0], #8			\n\
-	mov	ip, r1				\n\
-	strd	r2, [r1], #8			\n\
-	ldrd	r2, [r0], #8			\n\
-	strd	r4, [r1], #8			\n\
-	ldrd	r4, [r0], #8			\n\
-	strd	r2, [r1], #8			\n\
-	strd	r4, [r1], #8			\n\
+	asm volatile ("\
+	pld	[%0, #0]			\n\
+	pld	[%0, #32]			\n\
+	pld	[%1, #0]			\n\
+	pld	[%1, #32]			\n\
+1:	pld	[%0, #64]			\n\
+	pld	[%0, #96]			\n\
+	pld	[%1, #64]			\n\
+	pld	[%1, #96]			\n\
+2:	ldrd	r2, [%0], #8			\n\
+	ldrd	r4, [%0], #8			\n\
+	mov	ip, %1				\n\
+	strd	r2, [%1], #8			\n\
+	ldrd	r2, [%0], #8			\n\
+	strd	r4, [%1], #8			\n\
+	ldrd	r4, [%0], #8			\n\
+	strd	r2, [%1], #8			\n\
+	strd	r4, [%1], #8			\n\
 	mcr	p15, 0, ip, c7, c10, 1		@ clean D line\n\
-	ldrd	r2, [r0], #8			\n\
+	ldrd	r2, [%0], #8			\n\
 	mcr	p15, 0, ip, c7, c6, 1		@ invalidate D line\n\
-	ldrd	r4, [r0], #8			\n\
-	mov	ip, r1				\n\
-	strd	r2, [r1], #8			\n\
-	ldrd	r2, [r0], #8			\n\
-	strd	r4, [r1], #8			\n\
-	ldrd	r4, [r0], #8			\n\
-	strd	r2, [r1], #8			\n\
-	strd	r4, [r1], #8			\n\
+	ldrd	r4, [%0], #8			\n\
+	mov	ip, %1				\n\
+	strd	r2, [%1], #8			\n\
+	ldrd	r2, [%0], #8			\n\
+	strd	r4, [%1], #8			\n\
+	ldrd	r4, [%0], #8			\n\
+	strd	r2, [%1], #8			\n\
+	strd	r4, [%1], #8			\n\
 	mcr	p15, 0, ip, c7, c10, 1		@ clean D line\n\
-	subs	lr, lr, #1			\n\
+	subs	%2, %2, #1			\n\
 	mcr	p15, 0, ip, c7, c6, 1		@ invalidate D line\n\
 	bgt	1b				\n\
-	beq	2b				\n\
-	ldmfd	sp!, {r4, r5, pc}		"
-	:
-	: "r" (from), "r" (to), "I" (PAGE_SIZE / 64 - 1));
+	beq	2b				"
+	: "+&r" (from), "+&r" (to), "=&r" (tmp)
+	: "2" (PAGE_SIZE / 64 - 1)
+	: "r2", "r3", "r4", "r5", "ip");
 }
 
 void xscale_mc_copy_user_highpage(struct page *to, struct page *from,
