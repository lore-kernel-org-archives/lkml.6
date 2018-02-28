Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752571AbeB1Mk6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 07:40:58 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40648 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752339AbeB1Mk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 07:40:57 -0500
X-Google-Smtp-Source: AG47ELsZzk/67/qHvhViJ+CqcCxRVXAUXui4DK5C0aGkCCF1irAqfsGlgcDDoOS1XxQ8fuVd8e4Eaw==
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 28 Feb 2018 13:40:47 +0100
To: Matthew Wilcox <willy@infradead.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC v1] mm: add the preempt check into alloc_vmap_area()
Message-ID: <20180228124047.cnrcaqkvlngsz6ln@pc636>
References: <20180227102259.4629-1-urezki@gmail.com>
 <20180227130643.GA12781@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227130643.GA12781@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 05:06:43AM -0800, Matthew Wilcox wrote:
> On Tue, Feb 27, 2018 at 11:22:59AM +0100, Uladzislau Rezki (Sony) wrote:
> > During finding a suitable hole in the vmap_area_list
> > there is an explicit rescheduling check for latency reduction.
> > We do it, since there are workloads which are sensitive for
> > long (more than 1 millisecond) preemption off scenario.
> 
> I understand your problem, but this is a horrid solution.  If it takes
> us a millisecond to find a suitable chunk of free address space, something
> is terribly wrong.  On a 3GHz CPU, that's 3 million clock ticks!
>
Some background. I spent some time analyzing an issue regarding audio
drops/glitches during playing hires audio on our mobile device. It is
ARM A53 with 4 CPUs on one socket. When it comes to frequency and test
case, the system is most likely idle and operation is done on ~576 MHz.

I found out that the reason was in vmalloc due to it can take time
to find a suitable chunk of memory and it is done in non-preemptible
context. As a result the other audio thread is not run on CPU in time
despite need_resched is set.

> 
> I think our real problem is that we have no data structure that stores
> free VA space.  We have the vmap_area which stores allocated space, but no
> data structure to store free space.
> 
> My initial proposal would be to reuse the vmap_area structure and store
> the freed ones in a second rb_tree sorted by the size (ie va_end - va_start).
> When freeing, we might need to merge forwards and backwards.  Allocating
> would be a matter of finding an area preferably of the exact right size;
> otherwise split a larger free area into a free area and an allocated area
> (there's a lot of literature on how exactly to choose which larger area
> to split; memory allocators are pretty well-studied).
> 
Thank you for your comments and proposal.

--
Vlad Rezki
