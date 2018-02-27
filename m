Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753049AbeB0NGr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 08:06:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752107AbeB0NGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 08:06:45 -0500
Date: Tue, 27 Feb 2018 05:06:43 -0800
From: Matthew Wilcox <willy@infradead.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC v1] mm: add the preempt check into alloc_vmap_area()
Message-ID: <20180227130643.GA12781@bombadil.infradead.org>
References: <20180227102259.4629-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227102259.4629-1-urezki@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 11:22:59AM +0100, Uladzislau Rezki (Sony) wrote:
> During finding a suitable hole in the vmap_area_list
> there is an explicit rescheduling check for latency reduction.
> We do it, since there are workloads which are sensitive for
> long (more than 1 millisecond) preemption off scenario.

I understand your problem, but this is a horrid solution.  If it takes
us a millisecond to find a suitable chunk of free address space, something
is terribly wrong.  On a 3GHz CPU, that's 3 million clock ticks!

I think our real problem is that we have no data structure that stores
free VA space.  We have the vmap_area which stores allocated space, but no
data structure to store free space.

My initial proposal would be to reuse the vmap_area structure and store
the freed ones in a second rb_tree sorted by the size (ie va_end - va_start).
When freeing, we might need to merge forwards and backwards.  Allocating
would be a matter of finding an area preferably of the exact right size;
otherwise split a larger free area into a free area and an allocated area
(there's a lot of literature on how exactly to choose which larger area
to split; memory allocators are pretty well-studied).
