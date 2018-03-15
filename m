Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752841AbeCOVHQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 17:07:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751970AbeCOVHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 17:07:12 -0400
Date: Thu, 15 Mar 2018 15:07:01 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, peterx@redhat.com, aik@ozlabs.ru
Subject: Re: [PATCH 3/3] vfio/pci: Add ioeventfd support
Message-ID: <20180315150701.41f77280@w520.home>
In-Reply-To: <ca07aa34-c0c4-3a79-be4f-4143a10d97c3@redhat.com>
References: <20180228195504.25283.45666.stgit@gimli.home>
        <20180228201520.25283.97532.stgit@gimli.home>
        <ca07aa34-c0c4-3a79-be4f-4143a10d97c3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2018 14:12:34 +0100
Auger Eric <eric.auger@redhat.com> wrote:
> On 28/02/18 21:15, Alex Williamson wrote:
> > +long vfio_pci_ioeventfd(struct vfio_pci_device *vdev, loff_t offset,
> > +			uint64_t data, int count, int fd)
> > +{
> > +	struct pci_dev *pdev = vdev->pdev;
> > +	loff_t pos = offset & VFIO_PCI_OFFSET_MASK;
> > +	int ret, bar = VFIO_PCI_OFFSET_TO_INDEX(offset);
> > +	struct vfio_pci_ioeventfd *ioeventfd;
> > +	int (*handler)(void *addr, void *value);
> > +
> > +	/* Only support ioeventfds into BARs */
> > +	if (bar > VFIO_PCI_BAR5_REGION_INDEX)
> > +		return -EINVAL;
> > +
> > +	if (pos + count > pci_resource_len(pdev, bar))
> > +		return -EINVAL;
> > +
> > +	/* Disallow ioeventfds working around MSI-X table writes */
> > +	if (bar == vdev->msix_bar &&
> > +	    !(pos + count <= vdev->msix_offset ||
> > +	      pos >= vdev->msix_offset + vdev->msix_size))
> > +		return -EINVAL;
> > +
> > +	switch (count) {
> > +	case 1:
> > +		handler = &vfio_pci_ioeventfd_handler8;
> > +		break;
> > +	case 2:
> > +		handler = &vfio_pci_ioeventfd_handler16;
> > +		break;
> > +	case 4:
> > +		handler = &vfio_pci_ioeventfd_handler32;
> > +		break;
> > +#ifdef iowrite64
> > +	case 8:
> > +		handler = &vfio_pci_ioeventfd_handler64;
> > +		break;  
> from a user point of view, it is straightforward this setup will be
> rejected? This is not documented in the uapi at the moment.

I added a mention in the uapi, do you see any need for more?
Essentially I consider this an entirely optional accelerator, bus
drivers are free to implement as much or little as they want.
Userspace can clearly make due without it, we've gone this long, and
it's easy to reject cases we don't want to support.  Thanks,

Alex
