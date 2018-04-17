Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752672AbeDQPRT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:17:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47074 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751157AbeDQPRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:17:18 -0400
Date: Tue, 17 Apr 2018 23:17:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: PATCH V4 0/5 nvme-pci: fixes on nvme_timeout and nvme_dev_disable
Message-ID: <20180417151700.GC16286@ming.t460p>
References: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 02:19:26PM +0800, Jianchao Wang wrote:
> Firstly, really appreciate Keith and Sagi's precious advice on previous versions.
> And this is the version 4.
> 
> Some patches of the previous patchset have been submitted and the left is this patchset
> which has been refactored. Please consider it for 4.17.
> 
> The target of this patchset is to avoid nvme_dev_disable to be invoked by nvme_timeout.
> As we know, nvme_dev_disable will issue commands on adminq, if the controller no response,
> it has to depend on timeout path. However, nvme_timeout will also need to invoke
> nvme_dev_disable. This will introduce dangerous circular dependence. Moreover,
> nvme_dev_disable is under the shutdown_lock, even when it go to sleep, this makes things
> worse.
> 
> The basic idea of this patchset is:
>  - When need to schedule reset_work, hand over expired requests to nvme_dev_disable. They
>    will be completed after the controller is disabled/shtudown.
> 
>  - When requests from nvme_dev_disable and nvme_reset_work expires, disable the controller
>    directly then the request could be completed to wakeup the waiter. 
> 
> The 'disable the controller directly' here means that it doesn't send commands on adminq.
> A new interface is introduced for this, nvme_pci_disable_ctrl_directly. More details,
> please refer to the comment of the function.
> 
> Then nvme_timeout doesn't depends on nvme_dev_disable any more.
> 
> Because there is big difference from previous version, and some relatively independent patches
> have been submitted, so I just reserve the key part of previous version change log following.
> 
> Change V3->V4
>  - refactor the interfaces flushing in-flight requests and add them to nvme core.
>  - refactor the nvme_timeout to make it more clearly
> 
> Change V2->V3:
>  - discard the patch which unfreeze the queue after nvme_dev_disable
> 
> Changes V1->V2:
>  - disable PCI controller bus master in nvme_pci_disable_ctrl_directly
> 
> There are 5 patches:
> 1st one is to change the operations on nvme_request->flags to atomic operations, then we could introduce
> another NVME_REQ_ABORTED next.
> 2nd patch introduce two new interfaces to flush in-flight requests in nvme core.
> 3rd patch is to avoid the nvme_dev_disable in nvme_timeout, it introduce new interface nvme_pci_disable_ctrl_directly
> and refactor the nvme_timeout
> 4th~5th is to fix issues introduced after 3rd patch.
> 
> Jianchao Wang (5)
> 0001-nvme-do-atomically-bit-operations-on-nvme_request.fl.patch
> 0002-nvme-add-helper-interface-to-flush-in-flight-request.patch
> 0003-nvme-pci-avoid-nvme_dev_disable-to-be-invoked-in-nvm.patch
> 0004-nvme-pci-discard-wait-timeout-when-delete-cq-sq.patch
> 0005-nvme-pci-add-the-timeout-case-for-DELETEING-state.patch
> 
> diff stat
>  drivers/nvme/host/core.c |  96 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/nvme/host/nvme.h |   4 +-
>  drivers/nvme/host/pci.c  | 224 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------
>  

Hi Jianchao,

Looks blktest(block/011) can trigger IO hang easily on NVMe PCI device,
and all are related with nvme_dev_disable():

1) admin queue may be disabled by nvme_dev_disable() from timeout path
during resetting, then reset can't move on

2) the nvme_dev_disable() called from nvme_reset_work() may cause double
completion on timed-out request 

So could you share us what your plan is about this patchset?

Thanks,
Ming
