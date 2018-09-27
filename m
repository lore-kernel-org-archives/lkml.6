Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3107EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11C921547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11C921547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeI0Loo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 07:44:44 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:44605 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726599AbeI0Lon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 07:44:43 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07488097|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03273;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=20;RT=20;SR=0;TI=SMTPD_---.CwPENKx_1538026058;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CwPENKx_1538026058)
          by smtp.aliyun-inc.com(10.147.41.138);
          Thu, 27 Sep 2018 13:27:38 +0800
Date:   Thu, 27 Sep 2018 13:27:38 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20180927052737.GA28407@guoren>
References: <cover.1537789736.git.ren_guo@c-sky.com>
 <7cd7abcd2acf5c61435589338ff80a75a13173ca.1537789737.git.ren_guo@c-sky.com>
 <20180925072407.GA6999@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925072407.GA6999@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 09:24:07AM +0200, Peter Zijlstra wrote:
> On Mon, Sep 24, 2018 at 10:36:22PM +0800, Guo Ren wrote:
> > diff --git a/arch/csky/abiv1/inc/abi/cacheflush.h b/arch/csky/abiv1/inc/abi/cacheflush.h
> > new file mode 100644
> > index 0000000..f0de49c
> > --- /dev/null
> > +++ b/arch/csky/abiv1/inc/abi/cacheflush.h
> > @@ -0,0 +1,43 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> > +
> > +#ifndef __ABI_CSKY_CACHEFLUSH_H
> > +#define __ABI_CSKY_CACHEFLUSH_H
> > +
> > +#include <linux/compiler.h>
> > +#include <asm/string.h>
> > +#include <asm/cache.h>
> > +
> > +#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
> > +extern void flush_dcache_page(struct page *);
> > +
> > +#define flush_cache_mm(mm)		cache_wbinv_all()
> > +#define flush_cache_page(vma,page,pfn)	cache_wbinv_all()
> > +#define flush_cache_dup_mm(mm)		cache_wbinv_all()
> > +
> > +#define flush_cache_range(mm,start,end)	cache_wbinv_range(start, end)
>                              ^^^ should be vma
Yes, I'll change it to:
#define flush_cache_range(mm,start,end)	cache_wbinv_all()

I'll improve it later after test.

> 
> > +#endif /* __ABI_CSKY_CACHEFLUSH_H */
> 
> 
> > diff --git a/arch/csky/abiv1/inc/abi/tlb.h b/arch/csky/abiv1/inc/abi/tlb.h
> > new file mode 100644
> > index 0000000..6d461f3
> > --- /dev/null
> > +++ b/arch/csky/abiv1/inc/abi/tlb.h
> > @@ -0,0 +1,12 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> > +
> > +#ifndef __ABI_CSKY_TLB_H
> > +#define __ABI_CSKY_TLB_H
> > +
> > +#define tlb_start_vma(tlb, vma) \
> > +	do { \
> > +		if (!tlb->fullmm) \
> > +			cache_wbinv_all(); \
> > +	}  while (0)
> > +#endif /* __ABI_CSKY_TLB_H */
> 
> That should be:
> 
> 	if (!tlb->fullmm)
> 		flush_cache_range(vma, vma->vm_start, vma->vm_end);
> 
> Because as per the whole abiv1 vs abiv2, you don't need write back
> invalidation for v2 at all, also, you only need to invalidate the vma
> range, no reason to shoot everything down.
> 
> Also, I'll be shortly removing this:
> 
>   https://lkml.kernel.org/r/20180913092812.071989585@infradead.org
Ok, I'll follow the rules.

> 
> > diff --git a/arch/csky/abiv2/inc/abi/cacheflush.h b/arch/csky/abiv2/inc/abi/cacheflush.h
> > new file mode 100644
> > index 0000000..756beb7
> > --- /dev/null
> > +++ b/arch/csky/abiv2/inc/abi/cacheflush.h
> > @@ -0,0 +1,40 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#ifndef __ABI_CSKY_CACHEFLUSH_H
> > +#define __ABI_CSKY_CACHEFLUSH_H
> > +
> > +/* Keep includes the same across arches.  */
> > +#include <linux/mm.h>
> > +
> > +/*
> > + * The cache doesn't need to be flushed when TLB entries change when
> > + * the cache is mapped to physical memory, not virtual memory
> > + */
> > +#define flush_cache_all()			do { } while (0)
> > +#define flush_cache_mm(mm)			do { } while (0)
> > +#define flush_cache_dup_mm(mm)			do { } while (0)
> > +#define flush_cache_range(vma, start, end)	do { } while (0)
>                              ^^^ like here..
#define flush_cache_range(vma, start, end) \
	do { \
		if (vma->vm_flags & VM_EXEC) \
			icache_inv_all(); \
	}

Hmm ?

I'll improve it later after test.

Best Regards
 Guo Ren
