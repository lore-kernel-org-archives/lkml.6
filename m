Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751404AbeDEPOD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 11:14:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46222 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbeDEPOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 11:14:02 -0400
Date: Thu, 5 Apr 2018 08:13:59 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Joel Fernandes <joelaf@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-patch-test@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1] kernel/trace:check the val against the available mem
Message-ID: <20180405151359.GB28128@bombadil.infradead.org>
References: <20180403135607.GC5501@dhcp22.suse.cz>
 <CAGWkznH-yfAu=fMo1YWU9zo-DomHY8YP=rw447rUTgzvVH4RpQ@mail.gmail.com>
 <20180404062340.GD6312@dhcp22.suse.cz>
 <20180404101149.08f6f881@gandalf.local.home>
 <20180404142329.GI6312@dhcp22.suse.cz>
 <20180404114730.65118279@gandalf.local.home>
 <20180405025841.GA9301@bombadil.infradead.org>
 <CAJWu+oqP64QzvPM6iHtzowek6s4p+3rb7WDXs1z51mwW-9mLbA@mail.gmail.com>
 <20180405142258.GA28128@bombadil.infradead.org>
 <20180405142749.GL6312@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405142749.GL6312@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 04:27:49PM +0200, Michal Hocko wrote:
> On Thu 05-04-18 07:22:58, Matthew Wilcox wrote:
> > On Wed, Apr 04, 2018 at 09:12:52PM -0700, Joel Fernandes wrote:
> > > On Wed, Apr 4, 2018 at 7:58 PM, Matthew Wilcox <willy@infradead.org> wrote:
> > > > I still don't get why you want RETRY_MAYFAIL.  You know that tries
> > > > *harder* to allocate memory than plain GFP_KERNEL does, right?  And
> > > > that seems like the exact opposite of what you want.

Argh.  The comment confused me.  OK, now I've read the source and
understand that GFP_KERNEL | __GFP_RETRY_MAYFAIL tries exactly as hard
as GFP_KERNEL *except* that it won't cause OOM itself.  But any other
simultaneous GFP_KERNEL allocation without __GFP_RETRY_MAYFAIL will
cause an OOM.  (And that's why we're having a conversation)

That's a problem because we have places in the kernel that call
kv[zm]alloc(very_large_size, GFP_KERNEL), and that will turn into vmalloc,
which will do the exact same thing, only it will trigger OOM all by itself
(assuming the largest free chunk of address space in the vmalloc area
is larger than the amount of free memory).

I considered an alloc_page_array(), but that doesn't fit well with the
design of the ring buffer code.  We could have:

struct page *alloc_page_list_node(int nid, gfp_t gfp_mask, unsigned long nr);

and link the allocated pages together through page->lru.

We could also have a GFP flag that says to only succeed if we're further
above the existing watermark than normal.  __GFP_LOW (==ALLOC_LOW),
if you like.  That would give us the desired behaviour of trying all of
the reclaim methods that GFP_KERNEL would, but not being able to exhaust
all the memory that GFP_KERNEL allocations would take.
