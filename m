Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753751AbeENNeI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:34:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753369AbeENNeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:34:07 -0400
Date: Mon, 14 May 2018 06:34:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: fix lockdep warning in
 nvme_mpath_clear_current_path
Message-ID: <20180514133403.GA14243@infradead.org>
References: <20180514121312.13624-1-jthumshirn@suse.de>
 <20180514124230.GA654@infradead.org>
 <20180514133105.GU26088@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514133105.GU26088@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 06:31:05AM -0700, Paul E. McKenney wrote:
> > > +	if (head &&
> > > +	    ns == rcu_dereference_protected(head->current_path,
> > > +				lockdep_is_held(&ns->ctrl->subsys->lock)))
> > >  		rcu_assign_pointer(head->current_path, NULL);
> > >  }
> > >  struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
> > 
> > We don't really dereference it at all in fact, but just check the
> > pointers for equality.  I wonder if there is a better way to do this,
> > as my ANA patches add a caller without the lock (and withou SRU
> > protection either now that I think of it) - for a pure pointer compare
> > we really should not need any sort of protection.
> 
> If you are just looking at the value of an RCU-protected pointer, then
> using rcu_access_pointer() will cause RCU to just read out the value
> and otherwise keeps its mouth shut.

That is exactly the function I was looking for.  And given that srcu
and rcu use the same annotations I should have through of being able
to use it of course.  As you see above we only use the return value
to do a comparison, so we should be perfectly fine.

Johannes, can you respin the patch to use rcu_access_pointer?
