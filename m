Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2D7C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0EF225885
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EF225885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966167AbeF0V5B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 17:57:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:45502 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965460AbeF0V5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 17:57:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 14:56:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,280,1526367600"; 
   d="scan'208";a="52774567"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 27 Jun 2018 14:56:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 3D211CB; Thu, 28 Jun 2018 00:56:59 +0300 (EEST)
Date:   Thu, 28 Jun 2018 00:56:59 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv4 17/18] x86/mm: Handle encrypted memory in
 page_to_virt() and __pa()
Message-ID: <20180627215658.ol5zq3o5746gizpu@black.fi.intel.com>
References: <20180626142245.82850-1-kirill.shutemov@linux.intel.com>
 <20180626142245.82850-18-kirill.shutemov@linux.intel.com>
 <1609f2b4-4638-8b9d-4dc7-fcb3303739cd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609f2b4-4638-8b9d-4dc7-fcb3303739cd@intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 04:38:23PM +0000, Dave Hansen wrote:
> > diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
> > index ba83fba4f9b3..dbfbd955da98 100644
> > --- a/arch/x86/include/asm/mktme.h
> > +++ b/arch/x86/include/asm/mktme.h
> > @@ -29,6 +29,9 @@ void arch_free_page(struct page *page, int order);
> >  
> >  int sync_direct_mapping(void);
> >  
> > +#define page_to_virt(x) \
> > +	(__va(PFN_PHYS(page_to_pfn(x))) + page_keyid(x) * direct_mapping_size)
> 
> Please put this in a generic header so that this hunk represents the
> *default* x86 implementation that is used universally on x86.

As I said, I disagree with you on the style preference.

If a maintainer prefers it to be done in your way, I'll move the macros.

> Then, please do
> 
> #ifndef CONFIG_MKTME_WHATEVER
> #define page_keyid(x) (0)
> #endif

Default page_keyid() implementation returns 0.

> >  #else
> >  #define mktme_keyid_mask	((phys_addr_t)0)
> >  #define mktme_nr_keyids		0
> > diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
> > index 53c32af895ab..ffad496aadad 100644
> > --- a/arch/x86/include/asm/page_64.h
> > +++ b/arch/x86/include/asm/page_64.h
> > @@ -23,7 +23,7 @@ static inline unsigned long __phys_addr_nodebug(unsigned long x)
> >  	/* use the carry flag to determine if x was < __START_KERNEL_map */
> >  	x = y + ((x > y) ? phys_base : (__START_KERNEL_map - PAGE_OFFSET));
> >  
> > -	return x;
> > +	return x % direct_mapping_size;
> 
> There are almost *surely* performance implications from this that affect
> anyone with this compile option turned on.  There's now a 64-bit integer
> division operation which is used in places like kfree().

Fair point. Apparently, modern CPU is good enough to hide the overhead.
I'll look into how to avoid division.

After quick look the only way to get it cheap (near free on my CPU) is to
have power-of-2 direct_mapping_size and mask address before returning it.

If direct_mapping_size is not power-of-2, the best variant I've come up
with so far costs a branch for non-encrypted memory.

For encrypted it is branch, 32-bit division and some bit shifting and
masking.

I'll look into this more.

-- 
 Kirill A. Shutemov
