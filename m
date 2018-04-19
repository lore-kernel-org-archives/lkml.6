Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752907AbeDSC2C (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 22:28:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752245AbeDSC2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 22:28:01 -0400
Date: Thu, 19 Apr 2018 10:27:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: keith.busch@intel.com, sagi@grimberg.me, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de
Subject: Re: PATCH V4 0/5 nvme-pci: fixes on nvme_timeout and nvme_dev_disable
Message-ID: <20180419022735.GC5495@ming.t460p>
References: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180417151700.GC16286@ming.t460p>
 <a6e1de6d-6086-d467-d9ce-641bcd07b983@oracle.com>
 <20180418154032.GA22533@ming.t460p>
 <2b985ef5-223f-6a11-45b4-e570c8a93bb3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b985ef5-223f-6a11-45b4-e570c8a93bb3@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 09:51:16AM +0800, jianchao.wang wrote:
> Hi Ming
> 
> Thanks for your kindly response.
> 
> On 04/18/2018 11:40 PM, Ming Lei wrote:
> >> Regarding to this patchset, it is mainly to fix the dependency between
> >> nvme_timeout and nvme_dev_disable, as your can see:
> >> nvme_timeout will invoke nvme_dev_disable, and nvme_dev_disable have to
> >> depend on nvme_timeout when controller no response.
> > Do you mean nvme_disable_io_queues()? If yes, this one has been handled
> > by wait_for_completion_io_timeout() already, and looks the block timeout
> > can be disabled simply. Or are there others?
> > 
> Here is one possible scenario currently
> 
> nvme_dev_disable // hold shutdown_lock             nvme_timeout
>   -> nvme_set_host_mem                               -> nvme_dev_disable
>     -> nvme_submit_sync_cmd                            -> try to require shutdown_lock 
>       -> __nvme_submit_sync_cmd
>         -> blk_execute_rq
>           //if sysctl_hung_task_timeout_secs == 0
>           -> wait_for_completion_io
> And maybe nvme_dev_disable need to issue other commands in the future.

OK, thanks for sharing this one, for now I think it might need to be
handled by wait_for_completion_io_timeout() for working around this issue.

> 
> Even if we could fix these kind of issues as nvme_disable_io_queues, 
> it is still a risk I think.

Yeah, I can't agree more, that is why I think the nvme time/eh code should
be refactored, and solve the current issues in a more clean/maintainable
way.

Thanks,
Ming
