Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480C7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D8921872
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbeLRKSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:18:39 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:6685 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726391AbeLRKSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:18:38 -0500
Received: by suse.de (Postfix, from userid 1000)
        id 0D9F83C5B; Tue, 18 Dec 2018 11:18:35 +0100 (CET)
Date:   Tue, 18 Dec 2018 11:18:35 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm: do not report isolation failures for CMA pages
Message-ID: <20181218101831.ma3j5llxcsthibop@d104.suse.de>
References: <20181218092802.31429-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218092802.31429-1-mhocko@kernel.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 10:28:02AM +0100, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> Heiko has complained that his log is swamped by warnings from has_unmovable_pages
> [   20.536664] page dumped because: has_unmovable_pages
> [   20.536792] page:000003d081ff4080 count:1 mapcount:0 mapping:000000008ff88600 index:0x0 compound_mapcount: 0
> [   20.536794] flags: 0x3fffe0000010200(slab|head)
> [   20.536795] raw: 03fffe0000010200 0000000000000100 0000000000000200 000000008ff88600
> [   20.536796] raw: 0000000000000000 0020004100000000 ffffffff00000001 0000000000000000
> [   20.536797] page dumped because: has_unmovable_pages
> [   20.536814] page:000003d0823b0000 count:1 mapcount:0 mapping:0000000000000000 index:0x0
> [   20.536815] flags: 0x7fffe0000000000()
> [   20.536817] raw: 07fffe0000000000 0000000000000100 0000000000000200 0000000000000000
> [   20.536818] raw: 0000000000000000 0000000000000000 ffffffff00000001 0000000000000000
> 
> which are not triggered by the memory hotplug but rather CMA allocator.
> The original idea behind dumping the page state for all call paths was
> that these messages will be helpful debugging failures. From the above
> it seems that this is not the case for the CMA path because we are
> lacking much more context. E.g the second reported page might be a CMA
> allocated page. It is still interesting to see a slab page in the CMA
> area but it is hard to tell whether this is bug from the above output
> alone.
> 
> Address this issue by dumping the page state only on request. Both
> start_isolate_page_range and has_unmovable_pages already have an
> argument to ignore hwpoison pages so make this argument more generic and
> turn it into flags and allow callers to combine non-default modes into a
> mask. While we are at it, has_unmovable_pages call from is_pageblock_removable_nolock
> (sysfs removable file) is questionable to report the failure so drop it
> from there as well.
> 
> Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Looks good to me, and it makes sense to not spam other users.

Just one thing:

AFAICS alloc_contig_range() can also be called from hugetlb code.
Do we weant to specify that in the changelog too?
And possibly change the patch title to:

"Only report isolation failures from memhotplug code" ?

Although is_pageblock_removable_nolock will not report the failures
now, so I am not sure.

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
