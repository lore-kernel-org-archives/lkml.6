Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C594BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92887223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92887223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731929AbeKMT74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:59:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731399AbeKMT7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:59:55 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA51730041C2;
        Tue, 13 Nov 2018 10:02:34 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A6BC7546E0;
        Tue, 13 Nov 2018 10:02:34 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 55A07181A133;
        Tue, 13 Nov 2018 10:02:34 +0000 (UTC)
Date:   Tue, 13 Nov 2018 05:02:33 -0500 (EST)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Barret Rhoden <brho@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, yu c zhang <yu.c.zhang@intel.com>,
        yi z zhang <yi.z.zhang@intel.com>
Message-ID: <286665658.33247363.1542103353780.JavaMail.zimbra@redhat.com>
In-Reply-To: <043a592d-6592-3053-15a0-68cc54a26deb@redhat.com>
References: <20181109203921.178363-1-brho@google.com> <20181109203921.178363-3-brho@google.com> <043a592d-6592-3053-15a0-68cc54a26deb@redhat.com>
Subject: Re: [PATCH 2/2] kvm: Use huge pages for DAX-backed files
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.71, 10.4.195.7]
Thread-Topic: Use huge pages for DAX-backed files
Thread-Index: XzKD+IYl7+LQIXEseoTV2cViPjNFzw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 13 Nov 2018 10:02:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> On 09.11.18 21:39, Barret Rhoden wrote:
> > This change allows KVM to map DAX-backed files made of huge pages with
> > huge mappings in the EPT/TDP.
> > 
> > DAX pages are not PageTransCompound.  The existing check is trying to
> > determine if the mapping for the pfn is a huge mapping or not.  For
> > non-DAX maps, e.g. hugetlbfs, that means checking PageTransCompound.
> > For DAX, we can check the page table itself.
> > 
> > Note that KVM already faulted in the page (or huge page) in the host's
> > page table, and we hold the KVM mmu spinlock (grabbed before checking
> > the mmu seq).
> 
> I wonder if the KVM mmu spinlock is enough for walking (not KVM
> exclusive) host page tables. Can you elaborate?

As this patch is dependent on PageReserved patch(which is in progress), just 
wondering if we are able to test the code path for hugepage with DAX.

Thanks,
Pankaj 
 
> 
> > 
> > Signed-off-by: Barret Rhoden <brho@google.com>
> > ---
> >  arch/x86/kvm/mmu.c | 34 ++++++++++++++++++++++++++++++++--
> >  1 file changed, 32 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> > index cf5f572f2305..2df8c459dc6a 100644
> > --- a/arch/x86/kvm/mmu.c
> > +++ b/arch/x86/kvm/mmu.c
> > @@ -3152,6 +3152,36 @@ static int kvm_handle_bad_page(struct kvm_vcpu
> > *vcpu, gfn_t gfn, kvm_pfn_t pfn)
> >  	return -EFAULT;
> >  }
> >  
> > +static bool pfn_is_huge_mapped(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn)
> > +{
> > +	struct page *page = pfn_to_page(pfn);
> > +	unsigned long hva, map_shift;
> > +
> > +	if (!is_zone_device_page(page))
> > +		return PageTransCompoundMap(page);
> > +
> > +	/*
> > +	 * DAX pages do not use compound pages.  The page should have already
> > +	 * been mapped into the host-side page table during try_async_pf(), so
> > +	 * we can check the page tables directly.
> > +	 */
> > +	hva = gfn_to_hva(kvm, gfn);
> > +	if (kvm_is_error_hva(hva))
> > +		return false;
> > +
> > +	/*
> > +	 * Our caller grabbed the KVM mmu_lock with a successful
> > +	 * mmu_notifier_retry, so we're safe to walk the page table.
> > +	 */
> > +	map_shift = dev_pagemap_mapping_shift(hva, current->mm);
> 
> You could get rid of that local variable map_shift.
> 
> > +	switch (map_shift) {
> > +	case PMD_SHIFT:
> > +	case PUD_SIZE:
> > +		return true;
> > +	}
> > +	return false;
> > +}
> > +
> >  static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
> >  					gfn_t *gfnp, kvm_pfn_t *pfnp,
> >  					int *levelp)
> > @@ -3168,7 +3198,7 @@ static void transparent_hugepage_adjust(struct
> > kvm_vcpu *vcpu,
> >  	 */
> >  	if (!is_error_noslot_pfn(pfn) && !kvm_is_reserved_pfn(pfn) &&
> >  	    level == PT_PAGE_TABLE_LEVEL &&
> > -	    PageTransCompoundMap(pfn_to_page(pfn)) &&
> > +	    pfn_is_huge_mapped(vcpu->kvm, gfn, pfn) &&
> >  	    !mmu_gfn_lpage_is_disallowed(vcpu, gfn, PT_DIRECTORY_LEVEL)) {
> >  		unsigned long mask;
> >  		/*
> > @@ -5678,7 +5708,7 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm
> > *kvm,
> >  		 */
> >  		if (sp->role.direct &&
> >  			!kvm_is_reserved_pfn(pfn) &&
> > -			PageTransCompoundMap(pfn_to_page(pfn))) {
> > +			pfn_is_huge_mapped(kvm, sp->gfn, pfn)) {
> >  			pte_list_remove(rmap_head, sptep);
> >  			need_tlb_flush = 1;
> >  			goto restart;
> > 
> 
> This looks surprisingly simple to me :)
> 
> --
> 
> Thanks,
> 
> David / dhildenb
> 
