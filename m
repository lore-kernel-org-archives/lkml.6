Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD97C282C4
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 00:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE18221929
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 00:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfBJAth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 19:49:37 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38560 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfBJAtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 19:49:36 -0500
Received: by mail-qk1-f194.google.com with SMTP id p15so2768753qkl.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 16:49:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RUkKFTS85FoXbRyygGKOUvPm3q46TzJX+NNR/xpK20M=;
        b=VJrnA4nNbXjz8U8oEkQ9ij2/msq/7VmTLY38nLkXLt9tRbaBkABO+HgmTSC4G6UWNj
         /k/VE/6rKGYNGNfM3R69bzrthG/JjZkdMSc+wKNGoOGKpWU92cva69ci5NcdUeNmGQno
         qa0rxVpoxntJ9+gPvtSr/rol5tzfBArJgszSCKUNZ+cS4WOn0j/k5SaqfcmgoaSxrAoW
         MOOq3w+5SGl7Zk+16nN8S79Vn8p9v0ziE/3TwnhPm9iSErENSIgjoB8PzdkuYF/LtScj
         zHJtyXFsgtWPbUzE4N3iqmWfZcVhkcfoRHRBhS3X5kMQA2KgDuQvNM+9rF1qYnDVmj/F
         OmoQ==
X-Gm-Message-State: AHQUAuZfuWFNlbyebLHYFIMfE3/T2eDEluWqGWTiG+ExNZXkwJFg52Cv
        VdFghVJf8pcP14/GBNVYMu70jQ==
X-Google-Smtp-Source: AHgI3IZrOS4xixlnOrA12cEVvQYc+GOESwsGu6yDE0QQ6J97dBoIDOR6uKBT125l8m6fyCB1L/ihlg==
X-Received: by 2002:a37:7f41:: with SMTP id a62mr21745612qkd.247.1549759775240;
        Sat, 09 Feb 2019 16:49:35 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id k66sm6420163qkc.25.2019.02.09.16.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 16:49:34 -0800 (PST)
Date:   Sat, 9 Feb 2019 19:49:32 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, rkrcmar@redhat.com,
        alexander.h.duyck@linux.intel.com, x86@kernel.org,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, pbonzini@redhat.com,
        tglx@linutronix.de, akpm@linux-foundation.org
Subject: Re: [RFC PATCH 3/4] kvm: Add guest side support for free memory hints
Message-ID: <20190209194437-mutt-send-email-mst@kernel.org>
References: <20190204181118.12095.38300.stgit@localhost.localdomain>
 <20190204181552.12095.46287.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204181552.12095.46287.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 10:15:52AM -0800, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> Add guest support for providing free memory hints to the KVM hypervisor for
> freed pages huge TLB size or larger. I am restricting the size to
> huge TLB order and larger because the hypercalls are too expensive to be
> performing one per 4K page.

Even 2M pages start to get expensive with a TB guest.

Really it seems we want a virtio ring so we can pass a batch of these.
E.g. 256 entries, 2M each - that's more like it.

> Using the huge TLB order became the obvious
> choice for the order to use as it allows us to avoid fragmentation of higher
> order memory on the host.
> 
> I have limited the functionality so that it doesn't work when page
> poisoning is enabled. I did this because a write to the page after doing an
> MADV_DONTNEED would effectively negate the hint, so it would be wasting
> cycles to do so.

Again that's leaking host implementation detail into guest interface.

We are giving guest page hints to host that makes sense,
weird interactions with other features due to host
implementation details should be handled by host.




> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  arch/x86/include/asm/page.h |   13 +++++++++++++
>  arch/x86/kernel/kvm.c       |   23 +++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
> index 7555b48803a8..4487ad7a3385 100644
> --- a/arch/x86/include/asm/page.h
> +++ b/arch/x86/include/asm/page.h
> @@ -18,6 +18,19 @@
>  
>  struct page;
>  
> +#ifdef CONFIG_KVM_GUEST
> +#include <linux/jump_label.h>
> +extern struct static_key_false pv_free_page_hint_enabled;
> +
> +#define HAVE_ARCH_FREE_PAGE
> +void __arch_free_page(struct page *page, unsigned int order);
> +static inline void arch_free_page(struct page *page, unsigned int order)
> +{
> +	if (static_branch_unlikely(&pv_free_page_hint_enabled))
> +		__arch_free_page(page, order);
> +}
> +#endif
> +
>  #include <linux/range.h>
>  extern struct range pfn_mapped[];
>  extern int nr_pfn_mapped;
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 5c93a65ee1e5..09c91641c36c 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -48,6 +48,7 @@
>  #include <asm/tlb.h>
>  
>  static int kvmapf = 1;
> +DEFINE_STATIC_KEY_FALSE(pv_free_page_hint_enabled);
>  
>  static int __init parse_no_kvmapf(char *arg)
>  {
> @@ -648,6 +649,15 @@ static void __init kvm_guest_init(void)
>  	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
>  		apic_set_eoi_write(kvm_guest_apic_eoi_write);
>  
> +	/*
> +	 * The free page hinting doesn't add much value if page poisoning
> +	 * is enabled. So we only enable the feature if page poisoning is
> +	 * no present.
> +	 */
> +	if (!page_poisoning_enabled() &&
> +	    kvm_para_has_feature(KVM_FEATURE_PV_UNUSED_PAGE_HINT))
> +		static_branch_enable(&pv_free_page_hint_enabled);
> +
>  #ifdef CONFIG_SMP
>  	smp_ops.smp_prepare_cpus = kvm_smp_prepare_cpus;
>  	smp_ops.smp_prepare_boot_cpu = kvm_smp_prepare_boot_cpu;
> @@ -762,6 +772,19 @@ static __init int kvm_setup_pv_tlb_flush(void)
>  }
>  arch_initcall(kvm_setup_pv_tlb_flush);
>  
> +void __arch_free_page(struct page *page, unsigned int order)
> +{
> +	/*
> +	 * Limit hints to blocks no smaller than pageblock in
> +	 * size to limit the cost for the hypercalls.
> +	 */
> +	if (order < KVM_PV_UNUSED_PAGE_HINT_MIN_ORDER)
> +		return;
> +
> +	kvm_hypercall2(KVM_HC_UNUSED_PAGE_HINT, page_to_phys(page),
> +		       PAGE_SIZE << order);
> +}
> +
>  #ifdef CONFIG_PARAVIRT_SPINLOCKS
>  
>  /* Kick a cpu by its apicid. Used to wake up a halted vcpu */
