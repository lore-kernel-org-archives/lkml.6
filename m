Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39727C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DD020700
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfAKX6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:58:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfAKX6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:58:43 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4BF46A402E;
        Fri, 11 Jan 2019 23:58:42 +0000 (UTC)
Received: from x1.home (ovpn-116-25.phx2.redhat.com [10.3.116.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94B0A5D6B3;
        Fri, 11 Jan 2019 23:58:38 +0000 (UTC)
Date:   Fri, 11 Jan 2019 16:58:38 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@linux.intel.com,
        jean-philippe.brucker@arm.com, will.deacon@arm.com,
        robin.murphy@arm.com, kevin.tian@intel.com, ashok.raj@intel.com,
        marc.zyngier@arm.com, christoffer.dall@arm.com,
        peter.maydell@linaro.org
Subject: Re: [RFC v3 18/21] vfio-pci: Add a new VFIO_REGION_TYPE_NESTED
 region type
Message-ID: <20190111165838.06a22ab8@x1.home>
In-Reply-To: <20190108102633.17482-19-eric.auger@redhat.com>
References: <20190108102633.17482-1-eric.auger@redhat.com>
        <20190108102633.17482-19-eric.auger@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 11 Jan 2019 23:58:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  8 Jan 2019 11:26:30 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> This patch adds a new 64kB region aiming to report nested mode
> translation faults.
> 
> The region contains a header with the size of the queue,
> the producer and consumer indices and then the actual
> fault queue data. The producer is updated by the kernel while
> the consumer is updated by the userspace.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> ---
>  drivers/vfio/pci/vfio_pci.c         | 102 +++++++++++++++++++++++++++-
>  drivers/vfio/pci/vfio_pci_private.h |   2 +
>  include/uapi/linux/vfio.h           |  15 ++++
>  3 files changed, 118 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index ff60bd1ea587..2ba181ab2edd 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -56,6 +56,11 @@ module_param(disable_idle_d3, bool, S_IRUGO | S_IWUSR);
>  MODULE_PARM_DESC(disable_idle_d3,
>  		 "Disable using the PCI D3 low power state for idle, unused devices");
>  
> +#define VFIO_FAULT_REGION_SIZE 0x10000

Why 64K?

> +#define VFIO_FAULT_QUEUE_SIZE	\
> +	((VFIO_FAULT_REGION_SIZE - sizeof(struct vfio_fault_region_header)) / \
> +	sizeof(struct iommu_fault))
> +
>  static inline bool vfio_vga_disabled(void)
>  {
>  #ifdef CONFIG_VFIO_PCI_VGA
> @@ -1226,6 +1231,100 @@ static const struct vfio_device_ops vfio_pci_ops = {
>  static int vfio_pci_reflck_attach(struct vfio_pci_device *vdev);
>  static void vfio_pci_reflck_put(struct vfio_pci_reflck *reflck);
>  
> +static size_t
> +vfio_pci_dma_fault_rw(struct vfio_pci_device *vdev, char __user *buf,
> +		      size_t count, loff_t *ppos, bool iswrite)
> +{
> +	unsigned int i = VFIO_PCI_OFFSET_TO_INDEX(*ppos) - VFIO_PCI_NUM_REGIONS;
> +	void *base = vdev->region[i].data;
> +	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
> +
> +	if (pos >= vdev->region[i].size)
> +		return -EINVAL;
> +
> +	count = min(count, (size_t)(vdev->region[i].size - pos));
> +
> +	if (copy_to_user(buf, base + pos, count))
> +		return -EFAULT;
> +
> +	*ppos += count;
> +
> +	return count;
> +}
> +
> +static int vfio_pci_dma_fault_mmap(struct vfio_pci_device *vdev,
> +				   struct vfio_pci_region *region,
> +				   struct vm_area_struct *vma)
> +{
> +	u64 phys_len, req_len, pgoff, req_start;
> +	unsigned long long addr;
> +	unsigned int index;
> +
> +	index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
> +
> +	if (vma->vm_end < vma->vm_start)
> +		return -EINVAL;
> +	if ((vma->vm_flags & VM_SHARED) == 0)
> +		return -EINVAL;
> +
> +	phys_len = VFIO_FAULT_REGION_SIZE;
> +
> +	req_len = vma->vm_end - vma->vm_start;
> +	pgoff = vma->vm_pgoff &
> +		((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
> +	req_start = pgoff << PAGE_SHIFT;
> +
> +	if (req_start + req_len > phys_len)
> +		return -EINVAL;
> +
> +	addr = virt_to_phys(vdev->fault_region);
> +	vma->vm_private_data = vdev;
> +	vma->vm_pgoff = (addr >> PAGE_SHIFT) + pgoff;
> +
> +	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> +			       req_len, vma->vm_page_prot);
> +}
> +
> +void vfio_pci_dma_fault_release(struct vfio_pci_device *vdev,
> +				struct vfio_pci_region *region)
> +{
> +}
> +
> +static const struct vfio_pci_regops vfio_pci_dma_fault_regops = {
> +	.rw		= vfio_pci_dma_fault_rw,
> +	.mmap		= vfio_pci_dma_fault_mmap,
> +	.release	= vfio_pci_dma_fault_release,
> +};
> +
> +static int vfio_pci_init_dma_fault_region(struct vfio_pci_device *vdev)
> +{
> +	u32 flags = VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_WRITE |
> +		    VFIO_REGION_INFO_FLAG_MMAP;
> +	int ret;
> +
> +	spin_lock_init(&vdev->fault_queue_lock);
> +
> +	vdev->fault_region = kmalloc(VFIO_FAULT_REGION_SIZE, GFP_KERNEL);
> +	if (!vdev->fault_region)
> +		return -ENOMEM;
> +
> +	ret = vfio_pci_register_dev_region(vdev,
> +		VFIO_REGION_TYPE_NESTED,
> +		VFIO_REGION_SUBTYPE_NESTED_FAULT_REGION,
> +		&vfio_pci_dma_fault_regops, VFIO_FAULT_REGION_SIZE,
> +		flags, vdev->fault_region);
> +	if (ret) {
> +		kfree(vdev->fault_region);
> +		return ret;
> +	}
> +
> +	vdev->fault_region->header.prod = 0;
> +	vdev->fault_region->header.cons = 0;
> +	vdev->fault_region->header.reserved = 0;

Use kzalloc above or else we're leaking kernel memory to userspace
anyway.

> +	vdev->fault_region->header.size = VFIO_FAULT_QUEUE_SIZE;
> +	return 0;
> +}
> +
>  static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct vfio_pci_device *vdev;
> @@ -1300,7 +1399,7 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		pci_set_power_state(pdev, PCI_D3hot);
>  	}
>  
> -	return ret;
> +	return vfio_pci_init_dma_fault_region(vdev);

Missing lots of cleanup should this fail.  Why is this done on probe
anyway?  This looks like something we'd do from vfio_pci_enable() and
therefore our release callback would free fault_region rather than what
we have below.

>  }
>  
>  static void vfio_pci_remove(struct pci_dev *pdev)
> @@ -1315,6 +1414,7 @@ static void vfio_pci_remove(struct pci_dev *pdev)
>  
>  	vfio_iommu_group_put(pdev->dev.iommu_group, &pdev->dev);
>  	kfree(vdev->region);
> +	kfree(vdev->fault_region);
>  	mutex_destroy(&vdev->ioeventfds_lock);
>  	kfree(vdev);
>  
> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
> index 8c0009f00818..38b5d1764a26 100644
> --- a/drivers/vfio/pci/vfio_pci_private.h
> +++ b/drivers/vfio/pci/vfio_pci_private.h
> @@ -120,6 +120,8 @@ struct vfio_pci_device {
>  	int			ioeventfds_nr;
>  	struct eventfd_ctx	*err_trigger;
>  	struct eventfd_ctx	*req_trigger;
> +	spinlock_t              fault_queue_lock;
> +	struct vfio_fault_region *fault_region;
>  	struct list_head	dummy_resources_list;
>  	struct mutex		ioeventfds_lock;
>  	struct list_head	ioeventfds_list;
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 352e795a93c8..b78c2c62af6d 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -307,6 +307,9 @@ struct vfio_region_info_cap_type {
>  #define VFIO_REGION_TYPE_GFX                    (1)
>  #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
>  
> +#define VFIO_REGION_TYPE_NESTED			(2)
> +#define VFIO_REGION_SUBTYPE_NESTED_FAULT_REGION	(1)
> +
>  /**
>   * struct vfio_region_gfx_edid - EDID region layout.
>   *
> @@ -697,6 +700,18 @@ struct vfio_device_ioeventfd {
>  
>  #define VFIO_DEVICE_IOEVENTFD		_IO(VFIO_TYPE, VFIO_BASE + 16)
>  
> +struct vfio_fault_region_header {
> +	__u32	size;		/* Read-Only */
> +	__u32	prod;		/* Read-Only */

We can't really enforce read-only if it's mmap'd.  I worry about
synchronization here too, perhaps there should be a ring offset such
that the ring can be in a separate page from the header and then sparse
mmap support can ensure that the user access is restricted.  I also
wonder if there are other transports that make sense here, this almost
feels like a vhost sort of thing.  Thanks,

Alex

> +	__u32	cons;
> +	__u32	reserved;	/* must be 0 */
> +};
> +
> +struct vfio_fault_region {
> +	struct vfio_fault_region_header header;
> +	struct iommu_fault queue[0];
> +};
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
>  
>  /**

