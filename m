Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 65833C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176E920896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176E920896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936188AbeFOM5c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 08:57:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:48971 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753242AbeFOM5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 08:57:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 05:57:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,226,1526367600"; 
   d="scan'208";a="237457085"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jun 2018 05:57:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id BA5CB172; Fri, 15 Jun 2018 15:57:20 +0300 (EEST)
Date:   Fri, 15 Jun 2018 15:57:20 +0300
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
Message-ID: <20180615125720.r755xaegvfcqfr6x@black.fi.intel.com>
References: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
 <20180612143915.68065-8-kirill.shutemov@linux.intel.com>
 <8c31f6d2-6512-2726-763e-6dd1cbb0350a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c31f6d2-6512-2726-763e-6dd1cbb0350a@intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 06:13:03PM +0000, Dave Hansen wrote:
> On 06/12/2018 07:39 AM, Kirill A. Shutemov wrote:
> > Encrypted VMA will have KeyID stored in vma->vm_page_prot. This way we
> 
> "An encrypted VMA..."
> 
> > don't need to do anything special to setup encrypted page table entries
> > and don't need to reserve space for KeyID in a VMA.
> > 
> > This patch changes _PAGE_CHG_MASK to include KeyID bits. Otherwise they
> > are going to be stripped from vm_page_prot on the first pgprot_modify().
> > 
> > Define PTE_PFN_MASK_MAX similar to PTE_PFN_MASK but based on
> > __PHYSICAL_MASK_SHIFT. This way we include whole range of bits
> > architecturally available for PFN without referencing physical_mask and
> > mktme_keyid_mask variables.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/include/asm/pgtable_types.h | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> > index 1e5a40673953..e8ebe760b88d 100644
> > --- a/arch/x86/include/asm/pgtable_types.h
> > +++ b/arch/x86/include/asm/pgtable_types.h
> > @@ -121,8 +121,13 @@
> >   * protection key is treated like _PAGE_RW, for
> >   * instance, and is *not* included in this mask since
> >   * pte_modify() does modify it.
> > + *
> > + * It includes full range of PFN bits regardless if they were claimed for KeyID
> > + * or not: we want to preserve KeyID on pte_modify() and pgprot_modify().
> >   */
> > -#define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
> > +#define PTE_PFN_MASK_MAX \
> > +	(((signed long)PAGE_MASK) & ((1ULL << __PHYSICAL_MASK_SHIFT) - 1))
> 
> "signed long" is really unusual to see.  Was that intentional?

Yes. That's trick with sign-extension, borrowed from PHYSICAL_PAGE_MASK
definition. It helps on 32-bit with PAE properly expand the PAGE_MASK to
64-bit.

I'll add comment.

> > +#define _PAGE_CHG_MASK	(PTE_PFN_MASK_MAX | _PAGE_PCD | _PAGE_PWT |		\
> >  			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\
> >  			 _PAGE_SOFT_DIRTY)
> >  #define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)
> 
> This makes me a bit nervous.  We have some places (here) where we
> pretend that the KeyID is part of the paddr and then other places like
> pte_pfn() where it's not.

Other option is to include KeyID mask into _PAGE_CHG_MASK. But it means
_PAGE_CHG_MASK would need to reference *two* variables: physical_mask and
mktme_keyid_mask. I mentioned this in the commit message.

This is more efficient way to achieve the same compile-time without
referencing any variables.

> Seems like something that will come back to bite us.

Any suggestions?

-- 
 Kirill A. Shutemov
