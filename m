Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756247AbeDXG3X (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 02:29:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755871AbeDXG3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 02:29:21 -0400
Date: Tue, 24 Apr 2018 08:29:19 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, kwankhede@nvidia.com,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] sample: vfio mdev display - host device
Message-ID: <20180424062919.bouvw7qxyrvi3vqc@sirius.home.kraxel.org>
References: <20180409103513.8020-1-kraxel@redhat.com>
 <20180409103513.8020-2-kraxel@redhat.com>
 <20180423204139.2d157869@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423204139.2d157869@w520.home>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > +/* pci ids */
> > +#define MDPY_PCI_VENDOR_ID	0x1b36 /* redhat */
> > +#define MDPY_PCI_DEVICE_ID	0x00f0
> 
> I don't see this on pci-ids, so I assume we're just squatting on an
> ID.  How do we do that without risking that we don't interfere with
> some future user?  Are we relying on this being a non-default sample
> device?  Should we just ask for an allocation?

It's grabbed from qemu id range.
Allocating one is probably a good idea even for a sample device.

> > +#define MDPY_PCI_SUBVENDOR_ID	PCI_SUBVENDOR_ID_REDHAT_QUMRANET
> > +#define MDPY_PCI_SUBDEVICE_ID	PCI_SUBDEVICE_ID_QEMU
> > +
> > +/* pci cfg space offsets for fb config (dword) */
> > +#define MDPY_FORMAT_OFFSET	0x40
> > +#define MDPY_WIDTH_OFFSET	0x44
> > +#define MDPY_HEIGHT_OFFSET	0x48
> 
> As I understand, these are just registers in PCI config space outside
> of any capabilities.  Wouldn't it be more correct to put these within a
> vendor defined capability?

Can do that.

> > +		region_info->size   = mdev_state->memsize;
> > +		region_info->flags  = (VFIO_REGION_INFO_FLAG_READ  |
> > +				       VFIO_REGION_INFO_FLAG_WRITE |
> > +				       VFIO_REGION_INFO_FLAG_MMAP);
> 
> This doesn't appear to be true, the read and write functions call the
> access function which only handles the config space region.  Are these
> really mmap-only regions?

Yes, they are mmap-only.

> read/write access support is often useful
> for tracing and debugging, QEMU will break if x-no-mmap=on is used.

Hmm, can look into adding that, should not be that difficuilt after all.

cheers,
  Gerd
