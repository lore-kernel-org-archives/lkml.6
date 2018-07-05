Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88638C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461B7240E8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tlD3WN8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461B7240E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753931AbeGERvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:51:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35178 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753442AbeGERvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=408ztwvdzfvqrsVveUms+H94Hq2HU4OMkU8nFC3XlPE=; b=tlD3WN8jRmFUkPmx9M1uQRrwg
        t9IGOUvAzItMfA5H6XnKGP9ERMMBwq/odF/mHSOl3BwcgEbApFjhO41YpaNZrjo3P0dnieCiYwNgN
        l+9ECIgNE0MNNLD5xGZXevaOQoBIXJoxA5RN91Gavbskg6bRJ+IYFrHUc6W1wFxQrvw2QMpDqNWbX
        B+Zymfa2pMxnE85NAmeubPXELr62w87papMNLef81HEFPovqt1T1JYktnDOdjxzktxXlbN21H8CFR
        Aimm6VbbQPvx16WQcuCjAzZpLZBi4pNEKtnRVnwU4PXCXeLEjiHEEV1UR0fUOl2napMqt+3EtjZEP
        KQAUzApCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fb8PF-0007Ht-4P; Thu, 05 Jul 2018 17:51:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8984F20289CF4; Thu,  5 Jul 2018 19:50:59 +0200 (CEST)
Date:   Thu, 5 Jul 2018 19:50:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Message-ID: <20180705175059.GE2530@hirez.programming.kicks-ass.net>
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

> +#include <asm/barrier.h>
> +
> +#define __xchg(new, ptr, size)					\
> +({								\
> +	__typeof__(ptr) __ptr = (ptr);				\
> +	__typeof__(new) __new = (new);				\
> +	__typeof__(*(ptr)) __ret;				\
> +	unsigned long tmp;					\
> +	switch (size) {						\
> +	case 4:							\
> +		asm volatile (					\
> +		"1:	ldex.w		%0, (%3) \n"		\
> +		"	mov		%1, %2   \n"		\
> +		"	stex.w		%1, (%3) \n"		\
> +		"	bez		%1, 1b   \n"		\
> +			: "=&r" (__ret), "=&r" (tmp)		\
> +			: "r" (__new), "r"(__ptr)		\
> +			: "memory");				\
> +		smp_mb();					\
> +		break;						\
> +	default:						\
> +		BUILD_BUG();					\
> +	}							\
> +	__ret;							\
> +})
> +
> +#define xchg(ptr, x)	(__xchg((x), (ptr), sizeof(*(ptr))))
> +
> +#define __cmpxchg(ptr, old, new, size)				\
> +({								\
> +	__typeof__(ptr) __ptr = (ptr);				\
> +	__typeof__(new) __new = (new);				\
> +	__typeof__(new) __tmp;					\
> +	__typeof__(old) __old = (old);				\
> +	__typeof__(*(ptr)) __ret;				\
> +	switch (size) {						\
> +	case 4:							\
> +		asm volatile (					\
> +		"1:	ldex.w		%0, (%3) \n"		\
> +		"	cmpne		%0, %4   \n"		\
> +		"	bt		2f       \n"		\
> +		"	mov		%1, %2   \n"		\
> +		"	stex.w		%1, (%3) \n"		\
> +		"	bez		%1, 1b   \n"		\
> +		"2:				 \n"		\
> +			: "=&r" (__ret), "=&r" (__tmp)		\
> +			: "r" (__new), "r"(__ptr), "r"(__old)	\
> +			: "memory");				\
> +		smp_mb();					\
> +		break;						\
> +	default:						\
> +		BUILD_BUG();					\
> +	}							\
> +	__ret;							\
> +})
> +
> +#define cmpxchg(ptr, o, n) \
> +	(__cmpxchg((ptr), (o), (n), sizeof(*(ptr))))

What's the memory ordering rules for your LDEX/STEX ?

The mandated semantics for xchg() / cmpxchg() is an effective smp_mb()
before _and_ after.

The above implementation suggests LDEX implies a SYNC.IS, is this
correct?
