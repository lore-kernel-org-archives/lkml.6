Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbeFEHiD convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 03:38:03 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:36968 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751619AbeFEHiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 03:38:02 -0400
From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To: Matthew Wilcox <willy@infradead.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Huang Ying <ying.huang@intel.com>
Subject: Re: kernel panic in reading /proc/kpageflags when enabling
 RAM-simulated PMEM
Thread-Topic: kernel panic in reading /proc/kpageflags when enabling
 RAM-simulated PMEM
Thread-Index: AQHT/GeymmpDVR1XWE69lshFJtmzcqRQRpEAgABpKgA=
Date: Tue, 5 Jun 2018 07:35:01 +0000
Message-ID: <20180605073500.GA23766@hori1.linux.bs1.fc.nec.co.jp>
References: <20180605005402.GA22975@hori1.linux.bs1.fc.nec.co.jp>
 <20180605011836.GA32444@bombadil.infradead.org>
In-Reply-To: <20180605011836.GA32444@bombadil.infradead.org>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <6DF55117BC2F334FAC63EA0F79B38338@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 06:18:36PM -0700, Matthew Wilcox wrote:
> On Tue, Jun 05, 2018 at 12:54:03AM +0000, Naoya Horiguchi wrote:
> > Reproduction precedure is like this:
> >  - enable RAM based PMEM (with a kernel boot parameter like memmap=1G!4G)
> >  - read /proc/kpageflags (or call tools/vm/page-types with no arguments)
> >  (- my kernel config is attached)
> > 
> > I spent a few days on this, but didn't reach any solutions.
> > So let me report this with some details below ...
> > 
> > In the critial page request, stable_page_flags() is called with an argument
> > page whose ->compound_head was somehow filled with '0xffffffffffffffff'.
> > And compound_head() returns (struct page *)(head - 1), which explains the
> > address 0xfffffffffffffffe in the above message.
> 
> Hm.  compound_head shares with:
> 
>                         struct list_head lru;
>                                 struct list_head slab_list;     /* uses lru */
>                                 struct {        /* Partial pages */
>                                         struct page *next;
>                         unsigned long _compound_pad_1;  /* compound_head */
>                         unsigned long _pt_pad_1;        /* compound_head */
>                         struct dev_pagemap *pgmap;
>                 struct rcu_head rcu_head;
> 
> None of them should be -1.
> 
> > It seems that this kernel panic happens when reading kpageflags of pfn range
> > [0xbffd7, 0xc0000), which coresponds to a 'reserved' range.
> > 
> > [    0.000000] user-defined physical RAM map:
> > [    0.000000] user: [mem 0x0000000000000000-0x000000000009fbff] usable
> > [    0.000000] user: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> > [    0.000000] user: [mem 0x00000000000f0000-0x00000000000fffff] reserved
> > [    0.000000] user: [mem 0x0000000000100000-0x00000000bffd6fff] usable
> > [    0.000000] user: [mem 0x00000000bffd7000-0x00000000bfffffff] reserved
> > [    0.000000] user: [mem 0x00000000feffc000-0x00000000feffffff] reserved
> > [    0.000000] user: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
> > [    0.000000] user: [mem 0x0000000100000000-0x000000013fffffff] persistent (type 12)
> > 
> > So I guess 'memmap=' parameter might badly affect the memory initialization process.
> > 
> > This problem doesn't reproduce on v4.17, so some pre-released patch introduces it.
> > I hope this info helps you find the solution/workaround.
> 
> Can you try bisecting this?  It could be one of my patches to reorder struct
> page, or it could be one of Pavel's deferred page initialisation patches.
> Or something else ;-)

Thank you for the comment. I'm trying bisecting now, let you know the result later.

And I found that my statement "not reproduce on v4.17" was wrong (I used
different kvm guests, which made some different test condition and misguided me),
this seems an older (at least < 4.15) bug.

Thanks,
Naoya Horiguchi
