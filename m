Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753200AbeBGEZl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 23:25:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752540AbeBGEZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 23:25:39 -0500
Date: Tue, 6 Feb 2018 21:25:38 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org
Subject: Re: [RFC PATCH] vfio/pci: Add ioeventfd support
Message-ID: <20180206212538.50ef0e13@w520.home>
In-Reply-To: <cfe31ae1-2557-d15a-45a2-0ba03d8d71fa@ozlabs.ru>
References: <20180207000731.32764.95992.stgit@gimli.home>
        <cfe31ae1-2557-d15a-45a2-0ba03d8d71fa@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Feb 2018 15:09:22 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> On 07/02/18 11:08, Alex Williamson wrote:
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index e3301dbd27d4..07966a5f0832 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -503,6 +503,30 @@ struct vfio_pci_hot_reset {
> >  
> >  #define VFIO_DEVICE_PCI_HOT_RESET	_IO(VFIO_TYPE, VFIO_BASE + 13)
> >  
> > +/**
> > + * VFIO_DEVICE_IOEVENTFD - _IOW(VFIO_TYPE, VFIO_BASE + 14,
> > + *                              struct vfio_device_ioeventfd)
> > + *
> > + * Perform a write to the device at the specified device fd offset, with
> > + * the specified data and width when the provided eventfd is triggered.
> > + *
> > + * Return: 0 on success, -errno on failure.
> > + */
> > +struct vfio_device_ioeventfd {
> > +	__u32	argsz;
> > +	__u32	flags;
> > +#define VFIO_DEVICE_IOEVENTFD_8		(1 << 0) /* 1-byte write */
> > +#define VFIO_DEVICE_IOEVENTFD_16	(1 << 1) /* 2-byte write */
> > +#define VFIO_DEVICE_IOEVENTFD_32	(1 << 2) /* 4-byte write */
> > +#define VFIO_DEVICE_IOEVENTFD_64	(1 << 3) /* 8-byte write */
> > +#define VFIO_DEVICE_IOEVENTFD_SIZE_MASK	(0xf)
> > +	__u64	offset;			/* device fd offset of write */
> > +	__u64	data;			/* data to be written */
> > +	__s32	fd;			/* -1 for de-assignment */
> > +};
> > +
> > +#define VFIO_DEVICE_IOEVENTFD		_IO(VFIO_TYPE, VFIO_BASE + 14)  
> 
> 
> Is this a first ioctl with endianness fixed to little-endian? I'd suggest
> to comment on that as things like vfio_info_cap_header do use the host
> endianness.

Look at our current read and write interface, we call leXX_to_cpu
before calling iowriteXX there and I think a user would logically
expect to use the same data format here as they would there.  Also note
that iowriteXX does a cpu_to_leXX, so are we really defining the
interface as little-endian or are we just trying to make ourselves
endian neutral and counter that implicit conversion?  Thanks,

Alex
