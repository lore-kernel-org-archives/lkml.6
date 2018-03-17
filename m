Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeCQVnl (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 17:43:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751677AbeCQVnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 17:43:40 -0400
Message-ID: <1521323019.3722.98.camel@redhat.com>
Subject: Re: [PATCH 00/10 v2] iommu/amd: lock splitting & GFP_KERNEL
 allocation
From: Scott Wood <swood@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Date: Sat, 17 Mar 2018 16:43:39 -0500
In-Reply-To: <20180317211013.rlou66s542ad4y2i@linutronix.de>
References: <20180316201836.7864-1-bigeasy@linutronix.de>
         <1521316194.3722.74.camel@redhat.com>
         <20180317211013.rlou66s542ad4y2i@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-03-17 at 22:10 +0100, Sebastian Andrzej Siewior wrote:
> On 2018-03-17 14:49:54 [-0500], Scott Wood wrote:
> > On Fri, 2018-03-16 at 21:18 +0100, Sebastian Andrzej Siewior wrote:
> > > The goal here is to make the memory allocation in get_irq_table()
> > > not
> > > with disabled interrupts and having as little raw_spin_lock as
> > > possible
> > > while having them if the caller is also holding one (like desc-
> > > >lock
> > > during IRQ-affinity changes).
> > > I reverted one patch one patch in the iommu while rebasing since
> > > it
> > > make job easier.
> > 
> > If the goal is to have "as little raw_spin_lock as possible" -- and
> > presumably also to avoid unnecessary complexity -- wouldn't it be
> > better to leave my patch in, and drop patches 4 and 9?
> 
> 9 gives me GFP_KERNEL instead atomic so no.
> 4 is needed I think but I could double check on Monday. 

If that's worth the lock dropping then fine (though why does only one
of the two allocations use GFP_KERNEL?), but it doesn't need to be a
raw lock if the non-allocating users are separated.  Keeping them
separate will also preserve the WARNs if we somehow end up in an atomic
context with no table (versus relying on atomic sleep debugging that
may or may not be enabled), and make the code easier to understand by
being explicit about which functions can be used from RT-atomic
context.

-Scott
