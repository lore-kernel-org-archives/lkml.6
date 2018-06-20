Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BB5C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42807205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42807205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754234AbeFTCg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 22:36:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:41554 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752951AbeFTCgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 22:36:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 19:36:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,245,1526367600"; 
   d="scan'208";a="64677556"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.145])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jun 2018 19:36:51 -0700
Message-ID: <1529462205.2333.83.camel@intel.com>
Subject: Re: [PATCH V2] x86/efi: Free allocated memory if remap fails
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
Date:   Tue, 19 Jun 2018 19:36:45 -0700
In-Reply-To: <CAKv+Gu-yeXwLjd1Sp0jc41-9zVFOuxSBqMiHkivTLmT-u3Upjg@mail.gmail.com>
References: <1529350614-15555-1-git-send-email-sai.praneeth.prakhya@intel.com>
         <CAKv+Gu-yeXwLjd1Sp0jc41-9zVFOuxSBqMiHkivTLmT-u3Upjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > 
> Thank you Sai.
> 
> But this is not really what I meant.
> 

Ya.. sorry! about that. I had a hunch that you might be suggesting something
like below but I went ahead with this implementation as it looked very simple
(just 3 insertions and no deletions)

> How about we modify efi_memmap_alloc() like this
> 

It sounds like a good idea to me. Leaving aside the pros (which are obvious),
the only con I could see is few extra checks and some code but I don't think
it's an issue at all because this code is not in fast path and it dosen't
impact performance. So, I will post a V3 with suggested changes.

> @@ -39,10 +39,12 @@ static phys_addr_t __init
> __efi_memmap_alloc_late(unsigned long size)
>   * Returns the physical address of the allocated memory map on
>   * success, zero on failure.
>   */
> -phys_addr_t __init efi_memmap_alloc(unsigned int num_entries)
> +phys_addr_t __init efi_memmap_alloc(unsigned int num_entries, bool *late)
>  {
>         unsigned long size = num_entries * efi.memmap.desc_size;
> 
> +       if (late)
> +               *late = slab_is_available();
>         if (slab_is_available())
>                 return __efi_memmap_alloc_late(size);
> 
> and introduce efi_memmap_free() as before, but pass it the 'late'
> parameter you received from efi_memmap_alloc(). That way, it is the
> caller's job to take care of this.
> 

Sure! makes sense.

> Also, it seems to me that efi_arch_mem_reserve() leaks the old memory
> map every time you create a new one, no?

I think you are right. The issue I see is (please let me know if you think
otherwise):
1. efi_arch_mem_reserve() comes up with a new memory map and then tries to
install it via efi_memmap_install().
2. efi_memmap_install(), unmaps the existing memory map and installs the new
memory map but doesn't free the memory used by the existing memory map.
Hence, as you said, leaks the old memory map.

If this you what you meant, I think, the issue is not just limited to
efi_arch_mem_reserve() but to all the places that call efi_memmap_install().
I think, we could solve it as below

diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 678e85704054..50ae4ffbf058 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -228,6 +228,7 @@ int __init efi_memmap_install(phys_addr_t addr, unsigned
int nr_map)
        struct efi_memory_map_data data;
 
        efi_memmap_unmap();
+       efi_memmap_free(efi.memmap.phys_map, efi.memmap.nr_map,
efi.memmap.late);
 
        data.phys_map = addr;
        data.size = efi.memmap.desc_size * nr_map;

Please let me know your thoughts on it.

> That is a separate issue that
> you may want to look into, but it affects the design of this API as
> well.

Probably, I could have misunderstood you here.. but I think the
efi_memmap_free() API in V3 should work (without changes). Don't you think so?

Regards,
Sai
