Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752589AbeBBUoP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 15:44:15 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:50528 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbeBBUoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 15:44:09 -0500
Date: Fri, 2 Feb 2018 21:44:04 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Yang Shi <yang.shi@linux.alibaba.com>
cc: longman@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2 v5] lib: debugobjects: handle objects free in a batch
 outside the loop
In-Reply-To: <af314f63-1a6b-c2cb-95d9-59b1e4ff674d@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.1802022141390.1472@nanos.tec.linutronix.de>
References: <1517508959-63958-1-git-send-email-yang.shi@linux.alibaba.com> <1517508959-63958-2-git-send-email-yang.shi@linux.alibaba.com> <alpine.DEB.2.21.1802012203210.1472@nanos.tec.linutronix.de> <62f30929-47b0-87d6-f9cf-c85d9abf69df@linux.alibaba.com>
 <af314f63-1a6b-c2cb-95d9-59b1e4ff674d@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2018, Yang Shi wrote:
> On 2/1/18 3:01 PM, Yang Shi wrote:
> > On 2/1/18 1:36 PM, Thomas Gleixner wrote:
> > > The accounting is inconsistent. You leak obj_pool_used. But that's wrong
> > > anyway because an object should not be accounted for in two places. It's
> > > only on _ONE_ list....
> > 
> > So I should move the accounting to where the obj is deleted from the list?
> > It should look like:
> 
> I got your point here. Yes, obj_pool_used should be not decreased here since
> it has not been allocated from pool list.
> 
> But, I think obj_nr_tofree counter should be cleared since all the objs are
> *NOT* on the global free list anymore. They will be freed later. And, we can't
> decrease the obj_nr_tofree counter later without acquiring pool lock.

Right, when you split the list to the temporary tofree list head then you
need to reset obj_nr_tofree as well. And that's correct because the objects
are not longer reachable through one of the global lists.

> > > static bool __free_object(obj)
> > > {
> > >     bool work;
> > > 
> > >     lock(pool);
> > >     work = obj_pool_free > debug_objects_pool_size && obj_cache;
> > >     obj_pool_used++;
> 
> Should it be decreased here since the obj is being dequeued from hlist?

I guess so :)

Thanks,

	tglx
