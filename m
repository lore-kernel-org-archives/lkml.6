Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C022C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1641F2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfBGSoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:44:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:41509 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbfBGSoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:44:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 10:44:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,345,1544515200"; 
   d="scan'208";a="298032527"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga005.jf.intel.com with ESMTP; 07 Feb 2019 10:44:11 -0800
Message-ID: <34c93e5a05a7dc93e38364733f8832f2e1b2dcb3.camel@linux.intel.com>
Subject: Re: [RFC PATCH 3/4] kvm: Add guest side support for free memory
 hints
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Luiz Capitulino <lcapitulino@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, rkrcmar@redhat.com, x86@kernel.org,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, pbonzini@redhat.com,
        tglx@linutronix.de, akpm@linux-foundation.org
Date:   Thu, 07 Feb 2019 10:44:11 -0800
In-Reply-To: <20190207132104.17a296da@doriath>
References: <20190204181118.12095.38300.stgit@localhost.localdomain>
         <20190204181552.12095.46287.stgit@localhost.localdomain>
         <20190207132104.17a296da@doriath>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-07 at 13:21 -0500, Luiz Capitulino wrote:
> On Mon, 04 Feb 2019 10:15:52 -0800
> Alexander Duyck <alexander.duyck@gmail.com> wrote:
> 
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > 
> > Add guest support for providing free memory hints to the KVM hypervisor for
> > freed pages huge TLB size or larger. I am restricting the size to
> > huge TLB order and larger because the hypercalls are too expensive to be
> > performing one per 4K page. Using the huge TLB order became the obvious
> > choice for the order to use as it allows us to avoid fragmentation of higher
> > order memory on the host.
> > 
> > I have limited the functionality so that it doesn't work when page
> > poisoning is enabled. I did this because a write to the page after doing an
> > MADV_DONTNEED would effectively negate the hint, so it would be wasting
> > cycles to do so.
> > 
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >  arch/x86/include/asm/page.h |   13 +++++++++++++
> >  arch/x86/kernel/kvm.c       |   23 +++++++++++++++++++++++
> >  2 files changed, 36 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
> > index 7555b48803a8..4487ad7a3385 100644
> > --- a/arch/x86/include/asm/page.h
> > +++ b/arch/x86/include/asm/page.h
> > @@ -18,6 +18,19 @@
> >  
> >  struct page;
> >  
> > +#ifdef CONFIG_KVM_GUEST
> > +#include <linux/jump_label.h>
> > +extern struct static_key_false pv_free_page_hint_enabled;
> > +
> > +#define HAVE_ARCH_FREE_PAGE
> > +void __arch_free_page(struct page *page, unsigned int order);
> > +static inline void arch_free_page(struct page *page, unsigned int order)
> > +{
> > +	if (static_branch_unlikely(&pv_free_page_hint_enabled))
> > +		__arch_free_page(page, order);
> > +}
> > +#endif
> > +
> >  #include <linux/range.h>
> >  extern struct range pfn_mapped[];
> >  extern int nr_pfn_mapped;
> > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > index 5c93a65ee1e5..09c91641c36c 100644
> > --- a/arch/x86/kernel/kvm.c
> > +++ b/arch/x86/kernel/kvm.c
> > @@ -48,6 +48,7 @@
> >  #include <asm/tlb.h>
> >  
> >  static int kvmapf = 1;
> > +DEFINE_STATIC_KEY_FALSE(pv_free_page_hint_enabled);
> >  
> >  static int __init parse_no_kvmapf(char *arg)
> >  {
> > @@ -648,6 +649,15 @@ static void __init kvm_guest_init(void)
> >  	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
> >  		apic_set_eoi_write(kvm_guest_apic_eoi_write);
> >  
> > +	/*
> > +	 * The free page hinting doesn't add much value if page poisoning
> > +	 * is enabled. So we only enable the feature if page poisoning is
> > +	 * no present.
> > +	 */
> > +	if (!page_poisoning_enabled() &&
> > +	    kvm_para_has_feature(KVM_FEATURE_PV_UNUSED_PAGE_HINT))
> > +		static_branch_enable(&pv_free_page_hint_enabled);
> > +
> >  #ifdef CONFIG_SMP
> >  	smp_ops.smp_prepare_cpus = kvm_smp_prepare_cpus;
> >  	smp_ops.smp_prepare_boot_cpu = kvm_smp_prepare_boot_cpu;
> > @@ -762,6 +772,19 @@ static __init int kvm_setup_pv_tlb_flush(void)
> >  }
> >  arch_initcall(kvm_setup_pv_tlb_flush);
> >  
> > +void __arch_free_page(struct page *page, unsigned int order)
> > +{
> > +	/*
> > +	 * Limit hints to blocks no smaller than pageblock in
> > +	 * size to limit the cost for the hypercalls.
> > +	 */
> > +	if (order < KVM_PV_UNUSED_PAGE_HINT_MIN_ORDER)
> > +		return;
> > +
> > +	kvm_hypercall2(KVM_HC_UNUSED_PAGE_HINT, page_to_phys(page),
> > +		       PAGE_SIZE << order);
> 
> Does this mean that the vCPU executing this will get stuck
> here for the duration of the hypercall? Isn't that too long,
> considering that the zone lock is taken and madvise in the
> host block on semaphores?

I'm pretty sure the zone lock isn't held when this is called. The lock
isn't acquired until later in the path. This gets executed just before
the page poisoning call which would take time as well since it would
have to memset an entire page. This function is called as a part of
free_pages_prepare, the zone locks aren't acquired until we are calling
into either free_one_page and a few spots before calling
__free_one_page.

My other function in patch 4 which does this from inside of
__free_one_page does have to release the zone lock since it is taken
there.

