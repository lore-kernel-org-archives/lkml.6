Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9B0ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CDE20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CDE20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbeGSKFo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:05:44 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:53859 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbeGSKFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:05:44 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w6J9NICL011356
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 18:23:18 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6J9NIrx009676;
        Thu, 19 Jul 2018 18:23:18 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6J9Mmdg014063;
        Thu, 19 Jul 2018 18:23:18 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.149] [10.38.151.149]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-2113680; Thu, 19 Jul 2018 18:22:48 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC21GP.gisp.nec.co.jp ([10.38.151.149]) with mapi id 14.03.0319.002; Thu,
 19 Jul 2018 18:22:48 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        "zy.zhengyi@alibaba-inc.com" <zy.zhengyi@alibaba-inc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] mm: fix race on soft-offlining free huge pages
Thread-Topic: [PATCH v2 1/2] mm: fix race on soft-offlining free huge pages
Thread-Index: AQHUHY+ZfA+YF2+Ff02zwneBkDT4a6SS4qaAgACvZYCAAIS7AIABaDSAgAAPgwCAAA7BgIAABX2AgAAPYoA=
Date:   Thu, 19 Jul 2018 09:22:47 +0000
Message-ID: <20180719092247.GB32756@hori1.linux.bs1.fc.nec.co.jp>
References: <1531805552-19547-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <1531805552-19547-2-git-send-email-n-horiguchi@ah.jp.nec.com>
 <20180717142743.GJ7193@dhcp22.suse.cz>
 <20180718005528.GA12184@hori1.linux.bs1.fc.nec.co.jp>
 <20180718085032.GS7193@dhcp22.suse.cz>
 <20180719061945.GB22154@hori1.linux.bs1.fc.nec.co.jp>
 <20180719071516.GK7193@dhcp22.suse.cz>
 <20180719080804.GA32756@hori1.linux.bs1.fc.nec.co.jp>
 <20180719082743.GN7193@dhcp22.suse.cz>
In-Reply-To: <20180719082743.GN7193@dhcp22.suse.cz>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <6639E86FDB1B77409093923B9A4D5E73@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 10:27:43AM +0200, Michal Hocko wrote:
> On Thu 19-07-18 08:08:05, Naoya Horiguchi wrote:
> > On Thu, Jul 19, 2018 at 09:15:16AM +0200, Michal Hocko wrote:
> > > On Thu 19-07-18 06:19:45, Naoya Horiguchi wrote:
> > > > On Wed, Jul 18, 2018 at 10:50:32AM +0200, Michal Hocko wrote:
> [...]
> > > > > Why do we even need HWPoison flag here? Everything can be completely
> > > > > transparent to the application. It shouldn't fail from what I
> > > > > understood.
> > > > 
> > > > PageHWPoison flag is used to the 'remove from the allocator' part
> > > > which is like below:
> > > > 
> > > >   static inline
> > > >   struct page *rmqueue(
> > > >           ...
> > > >           do {
> > > >                   page = NULL;
> > > >                   if (alloc_flags & ALLOC_HARDER) {
> > > >                           page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
> > > >                           if (page)
> > > >                                   trace_mm_page_alloc_zone_locked(page, order, migratetype);
> > > >                   }
> > > >                   if (!page)
> > > >                           page = __rmqueue(zone, order, migratetype);
> > > >           } while (page && check_new_pages(page, order));
> > > > 
> > > > check_new_pages() returns true if the page taken from free list has
> > > > a hwpoison page so that the allocator iterates another round to get
> > > > another page.
> > > > 
> > > > There's no function that can be called from outside allocator to remove
> > > > a page in allocator.  So actual page removal is done at allocation time,
> > > > not at error handling time. That's the reason why we need PageHWPoison.
> > > 
> > > hwpoison is an internal mm functionality so why cannot we simply add a
> > > function that would do that?
> > 
> > That's one possible solution.
> 
> I would prefer that much more than add an overhead (albeit small) into
> the page allocator directly. HWPoison should be a really rare event so
> why should everybody pay the price? I would much rather see that the
> poison path pays the additional price.

Yes, that's more maintainable.

> 
> > I know about another downside in current implementation.
> > If a hwpoison page is found during high order page allocation,
> > all 2^order pages (not only hwpoison page) are removed from
> > buddy because of the above quoted code. And these leaked pages
> > are never returned to freelist even with unpoison_memory().
> > If we have a page removal function which properly splits high order
> > free pages into lower order pages, this problem is avoided.
> 
> Even more reason to move to a new scheme.
> 
> > OTOH PageHWPoison still has a role to report error to userspace.
> > Without it unpoison_memory() doesn't work.
> 
> Sure but we do not really need a special page flag for that. We know the
> page is not reachable other than via pfn walkers. If you make the page
> reserved and note the fact it has been poisoned in the past then you can
> emulate the missing functionality.
> 
> Btw. do we really need unpoisoning functionality? Who is really using
> it, other than some tests?

None, as long as I know.

> How does the memory become OK again?

For hard-offlined in-use pages which are assumed to be pinned,
we clear the PageHWPoison flag and unpin the page to return it to buddy.
For other cases, we simply clear the PageHWPoison flag.
Unless the page is checked by check_new_pages() before unpoison,
the page is reusable.

Sometimes error handling fails and the error page might turn into
unexpected state (like additional refcount/mapcount).
Unpoison just fails on such pages.

> Don't we
> really need to go through physical hotremove & hotadd to clean the
> poison status?

hotremove/hotadd can be a user of unpoison, but I think simply
reinitializing struct pages is easiler.

Thanks,
Naoya Horiguchi
