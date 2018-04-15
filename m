Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752410AbeDOMME (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 08:12:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36282 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbeDOMMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 08:12:02 -0400
Date: Sun, 15 Apr 2018 05:11:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christoph Hellwig <hch@infradead.org>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, robh@kernel.org, aik@ozlabs.ru,
        jasowang@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, joe@perches.com,
        david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org,
        elfring@users.sourceforge.net
Subject: Re: [RFC] virtio: Use DMA MAP API for devices without an IOMMU
Message-ID: <20180415121157.GA17726@infradead.org>
References: <20180405105631.9514-1-khandual@linux.vnet.ibm.com>
 <3e1b113b-79ca-b700-5be9-10c66d74aabe@linux.vnet.ibm.com>
 <20180405175326-mutt-send-email-mst@kernel.org>
 <1522940983.21446.205.camel@kernel.crashing.org>
 <20180405213042-mutt-send-email-mst@kernel.org>
 <1522963113.21446.211.camel@kernel.crashing.org>
 <70cb433f-a8f7-5199-3c96-a760c7624804@linux.vnet.ibm.com>
 <20180406071634.GA31108@infradead.org>
 <1523003838.21446.238.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523003838.21446.238.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 06:37:18PM +1000, Benjamin Herrenschmidt wrote:
> > > implemented as DMA API which the virtio core understands. There is no
> > > need for an IOMMU to be involved for the device representation in this
> > > case IMHO.
> > 
> > This whole virtio translation issue is a mess.  I think we need to
> > switch it to the dma API, and then quirk the legacy case to always
> > use the direct mapping inside the dma API.
> 
> Fine with using a dma API always on the Linux side, but we do want to
> special case virtio still at the arch and qemu side to have a "direct
> mapping" mode. Not sure how (special flags on PCI devices) to avoid
> actually going through an emulated IOMMU on the qemu side, because that
> slows things down, esp. with vhost.
> 
> IE, we can't I think just treat it the same as a physical device.

We should have treated it like a physical device from the start, but
that device has unfortunately sailed.

But yes, we'll need a per-device quirk that says 'don't attach an
iommu'.
