Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbeDEOym (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:54:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751195AbeDEOyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:54:41 -0400
Date: Thu, 5 Apr 2018 17:54:40 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, aik@ozlabs.ru,
        jasowang@redhat.com, joe@perches.com, linuxppc-dev@lists.ozlabs.org,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au
Subject: Re: [RFC] virtio: Use DMA MAP API for devices without an IOMMU
Message-ID: <20180405175326-mutt-send-email-mst@kernel.org>
References: <20180405105631.9514-1-khandual@linux.vnet.ibm.com>
 <3e1b113b-79ca-b700-5be9-10c66d74aabe@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e1b113b-79ca-b700-5be9-10c66d74aabe@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 08:09:30PM +0530, Anshuman Khandual wrote:
> On 04/05/2018 04:26 PM, Anshuman Khandual wrote:
> > There are certian platforms which would like to use SWIOTLB based DMA API
> > for bouncing purpose without actually requiring an IOMMU back end. But the
> > virtio core does not allow such mechanism. Right now DMA MAP API is only
> > selected for devices which have an IOMMU and then the QEMU/host back end
> > will process all incoming SG buffer addresses as IOVA instead of simple
> > GPA which is the case for simple bounce buffers after being processed with
> > SWIOTLB API. To enable this usage, it introduces an architecture specific
> > function which will just make virtio core front end select DMA operations
> > structure.
> > 
> > Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> 
> + "Michael S. Tsirkin" <mst@redhat.com>

I'm confused by this.

static bool vring_use_dma_api(struct virtio_device *vdev)
{
        if (!virtio_has_iommu_quirk(vdev))
                return true;


Why doesn't setting VIRTIO_F_IOMMU_PLATFORM on the
hypervisor side sufficient?
