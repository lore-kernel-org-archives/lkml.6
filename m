Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440A0C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC75D20836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC75D20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935475AbeFRRl7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:41:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:34611 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934957AbeFRRl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:41:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 10:41:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,240,1526367600"; 
   d="scan'208";a="65564581"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.145])
  by orsmga001.jf.intel.com with ESMTP; 18 Jun 2018 10:41:56 -0700
Message-ID: <1529343708.2333.65.camel@intel.com>
Subject: Re: [PATCH] x86/efi: Free allocated memory if remap fails
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
Date:   Mon, 18 Jun 2018 10:41:48 -0700
In-Reply-To: <CAKv+Gu9-YrLPuduh3YH67Fk0+tL1AfAveguu+mPjBwEBNU+==Q@mail.gmail.com>
References: <1529111365-32295-1-git-send-email-sai.praneeth.prakhya@intel.com>
         <CAKv+Gu-L=UMkzet7s1rUEYMYZxtoE1M_Qa1dqKo134S_hoZWuw@mail.gmail.com>
         <1529342439.2333.60.camel@intel.com>
         <CAKv+Gu9-YrLPuduh3YH67Fk0+tL1AfAveguu+mPjBwEBNU+==Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> > > > +void __init efi_memmap_free(phys_addr_t mem, unsigned int
> > > > num_entries)
> > > > +{
> > > > +       unsigned long size = num_entries * efi.memmap.desc_size;
> > > > +       unsigned int order = get_order(size);
> > > > +       phys_addr_t end = mem + size - 1;
> > > > +
> > > > +       if (slab_is_available()) {
> > > > +               __free_pages(pfn_to_page(PHYS_PFN(mem)), order);
> > > How do you know that the memory you are freeing was allocated when
> > > slab_is_available() was already true?
> > > 
> > efi_memmap_free() should be used *only* in conjunction
> > with efi_memmap_alloc()(As I explicitly didn't mention this, maybe it
> > might
> > have confused you).
> > 
> > When allocating memory efi_memmap_alloc() does similar check
> > for slab_is_available() and if so, it allocates memory using
> > alloc_pages().
> > So, to free pages allocated using alloc_pages(), efi_memmap_free()
> > uses __free_pages().
> > 
> I understand that. But by abstracting away the free() routine as well
> as the alloc() routine, you are hiding this fact.
> 
> What is preventing me from using efi_memmap_alloc() to allocate space
> for the memmap, and using efi_memmap_free() in another place? How are
> you preventing that this does not happen in a way where mm_init() may
> be called in the mean time?
> 
> Whether __free_pages() should be used or memblock_free() is a property
> of the *allocation* itself, not of whether mm_init() has already been
> called. So if (!slab_is_available()), you can use memblock_free().
> However, if (slab_is_available()), you cannot use __free_pages()
> because the allocation could have been made before mm_init() was
> called.
> 

Aahh.. Thanks a lot! for making it clear. I see the bug now
(efi_memmap_alloc() could be called before mm_init() in which case it uses
memblock_alloc() where as efi_memmap_free() could be called after mm_init() in
which case it uses __free_pages()).

I will fix this.

Regards,
Sai

