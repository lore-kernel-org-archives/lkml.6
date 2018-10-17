Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35392ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCE0214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCE0214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbeJQTQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:16:00 -0400
Received: from outbound-smtp10.blacknight.com ([46.22.139.15]:41156 "EHLO
        outbound-smtp10.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726904AbeJQTP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:15:59 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id D881F1C2FB7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 12:20:43 +0100 (IST)
Received: (qmail 26267 invoked from network); 17 Oct 2018 11:20:43 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.142])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Oct 2018 11:20:43 -0000
Date:   Wed, 17 Oct 2018 12:20:42 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Aaron Lu <aaron.lu@intel.com>
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
Message-ID: <20181017112042.GK5819@techsingularity.net>
References: <20181017063330.15384-1-aaron.lu@intel.com>
 <20181017063330.15384-4-aaron.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20181017063330.15384-4-aaron.lu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 02:33:28PM +0800, Aaron Lu wrote:
> Profile on Intel Skylake server shows the most time consuming part
> under zone->lock on allocation path is accessing those to-be-returned
> page's "struct page" on the free_list inside zone->lock. One explanation
> is, different CPUs are releasing pages to the head of free_list and
> those page's 'struct page' may very well be cache cold for the allocating
> CPU when it grabs these pages from free_list' head. The purpose here
> is to avoid touching these pages one by one inside zone->lock.
> 

I didn't read this one in depth because it's somewhat ortogonal to the
lazy buddy merging which I think would benefit from being finalised and
ensuring that there are no reductions in high-order allocation success
rates.  Pages being allocated on one CPU and freed on another is not that
unusual -- ping-pong workloads or things like netperf used to exhibit
this sort of pattern.

However, this part stuck out

> +static inline void zone_wait_cluster_alloc(struct zone *zone)
> +{
> +	while (atomic_read(&zone->cluster.in_progress))
> +		cpu_relax();
> +}
> +

RT has had problems with cpu_relax in the past but more importantly, as
this delay for parallel compactions and allocations of contig ranges,
we could be stuck here for very long periods of time with interrupts
disabled. It gets even worse if it's from an interrupt context such as
jumbo frame allocation or a high-order slab allocation that is atomic.
These potentially large periods of time with interrupts disabled is very
hazardous. It may be necessary to consider instead minimising the number
of struct page update when merging to PCP and then either increasing the
size of the PCP or allowing it to exceed pcp->high for short periods of
time to batch the struct page updates.

I didn't read the rest of the series as it builds upon this patch.

-- 
Mel Gorman
SUSE Labs
