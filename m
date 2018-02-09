Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751091AbeBIHFV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 02:05:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750828AbeBIHFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 02:05:20 -0500
Date: Fri, 9 Feb 2018 15:05:11 +0800
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] [RFC PATCH] vfio/pci: Add ioeventfd support
Message-ID: <20180209070511.GD2783@xz-mi>
References: <20180207000731.32764.95992.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180207000731.32764.95992.stgit@gimli.home>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 05:08:14PM -0700, Alex Williamson wrote:

[...]

> +long vfio_pci_ioeventfd(struct vfio_pci_device *vdev, loff_t offset,
> +			uint64_t data, int count, int fd)
> +{
> +	struct pci_dev *pdev = vdev->pdev;
> +	loff_t pos = offset & VFIO_PCI_OFFSET_MASK;
> +	int ret, bar = VFIO_PCI_OFFSET_TO_INDEX(offset);
> +	struct vfio_pci_ioeventfd *ioeventfd;
> +	int (*handler)(void *, void *);
> +	unsigned long val;
> +
> +	/* Only support ioeventfds into BARs */
> +	if (bar > VFIO_PCI_BAR5_REGION_INDEX)
> +		return -EINVAL;
> +
> +	if (pos + count > pci_resource_len(pdev, bar))
> +		return -EINVAL;
> +
> +	/* Disallow ioeventfds working around MSI-X table writes */
> +	if (bar == vdev->msix_bar &&
> +	    !(pos + count <= vdev->msix_offset ||
> +	      pos >= vdev->msix_offset + vdev->msix_size))
> +		return -EINVAL;
> +
> +	switch (count) {
> +	case 1:
> +		handler = &vfio_pci_ioeventfd_handler8;
> +		val = data;
> +		break;
> +	case 2:
> +		handler = &vfio_pci_ioeventfd_handler16;
> +		val = le16_to_cpu(data);
> +		break;
> +	case 4:
> +		handler = &vfio_pci_ioeventfd_handler32;
> +		val = le32_to_cpu(data);
> +		break;
> +#ifdef iowrite64
> +	case 8:
> +		handler = &vfio_pci_ioeventfd_handler64;
> +		val = le64_to_cpu(data);
> +		break;
> +#endif
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = vfio_pci_setup_barmap(vdev, bar);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&vdev->ioeventfds_lock);
> +
> +	list_for_each_entry(ioeventfd, &vdev->ioeventfds_list, next) {
> +		if (ioeventfd->pos == pos && ioeventfd->bar == bar &&
> +		    ioeventfd->data == data && ioeventfd->count == count) {
> +			if (fd == -1) {
> +				vfio_virqfd_disable(&ioeventfd->virqfd);
> +				list_del(&ioeventfd->next);
> +				kfree(ioeventfd);
> +				ret = 0;
> +			} else
> +				ret = -EEXIST;
> +
> +			goto out_unlock;
> +		}
> +	}
> +
> +	if (fd < 0) {
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}
> +
> +	ioeventfd = kzalloc(sizeof(*ioeventfd), GFP_KERNEL);
> +	if (!ioeventfd) {
> +		ret = -ENOMEM;
> +		goto out_unlock;
> +	}
> +
> +	ioeventfd->pos = pos;
> +	ioeventfd->bar = bar;
> +	ioeventfd->data = data;
> +	ioeventfd->count = count;
> +
> +	ret = vfio_virqfd_enable(vdev->barmap[ioeventfd->bar] + ioeventfd->pos,
> +				 handler, NULL, (void *)val,
> +				 &ioeventfd->virqfd, fd);
> +	if (ret) {
> +		kfree(ioeventfd);
> +		goto out_unlock;
> +	}
> +
> +	list_add(&ioeventfd->next, &vdev->ioeventfds_list);

Is there a limit on how many ioeventfds that can be created?

IIUC we'll create this eventfd "automatically" if a MMIO addr/data
triggered continuously for N=10 times, then would it be safer we have
a limitation on maximum eventfds?  Or not sure whether a malicious
guest can consume the host memory by sending:

- addr1/data1, 10 times
- addr2/data2, 10 times
- ...

To create unlimited ioeventfds?  Thanks,

-- 
Peter Xu
