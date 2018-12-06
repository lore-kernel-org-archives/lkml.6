Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19200C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27EF20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EFszL+cz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27EF20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbeLFEoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 23:44:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56714 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbeLFEoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 23:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QFeJN8oo/xfavEPpzpXmebRZOEyeWvGNNlMViIRBBYw=; b=EFszL+czeM4Qmk6dWX7BeKZ8n
        lyim7VqIA6oIVfeXEfk/yigPDzQ61Cm3UyecR3ngMJSw371+C5m2kuQ4UIm0ftvU24ANNeRKwBrio
        3jea32605A/tsdSe7QfO3OJY5GPSis9vbROa5Cf4wJa9BfBvuoA3x2Sose55VG/igJ0cBcy5Flwlk
        hEUM+TEBvFAhW4TpynGhK19fExY07LgE2C+BYGk5gsI5ul6hWErUn5hkkdRM8gSsSNJJ8xeiKtqL5
        hob/svQt6UZWrLX0bkms21qOmRoB5TUqHhx44J4xvisCV3NUPi5AffFZJlNP3ztmnlKx+gvhJM/N7
        3YJR26yYA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUlWH-0000zX-Cn; Thu, 06 Dec 2018 04:44:13 +0000
Date:   Wed, 5 Dec 2018 20:44:13 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>, igor.stoppa@huawei.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] __wr_after_init: write rare for static allocation
Message-ID: <20181206044413.GB24603@bombadil.infradead.org>
References: <20181204121805.4621-1-igor.stoppa@huawei.com>
 <20181204121805.4621-3-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204121805.4621-3-igor.stoppa@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 02:18:01PM +0200, Igor Stoppa wrote:
> +void *__wr_op(unsigned long dst, unsigned long src, __kernel_size_t len,
> +	      enum wr_op_type op)
> +{
> +	temporary_mm_state_t prev;
> +	unsigned long flags;
> +	unsigned long offset;
> +	unsigned long wr_poking_addr;
> +
> +	/* Confirm that the writable mapping exists. */
> +	BUG_ON(!wr_ready);
> +
> +	if (WARN_ONCE(op >= WR_OPS_NUMBER, "Invalid WR operation.") ||
> +	    WARN_ONCE(!is_wr_after_init(dst, len), "Invalid WR range."))
> +		return (void *)dst;
> +
> +	offset = dst - (unsigned long)&__start_wr_after_init;
> +	wr_poking_addr = wr_poking_base + offset;
> +	local_irq_save(flags);

Why not local_irq_disable()?  Do we have a use-case for wanting to access
this from interrupt context?

> +	/* XXX make the verification optional? */

Well, yes.  It seems like debug code to me.

> +	/* Randomize the poking address base*/
> +	wr_poking_base = TASK_UNMAPPED_BASE +
> +		(kaslr_get_random_long("Write Rare Poking") & PAGE_MASK) %
> +		(TASK_SIZE - (TASK_UNMAPPED_BASE + wr_range));

I don't think this is a great idea.  We want to use the same mm for both
static and dynamic wr memory, yes?  So we should have enough space for
all of ram, not splatter the static section all over the address space.

On x86-64 (4 level page tables), we have a 64TB space for all of physmem
and 128TB of user space, so we can place the base anywhere in a 64TB
range.

