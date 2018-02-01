Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754723AbeBATQB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 14:16:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754699AbeBATPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 14:15:53 -0500
Date: Thu, 1 Feb 2018 21:15:45 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        pbonzini@redhat.com, liliang.opensource@gmail.com,
        yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com,
        riel@redhat.com
Subject: Re: [PATCH v25 0/2] Virtio-balloon: support free page reporting
Message-ID: <20180201211525-mutt-send-email-mst@kernel.org>
References: <1516871646-22741-1-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516871646-22741-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 25, 2018 at 05:14:04PM +0800, Wei Wang wrote:
> This patch series is separated from the previous "Virtio-balloon
> Enhancement" series. The new feature, VIRTIO_BALLOON_F_FREE_PAGE_HINT,  
> implemented by this series enables the virtio-balloon driver to report
> hints of guest free pages to the host. It can be used to accelerate live
> migration of VMs. Here is an introduction of this usage:
> 
> Live migration needs to transfer the VM's memory from the source machine
> to the destination round by round. For the 1st round, all the VM's memory
> is transferred. From the 2nd round, only the pieces of memory that were
> written by the guest (after the 1st round) are transferred. One method
> that is popularly used by the hypervisor to track which part of memory is
> written is to write-protect all the guest memory.
> 
> The second feature enables the optimization of the 1st round memory
> transfer - the hypervisor can skip the transfer of guest free pages in the
> 1st round. It is not concerned that the memory pages are used after they
> are given to the hypervisor as a hint of the free pages, because they will
> be tracked by the hypervisor and transferred in the next round if they are
> used and written.

Could you post performance numbers please?

> ChangeLog:
> v24->v25:
>     - mm: change walk_free_mem_block to return 0 (instead of true) on
>           completing the report, and return a non-zero value from the
>           callabck, which stops the reporting.
>     - virtio-balloon:
>         - use enum instead of define for VIRTIO_BALLOON_VQ_INFLATE etc.
>         - avoid __virtio_clear_bit when bailing out;
>         - a new method to avoid reporting the some cmd id to host twice
>         - destroy_workqueue can cancel free page work when the feature is
>           negotiated;
>         - fail probe when the free page vq size is less than 2.
> v23->v24:
>     - change feature name VIRTIO_BALLOON_F_FREE_PAGE_VQ to
>       VIRTIO_BALLOON_F_FREE_PAGE_HINT
>     - kick when vq->num_free < half full, instead of "= half full"
>     - replace BUG_ON with bailing out
>     - check vb->balloon_wq in probe(), if null, bail out
>     - add a new feature bit for page poisoning
>     - solve the corner case that one cmd id being sent to host twice
> v22->v23:
>     - change to kick the device when the vq is half-way full;
>     - open-code batch_free_page_sg into add_one_sg;
>     - change cmd_id from "uint32_t" to "__virtio32";
>     - reserver one entry in the vq for teh driver to send cmd_id, instead
>       of busywaiting for an available entry;
>     - add "stop_update" check before queue_work for prudence purpose for
>       now, will have a separate patch to discuss this flag check later;
>     - init_vqs: change to put some variables on stack to have simpler
>       implementation;
>     - add destroy_workqueue(vb->balloon_wq);
> 
> v21->v22:
>     - add_one_sg: some code and comment re-arrangement
>     - send_cmd_id: handle a cornercase
> 
> For previous ChangeLog, please reference
> https://lwn.net/Articles/743660/
> 
> Wei Wang (2):
>   mm: support reporting free page blocks
>   virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
> 
>  drivers/virtio/virtio_balloon.c     | 251 ++++++++++++++++++++++++++++++------
>  include/linux/mm.h                  |   6 +
>  include/uapi/linux/virtio_balloon.h |   7 +
>  mm/page_alloc.c                     |  96 ++++++++++++++
>  4 files changed, 324 insertions(+), 36 deletions(-)
> 
> -- 
> 2.7.4
