Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5FD1BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC77208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC77208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965902AbeFOP1f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 11:27:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:19947 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964936AbeFOP1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 11:27:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 08:27:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,227,1526367600"; 
   d="scan'208";a="63515419"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jun 2018 08:27:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 5388B166; Fri, 15 Jun 2018 18:27:32 +0300 (EEST)
Date:   Fri, 15 Jun 2018 18:27:32 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv3 07/17] x86/mm: Preserve KeyID on pte_modify() and
 pgprot_modify()
Message-ID: <20180615152731.3y6rre7g66rmncxr@black.fi.intel.com>
References: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
 <20180612143915.68065-8-kirill.shutemov@linux.intel.com>
 <8c31f6d2-6512-2726-763e-6dd1cbb0350a@intel.com>
 <20180615125720.r755xaegvfcqfr6x@black.fi.intel.com>
 <645a4ca8-ae77-dcdd-0cbc-0da467fc210d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <645a4ca8-ae77-dcdd-0cbc-0da467fc210d@intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 01:43:03PM +0000, Dave Hansen wrote:
> On 06/15/2018 05:57 AM, Kirill A. Shutemov wrote:
> >>> +#define _PAGE_CHG_MASK	(PTE_PFN_MASK_MAX | _PAGE_PCD | _PAGE_PWT |		\
> >>>  			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\
> >>>  			 _PAGE_SOFT_DIRTY)
> >>>  #define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)
> >> This makes me a bit nervous.  We have some places (here) where we
> >> pretend that the KeyID is part of the paddr and then other places like
> >> pte_pfn() where it's not.
> > Other option is to include KeyID mask into _PAGE_CHG_MASK. But it means
> > _PAGE_CHG_MASK would need to reference *two* variables: physical_mask and
> > mktme_keyid_mask. I mentioned this in the commit message.
> 
> Why can't it be one variable with a different name that's populated by
> OR'ing physical_mask and mktme_keyid_mask together?

My point is that we don't need variables at all here.

Architecture defines range of bits in PTE used for PFN. MKTME reduces the
number of bits for PFN. PTE_PFN_MASK_MAX represents the original
architectural range, before MKTME stole these bits.

PTE_PFN_MASK_MAX is constant -- on x86-64 bits 51:12 -- regardless of
MKTME support.

> My issue here is that it this approach adds confusion around the logical
> separation between physical address and the bits immediately above the
> physical address in the PTE that are stolen for the keyID.

Well, yes, with MKTME the meaning of PFN/physical address is not that clear
cut. This comes from hardware design. I don't think we will be able to get
rid of ambiguity completely.

If you have suggestions on how to make it clearer, I would be glad to
rework it.

> Whatever you come up with will probably fine, as long as things that are
> called "PFN" or physical address don't also get used for keyID bits.

We are arguing about macros used exactly once. Is it really so confusing?

-- 
 Kirill A. Shutemov
