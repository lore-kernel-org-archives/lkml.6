Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753873AbeDSQT3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:19:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753122AbeDSQT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:19:27 -0400
Date: Thu, 19 Apr 2018 10:19:26 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Xu Yandong <xuyandong2@huawei.com>
Cc: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhang.zhanghailiang@huawei.com>, <wangxinxin.wang@huawei.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH] vfio iommu type1: no need to check task->mm if task has
 been destroyed
Message-ID: <20180419101926.5700f8a9@w520.home>
In-Reply-To: <20180418105545.13488-1-xuyandong2@huawei.com>
References: <20180418105545.13488-1-xuyandong2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[cc +Kirti]

On Wed, 18 Apr 2018 18:55:45 +0800
Xu Yandong <xuyandong2@huawei.com> wrote:

> The task structure in vfio_dma struct used to identify the same
> task who map it or other task who shares same adress space is
> allowed to unmap. But if the task who map it has exited, mm of
> the task has been set to null, we should unmap the vfio dma directly.
> 
> Signed-off-by: Xu Yandong <xuyandong2@huawei.com>
> ---
> Hi all,
> When I unplug a vcpu from a VM lanched with a VFIO hostdev device,
> I found that the *vfio_dma* mapped by this vcpu task could not be unmaped
> in the future, so I send this patch to unmap vfio_dma directly if the
> task who mapped it has exited. 
> 
> Howerver this patch may introduce a new security risk because any task can 
> unmap the *vfio_dma* if the mapper task has exited.  

Well that's unexpected, but adding some debugging code I can clearly
see that the map and unmap ioctls are typically called by the various
processor threads, which all share the same mm_struct (so accounting is
correct regardless of which CPU does the unmap).  I don't think the fix
below is correct though, it's not for a security risk, but for
accounting issue and correctness issues.  The pages are mapped and
accounted against the users locked memory limits, if we simply bail
out, both the IOMMU mappings and the limit accounting are wrong.
Perhaps rather than referencing the calling task_struct in the vfio_dma
on mapping, we should traverse to the highest parent task sharing the
same mm_struct.  Kirti, any thoughts since this code originated for
mdev support?  Thanks,

Alex
 
> ---
>  drivers/vfio/vfio_iommu_type1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 5c212bf..601a353 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -947,7 +947,7 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>  		 * Task with same address space who mapped this iova range is
>  		 * allowed to unmap the iova range.
>  		 */
> -		if (dma->task->mm != current->mm)
> +		if (dma->task->mm && (dma->task->mm != current->mm))
>  			break;
>  
>  		if (!RB_EMPTY_ROOT(&dma->pfn_list)) {
