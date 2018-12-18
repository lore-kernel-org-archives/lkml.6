Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0604CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E2D217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545132511;
	bh=hmjNSVZ8OyKTHLowdTM5K0ZndmrhwS6M7XSAnNTjDA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NetdYf5gkIiA+wXWijBso458jwPT2IPGqPkhgxaM4+vTcFJ9w/ckzYvy7e08XD71y
	 /PYNcnO2f0z6E92+2rT7eDrpvK6A4kWnw9qfLu0cL4tFaz/y36VL3UnDrI4Y9r0l08
	 G292cBmnx0STaQMjFe50GIpVZ1k63itKSH5RDrNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbeLRL20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:28:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:47264 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726364AbeLRL2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:28:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AA101B0EF;
        Tue, 18 Dec 2018 11:28:23 +0000 (UTC)
Date:   Tue, 18 Dec 2018 12:28:22 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: do not report isolation failures for CMA pages
Message-ID: <20181218112822.GG30879@dhcp22.suse.cz>
References: <20181218092802.31429-1-mhocko@kernel.org>
 <20181218101831.ma3j5llxcsthibop@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218101831.ma3j5llxcsthibop@d104.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18-12-18 11:18:35, Oscar Salvador wrote:
> On Tue, Dec 18, 2018 at 10:28:02AM +0100, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > Heiko has complained that his log is swamped by warnings from has_unmovable_pages
> > [   20.536664] page dumped because: has_unmovable_pages
> > [   20.536792] page:000003d081ff4080 count:1 mapcount:0 mapping:000000008ff88600 index:0x0 compound_mapcount: 0
> > [   20.536794] flags: 0x3fffe0000010200(slab|head)
> > [   20.536795] raw: 03fffe0000010200 0000000000000100 0000000000000200 000000008ff88600
> > [   20.536796] raw: 0000000000000000 0020004100000000 ffffffff00000001 0000000000000000
> > [   20.536797] page dumped because: has_unmovable_pages
> > [   20.536814] page:000003d0823b0000 count:1 mapcount:0 mapping:0000000000000000 index:0x0
> > [   20.536815] flags: 0x7fffe0000000000()
> > [   20.536817] raw: 07fffe0000000000 0000000000000100 0000000000000200 0000000000000000
> > [   20.536818] raw: 0000000000000000 0000000000000000 ffffffff00000001 0000000000000000
> > 
> > which are not triggered by the memory hotplug but rather CMA allocator.
> > The original idea behind dumping the page state for all call paths was
> > that these messages will be helpful debugging failures. From the above
> > it seems that this is not the case for the CMA path because we are
> > lacking much more context. E.g the second reported page might be a CMA
> > allocated page. It is still interesting to see a slab page in the CMA
> > area but it is hard to tell whether this is bug from the above output
> > alone.
> > 
> > Address this issue by dumping the page state only on request. Both
> > start_isolate_page_range and has_unmovable_pages already have an
> > argument to ignore hwpoison pages so make this argument more generic and
> > turn it into flags and allow callers to combine non-default modes into a
> > mask. While we are at it, has_unmovable_pages call from is_pageblock_removable_nolock
> > (sysfs removable file) is questionable to report the failure so drop it
> > from there as well.
> > 
> > Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> Looks good to me, and it makes sense to not spam other users.
> 
> Just one thing:
> 
> AFAICS alloc_contig_range() can also be called from hugetlb code.
> Do we weant to specify that in the changelog too?
> And possibly change the patch title to:

Well, I haven't seen any reports about hugetlb pages so I didn't bother
to mention it. Is this really important to note?

> "Only report isolation failures from memhotplug code" ?

only report isolation failures when offlining memory

> Although is_pageblock_removable_nolock will not report the failures
> now, so I am not sure.
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks!
-- 
Michal Hocko
SUSE Labs
