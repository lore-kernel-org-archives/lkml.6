Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753942AbeDRPlD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 11:41:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753634AbeDRPk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 11:40:59 -0400
Date: Wed, 18 Apr 2018 23:40:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: axboe@fb.com, sagi@grimberg.me, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com, hch@lst.de
Subject: Re: PATCH V4 0/5 nvme-pci: fixes on nvme_timeout and nvme_dev_disable
Message-ID: <20180418154032.GA22533@ming.t460p>
References: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180417151700.GC16286@ming.t460p>
 <a6e1de6d-6086-d467-d9ce-641bcd07b983@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6e1de6d-6086-d467-d9ce-641bcd07b983@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 10:24:28PM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 04/17/2018 11:17 PM, Ming Lei wrote:
> > Looks blktest(block/011) can trigger IO hang easily on NVMe PCI device,
> > and all are related with nvme_dev_disable():
> > 
> > 1) admin queue may be disabled by nvme_dev_disable() from timeout path
> > during resetting, then reset can't move on
> > 
> > 2) the nvme_dev_disable() called from nvme_reset_work() may cause double
> > completion on timed-out request 
> > 
> > So could you share us what your plan is about this patchset?
> 
> Regarding to this patchset, it is mainly to fix the dependency between
> nvme_timeout and nvme_dev_disable, as your can see:
> nvme_timeout will invoke nvme_dev_disable, and nvme_dev_disable have to
> depend on nvme_timeout when controller no response.

Do you mean nvme_disable_io_queues()? If yes, this one has been handled
by wait_for_completion_io_timeout() already, and looks the block timeout
can be disabled simply. Or are there others?

> Till now, some parts
> of the patchset looks bad and seem to have a lot of work need to be done.
> :)

Yeah, this part is much more complicated than I thought.

I think it is a good topic to discuss in the coming LSF/MM, and the NVMe
timeout(EH) may need to be refactored/cleaned up, and current issues
should be addressed in clean way.

Guys, are there other issues wrt. NVMe timeout & reset except for the
above?

Thanks,
Ming
