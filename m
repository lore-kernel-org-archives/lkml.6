Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932236AbeBUQRK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:17:10 -0500
Received: from mga01.intel.com ([192.55.52.88]:17652 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751952AbeBUQQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:16:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,543,1511856000";
   d="scan'208";a="205929989"
Subject: Re: Use higher-order pages in vmalloc
To: Matthew Wilcox <willy@infradead.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
References: <151670492223.658225.4605377710524021456.stgit@buzz>
 <151670493255.658225.2881484505285363395.stgit@buzz>
 <20180221154214.GA4167@bombadil.infradead.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <fff58819-d39d-3a8a-f314-690bcb2f95d7@intel.com>
Date: Wed, 21 Feb 2018 08:16:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221154214.GA4167@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/2018 07:42 AM, Matthew Wilcox wrote:
> On Tue, Jan 23, 2018 at 01:55:32PM +0300, Konstantin Khlebnikov wrote:
>> Virtually mapped stack have two bonuses: it eats order-0 pages and
>> adds guard page at the end. But it slightly slower if system have
>> plenty free high-order pages.
>>
>> This patch adds option to use virtually bapped stack as fallback for
>> atomic allocation of traditional high-order page.
> This prompted me to write a patch I've been meaning to do for a while,
> allocating large pages if they're available to satisfy vmalloc.  I thought
> it would save on touching multiple struct pages, but it turns out that
> the checking code we currently have in the free_pages path requires you
> to have initialised all of the tail pages (maybe we can make that code
> conditional ...)

What the concept here?  If we can use high-order pages for vmalloc() at
the moment, we *should* use them?

One of the coolest things about vmalloc() is that it can do large
allocations without consuming large (high-order) pages, so it has very
few side-effects compared to doing a bunch of order-0 allocations.  This
patch seems to propose removing that cool thing.  Even trying the
high-order allocation could kick off a bunch of reclaim and compaction
that was not there previously.

If you could take this an only _opportunistically_ allocate large pages,
it could be a more universal win.  You could try to make sure that no
compaction or reclaim is done for the large allocation.  Or, maybe you
only try it if there are *only* high-order pages in the allocator that
would have been broken down into order-0 *anyway*.

I'm not sure it's worth it, though.  I don't see a lot of folks
complaining about vmalloc()'s speed or TLB impact.
