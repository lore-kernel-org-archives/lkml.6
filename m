Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A834C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A3A20836
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dURxC2L4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfBKGk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 01:40:59 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46614 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfBKGk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 01:40:59 -0500
Received: by mail-ot1-f65.google.com with SMTP id w25so15622632otm.13;
        Sun, 10 Feb 2019 22:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0eTX9Tow9IPWyzaN5D0UVBuXHwWZHi+w6BDkGT9TxSI=;
        b=dURxC2L4T+BPLBNuH8R8jT8DZqN2StbusX7Uq9xo/Tx0Mxze49xx8O+VFFb+BLaI7b
         Gy+kZnlqwVjh7QRfVLac9AW9MHgwp++x6X7ZdDzEtj1hjzvlvj/lS4KT8kePl0x/OE0G
         r2ilyuSWC+AOVgmfzL1STM62SUATZzdII1hqiaft74dXZ0+ax0XHGn0M/4xl05U6chbN
         y/bwGafpVrtjltX/X9VWb96RQDhXPzUgPMCiSFedFkjyzoJ2wbONSGuT5HEJvsvYw2/F
         R0rd99D/zCyh911+wxbnuyYGUg0PNN21Rw+S+ODTgnTEHHRZSxQLveq0zkhJTua4X6mG
         kvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0eTX9Tow9IPWyzaN5D0UVBuXHwWZHi+w6BDkGT9TxSI=;
        b=kRjLcMlsA3QKi2wbCPPpPW+9JQtQxs4UQuOW1JCM9BkMqkaJiRdVRYhumDA0OnNFxK
         NZIDpl7yDNJOUNfAYUmyuWpAuGmcUv5PoEeKp7+c4X1pYcu3Dh9gb+4l6+wsNZu+ii2j
         xQQNm7nLh9xSBYfTcK4V61BkgUdxzT7ZOVYdThGyiKI8SKpCC/d2GzLsM/LvLoWatvAZ
         +ckmv7zvDHIaTnqLFtBVbcM4Iyr+gcHBgMD8tZlX3mHsqjkLrBztM6t5KfeC0EsVXtIE
         mJI4UAwDRzG/WZIu1pla7n0x2z6lhqklVsaMWC70lU2yJvN6CLtfXNCDUadtmTZ1i8F+
         ZX8Q==
X-Gm-Message-State: AHQUAua4P2Qjbz65a3cjasziQ+d4CtURwSLhWYbZs+gcYjXLdajumIg8
        0W23Y2lVorrXqT+8x1hzUjc=
X-Google-Smtp-Source: AHgI3IZnXnUzG4tnsQCjhbTyw8K1t9ImfH93nYEos0f6Ec4+/E3h75ghWblateJazVqf9JUI8QZecQ==
X-Received: by 2002:a9d:2c5:: with SMTP id 63mr26320540otl.271.1549867257781;
        Sun, 10 Feb 2019 22:40:57 -0800 (PST)
Received: from [10.15.232.100] ([205.204.117.38])
        by smtp.gmail.com with ESMTPSA id r16sm1687575oie.25.2019.02.10.22.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 22:40:57 -0800 (PST)
Subject: Re: [RFC PATCH 4/4] mm: Add merge page notifier
To:     Alexander Duyck <alexander.duyck@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     rkrcmar@redhat.com, alexander.h.duyck@linux.intel.com,
        x86@kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        pbonzini@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org
References: <20190204181118.12095.38300.stgit@localhost.localdomain>
 <20190204181558.12095.83484.stgit@localhost.localdomain>
From:   Aaron Lu <aaron.lwe@gmail.com>
Message-ID: <5e6d22b2-0f14-43eb-846b-a940e629c02b@gmail.com>
Date:   Mon, 11 Feb 2019 14:40:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190204181558.12095.83484.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/5 2:15, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> Because the implementation was limiting itself to only providing hints on
> pages huge TLB order sized or larger we introduced the possibility for free
> pages to slip past us because they are freed as something less then
> huge TLB in size and aggregated with buddies later.
> 
> To address that I am adding a new call arch_merge_page which is called
> after __free_one_page has merged a pair of pages to create a higher order
> page. By doing this I am able to fill the gap and provide full coverage for
> all of the pages huge TLB order or larger.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  arch/x86/include/asm/page.h |   12 ++++++++++++
>  arch/x86/kernel/kvm.c       |   28 ++++++++++++++++++++++++++++
>  include/linux/gfp.h         |    4 ++++
>  mm/page_alloc.c             |    2 ++
>  4 files changed, 46 insertions(+)
> 
> diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
> index 4487ad7a3385..9540a97c9997 100644
> --- a/arch/x86/include/asm/page.h
> +++ b/arch/x86/include/asm/page.h
> @@ -29,6 +29,18 @@ static inline void arch_free_page(struct page *page, unsigned int order)
>  	if (static_branch_unlikely(&pv_free_page_hint_enabled))
>  		__arch_free_page(page, order);
>  }
> +
> +struct zone;
> +
> +#define HAVE_ARCH_MERGE_PAGE
> +void __arch_merge_page(struct zone *zone, struct page *page,
> +		       unsigned int order);
> +static inline void arch_merge_page(struct zone *zone, struct page *page,
> +				   unsigned int order)
> +{
> +	if (static_branch_unlikely(&pv_free_page_hint_enabled))
> +		__arch_merge_page(zone, page, order);
> +}
>  #endif
>  
>  #include <linux/range.h>
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 09c91641c36c..957bb4f427bb 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -785,6 +785,34 @@ void __arch_free_page(struct page *page, unsigned int order)
>  		       PAGE_SIZE << order);
>  }
>  
> +void __arch_merge_page(struct zone *zone, struct page *page,
> +		       unsigned int order)
> +{
> +	/*
> +	 * The merging logic has merged a set of buddies up to the
> +	 * KVM_PV_UNUSED_PAGE_HINT_MIN_ORDER. Since that is the case, take
> +	 * advantage of this moment to notify the hypervisor of the free
> +	 * memory.
> +	 */
> +	if (order != KVM_PV_UNUSED_PAGE_HINT_MIN_ORDER)
> +		return;
> +
> +	/*
> +	 * Drop zone lock while processing the hypercall. This
> +	 * should be safe as the page has not yet been added
> +	 * to the buddy list as of yet and all the pages that
> +	 * were merged have had their buddy/guard flags cleared
> +	 * and their order reset to 0.
> +	 */
> +	spin_unlock(&zone->lock);
> +
> +	kvm_hypercall2(KVM_HC_UNUSED_PAGE_HINT, page_to_phys(page),
> +		       PAGE_SIZE << order);
> +
> +	/* reacquire lock and resume freeing memory */
> +	spin_lock(&zone->lock);
> +}
> +
>  #ifdef CONFIG_PARAVIRT_SPINLOCKS
>  
>  /* Kick a cpu by its apicid. Used to wake up a halted vcpu */
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index fdab7de7490d..4746d5560193 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -459,6 +459,10 @@ static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
>  #ifndef HAVE_ARCH_FREE_PAGE
>  static inline void arch_free_page(struct page *page, int order) { }
>  #endif
> +#ifndef HAVE_ARCH_MERGE_PAGE
> +static inline void
> +arch_merge_page(struct zone *zone, struct page *page, int order) { }
> +#endif
>  #ifndef HAVE_ARCH_ALLOC_PAGE
>  static inline void arch_alloc_page(struct page *page, int order) { }
>  #endif
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c954f8c1fbc4..7a1309b0b7c5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -913,6 +913,8 @@ static inline void __free_one_page(struct page *page,
>  		page = page + (combined_pfn - pfn);
>  		pfn = combined_pfn;
>  		order++;
> +
> +		arch_merge_page(zone, page, order);

Not a proper place AFAICS.

Assume we have an order-8 page being sent here for merge and its order-8
buddy is also free, then order++ became 9 and arch_merge_page() will do
the hint to host on this page as an order-9 page, no problem so far.
Then the next round, assume the now order-9 page's buddy is also free,
order++ will become 10 and arch_merge_page() will again hint to host on
this page as an order-10 page. The first hint to host became redundant.

I think the proper place is after the done_merging tag.

BTW, with arch_merge_page() at the proper place, I don't think patch3/4
is necessary - any freed page will go through merge anyway, we won't
lose any hint opportunity. Or do I miss anything?

>  	}
>  	if (max_order < MAX_ORDER) {
>  		/* If we are here, it means order is >= pageblock_order.
> 
