Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7940DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408E520870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408E520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbeJ3DIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:08:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:57634 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729178AbeJ3DIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:08:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5511CAF64;
        Mon, 29 Oct 2018 18:18:28 +0000 (UTC)
Date:   Mon, 29 Oct 2018 19:18:27 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Dave Hansen <dave.hansen@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        rppt@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        yi.z.zhang@linux.intel.com
Subject: Re: [PATCH v5 4/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
Message-ID: <20181029181827.GO32673@dhcp22.suse.cz>
References: <20181011085509.GS5873@dhcp22.suse.cz>
 <6f32f23c-c21c-9d42-7dda-a1d18613cd3c@linux.intel.com>
 <20181017075257.GF18839@dhcp22.suse.cz>
 <971729e6-bcfe-a386-361b-d662951e69a7@linux.intel.com>
 <20181029141210.GJ32673@dhcp22.suse.cz>
 <84f09883c16608ddd2ba88103f43ec6a1c649e97.camel@linux.intel.com>
 <20181029163528.GL32673@dhcp22.suse.cz>
 <18dfc5a0db11650ff31433311da32c95e19944d9.camel@linux.intel.com>
 <20181029172415.GM32673@dhcp22.suse.cz>
 <8e7a4311a240b241822945c0bb4095c9ffe5a14d.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e7a4311a240b241822945c0bb4095c9ffe5a14d.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29-10-18 10:42:33, Alexander Duyck wrote:
> On Mon, 2018-10-29 at 18:24 +0100, Michal Hocko wrote:
> > On Mon 29-10-18 10:01:28, Alexander Duyck wrote:
[...]
> > > So there end up being a few different issues with constructors. First
> > > in my mind is that it means we have to initialize the region of memory
> > > and cannot assume what the constructors are going to do for us. As a
> > > result we will have to initialize the LRU pointers, and then overwrite
> > > them with the pgmap and hmm_data.
> > 
> > Why we would do that? What does really prevent you from making a fully
> > customized constructor?
> 
> It is more an argument of complexity. Do I just pass a single pointer
> and write that value, or the LRU values in init, or do I have to pass a
> function pointer, some abstracted data, and then call said function
> pointer while passing the page and the abstracted data?

I though you have said that pgmap is the current common denominator for
zone device users. I really do not see what is the problem to do
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 89d2a2ab3fe6..9105a4ed2c96 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5516,7 +5516,10 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 
 not_early:
 		page = pfn_to_page(pfn);
-		__init_single_page(page, pfn, zone, nid);
+		if (pgmap && pgmap->init_page)
+			pgmap->init_page(page, pfn, zone, nid, pgmap);
+		else
+			__init_single_page(page, pfn, zone, nid);
 		if (context == MEMMAP_HOTPLUG)
 			SetPageReserved(page);
 
that would require to replace altmap throughout the call chain and
replace it by pgmap. Altmap could be then renamed to something more
clear
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 89d2a2ab3fe6..048e4cc72fdf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5474,8 +5474,8 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 	 * Honor reservation requested by the driver for this ZONE_DEVICE
 	 * memory
 	 */
-	if (altmap && start_pfn == altmap->base_pfn)
-		start_pfn += altmap->reserve;
+	if (pgmap && pgmap->get_memmap)
+		start_pfn = pgmap->get_memmap(pgmap, start_pfn);
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 		/*

[...]

> If I have to implement the code to verify the slowdown I will, but I
> really feel like it is just going to be time wasted since we have seen
> this in other spots within the kernel.

Please try to understand that I am not trying to force you write some
artificial benchmarks. All I really do care about is that we have sane
interfaces with reasonable performance. Especially for one-off things
in relattively slow paths. I fully recognize that ZONE_DEVICE begs for a
better integration but really, try to go incremental and try to unify
the code first and microptimize on top. Is that way too much to ask for?

Anyway we have gone into details while the primary problem here was that
the hotplug lock doesn't scale AFAIR. And my question was why cannot we
pull move_pfn_range_to_zone and what has to be done to achieve that.
That is a fundamental thing to address first. Then you can microptimize
on top.
-- 
Michal Hocko
SUSE Labs
