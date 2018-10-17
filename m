Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59776ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28AD8205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28AD8205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeJQWT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:19:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:12437 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbeJQWT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:19:27 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 07:23:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,392,1534834800"; 
   d="scan'208";a="89043679"
Received: from aaronlu.sh.intel.com (HELO intel.com) ([10.239.159.44])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Oct 2018 07:23:28 -0700
Date:   Wed, 17 Oct 2018 22:23:27 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kemi Wang <kemi.wang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [RFC v4 PATCH 3/5] mm/rmqueue_bulk: alloc without touching
 individual page structure
Message-ID: <20181017142327.GB9167@intel.com>
References: <20181017063330.15384-1-aaron.lu@intel.com>
 <20181017063330.15384-4-aaron.lu@intel.com>
 <20181017112042.GK5819@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017112042.GK5819@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 12:20:42PM +0100, Mel Gorman wrote:
> On Wed, Oct 17, 2018 at 02:33:28PM +0800, Aaron Lu wrote:
> > Profile on Intel Skylake server shows the most time consuming part
> > under zone->lock on allocation path is accessing those to-be-returned
> > page's "struct page" on the free_list inside zone->lock. One explanation
> > is, different CPUs are releasing pages to the head of free_list and
> > those page's 'struct page' may very well be cache cold for the allocating
> > CPU when it grabs these pages from free_list' head. The purpose here
> > is to avoid touching these pages one by one inside zone->lock.
> > 
> 
> I didn't read this one in depth because it's somewhat ortogonal to the
> lazy buddy merging which I think would benefit from being finalised and
> ensuring that there are no reductions in high-order allocation success
> rates.  Pages being allocated on one CPU and freed on another is not that
> unusual -- ping-pong workloads or things like netperf used to exhibit
> this sort of pattern.
> 
> However, this part stuck out
> 
> > +static inline void zone_wait_cluster_alloc(struct zone *zone)
> > +{
> > +	while (atomic_read(&zone->cluster.in_progress))
> > +		cpu_relax();
> > +}
> > +
> 
> RT has had problems with cpu_relax in the past but more importantly, as
> this delay for parallel compactions and allocations of contig ranges,
> we could be stuck here for very long periods of time with interrupts

The longest possible time is one CPU accessing pcp->batch number cold
cachelines. Reason:
When zone_wait_cluster_alloc() is called, we already held zone lock so
no more allocations are possible. Waiting in_progress to become zero
means waiting any CPU that increased in_progress to finish processing
their allocated pages. Since they will at most allocate pcp->batch pages
and worse case are all these page structres are cache cold, so the
longest wait time is one CPU accessing pcp->batch number cold cache lines.

I have no idea if this time is too long though.

> disabled. It gets even worse if it's from an interrupt context such as
> jumbo frame allocation or a high-order slab allocation that is atomic.

My understanding is atomic allocation won't trigger compaction, no?

> These potentially large periods of time with interrupts disabled is very
> hazardous.

I see and agree, thanks for pointing this out.
Hopefully, the above mentioned worst case time won't be regarded as
unbound or too long.

> It may be necessary to consider instead minimising the number
> of struct page update when merging to PCP and then either increasing the
> size of the PCP or allowing it to exceed pcp->high for short periods of
> time to batch the struct page updates.

I don't quite follow this part. It doesn't seem possible we can exceed
pcp->high in allocation path, or are you talking about free path?

And thanks a lot for the review!
