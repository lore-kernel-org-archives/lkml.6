Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753415AbeENMml (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:42:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40020 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752985AbeENMmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:42:38 -0400
Date: Mon, 14 May 2018 05:42:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        paulmck@linux.vnet.ibm.com
Subject: Re: [PATCH] nvme: fix lockdep warning in
 nvme_mpath_clear_current_path
Message-ID: <20180514124230.GA654@infradead.org>
References: <20180514121312.13624-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514121312.13624-1-jthumshirn@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  extern unsigned int nvme_io_timeout;
>  #define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)
> @@ -454,7 +455,9 @@ static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
>  {
>  	struct nvme_ns_head *head = ns->head;
>  
> -	if (head && ns == srcu_dereference(head->current_path, &head->srcu))
> +	if (head &&
> +	    ns == rcu_dereference_protected(head->current_path,
> +				lockdep_is_held(&ns->ctrl->subsys->lock)))
>  		rcu_assign_pointer(head->current_path, NULL);
>  }
>  struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);

We don't really dereference it at all in fact, but just check the
pointers for equality.  I wonder if there is a better way to do this,
as my ANA patches add a caller without the lock (and withou SRU
protection either now that I think of it) - for a pure pointer compare
we really should not need any sort of protection.
