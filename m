Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751567AbeFEBSl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 21:18:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52298 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbeFEBSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 21:18:40 -0400
Date: Mon, 4 Jun 2018 18:18:36 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Huang Ying <ying.huang@intel.com>
Subject: Re: kernel panic in reading /proc/kpageflags when enabling
 RAM-simulated PMEM
Message-ID: <20180605011836.GA32444@bombadil.infradead.org>
References: <20180605005402.GA22975@hori1.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605005402.GA22975@hori1.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 12:54:03AM +0000, Naoya Horiguchi wrote:
> Reproduction precedure is like this:
>  - enable RAM based PMEM (with a kernel boot parameter like memmap=1G!4G)
>  - read /proc/kpageflags (or call tools/vm/page-types with no arguments)
>  (- my kernel config is attached)
> 
> I spent a few days on this, but didn't reach any solutions.
> So let me report this with some details below ...
> 
> In the critial page request, stable_page_flags() is called with an argument
> page whose ->compound_head was somehow filled with '0xffffffffffffffff'.
> And compound_head() returns (struct page *)(head - 1), which explains the
> address 0xfffffffffffffffe in the above message.

Hm.  compound_head shares with:

                        struct list_head lru;
                                struct list_head slab_list;     /* uses lru */
                                struct {        /* Partial pages */
                                        struct page *next;
                        unsigned long _compound_pad_1;  /* compound_head */
                        unsigned long _pt_pad_1;        /* compound_head */
                        struct dev_pagemap *pgmap;
                struct rcu_head rcu_head;

None of them should be -1.

> It seems that this kernel panic happens when reading kpageflags of pfn range
> [0xbffd7, 0xc0000), which coresponds to a 'reserved' range.
> 
> [    0.000000] user-defined physical RAM map:
> [    0.000000] user: [mem 0x0000000000000000-0x000000000009fbff] usable
> [    0.000000] user: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> [    0.000000] user: [mem 0x00000000000f0000-0x00000000000fffff] reserved
> [    0.000000] user: [mem 0x0000000000100000-0x00000000bffd6fff] usable
> [    0.000000] user: [mem 0x00000000bffd7000-0x00000000bfffffff] reserved
> [    0.000000] user: [mem 0x00000000feffc000-0x00000000feffffff] reserved
> [    0.000000] user: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
> [    0.000000] user: [mem 0x0000000100000000-0x000000013fffffff] persistent (type 12)
> 
> So I guess 'memmap=' parameter might badly affect the memory initialization process.
> 
> This problem doesn't reproduce on v4.17, so some pre-released patch introduces it.
> I hope this info helps you find the solution/workaround.

Can you try bisecting this?  It could be one of my patches to reorder struct
page, or it could be one of Pavel's deferred page initialisation patches.
Or something else ;-)
