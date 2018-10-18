Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91939ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612BB21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612BB21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbeJRVWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:22:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:28738 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727199AbeJRVWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:22:33 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2018 06:21:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,396,1534834800"; 
   d="scan'208";a="98517244"
Received: from aaronlu.sh.intel.com (HELO intel.com) ([10.239.159.44])
  by fmsmga004.fm.intel.com with ESMTP; 18 Oct 2018 06:21:29 -0700
Date:   Thu, 18 Oct 2018 21:21:28 +0800
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
Message-ID: <20181018132128.GA17006@intel.com>
References: <20181017063330.15384-1-aaron.lu@intel.com>
 <20181017063330.15384-4-aaron.lu@intel.com>
 <20181017112042.GK5819@techsingularity.net>
 <20181017142327.GB9167@intel.com>
 <20181018112055.GN5819@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018112055.GN5819@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 12:20:55PM +0100, Mel Gorman wrote:
> On Wed, Oct 17, 2018 at 10:23:27PM +0800, Aaron Lu wrote:
> > > RT has had problems with cpu_relax in the past but more importantly, as
> > > this delay for parallel compactions and allocations of contig ranges,
> > > we could be stuck here for very long periods of time with interrupts
> > 
> > The longest possible time is one CPU accessing pcp->batch number cold
> > cachelines. Reason:
> > When zone_wait_cluster_alloc() is called, we already held zone lock so
> > no more allocations are possible. Waiting in_progress to become zero
> > means waiting any CPU that increased in_progress to finish processing
> > their allocated pages. Since they will at most allocate pcp->batch pages
> > and worse case are all these page structres are cache cold, so the
> > longest wait time is one CPU accessing pcp->batch number cold cache lines.
> > 
> > I have no idea if this time is too long though.
> > 
> 
> But compact_zone calls zone_wait_and_disable_cluster_alloc so how is the
> disabled time there bound by pcp->batch?

My mistake, I misunderstood spin_lock_irqsave() and thought lock would
need be acquired before irq is disabled...

So yeah, your concern of possible excessive long irq disabled time here
is true.
