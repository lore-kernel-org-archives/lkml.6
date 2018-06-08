Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id sMWYIj0jGlvvYgAAmS7hNA
	; Fri, 08 Jun 2018 06:37:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E0B66607DC; Fri,  8 Jun 2018 06:37:06 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YqpjGyQo"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 242B660275;
	Fri,  8 Jun 2018 06:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 242B660275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751616AbeFHGhD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 02:37:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55150 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbeFHGhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 02:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XzrxSuo3vFXaZp0ebofrR4Vx/9k33tk72bxGjouz/OA=; b=YqpjGyQoD+kXwjGtiYyg5K0cf
        Y6byR14+i7hpNa/Wq7PhYSs3rq4DcLIoCiNQl0vyEcC7EoqUlkcj7l9/ExQzkbo2R0x3EY3uWx/Tq
        Z+WvaqVe4cHwThRH/dSHHK2ObILhT9nGyfRLWE+w72nz02O6RoSgKX1ruDdvFKyRk3Aylqj9OK34v
        rXmtt6q8DX4qUXQQy6V4e8zlfWFpWRZ3curfo22/xtoZXpMMrWwuaeOPtld8MIp57vZIOKuoPcnUo
        d+jABJpy6X6AwL8kWz/2FAWJ9hGEa+kB0DwPKcJ2yUMO+VZnl19NGbxwz1w5EuzjxKKFZmCumYooj
        08G2Utekw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fRB16-00065O-Aa; Fri, 08 Jun 2018 06:36:56 +0000
Date: Thu, 7 Jun 2018 23:36:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>, robh@kernel.org, aik@ozlabs.ru,
        jasowang@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, joe@perches.com,
        linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net,
        david@gibson.dropbear.id.au, cohuck@redhat.com, pawel.moll@arm.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Rustad, Mark D" <mark.d.rustad@intel.com>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
Message-ID: <20180608063655.GA32080@infradead.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <20180524072104.GD6139@ram.oc3035372033.ibm.com>
 <0c508eb2-08df-3f76-c260-90cf7137af80@linux.vnet.ibm.com>
 <20180531204320-mutt-send-email-mst@kernel.org>
 <20180607052306.GA1532@infradead.org>
 <20180607185234-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607185234-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 07:28:35PM +0300, Michael S. Tsirkin wrote:
> Let me restate it: DMA API has support for a wide range of hardware, and
> hardware based virtio implementations likely won't benefit from all of
> it.

That is completely wrong.  All aspects of the DMA API are about the
system they are used in.  The CPU, the PCIe root complex, interconnects.

All the issues I mentioned in my previous mail exist in realy life
systems that you can plug virtio PCI or PCIe cards into.

> I'm not really sympathetic to people complaining that they can't even
> set a flag in qemu though. If that's the case the stack in question is
> way too inflexible.

The flag as defined in the spec is the wrong thing to set, because they
are not using an iommu.  They probably don't even do any address
translation.

> > Both in the flag naming and the implementation there is an implication
> > of DMA API == IOMMU, which is fundamentally wrong.
> 
> Maybe we need to extend the meaning of PLATFORM_IOMMU or rename it.

And the explanation.

> 
> It's possible that some setups will benefit from a more
> fine-grained approach where some aspects of the DMA
> API are bypassed, others aren't.

Hell no.  DMA API = abstraction for any possble platform wart.
We are not going to make this any more fine grained.  It is bad
enough that virtio already has a mode bypassing any of this,
we are not going to make even more of a mess of it.

> This seems to be what was being asked for in this thread,
> with comments claiming IOMMU flag adds too much overhead.

Right now it means implementing a virtual iommu, which I agree is
way too much overhead.

> 
> > The DMA API does a few different things:
> > 
> >  a) address translation
> > 
> > 	This does include IOMMUs.  But it also includes random offsets
> > 	between PCI bars and system memory that we see on various
> > 	platforms.
> 
> I don't think you mean bars. That's unrelated to DMA.

Of course it matters.  If the device always needs an offset in
the DMA addresses it is completely related to DMA.

For some examples take a look at:

  arch/x86/pci/sta2x11-fixup.c
  arch/mips/include/asm/mach-ath25/dma-coherence.h

or anything setting dma_pfn_offset.

> >  Worse so some of these offsets might be based on
> > 	banks, e.g. on the broadcom bmips platform.  It also deals
> > 	with bitmask in physical addresses related to memory encryption
> > 	like AMD SEV.  I'd be really curious how for example the
> > 	Intel virtio based NIC is going to work on any of those
> > 	plaforms.
> 
> SEV guys report that they just set the iommu flag and then it all works.
> I guess if there's translation we can think of this as a kind of iommu.
> Maybe we should rename PLATFORM_IOMMU to PLARTFORM_TRANSLATION?

VIRTIO_F_BEHAVES_LIKE_A_REAL_PCI_DEVICE_DONT_TRY_TO_OUTSMART_ME

as said it's not just translations, it is cache coherence as well.

> And apparently some people complain that just setting that flag makes
> qemu check translation on each access with an unacceptable performance
> overhead.  Forcing same behaviour for everyone on general principles
> even without the flag is unlikely to make them happy.

That sounds like a qemu implementation bug.  If qemu knowns that
guest physiscall == guest dma space there is no need to check.

> >   b) coherency
> > 
> > 	On many architectures DMA is not cache coherent, and we need
> > 	to invalidate and/or write back cache lines before doing
> > 	DMA.  Again, I wonder how this is every going to work with
> > 	hardware based virtio implementations.
> 
> 
> You mean dma_Xmb and friends?
> There's a new feature VIRTIO_F_IO_BARRIER that's being proposed
> for that.

No.  I mean the fact that PCI(e) devices often are not coherent with
the cache.  So you need to writeback the cpu cache before transferring
data to the device, and invalidate the cpu cache before transferring
data from the device.  Plus additional workarounds for speculation.

Looks at the implementations and comments around the dma_sync_*
calls.

> 
> >  Even worse I think this
> > 	is actually broken at least for VIVT event for virtualized
> > 	implementations.  E.g. a KVM guest is going to access memory
> > 	using different virtual addresses than qemu, vhost might throw
> > 	in another different address space.
> 
> I don't really know what VIVT is. Could you help me please?

Virtually indexed, virtually tagged.  In short you must do cache
maintainance based on the virtual address used to fill the cache.

> 
> >   c) bounce buffering
> > 
> > 	Many DMA implementations can not address all physical memory
> > 	due to addressing limitations.  In such cases we copy the
> > 	DMA memory into a known addressable bounc buffer and DMA
> > 	from there.
> 
> Don't do it then?

Because for example your PCIe root complex only supports 32-bit
addressing, but the memory buffer is outside the addressing range.

> >   d) flushing write combining buffers or similar
> > 
> > 	On some hardware platforms we need workarounds to e.g. read
> > 	from a certain mmio address to make sure DMA can actually
> > 	see memory written by the host.
> 
> I guess it isn't an issue as long as WC isn't actually used.
> It will become an issue when virtio spec adds some WC capability -
> I suspect we can ignore this for now.

This is write combibining in the SOC with the root complex.  Nothing
your can work around in the device or device driver.
