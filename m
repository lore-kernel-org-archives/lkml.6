Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25C1C004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 02:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A959220674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 02:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A959220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeJWKkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 06:40:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:39201 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbeJWKko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 06:40:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2018 19:19:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,414,1534834800"; 
   d="scan'208";a="97649079"
Received: from aaronlu.sh.intel.com (HELO intel.com) ([10.239.159.44])
  by fmsmga002.fm.intel.com with ESMTP; 22 Oct 2018 19:19:30 -0700
Date:   Tue, 23 Oct 2018 10:19:30 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kemi Wang <kemi.wang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [RFC v4 PATCH 3/5] mm/rmqueue_bulk: alloc without touching
 individual page structure
Message-ID: <20181023021930.GA20069@intel.com>
References: <20181017063330.15384-1-aaron.lu@intel.com>
 <20181017063330.15384-4-aaron.lu@intel.com>
 <b343cf1a-ea15-b70e-ff5a-e08d3dc5354d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b343cf1a-ea15-b70e-ff5a-e08d3dc5354d@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 11:37:53AM +0200, Vlastimil Babka wrote:
> On 10/17/18 8:33 AM, Aaron Lu wrote:
> > Profile on Intel Skylake server shows the most time consuming part
> > under zone->lock on allocation path is accessing those to-be-returned
> > page's "struct page" on the free_list inside zone->lock. One explanation
> > is, different CPUs are releasing pages to the head of free_list and
> > those page's 'struct page' may very well be cache cold for the allocating
> > CPU when it grabs these pages from free_list' head. The purpose here
> > is to avoid touching these pages one by one inside zone->lock.
> 
> What about making the pages cache-hot first, without zone->lock, by
> traversing via page->lru. It would need some safety checks obviously
> (maybe based on page_to_pfn + pfn_valid, or something) to make sure we
> only read from real struct pages in case there's some update racing. The
> worst case would be not populating enough due to race, and thus not
> gaining the performance when doing the actual rmqueueing under lock.

Yes, there are the 2 potential problems you have pointed out:
1 we may be prefetching something that isn't a page due to page->lru can
  be reused as different things under different scenerios;
2 we may not be able to prefetch much due to other CPU is doing
  allocation inside the lock, it's possible we end up with prefetching
  pages that are on another CPU's pcp list.

Considering the above 2 problems, I feel prefetching outside lock a
little risky and troublesome.

Allocation path is the hard part of improving page allocator
performance - in free path, we can prefetch them safely outside the lock
and we can even pre-merge them outside the lock to reduce the pressure of
the zone lock; but in allocation path, there is pretty nothing we can do
before acquiring the lock, except taking the risk to prefetch them
without taking the lock as you mentioned here.

We can come back to this if 'address space range' lock doesn't work out.
