Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55E3C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6692086C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfBGSVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:21:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfBGSVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:21:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3FEDA5C9;
        Thu,  7 Feb 2019 18:21:07 +0000 (UTC)
Received: from doriath (ovpn-116-107.phx2.redhat.com [10.3.116.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 324EC600C4;
        Thu,  7 Feb 2019 18:21:05 +0000 (UTC)
Date:   Thu, 7 Feb 2019 13:21:04 -0500
From:   Luiz Capitulino <lcapitulino@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, rkrcmar@redhat.com,
        alexander.h.duyck@linux.intel.com, x86@kernel.org,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, pbonzini@redhat.com,
        tglx@linutronix.de, akpm@linux-foundation.org
Subject: Re: [RFC PATCH 3/4] kvm: Add guest side support for free memory
 hints
Message-ID: <20190207132104.17a296da@doriath>
In-Reply-To: <20190204181552.12095.46287.stgit@localhost.localdomain>
References: <20190204181118.12095.38300.stgit@localhost.localdomain>
        <20190204181552.12095.46287.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 07 Feb 2019 18:21:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Feb 2019 10:15:52 -0800
Alexander Duyck <alexander.duyck@gmail.com> wrote:

> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> Add guest support for providing free memory hints to the KVM hypervisor for
> freed pages huge TLB size or larger. I am restricting the size to
> huge TLB order and larger because the hypercalls are too expensive to be
> performing one per 4K page. Using the huge TLB order became the obvious
> choice for the order to use as it allows us to avoid fragmentation of higher
> order memory on the host.
> 
> I have limited the functionality so that it doesn't work when page
> poisoning is enabled. I did this because a write to the page after doing an
> MADV_DONTNEED would effectively negate the hint, so it would be wasting
> cycles to do so.
> 
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

Does this mean that the vCPU executing this will get stuck
here for the duration of the hypercall? Isn't that too long,
considering that the zone lock is taken and madvise in the
host block on semaphores?

> +}
> +
>  #ifdef CONFIG_PARAVIRT_SPINLOCKS
>  
>  /* Kick a cpu by its apicid. Used to wake up a halted vcpu */
> 

