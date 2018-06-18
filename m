Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66485C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BC620693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BC620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935340AbeFRRUt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:20:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:33485 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934215AbeFRRUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:20:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 10:20:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,240,1526367600"; 
   d="scan'208";a="49925363"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.145])
  by orsmga007.jf.intel.com with ESMTP; 18 Jun 2018 10:20:46 -0700
Message-ID: <1529342439.2333.60.camel@intel.com>
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
Date:   Mon, 18 Jun 2018 10:20:39 -0700
In-Reply-To: <CAKv+Gu-L=UMkzet7s1rUEYMYZxtoE1M_Qa1dqKo134S_hoZWuw@mail.gmail.com>
References: <1529111365-32295-1-git-send-email-sai.praneeth.prakhya@intel.com>
         <CAKv+Gu-L=UMkzet7s1rUEYMYZxtoE1M_Qa1dqKo134S_hoZWuw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > It's a fact that memremap() and early_memremap() might never fail and
> > this code might never get a chance to run but to maintain good kernel
> > programming semantics, we might need this patch.
> > 
> > Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> > Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Please don't include tags for reviews that did not happen on-list.
> 

Sure! Thanks for letting me know.

> > @@ -450,10 +451,11 @@ void __init efi_free_boot_services(void)
> > 
> >         memunmap(new);
> > 
> > -       if (efi_memmap_install(new_phys, num_entries)) {
> > +       if (efi_memmap_install(new_phys, num_entries))
> >                 pr_err("Could not install new EFI memmap\n");
> > -               return;
> > -       }
> > +
> > +free_mem:
> > +       efi_memmap_free(new_phys, num_entries);
> Doesn't this free the memory map that you just installed?
> 

That's true! It's a bug. I will fix it.

> > 
> >  }
> > 
> >  /**
> > + * efi_memmap_free - Free memory allocated by efi_memmap_alloc()
> > + * @mem: Physical address allocated by efi_memmap_alloc()
> > + * @num_entries: Number of entries in the allocated map.
> > + *
> > + * efi_memmap_alloc() allocates memory depending on whether mm_init()
> > + * has already been invoked or not. It uses either memblock or "normal"
> > + * page allocation. Use this function to free the memory allocated by
> > + * efi_memmap_alloc(). Since the allocation is done in two different
> > + * ways, similarly, we free it in two different ways.
> > + *
> > + */
> > +void __init efi_memmap_free(phys_addr_t mem, unsigned int num_entries)
> > +{
> > +       unsigned long size = num_entries * efi.memmap.desc_size;
> > +       unsigned int order = get_order(size);
> > +       phys_addr_t end = mem + size - 1;
> > +
> > +       if (slab_is_available()) {
> > +               __free_pages(pfn_to_page(PHYS_PFN(mem)), order);
> How do you know that the memory you are freeing was allocated when
> slab_is_available() was already true?
> 

efi_memmap_free() should be used *only* in conjunction
with efi_memmap_alloc()(As I explicitly didn't mention this, maybe it might
have confused you).

When allocating memory efi_memmap_alloc() does similar check
for slab_is_available() and if so, it allocates memory using alloc_pages().
So, to free pages allocated using alloc_pages(), efi_memmap_free()
uses __free_pages().

> > 
> > +               return;
> > +       }
> > +
> > +       if (memblock_free(mem, size))
> > +               pr_err("Failed to free mem from %pa to %pa\n", &mem,
> > &end);
> > +}
> > +

Regards,
Sai
