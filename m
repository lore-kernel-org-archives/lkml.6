Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F51CC6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA38A2082B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA38A2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbeJaMDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 08:03:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:9449 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728578AbeJaMDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 08:03:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 20:07:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,447,1534834800"; 
   d="scan'208";a="103979219"
Received: from zhangyu-optiplex-9020.bj.intel.com (HELO localhost) ([10.238.135.159])
  by fmsmga001.fm.intel.com with ESMTP; 30 Oct 2018 20:07:25 -0700
Date:   Wed, 31 Oct 2018 11:05:35 +0800
From:   Yu Zhang <yu.c.zhang@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Barret Rhoden <brho@google.com>, X86 ML <x86@kernel.org>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        KVM list <kvm@vger.kernel.org>, rkrcmar@redhat.com,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        zwisler@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Subject: Re: [RFC PATCH] kvm: Use huge pages for DAX-backed files
Message-ID: <20181031030535.slgmorcrhacdrdml@linux.intel.com>
References: <20181029210716.212159-1-brho@google.com>
 <CAPcyv4gJUjuSKwy7i2wuKR=Vz-AkDrxnGya5qkg7XTFxuXbtzw@mail.gmail.com>
 <20181029202854.7c924fd3@gnomeregan.cam.corp.google.com>
 <CAPcyv4gQztHrJ3--rhU4ZpaZyyqdqE0=gx50CRArHKiXwfYC+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gQztHrJ3--rhU4ZpaZyyqdqE0=gx50CRArHKiXwfYC+A@mail.gmail.com>
User-Agent: NeoMutt/20180622-66-b94505
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 08:10:52PM -0700, Dan Williams wrote:
> On Mon, Oct 29, 2018 at 5:29 PM Barret Rhoden <brho@google.com> wrote:
> >
> > On 2018-10-29 at 15:25 Dan Williams <dan.j.williams@intel.com> wrote:
> > > > +       /*
> > > > +        * Our caller grabbed the KVM mmu_lock with a successful
> > > > +        * mmu_notifier_retry, so we're safe to walk the page table.
> > > > +        */
> > > > +       map_sz = pgd_mapping_size(current->mm, hva);
> > > > +       switch (map_sz) {
> > > > +       case PMD_SIZE:
> > > > +               return true;
> > > > +       case P4D_SIZE:
> > > > +       case PUD_SIZE:
> > > > +               printk_once(KERN_INFO "KVM THP promo found a very large page");
> > >
> > > Why not allow PUD_SIZE? The device-dax interface supports PUD mappings.
> >
> > The place where I use that helper seemed to care about PMDs (compared
> > to huge pages larger than PUDs), I think due to THP.  Though it also
> > checks "level == PT_PAGE_TABLE_LEVEL", so it's probably a moot point.
> >
> > I can change it from pfn_is_pmd_mapped -> pfn_is_huge_mapped and allow
> > any huge mapping that is appropriate: so PUD or PMD for DAX, PMD for
> > non-DAX, IIUC.
> 
> Yes, THP stops at PMDs, but DAX and hugetlbfs support PUD level mappings.
> 
> > > > +               return false;
> > > > +       }
> > > > +       return false;
> > > > +}
> > >
> > > The above 2 functions are  similar to what we need to do for
> > > determining the blast radius of a memory error, see
> > > dev_pagemap_mapping_shift() and its usage in add_to_kill().
> >
> > Great.  I don't know if I have access in the KVM code to the VMA to use
> > those functions directly, but I can extract the guts of
> > dev_pagemap_mapping_shift() or something and put it in mm/util.c.
> 
> Sounds good.
> 
> > > >  static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
> > > >                                         gfn_t *gfnp, kvm_pfn_t *pfnp,
> > > >                                         int *levelp)
> > > > @@ -3168,7 +3237,7 @@ static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
> > > >          */
> > > >         if (!is_error_noslot_pfn(pfn) && !kvm_is_reserved_pfn(pfn) &&
> > > >             level == PT_PAGE_TABLE_LEVEL &&
> > > > -           PageTransCompoundMap(pfn_to_page(pfn)) &&
> > > > +           pfn_is_pmd_mapped(vcpu->kvm, gfn, pfn) &&
> > >
> > > I'm wondering if we're adding an explicit is_zone_device_page() check
> > > in this path to determine the page mapping size if that can be a
> > > replacement for the kvm_is_reserved_pfn() check. In other words, the
> > > goal of fixing up PageReserved() was to preclude the need for DAX-page
> > > special casing in KVM, but if we already need add some special casing
> > > for page size determination, might as well bypass the
> > > kvm_is_reserved_pfn() dependency as well.
> >
> > kvm_is_reserved_pfn() is used in some other places, like
> > kvm_set_pfn_dirty()and kvm_set_pfn_accessed().  Maybe the way those
> > treat DAX pages matters on a case-by-case basis?
> >
> > There are other callers of kvm_is_reserved_pfn() such as
> > kvm_pfn_to_page() and gfn_to_page().  I'm not familiar (yet) with how
> > struct pages and DAX work together, and whether or not the callers of
> > those pfn_to_page() functions have expectations about the 'type' of
> > struct page they get back.
> >
> 
> The property of DAX pages that requires special coordination is the
> fact that the device hosting the pages can be disabled at will. The
> get_dev_pagemap() api is the interface to pin a device-pfn so that you
> can safely perform a pfn_to_page() operation.
> 
> Have the pages that kvm uses in this path already been pinned by vfio?

My understanding is, it could be - if there's any device assigned to the VM.
Otherwise, they will not.

B.R.
Yu

> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
> 
