Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC38C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6982086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6982086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935140AbeFROlK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:41:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:11442 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934367AbeFROlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:41:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 07:41:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,239,1526367600"; 
   d="scan'208";a="58212199"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Jun 2018 07:41:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 9B3E4FA; Mon, 18 Jun 2018 17:41:06 +0300 (EEST)
Date:   Mon, 18 Jun 2018 17:41:06 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv3 16/17] x86/mm: Handle encrypted memory in
 page_to_virt() and __pa()
Message-ID: <20180618144106.2gga6w55zbbnnjhb@black.fi.intel.com>
References: <20180612143915.68065-1-kirill.shutemov@linux.intel.com>
 <20180612143915.68065-17-kirill.shutemov@linux.intel.com>
 <f8b9da42-1f7b-529c-bfdd-e82f669f6fe8@intel.com>
 <20180618133455.aumn4wihygvds543@black.fi.intel.com>
 <48fe7072-e92d-959a-67f7-ded82124f79f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48fe7072-e92d-959a-67f7-ded82124f79f@intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 01:59:18PM +0000, Dave Hansen wrote:
> On 06/18/2018 06:34 AM, Kirill A. Shutemov wrote:
> > On Wed, Jun 13, 2018 at 06:43:08PM +0000, Dave Hansen wrote:
> >>> diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
> >>> index efc0d4bb3b35..d6edcabacfc7 100644
> >>> --- a/arch/x86/include/asm/mktme.h
> >>> +++ b/arch/x86/include/asm/mktme.h
> >>> @@ -43,6 +43,9 @@ void mktme_disable(void);
> >>>  void setup_direct_mapping_size(void);
> >>>  int sync_direct_mapping(void);
> >>>  
> >>> +#define page_to_virt(x) \
> >>> +	(__va(PFN_PHYS(page_to_pfn(x))) + page_keyid(x) * direct_mapping_size)
> >>
> >> This looks like a super important memory management function being
> >> defined in some obscure Intel-specific feature header.  How does that work?
> > 
> > No magic. It overwrites define in <linux/mm.h>.
> 
> It frankly looks like magic to me.  How can this possibly work without
> ensuring that asm/mktme.h is #included everywhere on every file compiled
> for the entire architecture?

asm/mktme.h is included from asm/page.h. It is functionally identical
other architectures.

> If we look at every definition of page_to_virt() on every architecture
> in the kernel, we see it uniquely defined in headers that look rather
> generic.  I don't see any precedent for feature-specific definitions.

I do.

m68k and microblaze have different definitions of the macro depending
on CONFIG_MMU.

On arm64 it depends on CONFIG_SPARSEMEM_VMEMMAP.

> > arch/arm64/include/asm/memory.h:#define page_to_virt(page)	((void *)((__page_to_voff(page)) | PAGE_OFFSET))
> > arch/hexagon/include/asm/page.h:#define page_to_virt(page)	__va(page_to_phys(page))
> > arch/m68k/include/asm/page_mm.h:#define page_to_virt(page) ({						\
> > arch/m68k/include/asm/page_no.h:#define page_to_virt(page)	__va(((((page) - mem_map) << PAGE_SHIFT) + PAGE_OFFSET))
> > arch/microblaze/include/asm/page.h:#  define page_to_virt(page)   __va(page_to_pfn(page) << PAGE_SHIFT)
> > arch/microblaze/include/asm/page.h:#  define page_to_virt(page)	(pfn_to_virt(page_to_pfn(page)))
> > arch/nios2/include/asm/page.h:#define page_to_virt(page)	\
> > arch/riscv/include/asm/page.h:#define page_to_virt(page)	(pfn_to_virt(page_to_pfn(page)))
> > arch/s390/include/asm/page.h:#define page_to_virt(page)	pfn_to_virt(page_to_pfn(page))
> > arch/xtensa/include/asm/page.h:#define page_to_virt(page)	__va(page_to_pfn(page) << PAGE_SHIFT)
> 
> *If* you do this, I think it 100% *HAS* to be done in a central header,
> like x86's page.h.  We need a single x86 macro for this, not something
> which can and will change based on #include ordering and Kconfig.

I don't agree.

asm/mktme.h included from the single header -- asm/page.h -- and has clear
path to linux/mm.h where the default page_to_virt() is defined.

I don't see a reason to move it out of feature-specific header. The
default page_to_virt() is perfectly fine without MKTME. And it will be
obvious on grep.

-- 
 Kirill A. Shutemov
