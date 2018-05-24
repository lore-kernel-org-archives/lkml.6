Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965053AbeEXHSF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 03:18:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51494 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964871AbeEXHSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 03:18:04 -0400
Date: Thu, 24 May 2018 00:17:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, mpe@ellerman.id.au, hch@infradead.org
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
Message-ID: <20180524071759.GA624@infradead.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <f77638ddef3af52dd71341083707c9e3745dd505.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f77638ddef3af52dd71341083707c9e3745dd505.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 08:27:04AM +1000, Benjamin Herrenschmidt wrote:
> - First qemu doesn't know that the guest will switch to "secure mode"
> in advance. There is no difference between a normal and a secure
> partition until the partition does the magic UV call to "enter secure
> mode" and qemu doesn't see any of it. So who can set the flag here ?
> 
> - Second, when using VIRTIO_F_IOMMU_PLATFORM, we also make qemu (or
> vhost) go through the emulated MMIO for every access to the guest,
> which adds additional overhead.

Also this whole scheme is simply the wrong way around.  No driver should
opt out of the DMA API in general.  For legacy reasons we might have to
opt out of the dma API for some virtio cases due to qemu bugs, but
this should never have been the default, but a quirk for the affected
versions.

We need to fix this now and make the dma ops bypass the quirk instead of
the default, which will also solve the power issue.
