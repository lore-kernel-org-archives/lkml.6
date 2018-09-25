Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA467C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596CA214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zXsdwN5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596CA214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbeIYNbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:31:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54710 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbeIYNbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xqthDeiSyOLcjqwUUqONFwF/RWTTYVn1S3WPQuE/9A4=; b=zXsdwN5QFPMAclseOLezHk66o
        mza2SvFiuwGTBfLMoCwolugNge9AOt/TgDhooFpg3OTyHkItSRUOrf5zMj7GmTniAg6eMaiRJ8KXZ
        dLxIfTwFo9CbEU6WaPVYRFWRjA7qtJ1D8k/VuX5MURvxL81Oq86/GAZjAgWLmhDnRUfX1KTpqYyQ5
        36ZyIuApsKHUEBZZ8T/LChVW4RxaS11bnZp0ELMODXm70wmROjUq85EM7B1xBn+IFk5CG/0DWeME0
        93lwMdd1ltzguo+e9gzzDRs3lW7U7odf/PS/spyAItfDucz46vfWS5fOYly5qDGJBC+EVEdowAGlK
        v47EDPhTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g4hha-0007kn-Ga; Tue, 25 Sep 2018 07:24:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9A83620289CF9; Tue, 25 Sep 2018 09:24:07 +0200 (CEST)
Date:   Tue, 25 Sep 2018 09:24:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, robh@kernel.org, robh+dt@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        green.hu@gmail.com, palmer@sifive.com
Subject: Re: [PATCH V5 06/30] csky: Cache and TLB routines
Message-ID: <20180925072407.GA6999@hirez.programming.kicks-ass.net>
References: <cover.1537789736.git.ren_guo@c-sky.com>
 <7cd7abcd2acf5c61435589338ff80a75a13173ca.1537789737.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cd7abcd2acf5c61435589338ff80a75a13173ca.1537789737.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 10:36:22PM +0800, Guo Ren wrote:
> diff --git a/arch/csky/abiv1/inc/abi/cacheflush.h b/arch/csky/abiv1/inc/abi/cacheflush.h
> new file mode 100644
> index 0000000..f0de49c
> --- /dev/null
> +++ b/arch/csky/abiv1/inc/abi/cacheflush.h
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +
> +#ifndef __ABI_CSKY_CACHEFLUSH_H
> +#define __ABI_CSKY_CACHEFLUSH_H
> +
> +#include <linux/compiler.h>
> +#include <asm/string.h>
> +#include <asm/cache.h>
> +
> +#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
> +extern void flush_dcache_page(struct page *);
> +
> +#define flush_cache_mm(mm)		cache_wbinv_all()
> +#define flush_cache_page(vma,page,pfn)	cache_wbinv_all()
> +#define flush_cache_dup_mm(mm)		cache_wbinv_all()
> +
> +#define flush_cache_range(mm,start,end)	cache_wbinv_range(start, end)
                             ^^^ should be vma

> +#endif /* __ABI_CSKY_CACHEFLUSH_H */


> diff --git a/arch/csky/abiv1/inc/abi/tlb.h b/arch/csky/abiv1/inc/abi/tlb.h
> new file mode 100644
> index 0000000..6d461f3
> --- /dev/null
> +++ b/arch/csky/abiv1/inc/abi/tlb.h
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +
> +#ifndef __ABI_CSKY_TLB_H
> +#define __ABI_CSKY_TLB_H
> +
> +#define tlb_start_vma(tlb, vma) \
> +	do { \
> +		if (!tlb->fullmm) \
> +			cache_wbinv_all(); \
> +	}  while (0)
> +#endif /* __ABI_CSKY_TLB_H */

That should be:

	if (!tlb->fullmm)
		flush_cache_range(vma, vma->vm_start, vma->vm_end);

Because as per the whole abiv1 vs abiv2, you don't need write back
invalidation for v2 at all, also, you only need to invalidate the vma
range, no reason to shoot everything down.

Also, I'll be shortly removing this:

  https://lkml.kernel.org/r/20180913092812.071989585@infradead.org

> diff --git a/arch/csky/abiv2/inc/abi/cacheflush.h b/arch/csky/abiv2/inc/abi/cacheflush.h
> new file mode 100644
> index 0000000..756beb7
> --- /dev/null
> +++ b/arch/csky/abiv2/inc/abi/cacheflush.h
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#ifndef __ABI_CSKY_CACHEFLUSH_H
> +#define __ABI_CSKY_CACHEFLUSH_H
> +
> +/* Keep includes the same across arches.  */
> +#include <linux/mm.h>
> +
> +/*
> + * The cache doesn't need to be flushed when TLB entries change when
> + * the cache is mapped to physical memory, not virtual memory
> + */
> +#define flush_cache_all()			do { } while (0)
> +#define flush_cache_mm(mm)			do { } while (0)
> +#define flush_cache_dup_mm(mm)			do { } while (0)
> +#define flush_cache_range(vma, start, end)	do { } while (0)
                             ^^^ like here..

> +#endif /* __ABI_CSKY_TLB_H */
