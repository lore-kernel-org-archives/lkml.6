Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932153AbeCCVS0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 16:18:26 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:32876 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeCCVSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 16:18:25 -0500
X-Google-Smtp-Source: AG47ELu8QIm7EyPidvwJFJcJmiwaYUxT+A2Ct5DLDg5lQubUZk/thC+vIXd37PfqYqFHn4Hz6lmvSw==
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Sat, 3 Mar 2018 22:18:05 +0100
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC v1] mm: add the preempt check into alloc_vmap_area()
Message-ID: <20180303211805.gadu4eg5bd63hvrs@pc636>
References: <20180227102259.4629-1-urezki@gmail.com>
 <20180227130643.GA12781@bombadil.infradead.org>
 <20180302153452.748892bd70bb23b9cee23691@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302153452.748892bd70bb23b9cee23691@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 03:34:52PM -0800, Andrew Morton wrote:
> On Tue, 27 Feb 2018 05:06:43 -0800 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Tue, Feb 27, 2018 at 11:22:59AM +0100, Uladzislau Rezki (Sony) wrote:
> > > During finding a suitable hole in the vmap_area_list
> > > there is an explicit rescheduling check for latency reduction.
> > > We do it, since there are workloads which are sensitive for
> > > long (more than 1 millisecond) preemption off scenario.
> > 
> > I understand your problem, but this is a horrid solution.  If it takes
> > us a millisecond to find a suitable chunk of free address space, something
> > is terribly wrong.  On a 3GHz CPU, that's 3 million clock ticks!
> 
> Yup.
> 
> > I think our real problem is that we have no data structure that stores
> > free VA space.  We have the vmap_area which stores allocated space, but no
> > data structure to store free space.
> 
> I wonder if we can reuse free_vmap_cache as a quick fix: if
> need_resched(), point free_vmap_cache at the current rb_node, drop the
> lock, cond_resched, goto retry?
> 
It sounds like we can. But there is a concern if that potentially can
introduce a degrade of search time due to changing a starting point
for our search.

--
Vlad Rezki
