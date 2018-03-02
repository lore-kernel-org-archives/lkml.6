Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934707AbeCBXey (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 18:34:54 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51496 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934690AbeCBXex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 18:34:53 -0500
Date: Fri, 2 Mar 2018 15:34:52 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC v1] mm: add the preempt check into alloc_vmap_area()
Message-Id: <20180302153452.748892bd70bb23b9cee23691@linux-foundation.org>
In-Reply-To: <20180227130643.GA12781@bombadil.infradead.org>
References: <20180227102259.4629-1-urezki@gmail.com>
        <20180227130643.GA12781@bombadil.infradead.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2018 05:06:43 -0800 Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Feb 27, 2018 at 11:22:59AM +0100, Uladzislau Rezki (Sony) wrote:
> > During finding a suitable hole in the vmap_area_list
> > there is an explicit rescheduling check for latency reduction.
> > We do it, since there are workloads which are sensitive for
> > long (more than 1 millisecond) preemption off scenario.
> 
> I understand your problem, but this is a horrid solution.  If it takes
> us a millisecond to find a suitable chunk of free address space, something
> is terribly wrong.  On a 3GHz CPU, that's 3 million clock ticks!

Yup.

> I think our real problem is that we have no data structure that stores
> free VA space.  We have the vmap_area which stores allocated space, but no
> data structure to store free space.

I wonder if we can reuse free_vmap_cache as a quick fix: if
need_resched(), point free_vmap_cache at the current rb_node, drop the
lock, cond_resched, goto retry?
