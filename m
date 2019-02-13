Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AC3C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8460222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550061226;
	bh=wcRKohBVAkOx4a8rxSAw5QqGYNje1noU+Lau0d0fRtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eUveQjgbGEjluMckNl0SXHJqpYsXpA+hEO5a0oIwWiDAgchy24/hBZ9gzoXL7qvB/
	 6KD/1UeI7FHAmCfLavYF+saOBgODpk6/j9du4MZTsjJLG5/jQg69WHdtH+pd+QDnz5
	 qLUr8/2zzI5VmUnTMn4AP3MT7d7cGsmCN0I+zR/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392134AbfBMMdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:33:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:59046 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732946AbfBMMdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:33:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E819DAFB8;
        Wed, 13 Feb 2019 12:33:41 +0000 (UTC)
Date:   Wed, 13 Feb 2019 13:33:39 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, akpm@linux-foundation.org,
        david@redhat.com, anthony.yznaga@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,memory_hotplug: Explicitly pass the head to
 isolate_huge_page
Message-ID: <20190213123339.GG4525@dhcp22.suse.cz>
References: <20190208090604.975-1-osalvador@suse.de>
 <20190212083329.GN15609@dhcp22.suse.cz>
 <20190212134546.gubfir6zzwrvmunr@d104.suse.de>
 <20190212144026.GY15609@dhcp22.suse.cz>
 <52f7a47c-4a8b-c06d-04c0-48d9bb43823b@oracle.com>
 <20190213081310.zfxwb3svoqsxnuyc@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213081310.zfxwb3svoqsxnuyc@d104.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-02-19 09:13:14, Oscar Salvador wrote:
> On Tue, Feb 12, 2019 at 04:13:05PM -0800, Mike Kravetz wrote:
> > Well, commit 94310cbcaa3c ("mm/madvise: enable (soft|hard) offline of
> > HugeTLB pages at PGD level") should have allowed migration of gigantic
> > pages.  I believe it was added for 16GB pages on powerpc.  However, due
> > to subsequent changes I suspsect this no longer works.
> 
> I will take a look, I am definitely interested in that.
> Thanks for pointing it out Mike.
> 
> > 
> > > This check doesn't make much sense in principle. Why should we bail out
> > > based on a section size? We are offlining a pfn range. All that we care
> > > about is whether the hugetlb is migrateable.
> > 
> > Yes.  Do note that the do_migrate_range is only called from __offline_pages
> > with a start_pfn that was returned by scan_movable_pages.  scan_movable_pages
> > has the hugepage_migration_supported check for PageHuge pages.  So, it would
> > seem to be redundant to do another check in do_migrate_range.
> 
> Well, the thing is that if the gigantic page does not start at the very beginning
> of the memblock, and we do find migrateable pages before it in scan_movable_pages(),
> the range that we will pass to do_migrate_ranges() will contain the gigantic page.
> So we need the check there to cover that case too, although I agree that the current
> check is misleading.

Why isn't our check in has_unmovable_pages sufficient?
-- 
Michal Hocko
SUSE Labs
