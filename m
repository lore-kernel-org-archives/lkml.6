Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E947C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1DB20989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548657789;
	bh=IzXUaKPCAgefkY3KAKPTrMy/z1ebO0On80hwHML8jmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xZ1UeSCrYnK23DUq7HaNBMUyumLkbzOzcmGMK59/sWXhfozYdPWTQY+YDlHj2EJJ5
	 hYKeQwFzznmF1+kwPcV+YLTgNR2Hu9Lw/yZqGTLAXoil0v2oNpuMFEU155Wm20aRTG
	 uOGbqa1fNiTvc/q1XzrmTTg7DicaS9ysPrPF3CAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfA1GnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:43:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:39200 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726612AbfA1GnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:43:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F284AEB2;
        Mon, 28 Jan 2019 06:43:05 +0000 (UTC)
Date:   Mon, 28 Jan 2019 07:43:03 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     robert shteynfeld <robert.shteynfeld@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Bob Picco <bob.picco@oracle.com>
Subject: Re: kernel panic due to
 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2830bf6f05fb3e05bc4743274b806c821807a684
Message-ID: <20190128064303.GD18811@dhcp22.suse.cz>
References: <20190125073704.GC3560@dhcp22.suse.cz>
 <20190125081924.GF3560@dhcp22.suse.cz>
 <20190125082952.GG3560@dhcp22.suse.cz>
 <CADfvbxqOOt_07hyeReEH_gCmTxxMYJr0-CSkqdX57wGTWisNTA@mail.gmail.com>
 <20190125155810.GQ3560@dhcp22.suse.cz>
 <CADfvbxp8sER_Xjkm-g8+BH87Ne8oUBirSWx6mmL=Z3XwyYoQHA@mail.gmail.com>
 <20190125163938.GA20411@dhcp22.suse.cz>
 <20190125173315.GC20411@dhcp22.suse.cz>
 <20190125181549.GE20411@dhcp22.suse.cz>
 <CABXGCsM+p5BxJ9qH8z6q9bj9EeVqLW8hauke1jahQKG=mtDvmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsM+p5BxJ9qH8z6q9bj9EeVqLW8hauke1jahQKG=mtDvmQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28-01-19 11:37:00, Mikhail Gavrilov wrote:
> > Linus, could you take the revert please?
> >
> > From 817b18d3db36a6900ca9043af8c1416c56358be3 Mon Sep 17 00:00:00 2001
> > From: Michal Hocko <mhocko@suse.com>
> > Date: Fri, 25 Jan 2019 19:08:58 +0100
> > Subject: [PATCH] Revert "mm, memory_hotplug: initialize struct pages for the
> >  full memory section"
> >
> > This reverts commit 2830bf6f05fb3e05bc4743274b806c821807a684.
> >
> > The underlying assumption that one sparse section belongs into a single
> > numa node doesn't hold really. Robert Shteynfeld has reported a boot
> > failure. The boot log was not captured but his memory layout is as
> > follows:
> > [    0.286954] Early memory node ranges
> > [    0.286955]   node   1: [mem 0x0000000000001000-0x0000000000090fff]
> > [    0.286955]   node   1: [mem 0x0000000000100000-0x00000000dbdf8fff]
> > [    0.286956]   node   1: [mem 0x0000000100000000-0x0000001423ffffff]
> > [    0.286956]   node   0: [mem 0x0000001424000000-0x0000002023ffffff]
> >
> > This means that node0 starts in the middle of a memory section which is
> > also in node1. memmap_init_zone tries to initialize padding of a section
> > even when it is outside of the given pfn range because there are code
> > paths (e.g. memory hotplug) which assume that the full worth of memory
> > section is always initialized. In this particular case, though, such a
> > range is already intialized and most likely already managed by the page
> > allocator. Scribbling over those pages corrupts the internal state and
> > likely blows up when any of those pages gets used.
> >
> > Reported-by: Robert Shteynfeld <robert.shteynfeld@gmail.com>
> > Fixes: 2830bf6f05fb ("mm, memory_hotplug: initialize struct pages for the full memory section")
> > Cc: stable
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  mm/page_alloc.c | 12 ------------
> >  1 file changed, 12 deletions(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index d295c9bc01a8..35fdde041f5c 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5701,18 +5701,6 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> >                         cond_resched();
> >                 }
> >         }
> > -#ifdef CONFIG_SPARSEMEM
> > -       /*
> > -        * If the zone does not span the rest of the section then
> > -        * we should at least initialize those pages. Otherwise we
> > -        * could blow up on a poisoned page in some paths which depend
> > -        * on full sections being initialized (e.g. memory hotplug).
> > -        */
> > -       while (end_pfn % PAGES_PER_SECTION) {
> > -               __init_single_page(pfn_to_page(end_pfn), end_pfn, zone, nid);
> > -               end_pfn++;
> > -       }
> > -#endif
> >  }
> >
> >  #ifdef CONFIG_ZONE_DEVICE
> 
> Michal, I suppose that revert the commit
> 2830bf6f05fb3e05bc4743274b806c821807a68 are return my issue
> https://marc.info/?l=linux-mm&m=154499704718428
> Are any other better approach would be proposed for fixing my issue?

As I've said above. We will need to remove the hardcoded
PAGES_PER_SECTION assumption from the hotplug code. Mikhail had a patch
which was dealing with the two specific sysfs file handlers and I will
build on top of that.

-- 
Michal Hocko
SUSE Labs
