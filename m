Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133D0C4151A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFF3222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390559AbfBMINQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:13:16 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:7136 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730382AbfBMINP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:13:15 -0500
Received: by suse.de (Postfix, from userid 1000)
        id 6058E426F; Wed, 13 Feb 2019 09:13:14 +0100 (CET)
Date:   Wed, 13 Feb 2019 09:13:14 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        david@redhat.com, anthony.yznaga@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,memory_hotplug: Explicitly pass the head to
 isolate_huge_page
Message-ID: <20190213081310.zfxwb3svoqsxnuyc@d104.suse.de>
References: <20190208090604.975-1-osalvador@suse.de>
 <20190212083329.GN15609@dhcp22.suse.cz>
 <20190212134546.gubfir6zzwrvmunr@d104.suse.de>
 <20190212144026.GY15609@dhcp22.suse.cz>
 <52f7a47c-4a8b-c06d-04c0-48d9bb43823b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52f7a47c-4a8b-c06d-04c0-48d9bb43823b@oracle.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 04:13:05PM -0800, Mike Kravetz wrote:
> Well, commit 94310cbcaa3c ("mm/madvise: enable (soft|hard) offline of
> HugeTLB pages at PGD level") should have allowed migration of gigantic
> pages.  I believe it was added for 16GB pages on powerpc.  However, due
> to subsequent changes I suspsect this no longer works.

I will take a look, I am definitely interested in that.
Thanks for pointing it out Mike.

> 
> > This check doesn't make much sense in principle. Why should we bail out
> > based on a section size? We are offlining a pfn range. All that we care
> > about is whether the hugetlb is migrateable.
> 
> Yes.  Do note that the do_migrate_range is only called from __offline_pages
> with a start_pfn that was returned by scan_movable_pages.  scan_movable_pages
> has the hugepage_migration_supported check for PageHuge pages.  So, it would
> seem to be redundant to do another check in do_migrate_range.

Well, the thing is that if the gigantic page does not start at the very beginning
of the memblock, and we do find migrateable pages before it in scan_movable_pages(),
the range that we will pass to do_migrate_ranges() will contain the gigantic page.
So we need the check there to cover that case too, although I agree that the current
check is misleading.

I will think about it.

-- 
Oscar Salvador
SUSE L3
