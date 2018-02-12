Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933394AbeBLJuX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 04:50:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:42941 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933377AbeBLJuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 04:50:21 -0500
Date: Mon, 12 Feb 2018 10:50:19 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kai Heng Feng <kai.heng.feng@canonical.com>,
        Laura Abbott <labbott@redhat.com>, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Regression after commit 19809c2da28a ("mm, vmalloc: use
 __GFP_HIGHMEM implicitly")
Message-ID: <20180212095019.GX21609@dhcp22.suse.cz>
References: <627DA40A-D0F6-41C1-BB5A-55830FBC9800@canonical.com>
 <20180208130649.GA15846@bombadil.infradead.org>
 <20180208232004.GA21027@bombadil.infradead.org>
 <20180211092652.GV21609@dhcp22.suse.cz>
 <20180211112808.GA4551@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180211112808.GA4551@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[I am crawling over a large backlog after vacation so I will get to
 other emails in this thread later. Let's just fix the regression
 first. The patch with the full changelog is at the end of this email.
 CC Andrew - the original report is http://lkml.kernel.org/r/627DA40A-D0F6-41C1-BB5A-55830FBC9800@canonical.com]

On Sun 11-02-18 03:28:08, Matthew Wilcox wrote:
> On Sun, Feb 11, 2018 at 10:26:52AM +0100, Michal Hocko wrote:
> > On Thu 08-02-18 15:20:04, Matthew Wilcox wrote:
> > > ... nevertheless, 19809c2da28a does in fact break vmalloc_32 on 32-bit.  Look:
> > > 
> > > #if defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA32)
> > > #define GFP_VMALLOC32 GFP_DMA32 | GFP_KERNEL
> > > #elif defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA)
> > > #define GFP_VMALLOC32 GFP_DMA | GFP_KERNEL
> > > #else
> > > #define GFP_VMALLOC32 GFP_KERNEL
> > > #endif
> > > 
> > > So we pass in GFP_KERNEL to __vmalloc_node, which calls __vmalloc_node_range
> > > which calls __vmalloc_area_node, which ORs in __GFP_HIGHMEM.
> > 
> > Dohh. I have missed this. I was convinced that we always add GFP_DMA32
> > when doing vmalloc_32. Sorry about that. The above definition looks
> > quite weird to be honest. First of all do we have any 64b system without
> > both DMA and DMA32 zones? If yes, what is the actual semantic of
> > vmalloc_32? Or is there any magic forcing GFP_KERNEL into low 32b?
> 
> mmzone.h has the following, which may be inaccurate / out of date:
> 
>          * parisc, ia64, sparc  <4G
>          * s390                 <2G
>          * arm                  Various
>          * alpha                Unlimited or 0-16MB.
>          *
>          * i386, x86_64 and multiple other arches
>          *                      <16M.
> 
> It claims ZONE_DMA32 is x86-64 only, which is incorrect; it's now used
> by arm64, ia64, mips, powerpc, tile.

yes, nobody seem to keep this one in sync.

> > Also I would expect that __GFP_DMA32 should do the right thing on 32b
> > systems. So something like the below should do the trick
> 
> Oh, I see.  Because we have:
> 
> #ifdef CONFIG_ZONE_DMA32
> #define OPT_ZONE_DMA32 ZONE_DMA32
> #else
> #define OPT_ZONE_DMA32 ZONE_NORMAL
> #endif
> 
> we'll end up allocating from ZONE_NORMAL if a non-DMA32 architecture asks
> for GFP_DMA32 memory.  Thanks; I missed that.

yep

> I'd recommend this instead then:
> 
> #if defined(CONFIG_64BIT) && !defined(CONFIG_ZONE_DMA32)
> #define GFP_VMALLOC32 GFP_DMA | GFP_KERNEL
> #else
> #define GFP_VMALLOC32 GFP_DMA32 | GFP_KERNEL
> #endif
> 
> I think it's clearer than the three-way #if.

I do not have a strong opinion here. I just wanted the change to be
obvious without meddling with the 64b ifdefs much. Follow up cleanups
are certainly possible.

> Now, longer-term, perhaps we should do the following:
> 
> #ifdef CONFIG_ZONE_DMA32
> #define OPT_ZONE_DMA32	ZONE_DMA32
> #elif defined(CONFIG_64BIT)
> #define OPT_ZONE_DMA	OPT_ZONE_DMA
> #else
> #define OPT_ZONE_DMA32 ZONE_NORMAL
> #endif
> 
> Then we wouldn't need the ifdef here and could always use GFP_DMA32
> | GFP_KERNEL.  Would need to audit current users and make sure they
> wouldn't be broken by such a change.

I am pretty sure improvements are possible.

> I noticed a mistake in 704b862f9efd;
> 
> -               pages = __vmalloc_node(array_size, 1, nested_gfp|__GFP_HIGHMEM,
> +               pages = __vmalloc_node(array_size, 1, nested_gfp|highmem_mask,
> 
> We should unconditionally use __GFP_HIGHMEM here instead of highmem_mask
> because this is where we allocate the array to hold the struct page
> pointers.  This can be allocated from highmem, and does not need to be
> allocated from ZONE_NORMAL.

You seem to be right. nested_gfp doesn't include zone modifiers. Care to
send a patch?

> Similarly,
> 
> -               if (gfpflags_allow_blocking(gfp_mask))
> +               if (gfpflags_allow_blocking(gfp_mask|highmem_mask))
> 
> is not needed (it's not *wrong*, it was just an unnecessary change).

yes. highmem_mask has no influence on the blocking behavior.

The fix for the regressions should be

>From 301c0acbce9dd80a854bba49c9db40991df0f9e4 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Mon, 12 Feb 2018 10:37:19 +0100
Subject: [PATCH] vmalloc: fix __GFP_HIGHMEM usage for vmalloc_32 on 32b
 systems
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Kai Heng Feng has noticed that BUG_ON(PageHighMem(pg)) triggers in
drivers/media/common/saa7146/saa7146_core.c since 19809c2da28a ("mm,
vmalloc: use __GFP_HIGHMEM implicitly”). saa7146_vmalloc_build_pgtable
uses vmalloc_32 and it is reasonable to expect that the resulting page
is not in highmem. The above commit aimed to add __GFP_HIGHMEM only
for those requests which do not specify any zone modifier gfp flag.
vmalloc_32 relies on GFP_VMALLOC32 which should do the right thing.
Except it has been missed that GFP_VMALLOC32 is an alias for GFP_KERNEL
on 32b architectures. Thanks to Matthew to notice this.

Fix the problem by unconditionally setting GFP_DMA32 in GFP_VMALLOC32
for !64b arches (as a bailout). This should do the right thing and use
ZONE_NORMAL which should be always below 4G on 32b systems.

Debugged-by: Matthew Wilcox <willy@infradead.org>
Reported-by: Kai Heng Feng <kai.heng.feng@canonical.com>
Fixes: 19809c2da28a ("mm, vmalloc: use __GFP_HIGHMEM implicitly”)
Cc: stable
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/vmalloc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 673942094328..1d147078c469 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1947,7 +1947,11 @@ void *vmalloc_exec(unsigned long size)
 #elif defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA)
 #define GFP_VMALLOC32 GFP_DMA | GFP_KERNEL
 #else
-#define GFP_VMALLOC32 GFP_KERNEL
+/*
+ * 64b systems should always have either DMA or DMA32 zones. For others
+ * GFP_DMA32 should do the right thing and use the normal zone.
+ */
+#define GFP_VMALLOC32 GFP_DMA32 | GFP_KERNEL
 #endif
 
 /**
-- 
2.15.1

-- 
Michal Hocko
SUSE Labs
