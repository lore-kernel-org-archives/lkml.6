Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933950AbeBMKCJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 05:02:09 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:50135 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933931AbeBMKCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 05:02:07 -0500
Date: Tue, 13 Feb 2018 11:02:07 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Yang Shi <yang.shi@linux.alibaba.com>
cc: longman@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4 v6] lib: debugobjects: add global free list and the
 counter
In-Reply-To: <73222ea2-3d8b-e84d-6042-3f92fcd9bc08@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.1802131100470.1130@nanos.tec.linutronix.de>
References: <1517872708-24207-1-git-send-email-yang.shi@linux.alibaba.com> <1517872708-24207-3-git-send-email-yang.shi@linux.alibaba.com> <alpine.DEB.2.21.1802121718270.1158@nanos.tec.linutronix.de> <73222ea2-3d8b-e84d-6042-3f92fcd9bc08@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2018, Yang Shi wrote:
> On 2/12/18 8:25 AM, Thomas Gleixner wrote:
> > On Tue, 6 Feb 2018, Yang Shi wrote:
> > > +	/*
> > > +	 * Reuse objs from the global free list, they will be reinitialized
> > > +	 * when allocating
> > > +	 */
> > > +	while (obj_nr_tofree > 0 && (obj_pool_free < obj_pool_min_free)) {
> > > +		raw_spin_lock_irqsave(&pool_lock, flags);
> > > +		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
> > This is racy vs. the worker thread. Assume obj_nr_tofree = 1:
> > 
> > CPU0					CPU1
> > worker
> >     lock(&pool_lock);			while (obj_nr_tofree > 0 && ...) {
> >       obj = hlist_entry(obj_to_free);	  lock(&pool_lock);
> >       hlist_del(obj);			
> >       obj_nr_tofree--;
> >       ...
> >     unlock(&pool_lock);
> > 					  obj = hlist_entry(obj_to_free);
> > 					  hlist_del(obj); <------- NULL
> > pointer dereference
> > 
> > Not what you want, right? The counter or the list head need to be rechecked
> > after the lock is acquired.
> 
> Yes, you are right. Will fix the race in newer version.

I fixed up all the minor issues with this series and applied it to:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/debugobjects

Please double check the result.

Thanks,

	tglx
