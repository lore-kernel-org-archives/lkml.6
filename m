Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425A3C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E608023DB7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="udRPyPsu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E608023DB7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753854AbeGER7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:59:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36166 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753661AbeGER7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/MwNrZ5TZX+cnUrZUFCwVIDza/pl1zHKiftiVe5yN3U=; b=udRPyPsuujLlkR5kjj3ZYnPZW
        6WrYuoSpU9BQTHNISsrJHHlPIGJJp4qq/ez33RPGZen/hRjzaeoHWUuh/pdtIjkIW2eAMBu5mxA4e
        oOMqf4cGXhP4GroHsV+wRVA7lR4hOoQwtAQngwOrqzXEex4P+8rZ8214kG5pOpdExgrzPXc84x1dN
        yoYK806frDt25FEB/zxWrSOEum7TMOVp7J+uWYXxAGMsT721XwyUmvwcrLi8mEOlNqXr10MAAfdeq
        RHOIL83z/AvITP1LJuYodaYpOv9T/wiCAuj6iDEZT07gMrCwYr/6ra0Qyjuij+AZq8RlYwNygp/mz
        RnJ2G+s3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fb8X1-0001ex-V7; Thu, 05 Jul 2018 17:59:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4C2CE20289CF4; Thu,  5 Jul 2018 19:59:02 +0200 (CEST)
Date:   Thu, 5 Jul 2018 19:59:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Message-ID: <20180705175902.GF2530@hirez.programming.kicks-ass.net>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 01:30:14AM +0800, Guo Ren wrote:

> +static inline void arch_spin_lock(arch_spinlock_t *lock)
> +{
> +	unsigned int *p = &lock->lock;
> +	unsigned int tmp;
> +
> +	asm volatile (
> +		"1:	ldex.w		%0, (%1) \n"
> +		"	bnez		%0, 1b   \n"
> +		"	movi		%0, 1    \n"
> +		"	stex.w		%0, (%1) \n"
> +		"	bez		%0, 1b   \n"
> +		: "=&r" (tmp)
> +		: "r"(p)
> +		: "memory");
> +	smp_mb();
> +}

Test-and-set with MB acting as ACQUIRE, ok.

> +static inline void arch_spin_unlock(arch_spinlock_t *lock)
> +{
> +	unsigned int *p = &lock->lock;
> +	unsigned int tmp;
> +
> +	smp_mb();
> +	asm volatile (
> +		"1:	ldex.w		%0, (%1) \n"
> +		"	movi		%0, 0    \n"
> +		"	stex.w		%0, (%1) \n"
> +		"	bez		%0, 1b   \n"
> +		: "=&r" (tmp)
> +		: "r"(p)
> +		: "memory");
> +}

MB acting for RELEASE, but _why_ are you using a LDEX/STEX to clear the
lock word? Would not a normal store work?

Also, the fact that you need MB for release implies your LDEX does not
in fact imply anything and your xchg/cmpxchg implementation is broken.

> +static inline int arch_spin_trylock(arch_spinlock_t *lock)
> +{
> +	unsigned int *p = &lock->lock;
> +	unsigned int tmp;
> +
> +	asm volatile (
> +		"1:	ldex.w		%0, (%1) \n"
> +		"	bnez		%0, 2f   \n"
> +		"	movi		%0, 1    \n"
> +		"	stex.w		%0, (%1) \n"
> +		"	bez		%0, 1b   \n"
> +		"	movi		%0, 0    \n"
> +		"2:				 \n"
> +		: "=&r" (tmp)
> +		: "r"(p)
> +		: "memory");
> +	smp_mb();
> +
> +	return !tmp;
> +}

Strictly speaking you can avoid the MB on failure. You only need to
provide ACQUIRE semantics on success.

That said, I would really suggest you implement a ticket lock instead of
a test-and-set lock. They're not really all that complicated and do
provide better worst case behaviour.


> +/****** read lock/unlock/trylock ******/

Please have a look at using qrwlock -- esp. if you implement a ticket
lock, then the rwlock comes for 'free'.
