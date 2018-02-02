Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751611AbeBBFU6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 00:20:58 -0500
Received: from mga04.intel.com ([192.55.52.120]:12406 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751463AbeBBFUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 00:20:45 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,447,1511856000";
   d="scan'208";a="200747805"
Date: Fri, 2 Feb 2018 13:21:20 +0800
From: Aaron Lu <aaron.lu@intel.com>
To: daniel.m.jordan@oracle.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, ak@linux.intel.com,
        akpm@linux-foundation.org, Dave.Dice@oracle.com, dave@stgolabs.net,
        khandual@linux.vnet.ibm.com, ldufour@linux.vnet.ibm.com,
        mgorman@suse.de, mhocko@kernel.org, pasha.tatashin@oracle.com,
        steven.sistare@oracle.com, yossi.lev@oracle.com,
        Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [RFC PATCH v1 13/13] mm: splice local lists onto the front of
 the LRU
Message-ID: <20180202052120.GA16272@intel.com>
References: <20180131230413.27653-1-daniel.m.jordan@oracle.com>
 <20180131230413.27653-14-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131230413.27653-14-daniel.m.jordan@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 06:04:13PM -0500, daniel.m.jordan@oracle.com wrote:
> Now that release_pages is scaling better with concurrent removals from
> the LRU, the performance results (included below) showed increased
> contention on lru_lock in the add-to-LRU path.
> 
> To alleviate some of this contention, do more work outside the LRU lock.
> Prepare a local list of pages to be spliced onto the front of the LRU,
> including setting PageLRU in each page, before taking lru_lock.  Since
> other threads use this page flag in certain checks outside lru_lock,
> ensure each page's LRU links have been properly initialized before
> setting the flag, and use memory barriers accordingly.
> 
> Performance Results
> 
> This is a will-it-scale run of page_fault1 using 4 different kernels.
> 
>             kernel     kern #
> 
>           4.15-rc2          1
>   large-zone-batch          2
>      lru-lock-base          3
>    lru-lock-splice          4
> 
> Each kernel builds on the last.  The first is a baseline, the second
> makes zone->lock more scalable by increasing an order-0 per-cpu
> pagelist's 'batch' and 'high' values to 310 and 1860 respectively

Since the purpose of the patchset is to optimize lru_lock, you may
consider adjusting pcp->high to be >= 32768(page_fault1's test size is
128M = 32768 pages). That should eliminate zone->lock contention
entirely.

> (courtesy of Aaron Lu's patch), the third scales lru_lock without
> splicing pages (the previous patch in this series), and the fourth adds
> page splicing (this patch).
> 
> N tasks mmap, fault, and munmap anonymous pages in a loop until the test
> time has elapsed.
