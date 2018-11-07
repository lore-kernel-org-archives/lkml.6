Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79891C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0769C2086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="nebVwnBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0769C2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbeKHB62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:58:28 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:59758 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbeKHB62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:58:28 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id B01025C02D9;
        Wed,  7 Nov 2018 17:27:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1541608039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WRq+6uYcKXr+42w3fppjRC45AsQq8IsOCr7eJmzVjl4=;
        b=nebVwnBj2sQJ0hoA3b7Ej6XCQRawCKUfkjgTYJC+Lg3nFuFwRlCIrPSjB0BKGARad/rKwF
        rSehfXqHcV19xJwV6z+iz+ZO+lkiGoH/QT72K66oPDbMMistSzn2Sa1OTeQBzwciRPopWs
        yIkt/anFBZt68c+KKzZB9k0gXw3jbO0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 07 Nov 2018 17:27:19 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Roman Yeryomin <roman@advem.lv>
Subject: Re: [PATCH 1/2] ARM: copypage-fa: add kto and kfrom to input operands
 list
In-Reply-To: <nycvar.YSQ.7.76.1811052231220.1498@knanqh.ubzr>
References: <20181015221629.13924-1-stefan@agner.ch>
 <CACRpkdaVGKLtE-whhK3oFgY+4xoy1JqWkcBW4UO0-hJs2B-QGg@mail.gmail.com>
 <20181016084416.GF30658@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1810161357580.1498@knanqh.ubzr>
 <fe7595f5d02424c9d92e437cd20361f9@agner.ch>
 <nycvar.YSQ.7.76.1811052231220.1498@knanqh.ubzr>
Message-ID: <806401fd406b1391fd3a9f5e072c107a@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.11.2018 05:49, Nicolas Pitre wrote:
> On Tue, 6 Nov 2018, Stefan Agner wrote:
> 
>> On 16.10.2018 22:43, Nicolas Pitre wrote:
>> > Subject: [PATCH] ARM: remove naked function usage
>> >
>> > Convert page copy functions not to rely on the naked function attribute.
>> >
>> > This attribute is known to confuse some gcc versions when function
>> > arguments aren't explicitly listed as inline assembly operands despite
>> > the gcc documentation. That resulted in commit 9a40ac86152c ("ARM:
>> > 6164/1: Add kto and kfrom to input operands list.").
>> >
>> > Yet that commit has problems of its own by having assembly operand
>> > constraints completely wrong. If the generated code has been OK since
>> > then, it is due to luck rather than correctness. So this patch provides
>> > proper assembly operand usage, and removes two instances of redundant
>> > register duplications in the implementation while at it.
>> >
>> > Inspection of the generated code with this patch doesn't show any obvious
>> > quality degradation either, so not relying on __naked at all will make
>> > the code less fragile, and more likely to be compilable with clang.
>> >
>> > The only remaining __naked instances (excluding the kprobes test cases)
>> > are exynos_pm_power_up_setup() and tc2_pm_power_up_setup(). But in those
>> > cases only the function address is used by the compiler with no chance of
>> > inlining it by mistake.
>> >
>> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
>>
>> As mentioned a couple of weeks ago, I did test this patchset on two
>> architectures (pxa_defconfig -> copypage-xscale.c and
>> versatile_defconfig -> copypage-v4wb.c).
>>
>> I really like this approach, can we move forward with this?
> 
> Yes, the patch was submitted to the patch tracker a few days later.
> 

Oh sorry, didn't realize that!

<snip>
>> > +	asm volatile ("\
>> > +	pld	[%1, #0]			\n\
>> > +	pld	[%1, #32]			\n\
>> > +1:	pld	[%1, #64]			\n\
>> > +	pld	[%1, #96]			\n\
>> >  						\n\
>> > -2:	ldrd	r2, [r1], #8			\n\
>> > -	mov	ip, r0				\n\
>> > -	ldrd	r4, [r1], #8			\n\
>> > -	mcr	p15, 0, ip, c7, c6, 1		@ invalidate\n\
>> > -	strd	r2, [r0], #8			\n\
>> > -	ldrd	r2, [r1], #8			\n\
>> > -	strd	r4, [r0], #8			\n\
>> > -	ldrd	r4, [r1], #8			\n\
>> > -	strd	r2, [r0], #8			\n\
>> > -	strd	r4, [r0], #8			\n\
>> > -	ldrd	r2, [r1], #8			\n\
>> > -	mov	ip, r0				\n\
>> > -	ldrd	r4, [r1], #8			\n\
>> > -	mcr	p15, 0, ip, c7, c6, 1		@ invalidate\n\
>> > -	strd	r2, [r0], #8			\n\
>> > -	ldrd	r2, [r1], #8			\n\
>> > -	subs	lr, lr, #1			\n\
>> > -	strd	r4, [r0], #8			\n\
>> > -	ldrd	r4, [r1], #8			\n\
>> > -	strd	r2, [r0], #8			\n\
>> > -	strd	r4, [r0], #8			\n\
>> > +2:	ldrd	r2, [%1], #8			\n\
>> > +	ldrd	r4, [%1], #8			\n\
>> > +	mcr	p15, 0, %0, c7, c6, 1		@ invalidate\n\
>> > +	strd	r2, [%0], #8			\n\
>> > +	ldrd	r2, [%1], #8			\n\
>> > +	strd	r4, [%0], #8			\n\
>> > +	ldrd	r4, [%1], #8			\n\
>> > +	strd	r2, [%0], #8			\n\
>> > +	strd	r4, [%0], #8			\n\
>> > +	ldrd	r2, [%1], #8			\n\
>> > +	ldrd	r4, [%1], #8			\n\
>> > +	mcr	p15, 0, %0, c7, c6, 1		@ invalidate\n\
>> > +	strd	r2, [%0], #8			\n\
>> > +	ldrd	r2, [%1], #8			\n\
>> > +	subs	%2, %2, #1			\n\
>> > +	strd	r4, [%0], #8			\n\
>> > +	ldrd	r4, [%1], #8			\n\
>> > +	strd	r2, [%0], #8			\n\
>> > +	strd	r4, [%0], #8			\n\
>> >  	bgt	1b				\n\
>> > -	beq	2b				\n\
>> > -						\n\
>> > -	ldmfd	sp!, {r4, r5, pc}"
>> > -	:
>> > -	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64 - 1));
>> > +	beq	2b				"
>> > +	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
>> > +	: "2" (PAGE_SIZE / 64 - 1)
>> > +	: "r2", "r3", "r4", "r5");
>>
>> r3 and r5 are not used above, so no need to have them in the clobber
>> list.
> 
> They are used. ldrd and strd instructions always use a pair of 
> consecutive registers. So "ldrd r2, ..." loads into r2-r3 and "ldrd r4, ..." 
> loads into r4-r5.

Oh I see. The clobber list is fine then!

> 
>> > diff --git a/arch/arm/mm/copypage-xscale.c b/arch/arm/mm/copypage-xscale.c
>> > index 97972379f4..fa0be66082 100644
>> > --- a/arch/arm/mm/copypage-xscale.c
>> > +++ b/arch/arm/mm/copypage-xscale.c
>> > @@ -36,52 +36,50 @@ static DEFINE_RAW_SPINLOCK(minicache_lock);
>> >   * Dcache aliasing issue.  The writes will be forwarded to the write buffer,
>> >   * and merged as appropriate.
>> >   */
>> > -static void __naked
>> > -mc_copy_user_page(void *from, void *to)
>> > +static void mc_copy_user_page(void *from, void *to)
>> >  {
>> > +	int tmp;
>> >  	/*
>> >  	 * Strangely enough, best performance is achieved
>> >  	 * when prefetching destination as well.  (NP)
>> >  	 */
>> > -	asm volatile(
>> > -	"stmfd	sp!, {r4, r5, lr}		\n\
>> > -	mov	lr, %2				\n\
>> > -	pld	[r0, #0]			\n\
>> > -	pld	[r0, #32]			\n\
>> > -	pld	[r1, #0]			\n\
>> > -	pld	[r1, #32]			\n\
>> > -1:	pld	[r0, #64]			\n\
>> > -	pld	[r0, #96]			\n\
>> > -	pld	[r1, #64]			\n\
>> > -	pld	[r1, #96]			\n\
>> > -2:	ldrd	r2, [r0], #8			\n\
>> > -	ldrd	r4, [r0], #8			\n\
>> > -	mov	ip, r1				\n\
>> > -	strd	r2, [r1], #8			\n\
>> > -	ldrd	r2, [r0], #8			\n\
>> > -	strd	r4, [r1], #8			\n\
>> > -	ldrd	r4, [r0], #8			\n\
>> > -	strd	r2, [r1], #8			\n\
>> > -	strd	r4, [r1], #8			\n\
>> > +	asm volatile ("\
>> > +	pld	[%0, #0]			\n\
>> > +	pld	[%0, #32]			\n\
>> > +	pld	[%1, #0]			\n\
>> > +	pld	[%1, #32]			\n\
>> > +1:	pld	[%0, #64]			\n\
>> > +	pld	[%0, #96]			\n\
>> > +	pld	[%1, #64]			\n\
>> > +	pld	[%1, #96]			\n\
>> > +2:	ldrd	r2, [%0], #8			\n\
>> > +	ldrd	r4, [%0], #8			\n\
>> > +	mov	ip, %1				\n\
>> > +	strd	r2, [%1], #8			\n\
>> > +	ldrd	r2, [%0], #8			\n\
>> > +	strd	r4, [%1], #8			\n\
>> > +	ldrd	r4, [%0], #8			\n\
>> > +	strd	r2, [%1], #8			\n\
>> > +	strd	r4, [%1], #8			\n\
>> >  	mcr	p15, 0, ip, c7, c10, 1		@ clean D line\n\
>>
>> How about using %1 here directly and skip the move to ip, as you did in
>> copypage-xsc3.c above?
> 
> No. The cache line that needs cleaning is the line that we just wrote 
> to. %1 is now pointing at the next cache line at this point. That is why 
> %1 needs to be preserved into ip before it is incremented.

Got it, in copypage-xsc3.c r0 got copied before the first strd.

> 
> So here's the revised patch. It now has full compile-test coverage for 
> real this time. Would you mind reviewing it again before I resubmit it 
> please?

Compile tested all copypage implementations with the revised patch using
Clang too, everything builds fine.

FWIW, I used this defconfigs:
copypage-fa.c: moxart_defconfig
copypage-feroceon.c: mvebu_v5_defconfig
copypage-v4mc.c: h3600_defconfig+CONFIG_AEABI
copypage-v4wb.c/v4wt.c: multi_v4t_defconfig
copypage-xsc3.c/scale.c: pxa_defconfig-CONFIG_FTRACE

The changes look good to me:

Reviewed-by: Stefan Agner <stefan@agner.ch>

> 
> ----- >8
> Subject: [PATCH] remove unneeded naked function usage
> 
> Convert page copy functions not to rely on the naked function attribute.
> 
> This attribute is known to confuse some old gcc versions when function
> arguments aren't explicitly listed as inline assembly operands despite
> the gcc documentation. That resulted in commit 9a40ac86152c ("ARM:
> 6164/1: Add kto and kfrom to input operands list.").
> 
> Yet that commit has problems of its own by having assembly operand
> constraints completely wrong. If the generated code has been OK since
> then, it is due to luck rather than correctness. So this patch also
> provides proper assembly operand constraints, and removes two instances
> of redundant register usages in the implementation while at it.
> 
> Inspection of the generated code with this patch doesn't show any obvious
> quality degradation either, so not relying on __naked at all will make
> the code less fragile, and avoid some issues with clang.
> 
> The only remaining __naked instances (excluding the kprobes test cases)
> are exynos_pm_power_up_setup(), tc2_pm_power_up_setup() and
> cci_enable_port_for_self(. But in the first two cases, only the function
> address is used by the compiler with no chance of inlining it by 
> mistake, and the third case is called from assembly code only.
> And the fact that no stack is available when the corresponding code is
> executed does warrant the __naked usage in those cases.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> 
> diff --git a/arch/arm/mm/copypage-fa.c b/arch/arm/mm/copypage-fa.c
> index d130a5ece5..bf24690ec8 100644
> --- a/arch/arm/mm/copypage-fa.c
> +++ b/arch/arm/mm/copypage-fa.c
> @@ -17,26 +17,25 @@
>  /*
>   * Faraday optimised copy_user_page
>   */
> -static void __naked
> -fa_copy_user_page(void *kto, const void *kfrom)
> +static void fa_copy_user_page(void *kto, const void *kfrom)
>  {
> -	asm("\
> -	stmfd	sp!, {r4, lr}			@ 2\n\
> -	mov	r2, %0				@ 1\n\
> -1:	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
> -	stmia	r0, {r3, r4, ip, lr}		@ 4\n\
> -	mcr	p15, 0, r0, c7, c14, 1		@ 1   clean and invalidate D line\n\
> -	add	r0, r0, #16			@ 1\n\
> -	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
> -	stmia	r0, {r3, r4, ip, lr}		@ 4\n\
> -	mcr	p15, 0, r0, c7, c14, 1		@ 1   clean and invalidate D line\n\
> -	add	r0, r0, #16			@ 1\n\
> -	subs	r2, r2, #1			@ 1\n\
> +	int tmp;
> +
> +	asm volatile ("\
> +1:	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
> +	stmia	%0, {r3, r4, ip, lr}		@ 4\n\
> +	mcr	p15, 0, %0, c7, c14, 1		@ 1   clean and invalidate D line\n\
> +	add	%0, %0, #16			@ 1\n\
> +	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
> +	stmia	%0, {r3, r4, ip, lr}		@ 4\n\
> +	mcr	p15, 0, %0, c7, c14, 1		@ 1   clean and invalidate D line\n\
> +	add	%0, %0, #16			@ 1\n\
> +	subs	%2, %2, #1			@ 1\n\
>  	bne	1b				@ 1\n\
> -	mcr	p15, 0, r2, c7, c10, 4		@ 1   drain WB\n\
> -	ldmfd	sp!, {r4, pc}			@ 3"
> -	:
> -	: "I" (PAGE_SIZE / 32));
> +	mcr	p15, 0, %2, c7, c10, 4		@ 1   drain WB"
> +	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
> +	: "2" (PAGE_SIZE / 32)
> +	: "r3", "r4", "ip", "lr");
>  }
>  
>  void fa_copy_user_highpage(struct page *to, struct page *from,
> diff --git a/arch/arm/mm/copypage-feroceon.c b/arch/arm/mm/copypage-feroceon.c
> index 49ee0c1a72..cc819732d9 100644
> --- a/arch/arm/mm/copypage-feroceon.c
> +++ b/arch/arm/mm/copypage-feroceon.c
> @@ -13,58 +13,56 @@
>  #include <linux/init.h>
>  #include <linux/highmem.h>
>  
> -static void __naked
> -feroceon_copy_user_page(void *kto, const void *kfrom)
> +static void feroceon_copy_user_page(void *kto, const void *kfrom)
>  {
> -	asm("\
> -	stmfd	sp!, {r4-r9, lr}		\n\
> -	mov	ip, %2				\n\
> -1:	mov	lr, r1				\n\
> -	ldmia	r1!, {r2 - r9}			\n\
> -	pld	[lr, #32]			\n\
> -	pld	[lr, #64]			\n\
> -	pld	[lr, #96]			\n\
> -	pld	[lr, #128]			\n\
> -	pld	[lr, #160]			\n\
> -	pld	[lr, #192]			\n\
> -	pld	[lr, #224]			\n\
> -	stmia	r0, {r2 - r9}			\n\
> -	ldmia	r1!, {r2 - r9}			\n\
> -	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
> -	add	r0, r0, #32			\n\
> -	stmia	r0, {r2 - r9}			\n\
> -	ldmia	r1!, {r2 - r9}			\n\
> -	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
> -	add	r0, r0, #32			\n\
> -	stmia	r0, {r2 - r9}			\n\
> -	ldmia	r1!, {r2 - r9}			\n\
> -	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
> -	add	r0, r0, #32			\n\
> -	stmia	r0, {r2 - r9}			\n\
> -	ldmia	r1!, {r2 - r9}			\n\
> -	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
> -	add	r0, r0, #32			\n\
> -	stmia	r0, {r2 - r9}			\n\
> -	ldmia	r1!, {r2 - r9}			\n\
> -	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
> -	add	r0, r0, #32			\n\
> -	stmia	r0, {r2 - r9}			\n\
> -	ldmia	r1!, {r2 - r9}			\n\
> -	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
> -	add	r0, r0, #32			\n\
> -	stmia	r0, {r2 - r9}			\n\
> -	ldmia	r1!, {r2 - r9}			\n\
> -	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
> -	add	r0, r0, #32			\n\
> -	stmia	r0, {r2 - r9}			\n\
> -	subs	ip, ip, #(32 * 8)		\n\
> -	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
> -	add	r0, r0, #32			\n\
> +	int tmp;
> +
> +	asm volatile ("\
> +1:	ldmia	%1!, {r2 - r7, ip, lr}		\n\
> +	pld	[%1, #0]			\n\
> +	pld	[%1, #32]			\n\
> +	pld	[%1, #64]			\n\
> +	pld	[%1, #96]			\n\
> +	pld	[%1, #128]			\n\
> +	pld	[%1, #160]			\n\
> +	pld	[%1, #192]			\n\
> +	stmia	%0, {r2 - r7, ip, lr}		\n\
> +	ldmia	%1!, {r2 - r7, ip, lr}		\n\
> +	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
> +	add	%0, %0, #32			\n\
> +	stmia	%0, {r2 - r7, ip, lr}		\n\
> +	ldmia	%1!, {r2 - r7, ip, lr}		\n\
> +	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
> +	add	%0, %0, #32			\n\
> +	stmia	%0, {r2 - r7, ip, lr}		\n\
> +	ldmia	%1!, {r2 - r7, ip, lr}		\n\
> +	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
> +	add	%0, %0, #32			\n\
> +	stmia	%0, {r2 - r7, ip, lr}		\n\
> +	ldmia	%1!, {r2 - r7, ip, lr}		\n\
> +	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
> +	add	%0, %0, #32			\n\
> +	stmia	%0, {r2 - r7, ip, lr}		\n\
> +	ldmia	%1!, {r2 - r7, ip, lr}		\n\
> +	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
> +	add	%0, %0, #32			\n\
> +	stmia	%0, {r2 - r7, ip, lr}		\n\
> +	ldmia	%1!, {r2 - r7, ip, lr}		\n\
> +	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
> +	add	%0, %0, #32			\n\
> +	stmia	%0, {r2 - r7, ip, lr}		\n\
> +	ldmia	%1!, {r2 - r7, ip, lr}		\n\
> +	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
> +	add	%0, %0, #32			\n\
> +	stmia	%0, {r2 - r7, ip, lr}		\n\
> +	subs	%2, %2, #(32 * 8)		\n\
> +	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
> +	add	%0, %0, #32			\n\
>  	bne	1b				\n\
> -	mcr	p15, 0, ip, c7, c10, 4		@ drain WB\n\
> -	ldmfd	sp!, {r4-r9, pc}"
> -	:
> -	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE));
> +	mcr	p15, 0, %2, c7, c10, 4		@ drain WB"
> +	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
> +	: "2" (PAGE_SIZE)
> +	: "r2", "r3", "r4", "r5", "r6", "r7", "ip", "lr");
>  }
>  
>  void feroceon_copy_user_highpage(struct page *to, struct page *from,
> diff --git a/arch/arm/mm/copypage-v4mc.c b/arch/arm/mm/copypage-v4mc.c
> index 0224416cba..b03202cddd 100644
> --- a/arch/arm/mm/copypage-v4mc.c
> +++ b/arch/arm/mm/copypage-v4mc.c
> @@ -40,12 +40,11 @@ static DEFINE_RAW_SPINLOCK(minicache_lock);
>   * instruction.  If your processor does not supply this, you have to write your
>   * own copy_user_highpage that does the right thing.
>   */
> -static void __naked
> -mc_copy_user_page(void *from, void *to)
> +static void mc_copy_user_page(void *from, void *to)
>  {
> -	asm volatile(
> -	"stmfd	sp!, {r4, lr}			@ 2\n\
> -	mov	r4, %2				@ 1\n\
> +	int tmp;
> +
> +	asm volatile ("\
>  	ldmia	%0!, {r2, r3, ip, lr}		@ 4\n\
>  1:	mcr	p15, 0, %1, c7, c6, 1		@ 1   invalidate D line\n\
>  	stmia	%1!, {r2, r3, ip, lr}		@ 4\n\
> @@ -55,13 +54,13 @@ mc_copy_user_page(void *from, void *to)
>  	mcr	p15, 0, %1, c7, c6, 1		@ 1   invalidate D line\n\
>  	stmia	%1!, {r2, r3, ip, lr}		@ 4\n\
>  	ldmia	%0!, {r2, r3, ip, lr}		@ 4\n\
> -	subs	r4, r4, #1			@ 1\n\
> +	subs	%2, %2, #1			@ 1\n\
>  	stmia	%1!, {r2, r3, ip, lr}		@ 4\n\
>  	ldmneia	%0!, {r2, r3, ip, lr}		@ 4\n\
> -	bne	1b				@ 1\n\
> -	ldmfd	sp!, {r4, pc}			@ 3"
> -	:
> -	: "r" (from), "r" (to), "I" (PAGE_SIZE / 64));
> +	bne	1b				@ "
> +	: "+&r" (from), "+&r" (to), "=&r" (tmp)
> +	: "2" (PAGE_SIZE / 64)
> +	: "r2", "r3", "ip", "lr");
>  }
>  
>  void v4_mc_copy_user_highpage(struct page *to, struct page *from,
> diff --git a/arch/arm/mm/copypage-v4wb.c b/arch/arm/mm/copypage-v4wb.c
> index 067d0fdd63..cd3e165afe 100644
> --- a/arch/arm/mm/copypage-v4wb.c
> +++ b/arch/arm/mm/copypage-v4wb.c
> @@ -22,29 +22,28 @@
>   * instruction.  If your processor does not supply this, you have to write your
>   * own copy_user_highpage that does the right thing.
>   */
> -static void __naked
> -v4wb_copy_user_page(void *kto, const void *kfrom)
> +static void v4wb_copy_user_page(void *kto, const void *kfrom)
>  {
> -	asm("\
> -	stmfd	sp!, {r4, lr}			@ 2\n\
> -	mov	r2, %2				@ 1\n\
> -	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
> -1:	mcr	p15, 0, r0, c7, c6, 1		@ 1   invalidate D line\n\
> -	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
> -	ldmia	r1!, {r3, r4, ip, lr}		@ 4+1\n\
> -	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
> -	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
> -	mcr	p15, 0, r0, c7, c6, 1		@ 1   invalidate D line\n\
> -	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
> -	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
> -	subs	r2, r2, #1			@ 1\n\
> -	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
> -	ldmneia	r1!, {r3, r4, ip, lr}		@ 4\n\
> +	int tmp;
> +
> +	asm volatile ("\
> +	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
> +1:	mcr	p15, 0, %0, c7, c6, 1		@ 1   invalidate D line\n\
> +	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
> +	ldmia	%1!, {r3, r4, ip, lr}		@ 4+1\n\
> +	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
> +	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
> +	mcr	p15, 0, %0, c7, c6, 1		@ 1   invalidate D line\n\
> +	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
> +	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
> +	subs	%2, %2, #1			@ 1\n\
> +	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
> +	ldmneia	%1!, {r3, r4, ip, lr}		@ 4\n\
>  	bne	1b				@ 1\n\
> -	mcr	p15, 0, r1, c7, c10, 4		@ 1   drain WB\n\
> -	ldmfd	 sp!, {r4, pc}			@ 3"
> -	:
> -	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64));
> +	mcr	p15, 0, %1, c7, c10, 4		@ 1   drain WB"
> +	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
> +	: "2" (PAGE_SIZE / 64)
> +	: "r3", "r4", "ip", "lr");
>  }
>  
>  void v4wb_copy_user_highpage(struct page *to, struct page *from,
> diff --git a/arch/arm/mm/copypage-v4wt.c b/arch/arm/mm/copypage-v4wt.c
> index b85c5da2e5..8614572e12 100644
> --- a/arch/arm/mm/copypage-v4wt.c
> +++ b/arch/arm/mm/copypage-v4wt.c
> @@ -20,27 +20,26 @@
>   * dirty data in the cache.  However, we do have to ensure that
>   * subsequent reads are up to date.
>   */
> -static void __naked
> -v4wt_copy_user_page(void *kto, const void *kfrom)
> +static void v4wt_copy_user_page(void *kto, const void *kfrom)
>  {
> -	asm("\
> -	stmfd	sp!, {r4, lr}			@ 2\n\
> -	mov	r2, %2				@ 1\n\
> -	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
> -1:	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
> -	ldmia	r1!, {r3, r4, ip, lr}		@ 4+1\n\
> -	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
> -	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
> -	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
> -	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
> -	subs	r2, r2, #1			@ 1\n\
> -	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
> -	ldmneia	r1!, {r3, r4, ip, lr}		@ 4\n\
> +	int tmp;
> +
> +	asm volatile ("\
> +	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
> +1:	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
> +	ldmia	%1!, {r3, r4, ip, lr}		@ 4+1\n\
> +	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
> +	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
> +	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
> +	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
> +	subs	%2, %2, #1			@ 1\n\
> +	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
> +	ldmneia	%1!, {r3, r4, ip, lr}		@ 4\n\
>  	bne	1b				@ 1\n\
> -	mcr	p15, 0, r2, c7, c7, 0		@ flush ID cache\n\
> -	ldmfd	sp!, {r4, pc}			@ 3"
> -	:
> -	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64));
> +	mcr	p15, 0, %2, c7, c7, 0		@ flush ID cache"
> +	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
> +	: "2" (PAGE_SIZE / 64)
> +	: "r3", "r4", "ip", "lr");
>  }
>  
>  void v4wt_copy_user_highpage(struct page *to, struct page *from,
> diff --git a/arch/arm/mm/copypage-xsc3.c b/arch/arm/mm/copypage-xsc3.c
> index 03a2042ace..55cbc3a89d 100644
> --- a/arch/arm/mm/copypage-xsc3.c
> +++ b/arch/arm/mm/copypage-xsc3.c
> @@ -21,53 +21,46 @@
>  
>  /*
>   * XSC3 optimised copy_user_highpage
> - *  r0 = destination
> - *  r1 = source
>   *
>   * The source page may have some clean entries in the cache already, but we
>   * can safely ignore them - break_cow() will flush them out of the cache
>   * if we eventually end up using our copied page.
>   *
>   */
> -static void __naked
> -xsc3_mc_copy_user_page(void *kto, const void *kfrom)
> +static void xsc3_mc_copy_user_page(void *kto, const void *kfrom)
>  {
> -	asm("\
> -	stmfd	sp!, {r4, r5, lr}		\n\
> -	mov	lr, %2				\n\
> -						\n\
> -	pld	[r1, #0]			\n\
> -	pld	[r1, #32]			\n\
> -1:	pld	[r1, #64]			\n\
> -	pld	[r1, #96]			\n\
> +	int tmp;
> +
> +	asm volatile ("\
> +	pld	[%1, #0]			\n\
> +	pld	[%1, #32]			\n\
> +1:	pld	[%1, #64]			\n\
> +	pld	[%1, #96]			\n\
>  						\n\
> -2:	ldrd	r2, [r1], #8			\n\
> -	mov	ip, r0				\n\
> -	ldrd	r4, [r1], #8			\n\
> -	mcr	p15, 0, ip, c7, c6, 1		@ invalidate\n\
> -	strd	r2, [r0], #8			\n\
> -	ldrd	r2, [r1], #8			\n\
> -	strd	r4, [r0], #8			\n\
> -	ldrd	r4, [r1], #8			\n\
> -	strd	r2, [r0], #8			\n\
> -	strd	r4, [r0], #8			\n\
> -	ldrd	r2, [r1], #8			\n\
> -	mov	ip, r0				\n\
> -	ldrd	r4, [r1], #8			\n\
> -	mcr	p15, 0, ip, c7, c6, 1		@ invalidate\n\
> -	strd	r2, [r0], #8			\n\
> -	ldrd	r2, [r1], #8			\n\
> -	subs	lr, lr, #1			\n\
> -	strd	r4, [r0], #8			\n\
> -	ldrd	r4, [r1], #8			\n\
> -	strd	r2, [r0], #8			\n\
> -	strd	r4, [r0], #8			\n\
> +2:	ldrd	r2, [%1], #8			\n\
> +	ldrd	r4, [%1], #8			\n\
> +	mcr	p15, 0, %0, c7, c6, 1		@ invalidate\n\
> +	strd	r2, [%0], #8			\n\
> +	ldrd	r2, [%1], #8			\n\
> +	strd	r4, [%0], #8			\n\
> +	ldrd	r4, [%1], #8			\n\
> +	strd	r2, [%0], #8			\n\
> +	strd	r4, [%0], #8			\n\
> +	ldrd	r2, [%1], #8			\n\
> +	ldrd	r4, [%1], #8			\n\
> +	mcr	p15, 0, %0, c7, c6, 1		@ invalidate\n\
> +	strd	r2, [%0], #8			\n\
> +	ldrd	r2, [%1], #8			\n\
> +	subs	%2, %2, #1			\n\
> +	strd	r4, [%0], #8			\n\
> +	ldrd	r4, [%1], #8			\n\
> +	strd	r2, [%0], #8			\n\
> +	strd	r4, [%0], #8			\n\
>  	bgt	1b				\n\
> -	beq	2b				\n\
> -						\n\
> -	ldmfd	sp!, {r4, r5, pc}"
> -	:
> -	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64 - 1));
> +	beq	2b				"
> +	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
> +	: "2" (PAGE_SIZE / 64 - 1)
> +	: "r2", "r3", "r4", "r5");
>  }
>  
>  void xsc3_mc_copy_user_highpage(struct page *to, struct page *from,
> @@ -85,8 +78,6 @@ void xsc3_mc_copy_user_highpage(struct page *to,
> struct page *from,
>  
>  /*
>   * XScale optimised clear_user_page
> - *  r0 = destination
> - *  r1 = virtual user address of ultimate destination page
>   */
>  void xsc3_mc_clear_user_highpage(struct page *page, unsigned long vaddr)
>  {
> diff --git a/arch/arm/mm/copypage-xscale.c b/arch/arm/mm/copypage-xscale.c
> index 97972379f4..b0ae8c7acb 100644
> --- a/arch/arm/mm/copypage-xscale.c
> +++ b/arch/arm/mm/copypage-xscale.c
> @@ -36,52 +36,51 @@ static DEFINE_RAW_SPINLOCK(minicache_lock);
>   * Dcache aliasing issue.  The writes will be forwarded to the write buffer,
>   * and merged as appropriate.
>   */
> -static void __naked
> -mc_copy_user_page(void *from, void *to)
> +static void mc_copy_user_page(void *from, void *to)
>  {
> +	int tmp;
> +
>  	/*
>  	 * Strangely enough, best performance is achieved
>  	 * when prefetching destination as well.  (NP)
>  	 */
> -	asm volatile(
> -	"stmfd	sp!, {r4, r5, lr}		\n\
> -	mov	lr, %2				\n\
> -	pld	[r0, #0]			\n\
> -	pld	[r0, #32]			\n\
> -	pld	[r1, #0]			\n\
> -	pld	[r1, #32]			\n\
> -1:	pld	[r0, #64]			\n\
> -	pld	[r0, #96]			\n\
> -	pld	[r1, #64]			\n\
> -	pld	[r1, #96]			\n\
> -2:	ldrd	r2, [r0], #8			\n\
> -	ldrd	r4, [r0], #8			\n\
> -	mov	ip, r1				\n\
> -	strd	r2, [r1], #8			\n\
> -	ldrd	r2, [r0], #8			\n\
> -	strd	r4, [r1], #8			\n\
> -	ldrd	r4, [r0], #8			\n\
> -	strd	r2, [r1], #8			\n\
> -	strd	r4, [r1], #8			\n\
> +	asm volatile ("\
> +	pld	[%0, #0]			\n\
> +	pld	[%0, #32]			\n\
> +	pld	[%1, #0]			\n\
> +	pld	[%1, #32]			\n\
> +1:	pld	[%0, #64]			\n\
> +	pld	[%0, #96]			\n\
> +	pld	[%1, #64]			\n\
> +	pld	[%1, #96]			\n\
> +2:	ldrd	r2, [%0], #8			\n\
> +	ldrd	r4, [%0], #8			\n\
> +	mov	ip, %1				\n\
> +	strd	r2, [%1], #8			\n\
> +	ldrd	r2, [%0], #8			\n\
> +	strd	r4, [%1], #8			\n\
> +	ldrd	r4, [%0], #8			\n\
> +	strd	r2, [%1], #8			\n\
> +	strd	r4, [%1], #8			\n\
>  	mcr	p15, 0, ip, c7, c10, 1		@ clean D line\n\
> -	ldrd	r2, [r0], #8			\n\
> +	ldrd	r2, [%0], #8			\n\
>  	mcr	p15, 0, ip, c7, c6, 1		@ invalidate D line\n\
> -	ldrd	r4, [r0], #8			\n\
> -	mov	ip, r1				\n\
> -	strd	r2, [r1], #8			\n\
> -	ldrd	r2, [r0], #8			\n\
> -	strd	r4, [r1], #8			\n\
> -	ldrd	r4, [r0], #8			\n\
> -	strd	r2, [r1], #8			\n\
> -	strd	r4, [r1], #8			\n\
> +	ldrd	r4, [%0], #8			\n\
> +	mov	ip, %1				\n\
> +	strd	r2, [%1], #8			\n\
> +	ldrd	r2, [%0], #8			\n\
> +	strd	r4, [%1], #8			\n\
> +	ldrd	r4, [%0], #8			\n\
> +	strd	r2, [%1], #8			\n\
> +	strd	r4, [%1], #8			\n\
>  	mcr	p15, 0, ip, c7, c10, 1		@ clean D line\n\
> -	subs	lr, lr, #1			\n\
> +	subs	%2, %2, #1			\n\
>  	mcr	p15, 0, ip, c7, c6, 1		@ invalidate D line\n\
>  	bgt	1b				\n\
> -	beq	2b				\n\
> -	ldmfd	sp!, {r4, r5, pc}		"
> -	:
> -	: "r" (from), "r" (to), "I" (PAGE_SIZE / 64 - 1));
> +	beq	2b				"
> +	: "+&r" (from), "+&r" (to), "=&r" (tmp)
> +	: "2" (PAGE_SIZE / 64 - 1)
> +	: "r2", "r3", "r4", "r5", "ip");
>  }
>  
>  void xscale_mc_copy_user_highpage(struct page *to, struct page *from,
