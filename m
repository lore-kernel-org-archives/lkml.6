Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BA3C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205732146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfBYOWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:22:20 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33108 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfBYOWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:22:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBF8780D;
        Mon, 25 Feb 2019 06:22:18 -0800 (PST)
Received: from debian (c02th0x6hf1t.nice.arm.com [10.36.160.142])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6CA33F575;
        Mon, 25 Feb 2019 06:22:14 -0800 (PST)
Date:   Mon, 25 Feb 2019 15:22:10 +0100
From:   Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@linux.intel.com, jean-philippe.brucker@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, kevin.tian@intel.com,
        ashok.raj@intel.com, marc.zyngier@arm.com,
        christoffer.dall@arm.com, peter.maydell@linaro.org
Subject: Re: [PATCH v4 19/22] vfio-pci: Register an iommu fault handler
Message-ID: <20190225142209.GC23257@debian>
References: <20190218135504.25048-1-eric.auger@redhat.com>
 <20190218135504.25048-20-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218135504.25048-20-eric.auger@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Mon, Feb 18, 2019 at 02:55:00PM +0100, Eric Auger wrote:
> This patch registers a fault handler which records faults in
> a circular buffer and then signals an eventfd. This buffer is
> exposed within the fault region.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/vfio/pci/vfio_pci.c         | 49 +++++++++++++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_private.h |  1 +
>  2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index aaf63e5ca2b6..019c9fd380a5 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
(..)
>  static int vfio_pci_init_fault_region(struct vfio_pci_device *vdev)
>  {
>  	struct vfio_region_fault_prod *header;
> @@ -276,6 +317,13 @@ static int vfio_pci_init_fault_region(struct vfio_pci_device *vdev)
>  	header = (struct vfio_region_fault_prod *)vdev->fault_pages;
>  	header->version = -1;
>  	header->offset = PAGE_SIZE;
> +
> +	ret = iommu_register_device_fault_handler(&vdev->pdev->dev,
> +					vfio_pci_iommu_dev_fault_handler,
> +					vdev);
> +	if (ret)
> +		goto out;
> +
>  	return 0;
>  out:
>  	kfree(vdev->fault_pages);

This patch calls iommu_register_device_fault_handler from
vfio_pci_init_fault_region, leading to the following call stack:

iommu_register_device_fault_handler
vfio_pci_init_fault_region
vfio_pci_enable
vfio_pci_open
vfio_group_get_device_fd

> @@ -1420,6 +1468,7 @@ static void vfio_pci_remove(struct pci_dev *pdev)
>  	vfio_iommu_group_put(pdev->dev.iommu_group, &pdev->dev);
>  	kfree(vdev->region);
>  	kfree(vdev->fault_pages);
> +	iommu_unregister_device_fault_handler(&pdev->dev);
>  	mutex_destroy(&vdev->ioeventfds_lock);
>  	kfree(vdev);

And then this patch calls iommu_unregister_device_fault_handler from
vfio_pci_remove, and not from vfio_pci_release.

I think this means a device cannot be used twice in a row without unloading the
module.

Here is an example sequence:

1. modprobe vfio-pci
2. Userspace uses VFIO, calls ioctl(VFIO_GROUP_GET_DEVICE_FD)
    2.1. iommu_register_device_fault_handler is called
3. Userspace exits
    3.1. vfio_pci_release is called,
         but iommu_unregister_device_fault_handler is not called
4. Userspace uses VFIO agin, calls ioctl(VFIO_GROUP_GET_DEVICE_FD) again
    4.1. iommu_register_device_fault_handler is called again,
         notices a fault handler is already there,
         returns -EBUSY

Unloading the vfio-pci module will call vfio_pci_remove.

Maybe iommu_unregister_device_fault_handler should be called from
vfio_pci_release instead of vfio_pci_remove?

Best regards,
Vincent.
