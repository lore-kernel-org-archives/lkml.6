Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932258AbeENN4Z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:56:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:54156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932210AbeENN4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:56:24 -0400
Date: Mon, 14 May 2018 15:56:22 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@infradead.org>, Hannes Reinecke <hare@suse.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: fix lockdep warning in
 nvme_mpath_clear_current_path
Message-ID: <20180514135622.3fks4w7c6joqxbqp@linux-x5ow.site>
References: <20180514121312.13624-1-jthumshirn@suse.de>
 <20180514124230.GA654@infradead.org>
 <20180514125725.uobtf2nf4corisea@linux-x5ow.site>
 <20180514133849.GV26088@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180514133849.GV26088@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 06:38:49AM -0700, Paul E. McKenney wrote:
> On Mon, May 14, 2018 at 02:57:25PM +0200, Johannes Thumshirn wrote:
> > On Mon, May 14, 2018 at 05:42:30AM -0700, Christoph Hellwig wrote:
> > > >  extern unsigned int nvme_io_timeout;
> > > >  #define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)
> > > > @@ -454,7 +455,9 @@ static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
> > > >  {
> > > >  	struct nvme_ns_head *head = ns->head;
> > > >  
> > > > -	if (head && ns == srcu_dereference(head->current_path, &head->srcu))
> > > > +	if (head &&
> > > > +	    ns == rcu_dereference_protected(head->current_path,
> > > > +				lockdep_is_held(&ns->ctrl->subsys->lock)))
> > > >  		rcu_assign_pointer(head->current_path, NULL);
> > > >  }
> > > >  struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
> > > 
> > > We don't really dereference it at all in fact, but just check the
> > > pointers for equality.  I wonder if there is a better way to do this,
> > > as my ANA patches add a caller without the lock (and withou SRU
> > > protection either now that I think of it) - for a pure pointer compare
> > > we really should not need any sort of protection.
> > 
> > Uff maybe, but are you sure a comparison of two pointer is always
> > atomic (on all architectures)?
> > 
> > Paul, can you shed some light on us mere mortal, whether the above
> > rcu_dereference_protected() is needed or if a simple ns ==
> > head->current_path is sufficient.
> 
> One approach is the following:
> 
> static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
> {
> 	struct nvme_ns_head *head = ns->head;
>  
> 	if (head && ns == rcu_access_pointer(head->current_path))
> 		rcu_assign_pointer(head->current_path, NULL);
> }

Yes that's what I have now as well, and it tests fine.
> 
> Without the rcu_access_pointer(), sparse (and thus the 0-day test robot)
> will complain that you are accessing an RCU-protected pointer without
> using RCU.  However, rcu_access_pointer() won't ever give any lockdep
> splats about there being no RCU read-side critical section.
> 
> You might still want rcu_dereference_protected() because it will yell
> at you if the lock is not held.  Yes, the comparison will still be valid
> without the lock (at least at the exact moment when the load occurred),
> but the rcu_assign_pointer() might be a bit problematic if that lock is
> not held, right?
> 
> But it is your guys' code, so I must defer to you for the intent.
> 
> 							Thanx, Paul
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
