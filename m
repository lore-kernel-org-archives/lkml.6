Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932634AbeCLRcg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 13:32:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:59504 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932231AbeCLRcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 13:32:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,462,1515484800";
   d="scan'208";a="36662994"
Subject: Re: [PATCH v4 3/3 update] mm/free_pcppages_bulk: prefetch buddy while
 not holding lock
To: Aaron Lu <aaron.lu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180301062845.26038-1-aaron.lu@intel.com>
 <20180301062845.26038-4-aaron.lu@intel.com>
 <20180301160950.b561d6b8b561217bad511229@linux-foundation.org>
 <20180302082756.GC6356@intel.com> <20180309082431.GB30868@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>, Kemi Wang <kemi.wang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <988ce376-bdc4-0989-5133-612bfa3f7c45@intel.com>
Date: Mon, 12 Mar 2018 10:32:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309082431.GB30868@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2018 12:24 AM, Aaron Lu wrote:
> +			/*
> +			 * We are going to put the page back to the global
> +			 * pool, prefetch its buddy to speed up later access
> +			 * under zone->lock. It is believed the overhead of
> +			 * an additional test and calculating buddy_pfn here
> +			 * can be offset by reduced memory latency later. To
> +			 * avoid excessive prefetching due to large count, only
> +			 * prefetch buddy for the last pcp->batch nr of pages.
> +			 */
> +			if (count > pcp->batch)
> +				continue;
> +			pfn = page_to_pfn(page);
> +			buddy_pfn = __find_buddy_pfn(pfn, 0);
> +			buddy = page + (buddy_pfn - pfn);
> +			prefetch(buddy);

FWIW, I think this needs to go into a helper function.  Is that possible?

There's too much logic happening here.  Also, 'count' going from
batch_size->0 is totally non-obvious from the patch context.  It makes
this hunk look totally wrong by itself.
