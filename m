Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeEOHwY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 03:52:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:43995 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752155AbeEOHwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 03:52:23 -0400
Date: Tue, 15 May 2018 09:52:21 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 3/5] nvme: call nvmf_create_ctrl before checking for
 duplicate assignment
Message-ID: <20180515075221.4ppaxdvbosy36ltk@linux-x5ow.site>
References: <20180515074043.22843-1-jthumshirn@suse.de>
 <20180515074043.22843-4-jthumshirn@suse.de>
 <20180515075055.GB23659@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180515075055.GB23659@lst.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 09:50:55AM +0200, Christoph Hellwig wrote:
> On Tue, May 15, 2018 at 09:40:41AM +0200, Johannes Thumshirn wrote:
> > In nvmf_dev_write we did check if the /dev/nvme-fabrics device node's
> > private data is already set and then create a controller data
> > structure afterwards. The private data is protected by the
> > nvmf_dev_mutex, but there is no need to hold it while calling
> > nvmf_create_ctrl().
> > 
> > This also reduces the number of lockdep complaints in the 'nvme
> > connect' with fcloop scenario.
> 
> Something looks seriously fishy in fcloop.  How do we and up in
> a RCU critical section here?

__blk_mq_run_hw_queue() calls blk_mq_sched_dispatch_requests() with
the hctx_lock() a.k.a rcu_read_lock() held.

nvmf_connect_admin_queue() does I/O which causes the above to be called.

> In general it seems like fc loop needs to offload any I/O to a workqueue
> just like nvme-loop does, but even then I can't see how that is going to
> cause an issue in this area.

Hmm I'll be looking into it.

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
