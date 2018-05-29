Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934919AbeE2ODZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:03:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45650 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934751AbeE2ODY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:03:24 -0400
Date: Tue, 29 May 2018 07:03:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, mpe@ellerman.id.au, hch@infradead.org,
        luto@kernel.org
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
Message-ID: <20180529140319.GA19972@infradead.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <f77638ddef3af52dd71341083707c9e3745dd505.camel@kernel.crashing.org>
 <20180525202300-mutt-send-email-mst@kernel.org>
 <6fff9f5d67361653e6072570a857cf0d1009a123.camel@kernel.crashing.org>
 <2f1d48cf029c1f0903f3cffea946ae5b85f60ec0.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f1d48cf029c1f0903f3cffea946ae5b85f60ec0.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 09:56:24AM +1000, Benjamin Herrenschmidt wrote:
> I don't think forcing the addition of an emulated iommu in the middle
> just to work around the fact that virtio "cheats" and doesn't use the
> dma API unless there is one, is the right "fix".

Agreed.

> The right long term fix is to always use the DMA API, reducing code
> path etc... and just have a single point where virtio can "chose"
> alternate DMA ops (via an arch hook to deal with our case).

Also agreed.

When Andi added vring_use_dma_api it was marked as temporary.

So I'd much rather move to blacklisting platforms that needs this
hack now than adding another exception.

And then once we have the blacklist move it to a quirk in the arch
code that just forces dma_direct_ops as the per-device dma ops.

I don't really think this is crazy long term, but something we could
do relatively quickly.  Interestingly enough the original commit
mentions PPC64 as a case where this quirk is needed.
