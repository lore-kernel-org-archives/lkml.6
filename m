Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB27C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5181321710
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5181321710
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeHXMVx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:21:53 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:43163 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbeHXMVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:21:53 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w7O8m2af004956
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 24 Aug 2018 17:48:02 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w7O8m1cw019465;
        Fri, 24 Aug 2018 17:48:02 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w7O8iBnX024146;
        Fri, 24 Aug 2018 17:48:01 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.152] [10.38.151.152]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-3062286; Fri, 24 Aug 2018 17:46:54 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC24GP.gisp.nec.co.jp ([10.38.151.152]) with mapi id 14.03.0319.002; Fri,
 24 Aug 2018 17:46:54 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>
Subject: Re: [PATCH] mm/hugetlb: filter out hugetlb pages if HUGEPAGE
 migration is not supported.
Thread-Topic: [PATCH] mm/hugetlb: filter out hugetlb pages if HUGEPAGE
 migration is not supported.
Thread-Index: AQHUO3RjbmsiOlp/NU6jB8cJR2hk2KTN8qOAgAANl4A=
Date:   Fri, 24 Aug 2018 08:46:53 +0000
Message-ID: <20180824084652.GA31218@hori1.linux.bs1.fc.nec.co.jp>
References: <20180824063314.21981-1-aneesh.kumar@linux.ibm.com>
 <20180824075815.GA29735@dhcp22.suse.cz>
In-Reply-To: <20180824075815.GA29735@dhcp22.suse.cz>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <D455CDDFDFDC3D49B4F804BCB78999D3@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 09:58:15AM +0200, Michal Hocko wrote:
> On Fri 24-08-18 12:03:14, Aneesh Kumar K.V wrote:
> > When scanning for movable pages, filter out Hugetlb pages if hugepage migration
> > is not supported. Without this we hit infinte loop in __offline pages where we
> > do
> > 	pfn = scan_movable_pages(start_pfn, end_pfn);
> > 	if (pfn) { /* We have movable pages */
> > 		ret = do_migrate_range(pfn, end_pfn);
> > 		goto repeat;
> > 	}
> > 
> > We do support hugetlb migration ony if the hugetlb pages are at pmd level. Here
> > we just check for Kernel config. The gigantic page size check is done in
> > page_huge_active.
> 
> Well, this is a bit misleading. I would say that
> 
> Fix this by checking hugepage_migration_supported both in has_unmovable_pages
> which is the primary backoff mechanism for page offlining and for
> consistency reasons also into scan_movable_pages because it doesn't make
> any sense to return a pfn to non-migrateable huge page.
> 
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > Reported-by: Haren Myneni <haren@linux.vnet.ibm.com>
> > CC: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> 
> I would add
> Fixes: 72b39cfc4d75 ("mm, memory_hotplug: do not fail offlining too early")
> 
> Not because the bug has been introduced by that commit but rather
> because the issue would be latent before that commit.
> 
> My Acked-by still holds.

Looks good to me (with Michal's update on description).

Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

> 
> > ---
> >  mm/memory_hotplug.c | 3 ++-
> >  mm/page_alloc.c     | 4 ++++
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 9eea6e809a4e..38d94b703e9d 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1333,7 +1333,8 @@ static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
> >  			if (__PageMovable(page))
> >  				return pfn;
> >  			if (PageHuge(page)) {
> > -				if (page_huge_active(page))
> > +				if (hugepage_migration_supported(page_hstate(page)) &&
> > +				    page_huge_active(page))
> >  					return pfn;
> >  				else
> >  					pfn = round_up(pfn + 1,
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index c677c1506d73..b8d91f59b836 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -7709,6 +7709,10 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
> >  		 * handle each tail page individually in migration.
> >  		 */
> >  		if (PageHuge(page)) {
> > +
> > +			if (!hugepage_migration_supported(page_hstate(page)))
> > +				goto unmovable;
> > +
> >  			iter = round_up(iter + 1, 1<<compound_order(page)) - 1;
> >  			continue;
> >  		}
> > -- 
> > 2.17.1
> 
> -- 
> Michal Hocko
> SUSE Labs
> 
