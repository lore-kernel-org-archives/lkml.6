Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E569EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05C52070D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732123AbfBSAEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 19:04:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730731AbfBSAEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 19:04:22 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 586958EA;
        Tue, 19 Feb 2019 00:04:21 +0000 (UTC)
Received: from localhost (ovpn-12-16.pek2.redhat.com [10.72.12.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 535FD600C8;
        Tue, 19 Feb 2019 00:04:20 +0000 (UTC)
Date:   Tue, 19 Feb 2019 08:04:17 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Travis <mike.travis@hpe.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, thgarnie@google.com, linux-kernel@vger.kernel.org,
        keescook@chromium.org, akpm@linux-foundation.org,
        yamada.masahiro@socionext.com, kirill@shutemov.name,
        Russ Anderson <rja@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH v3 6/6] x86/mm/KASLR: Do not adapt the size of the direct
 mapping section for SGI UV system
Message-ID: <20190219000417.GM14858@MiWiFi-R3L-srv>
References: <20190216140008.28671-1-bhe@redhat.com>
 <20190216140008.28671-7-bhe@redhat.com>
 <20190217020904.GF14858@MiWiFi-R3L-srv>
 <2556be96-3bf9-746e-8a15-6339355869af@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2556be96-3bf9-746e-8a15-6339355869af@hpe.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 19 Feb 2019 00:04:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/18/19 at 11:24am, Mike Travis wrote:
> Hi Baoquan,
> 
> There was a breakage in the TSC code (for UV) where the change was to
> introduce an early TSC "adjustment".  This bypassed the UV auto setting of
> TSC by BIOS because it came before the UV init code could indicate that the
> TSC was already in sync.  (I believe I already sent you a note about this?)
> 
> To fix this, I sent in two patches, the first had this is_early_uv_system()
> function defined and the second had the check to avoid adjusting TSC too
> early.
> 
> The commit referred to is:
> 
> > commit 20a8378aa9dd108a01cb0e695599f5257a885c4b
> > Author: Mike Travis <mike.travis@hpe.com>
> > Date:   Tue Oct 2 13:01:45 2018 -0500
> > 
> >     x86/platform/uv: Provide is_early_uv_system()
> >     Introduce is_early_uv_system() which uses efi.uv_systab to decide early
> >     in the boot process whether the kernel is running on a UV system.
> >     This is needed to skip other early setup/init code that might break
> >     the UV platform if done too early such as before necessary ACPI tables
> >     parsing takes place.
> 
> Check to see if that function is defined in the kernels you are pushing this
> patch to.

Thanks, Mike. Yes, I received your mail before, so use the
is_early_uv_system() function directly in this patch.

> 
> As to testing on a UV system, I can schedule the time to do that, just send
> me the details.

The bug is triggered because 

UV MMIOH region is larger than

  "(the size of actual RAM) + CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING"

Here CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING is 10 TB by default.

E.g UV system with 1 TB RAM, 1 TB + 10 TB = 11 TB. If UV MMIOH region is
located beyond [0, 11TB], it may trigger bug. I suggest a UV system can
be set like this:

The actual RAM can be several GB, like 20 GB is enough.

Then install UV modules after 11 TB, e.g if the size of UV reion is 16
TB, you can put it in [16TB, 32TB].

We can discuss and decide the setting according to the UV module size.

Thanks
Baoquan
> 
> 
> On 2/16/2019 6:09 PM, Baoquan He wrote:
> > Hi Mike,
> > 
> > On 02/16/19 at 10:00pm, Baoquan He wrote:
> > > On SGI UV system, kernel often hangs when KASLR is enabled. Disabling
> > > KASLR makes kernel work well.
> > 
> > I wrap codes which calculate the size of the direct mapping section
> > into a new function calc_direct_mapping_size() as Ingo suggested. This
> > code change has passed basic testing, but hasn't been tested on a
> > SGI UV machine after reproducing since it needs UV machine with UV
> > module installed of enough size.
> > 
> > To reproduce it, we can apply patches 0001~0005. If reproduced, patch
> > 0006 can be applied on top to check if bug is fixed. Please help check
> > if the code is OK, if you have a machine, I can have a test.
> > 
> > Thanks
> > Baoquan
> > 
> > > 
> > > The back trace is:
> > > 
> > > kernel BUG at arch/x86/mm/init_64.c:311!
> > > invalid opcode: 0000 [#1] SMP
> > > [...]
> > > RIP: 0010:__init_extra_mapping+0x188/0x196
> > > [...]
> > > Call Trace:
> > >   init_extra_mapping_uc+0x13/0x15
> > >   map_high+0x67/0x75
> > >   map_mmioh_high_uv3+0x20a/0x219
> > >   uv_system_init_hub+0x12d9/0x1496
> > >   uv_system_init+0x27/0x29
> > >   native_smp_prepare_cpus+0x28d/0x2d8
> > >   kernel_init_freeable+0xdd/0x253
> > >   ? rest_init+0x80/0x80
> > >   kernel_init+0xe/0x110
> > >   ret_from_fork+0x2c/0x40
> > > 
> > > This is because the SGI UV system need map its MMIOH region to the direct
> > > mapping section, and the mapping happens in rest_init() which is much
> > > later than the calling of kernel_randomize_memory() to do mm KASLR. So
> > > mm KASLR can't count in the size of the MMIOH region when calculate the
> > > needed size of address space for the direct mapping section.
> > > 
> > > When KASLR is disabled, there are 64TB address space for both system RAM
> > > and the MMIOH regions to share. When KASLR is enabled, the current code
> > > of mm KASLR only reserves the actual size of system RAM plus extra 10TB
> > > for the direct mapping. Thus later the MMIOH mapping could go beyond
> > > the upper bound of the direct mapping to step into VMALLOC or VMEMMAP area.
> > > Then BUG_ON() in __init_extra_mapping() will be triggered.
> > > 
> > > E.g on the SGI UV3 machine where this bug was reported , there are two
> > > MMIOH regions:
> > > 
> > > [    1.519001] UV: Map MMIOH0_HI 0xffc00000000 - 0x100000000000
> > > [    1.523001] UV: Map MMIOH1_HI 0x100000000000 - 0x200000000000
> > > 
> > > They are [16TB-16G, 16TB) and [16TB, 32TB). On this machine, 512G RAM are
> > > spread out to 1TB regions. Then above two SGI MMIOH regions also will be
> > > mapped into the direct mapping section.
> > > 
> > > To fix it, we need check if it's SGI UV system by calling
> > > is_early_uv_system() in kernel_randomize_memory(). If yes, do not adapt
> > > thesize of the direct mapping section, just keep it as is, e.g in level-4
> > > paging mode, 64TB.
> > > 
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > ---
> > >   arch/x86/mm/kaslr.c | 57 +++++++++++++++++++++++++++++++++------------
> > >   1 file changed, 42 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> > > index ca12ed4e5239..754b5da91d43 100644
> > > --- a/arch/x86/mm/kaslr.c
> > > +++ b/arch/x86/mm/kaslr.c
> > > @@ -29,6 +29,7 @@
> > >   #include <asm/pgtable.h>
> > >   #include <asm/setup.h>
> > >   #include <asm/kaslr.h>
> > > +#include <asm/uv/uv.h>
> > >   #include "mm_internal.h"
> > > @@ -113,15 +114,51 @@ static inline bool kaslr_memory_enabled(void)
> > >   	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
> > >   }
> > > +/*
> > > + * Even though a huge virtual address space is reserved for the direct
> > > + * mapping of physical memory, e.g in 4-level pageing mode, it's 64TB,
> > > + * rare system can own enough physical memory to use it up, most are
> > > + * even less than 1TB. So with KASLR enabled, we adapt the size of
> > > + * direct mapping area to size of actual physical memory plus the
> > > + * configured padding CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING.
> > > + * The left part will be taken out to join memory randomization.
> > > + *
> > > + * Note that UV system is an exception, its MMIOH region need be mapped
> > > + * into the direct mapping area too, while the size can't be got until
> > > + * rest_init() calling. Hence for UV system, do not adapt the size
> > > + * of direct mapping area.
> > > + */
> > > +static inline unsigned long calc_direct_mapping_size(void)
> > > +{
> > > +	unsigned long size_tb, memory_tb;
> > > +
> > > +	/*
> > > +	 * Update Physical memory mapping to available and
> > > +	 * add padding if needed (especially for memory hotplug support).
> > > +	 */
> > > +	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
> > > +		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
> > > +
> > > +	size_tb = 1 << (MAX_PHYSMEM_BITS - TB_SHIFT);
> > > +
> > > +	/*
> > > +	 * Adapt phyiscal memory region size based on available memory if
> > > +	 * it's not UV system.
> > > +	 */
> > > +	if (memory_tb < size_tb && !is_early_uv_system())
> > > +		size_tb = memory_tb;
> > > +
> > > +	return size_tb;
> > > +}
> > > +
> > >   /* Initialize base and padding for each memory region randomized with KASLR */
> > >   void __init kernel_randomize_memory(void)
> > >   {
> > > -	size_t i;
> > > -	unsigned long vaddr_start, vaddr;
> > > -	unsigned long rand, memory_tb;
> > > -	struct rnd_state rand_state;
> > > +	unsigned long vaddr_start, vaddr, rand;
> > >   	unsigned long remain_entropy;
> > >   	unsigned long vmemmap_size;
> > > +	struct rnd_state rand_state;
> > > +	size_t i;
> > >   	vaddr_start = pgtable_l5_enabled() ? __PAGE_OFFSET_BASE_L5 : __PAGE_OFFSET_BASE_L4;
> > >   	vaddr = vaddr_start;
> > > @@ -138,20 +175,10 @@ void __init kernel_randomize_memory(void)
> > >   	if (!kaslr_memory_enabled())
> > >   		return;
> > > -	kaslr_regions[0].size_tb = 1 << (MAX_PHYSMEM_BITS - TB_SHIFT);
> > > +	kaslr_regions[0].size_tb = calc_direct_mapping_size();
> > >   	kaslr_regions[1].size_tb = VMALLOC_SIZE_TB;
> > > -	/*
> > > -	 * Update Physical memory mapping to available and
> > > -	 * add padding if needed (especially for memory hotplug support).
> > > -	 */
> > >   	BUG_ON(kaslr_regions[0].base != &page_offset_base);
> > > -	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
> > > -		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
> > > -
> > > -	/* Adapt phyiscal memory region size based on available memory */
> > > -	if (memory_tb < kaslr_regions[0].size_tb)
> > > -		kaslr_regions[0].size_tb = memory_tb;
> > >   	/*
> > >   	 * Calculate how many TB vmemmap region needs, and align to
> > > -- 
> > > 2.17.2
> > > 
