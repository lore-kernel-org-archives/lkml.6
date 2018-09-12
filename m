Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CA8C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789AC206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789AC206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeILSV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:21:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:59610 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726640AbeILSV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:21:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3953AE5F;
        Wed, 12 Sep 2018 13:17:26 +0000 (UTC)
Date:   Wed, 12 Sep 2018 15:17:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     Arun KS <arunks@codeaurora.org>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, vbabka@suse.cz,
        pasha.tatashin@oracle.com, iamjoonsoo.kim@lge.com,
        osalvador@suse.de, malat@debian.org, gregkh@linuxfoundation.org,
        yasu.isimatu@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, arunks.linux@gmail.com,
        vinmenon@codeaurora.org
Subject: Re: [RFC] memory_hotplug: Free pages as pageblock_order
Message-ID: <20180912131724.GH10951@dhcp22.suse.cz>
References: <1536744405-16752-1-git-send-email-arunks@codeaurora.org>
 <20180912103853.GC10951@dhcp22.suse.cz>
 <20180912125743.GB8537@350D>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912125743.GB8537@350D>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-09-18 22:57:43, Balbir Singh wrote:
> On Wed, Sep 12, 2018 at 12:38:53PM +0200, Michal Hocko wrote:
> > On Wed 12-09-18 14:56:45, Arun KS wrote:
> > > When free pages are done with pageblock_order, time spend on
> > > coalescing pages by buddy allocator can be reduced. With
> > > section size of 256MB, hot add latency of a single section
> > > shows improvement from 50-60 ms to less than 1 ms, hence
> > > improving the hot add latency by 60%.
> > 
> > Where does the improvement come from? You are still doing the same
> > amount of work except that the number of callbacks is lower. Is this the
> > real source of 60% improvement?
> >
> 
> It looks like only the first page of the pageblock is initialized, is
> some of the cost amortized in terms of doing one initialization for
> the page with order (order) and then relying on split_page and helpers
> to do the rest? Of course the number of callbacks reduce by a significant
> number as well.

Ohh, I have missed that part. Now when re-reading I can see the reason
for the perf improvement. It is most likely the higher order free which
ends up being much cheaper. This part makes some sense.

How much is this feasible is another question. Do not forget we have
those external providers of the online callback and those would need to
be updated as well.

Btw. the normal memmap init code path does the same per-page free as
well. If we really want to speed the hotplug path then I guess the init
one would see a bigger improvement and those two should be in sync.
 
> > > 
> > > If this looks okey, I'll modify users of set_online_page_callback
> > > and resend clean patch.
> > 
> > [...]
> > 
> > > +static int generic_online_pages(struct page *page, unsigned int order);
> > > +static online_pages_callback_t online_pages_callback = generic_online_pages;
> > > +
> > > +static int generic_online_pages(struct page *page, unsigned int order)
> > > +{
> > > +	unsigned long nr_pages = 1 << order;
> > > +	struct page *p = page;
> > > +	unsigned int loop;
> > > +
> > > +	for (loop = 0 ; loop < nr_pages ; loop++, p++) {
> > > +		__ClearPageReserved(p);
> > > +		set_page_count(p, 0);

btw. you want init_page_count here.
-- 
Michal Hocko
SUSE Labs
