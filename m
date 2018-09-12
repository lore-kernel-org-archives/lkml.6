Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B11C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC09220880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:41:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC09220880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbeILOpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:45:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726138AbeILOpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:45:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 10697DFFA;
        Wed, 12 Sep 2018 09:41:24 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 961C5945D5;
        Wed, 12 Sep 2018 09:41:22 +0000 (UTC)
Date:   Wed, 12 Sep 2018 17:41:18 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, thgarnie@google.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 2/3] x86/mm/KASLR: Calculate the actual size of
 vmemmap region
Message-ID: <20180912094118.GD1740@192.168.1.3>
References: <20180909124946.17988-1-bhe@redhat.com>
 <20180909124946.17988-2-bhe@redhat.com>
 <20180910061151.GA85199@gmail.com>
 <20180911073057.GW1740@192.168.1.3>
 <20180911075946.GA97454@gmail.com>
 <20180911081811.GY1740@192.168.1.3>
 <20180911092829.GA9079@gmail.com>
 <20180911120803.GZ1740@192.168.1.3>
 <20180912031808.GC1740@192.168.1.3>
 <20180912063152.GA33500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912063152.GA33500@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 12 Sep 2018 09:41:24 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 12 Sep 2018 09:41:24 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/18 at 08:31am, Ingo Molnar wrote:
> 
> * Baoquan He <bhe@redhat.com> wrote:
> 
> > On 09/11/18 at 08:08pm, Baoquan He wrote:
> > > On 09/11/18 at 11:28am, Ingo Molnar wrote:
> > > > Yeah, so proper context is still missing, this paragraph appears to assume from the reader a 
> > > > whole lot of prior knowledge, and this is one of the top comments in kaslr.c so there's nowhere 
> > > > else to go read about the background.
> > > > 
> > > > For example what is the range of randomization of each region? Assuming the static, 
> > > > non-randomized description in Documentation/x86/x86_64/mm.txt is correct, in what way does 
> > > > KASLR modify that layout?
> > 
> > Re-read this paragraph, found I missed saying the range for each memory
> > region, and in what way KASLR modify the layout.
> > 
> > > > 
> > > > All of this is very opaque and not explained very well anywhere that I could find. We need to 
> > > > generate a proper description ASAP.
> > > 
> > > OK, let me try to give an context with my understanding. And copy the
> > > static layout of memory regions at below for reference.
> > > 
> > Here, Documentation/x86/x86_64/mm.txt is correct, and it's the
> > guideline for us to manipulate the layout of kernel memory regions.
> > Originally the starting address of each region is aligned to 512GB
> > so that they are all mapped at the 0-th entry of PGD table in 4-level
> > page mapping. Since we are so rich to have 120 TB virtual address space,
> > they are aligned at 1 TB actually. So randomness comes from three parts
> > mainly:
> > 
> > 1) The direct mapping region for physical memory. 64 TB are reserved to
> > cover the maximum physical memory support. However, most of systems only
> > have much less RAM memory than 64 TB, even much less than 1 TB most of
> > time. We can take the superfluous to join the randomization. This is
> > often the biggest part.
> 
> So i.e. in the non-KASLR case we have this description (from mm.txt):
> 
>  ffff880000000000 - ffffc7ffffffffff (=64 TB) direct mapping of all phys. memory
>  ffffc80000000000 - ffffc8ffffffffff (=40 bits) hole
>  ffffc90000000000 - ffffe8ffffffffff (=45 bits) vmalloc/ioremap space
>  ffffe90000000000 - ffffe9ffffffffff (=40 bits) hole
>  ffffea0000000000 - ffffeaffffffffff (=40 bits) virtual memory map (1TB)
>  ... unused hole ...
>  ffffec0000000000 - fffffbffffffffff (=44 bits) kasan shadow memory (16TB)
>  ... unused hole ...
>                                      vaddr_end for KASLR
>  fffffe0000000000 - fffffe7fffffffff (=39 bits) cpu_entry_area mapping
>  ...
> 
> The problems start here, this map is already *horribly* confusing:
> 
>  - we mix size in TB with 'bits'
>  - we sometimes mention a size in the description and sometimes not
>  - we sometimes list holes by address, sometimes only as an 'unused hole' line ...
> 
> So how about first cleaning up the memory maps in mm.txt and streamlining them, like this:
> 
>  ffff880000000000 - ffffc7ffffffffff (=46 bits, 64 TB) direct mapping of all phys. memory (page_offset_base)
>  ffffc80000000000 - ffffc8ffffffffff (=40 bits,  1 TB) ... unused hole
>  ffffc90000000000 - ffffe8ffffffffff (=45 bits, 32 TB) vmalloc/ioremap space (vmalloc_base)
>  ffffe90000000000 - ffffe9ffffffffff (=40 bits,  1 TB) ... unused hole
>  ffffea0000000000 - ffffeaffffffffff (=40 bits,  1 TB) virtual memory map (vmemmap_base)
>  ffffeb0000000000 - ffffebffffffffff (=40 bits,  1 TB) ... unused hole
>  ffffec0000000000 - fffffbffffffffff (=44 bits, 16 TB) KASAN shadow memory
>  fffffc0000000000 - fffffdffffffffff (=41 bits,  2 TB) ... unused hole
>                                      vaddr_end for KASLR
>  fffffe0000000000 - fffffe7fffffffff (=39 bits) cpu_entry_area mapping
>  ...
> 
> Please double check all the calculations and ranges, and I'd suggest doing it for the whole 
> file. Note how I added the global variables describing the base addresses - this makes it very 
> easy to match the pointers in kaslr_regions[] to the static map, to see the intent of 
> kaslr_regions[].

OK.

> 
> BTW., isn't that 'vaddr_end for KASLR' entry position inaccurate? In the typical case it could 
> very well be that by chance all 3 areas end up being randomized into the first 64 TB region, 
> right?

Hmm, I think it means the whole space where KASLR can be allowed to
randomize. [vaddr_start, vaddr_end] is a scope, KASLR algorithm can
only move memory regions inside this area. It doesn't mean the final
result of KASLR, or any typical case of them.

vaddr_start = pgtable_l5_enabled() ? __PAGE_OFFSET_BASE_L5 : __PAGE_OFFSET_BASE_L4;
vaddr_end = CPU_ENTRY_AREA_BASE;

> 
> I.e. vaddr_end could be at any 1 TB boundary in the above ranges. I'd suggest leaving out all 
> KASLR from this static mappings table - explain it separately in this file, maybe even create 
> its own memory map. I'll help with the wording.
> 
> > 2) The hole between memory regions, even though they are only 1 TB.
> 
> There's a 2 TB hole too.

Yeah, the last one.

> 
> > 3) KASAN region takes up 16 TB, while it won't take effect when KASLR is
> > enabled. This is another big part. 
> 
> Ok.
> 
> > As you can see, in these three memory regions, the physical memory
> > mapping region has variable size according to the existing system RAM.
> > However, the remaining two memory regions have fixed size, vmalloc is 32
> > TB, vmemmap is 1 TB.
> > 
> > With this superfluous address space as well as changing the starting address
> > of each memory region to be PUD level, namely 1 GB aligned, we can have
> > thousands of candidate position to locate those three memory regions.
> 
> Would be nice provide the number of bits randomized, maximum, from which the number of GBs of 
> physical RAM has to be subtracted.
> 
> Because 'thousands' of randomization targets is *excessively* poor randomization - caused by 
> the ridiculously high rounding to 1GB. It would be _very_ nice to extend randomization to at 
> least 2MB boundaries instead. (If the half cacheline of PTE entries possibly 'wasted' is an 
> issue we could increase that to 128 MB, but should start with 2MB first.)
> 
> That would instantly multiply the randomization selection by 512 ...

This may involve critical code changes. E.g in below commit, when we
copy page table, we just need go deep into PUD level since PAGE_OFFSET
is PUD_SIZE aligned, now if 2M aligned, we need deep into PMD level. I
can only think of this about this issue. Surely, I can do more
investigation and see what need be done to achieve the goal.

commit 94133e46a0f5ca3f138479806104ab4a8cb0455e
Author: Baoquan He <bhe@redhat.com>
Date:   Fri May 26 12:36:50 2017 +0100

    x86/efi: Correct EFI identity mapping under 'efi=old_map' when KASLR is enabled

> 
> > Above is for 4-level paging mode . As for 5-level, since the virtual
> > address space is too big, Kirill makes the starting address of regions
> > P4D aligned, namely 512 GB.
> 
> 512 GB of every region? That's ridiculously poor randomization too: we should *utilize* the 
> extra randomness and match the randomization on 56 bits CPUs as well, instead of wasting it!
> 
> > When randomize the layout, their order are kept, still the physical
> > memory mapping region is handled fistly, next vmalloc and vmemmap. Let's
> > take the physical memory mapping region as example, we limit the
> > starting address to be taken from the 1st 1/3 part of the whole
> > available virtual address space which is from 0xffff880000000000 to
> > 0xfffffe0000000000, namely the original starting address of the physical
> > memory mapping region to the starting address of cpu_entry_area mapping
> > region. Once a random address is chosen for the physical memory mapping,
> > we jump over the region and add 1G to begin the next region handling
> > with the remaining available space.
> 
> Ok, makes sense now!
> 
> I'd suggest adding an explanation like this to @size_tb:
> 
>   @size_tb is physical RAM size, rounded up to the next 1 TB boundary so that the base 
>   addresses following this region still start on 1 TB boundaries.
> 
> Once we improve randomization to be at the 2 MB granularity this should be renamed 
> ->size_rounded_up or so.
> 
> Would you like to work on this? These would be really nice additions, once the code is cleaned 
> up to be maintainable and the pending bug fixes you have are merged.
> 
> In terms of patch logistics I'd suggest this ordering:
> 
>  - documentation fixes
>  - simple cleanups
>  - fixes
>  - enhancements
> 
> With no more than ~5 patches sent in a series. Feel free to integrate all pending 
> boot-memory-map fixes and features as well, we'll figure out the right way to do them as they 
> happen - but let's start with the simple stuff first, ok?

Sure, will do according to your suggestion.

Thanks
Baoquan
