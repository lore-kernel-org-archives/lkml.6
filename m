Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD3BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531172086C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548675843;
	bh=3VXdv9jrfUUHjKvshgjOOYJdtUiqUrZStarL53yRhY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lCCcWcodCRbzuzoIIm7SrfrXM73BAf7LDoPsTToMUAH9q0/8yx4U0In4JxMGGg1AF
	 v03lIMm+OHL4cqziudqZ0el34iYuYf9XU8L00XvlHEPWwOAbC4Jnt+GIg3Eitl4u70
	 SbQYY6doBfW6x33WgwbNqkcdLQ0FkL+Jnc2dGnRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfA1LoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:44:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:54968 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726611AbfA1LoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:44:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 620F6AE17;
        Mon, 28 Jan 2019 11:43:59 +0000 (UTC)
Date:   Mon, 28 Jan 2019 12:43:58 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     robert shteynfeld <robert.shteynfeld@gmail.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Bob Picco <bob.picco@oracle.com>
Subject: Re: kernel panic due to
 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2830bf6f05fb3e05bc4743274b806c821807a684
Message-ID: <20190128114358.GH18811@dhcp22.suse.cz>
References: <CAHk-=wh-1wB_X2MG0vW5e755rWJ5pBN8yyXLo2syOdcMV6qYoQ@mail.gmail.com>
 <20190125073704.GC3560@dhcp22.suse.cz>
 <20190125081924.GF3560@dhcp22.suse.cz>
 <20190125082952.GG3560@dhcp22.suse.cz>
 <CADfvbxqOOt_07hyeReEH_gCmTxxMYJr0-CSkqdX57wGTWisNTA@mail.gmail.com>
 <20190125155810.GQ3560@dhcp22.suse.cz>
 <CADfvbxp8sER_Xjkm-g8+BH87Ne8oUBirSWx6mmL=Z3XwyYoQHA@mail.gmail.com>
 <20190125163938.GA20411@dhcp22.suse.cz>
 <20190125173315.GC20411@dhcp22.suse.cz>
 <20190125181549.GE20411@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125181549.GE20411@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-01-19 19:15:49, Michal Hocko wrote:
> On Fri 25-01-19 18:33:15, Michal Hocko wrote:
> > On Fri 25-01-19 17:39:38, Michal Hocko wrote:
> > > On Fri 25-01-19 11:16:30, robert shteynfeld wrote:
> > > > Attached is the dmesg from patched kernel.
> > > 
> > > Your Node1 physical memory range precedes Node0 which is quite unusual
> > > but it shouldn't be a huge problem on its own. But memory ranges are
> > > not aligned to the memory section
> > > 
> > > [    0.286954] Early memory node ranges
> > > [    0.286955]   node   1: [mem 0x0000000000001000-0x0000000000090fff]
> > > [    0.286955]   node   1: [mem 0x0000000000100000-0x00000000dbdf8fff]
> > > [    0.286956]   node   1: [mem 0x0000000100000000-0x0000001423ffffff]
> > > [    0.286956]   node   0: [mem 0x0000001424000000-0x0000002023ffffff]
> > > 
> > > As you can see the last pfn for the node1 is inside the section and
> > > Node0 starts right after. This is quite unusual as well. If for no other
> > > reasons then the memmap of those struct pages will be remote for one or
> > > the other. Actually I am not even sure we can handle that properly
> > > because we do expect 1:1 mapping between sections and nodes.
> > > 
> > > Now it also makes some sense why 2830bf6f05fb ("mm, memory_hotplug:
> > > initialize struct pages for the full memory section") made any
> > > difference. We simply write over a potentially initialized struct page
> > > and blow up on that. I strongly suspect that the commit just uncovered
> > > a pre-existing problem. Let me think what we can do about that.
> > 
> > Appart from force aligning node's start the only other option is to
> > revert 2830bf6f05fb and handling the underlying issue in the hotplug
> > code.
> 
> We cannot really align because we have things like ZONE_DMA starting at
> 0x1000 and who knows what else. So let's go with the revert. Hutplug
> simply needs a larger surgery to get rid of the PAGES_PER_SECTION
> inherent assumptions.
> 
> Linus, could you take the revert please?

or should I post the patch as a reply to make your life easier?

> From 817b18d3db36a6900ca9043af8c1416c56358be3 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Fri, 25 Jan 2019 19:08:58 +0100
> Subject: [PATCH] Revert "mm, memory_hotplug: initialize struct pages for the
>  full memory section"
> 
> This reverts commit 2830bf6f05fb3e05bc4743274b806c821807a684.
> 
> The underlying assumption that one sparse section belongs into a single
> numa node doesn't hold really. Robert Shteynfeld has reported a boot
> failure. The boot log was not captured but his memory layout is as
> follows:
> [    0.286954] Early memory node ranges
> [    0.286955]   node   1: [mem 0x0000000000001000-0x0000000000090fff]
> [    0.286955]   node   1: [mem 0x0000000000100000-0x00000000dbdf8fff]
> [    0.286956]   node   1: [mem 0x0000000100000000-0x0000001423ffffff]
> [    0.286956]   node   0: [mem 0x0000001424000000-0x0000002023ffffff]
> 
> This means that node0 starts in the middle of a memory section which is
> also in node1. memmap_init_zone tries to initialize padding of a section
> even when it is outside of the given pfn range because there are code
> paths (e.g. memory hotplug) which assume that the full worth of memory
> section is always initialized. In this particular case, though, such a
> range is already intialized and most likely already managed by the page
> allocator. Scribbling over those pages corrupts the internal state and
> likely blows up when any of those pages gets used.
> 
> Reported-by: Robert Shteynfeld <robert.shteynfeld@gmail.com>
> Fixes: 2830bf6f05fb ("mm, memory_hotplug: initialize struct pages for the full memory section")
> Cc: stable
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/page_alloc.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d295c9bc01a8..35fdde041f5c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5701,18 +5701,6 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>  			cond_resched();
>  		}
>  	}
> -#ifdef CONFIG_SPARSEMEM
> -	/*
> -	 * If the zone does not span the rest of the section then
> -	 * we should at least initialize those pages. Otherwise we
> -	 * could blow up on a poisoned page in some paths which depend
> -	 * on full sections being initialized (e.g. memory hotplug).
> -	 */
> -	while (end_pfn % PAGES_PER_SECTION) {
> -		__init_single_page(pfn_to_page(end_pfn), end_pfn, zone, nid);
> -		end_pfn++;
> -	}
> -#endif
>  }
>  
>  #ifdef CONFIG_ZONE_DEVICE
> -- 
> 2.20.1
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs
