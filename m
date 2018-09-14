Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61854FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D9020866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D9020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeINOYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:24:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:33594 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727944AbeINOYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:24:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0E62BAD65;
        Fri, 14 Sep 2018 09:11:01 +0000 (UTC)
Date:   Fri, 14 Sep 2018 11:10:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Arun KS <arunks@codeaurora.org>
Cc:     Balbir Singh <bsingharora@gmail.com>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, vbabka@suse.cz,
        pasha.tatashin@oracle.com, iamjoonsoo.kim@lge.com,
        osalvador@suse.de, malat@debian.org, gregkh@linuxfoundation.org,
        yasu.isimatu@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, arunks.linux@gmail.com,
        vinmenon@codeaurora.org
Subject: Re: [RFC] memory_hotplug: Free pages as pageblock_order
Message-ID: <20180914091053.GJ20287@dhcp22.suse.cz>
References: <1536744405-16752-1-git-send-email-arunks@codeaurora.org>
 <20180912103853.GC10951@dhcp22.suse.cz>
 <20180912125743.GB8537@350D>
 <20180912131724.GH10951@dhcp22.suse.cz>
 <9d8dfd50046036a7b4e730738940014d@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d8dfd50046036a7b4e730738940014d@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-09-18 20:12:30, Arun KS wrote:
> On 2018-09-12 18:47, Michal Hocko wrote:
> > On Wed 12-09-18 22:57:43, Balbir Singh wrote:
> > > On Wed, Sep 12, 2018 at 12:38:53PM +0200, Michal Hocko wrote:
> > > > On Wed 12-09-18 14:56:45, Arun KS wrote:
> > > > > When free pages are done with pageblock_order, time spend on
> > > > > coalescing pages by buddy allocator can be reduced. With
> > > > > section size of 256MB, hot add latency of a single section
> > > > > shows improvement from 50-60 ms to less than 1 ms, hence
> > > > > improving the hot add latency by 60%.
> > > >
> > > > Where does the improvement come from? You are still doing the same
> > > > amount of work except that the number of callbacks is lower. Is this the
> > > > real source of 60% improvement?
> > > >
> > > 
> > > It looks like only the first page of the pageblock is initialized, is
> > > some of the cost amortized in terms of doing one initialization for
> > > the page with order (order) and then relying on split_page and helpers
> > > to do the rest? Of course the number of callbacks reduce by a
> > > significant
> > > number as well.
> > 
> > Ohh, I have missed that part. Now when re-reading I can see the reason
> > for the perf improvement. It is most likely the higher order free which
> > ends up being much cheaper. This part makes some sense.
> > 
> > How much is this feasible is another question. Do not forget we have
> > those external providers of the online callback and those would need to
> > be updated as well.
> Sure Michal, I ll look into this.
> 
> > 
> > Btw. the normal memmap init code path does the same per-page free as
> > well. If we really want to speed the hotplug path then I guess the init
> > one would see a bigger improvement and those two should be in sync.
> Thanks for pointers, Will look further.

I haven't looked closer and I will be travelling next week so just hint.
Have a look at the nobootmem and how it frees pages to the page
allocator in __free_pages_boot_core. Seems exactly what you want and it
also answers your question about reference counting.
-- 
Michal Hocko
SUSE Labs
