Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754057AbeCVB3r (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 21:29:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:35221 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752345AbeCVB3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 21:29:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,342,1517904000";
   d="scan'208";a="27793927"
Date: Thu, 22 Mar 2018 09:30:49 +0800
From: Aaron Lu <aaron.lu@intel.com>
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH v2 0/4] Eliminate zone->lock contention for
 will-it-scale/page_fault1 and parallel free
Message-ID: <20180322013049.GA4056@intel.com>
References: <20180320085452.24641-1-aaron.lu@intel.com>
 <1dfd4b33-6eff-160e-52fd-994d9bcbffed@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dfd4b33-6eff-160e-52fd-994d9bcbffed@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 01:44:25PM -0400, Daniel Jordan wrote:
> On 03/20/2018 04:54 AM, Aaron Lu wrote:
> ...snip...
> > reduced zone->lock contention on free path from 35% to 1.1%. Also, it
> > shows good result on parallel free(*) workload by reducing zone->lock
> > contention from 90% to almost zero(lru lock increased from almost 0 to
> > 90% though).
> 
> Hi Aaron, I'm looking through your series now.  Just wanted to mention that I'm seeing the same interaction between zone->lock and lru_lock in my own testing.  IOW, it's not enough to fix just one or the other: both need attention to get good performance on a big system, at least in this microbenchmark we've both been using.

Agree.

> 
> There's anti-scaling at high core counts where overall system page faults per second actually decrease with more CPUs added to the test.  This happens when either zone->lock or lru_lock contention are completely removed, but the anti-scaling goes away when both locks are fixed.
> 
> Anyway, I'll post some actual data on this stuff soon.

Looking forward to that, thanks.

In the meantime, I'll also try your lru_lock optimization work on top of
this patchset to see if the lock contention shifts back to zone->lock.
