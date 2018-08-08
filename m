Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00697C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4326219DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Iyk1NAkG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4326219DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeHHOuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 10:50:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51336 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbeHHOuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 10:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ckk+O19Jk46Fk3kku45iko32uRtDTntEYPDrMRcdAQg=; b=Iyk1NAkGAg5EfqCy3Et3V71EVu
        7FBXgJLbZV8Mg5SSHOpRsOxlTAIUMI5wn1INK11vWPElH611saZO5g0uQEL82PcZTr/DQ/IZJUMbt
        UuYQjzzc1hca6kUU8echI6Yzq5qpYcwo6kmtDWRkmGD6MPUGh+Bq7Nhn7vGFx6kH2aYX/euxWkNvI
        Fdmdji2ZgEyAlpBXGUveqVfMSUM6kmDgtFlxMnyyNguiH2OVQ14OUf8V0iBFCBikaTc2EhQoaE+xf
        YFtOfSdxQY8plLTg/FoXX7I+zR5HA0Px3Kw4q/BK6HB7rI7NfTNep4U5eTzTABqjOG6B/mtUOx3vu
        W7H4EFXA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fnNbo-0002kv-R9; Wed, 08 Aug 2018 12:30:36 +0000
Date:   Wed, 8 Aug 2018 05:30:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, mpe@ellerman.id.au, linuxram@us.ibm.com,
        haren@linux.vnet.ibm.com, paulus@samba.org,
        srikar@linux.vnet.ibm.com, robin.murphy@arm.com,
        jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180808123036.GA2525@infradead.org>
References: <20180805072930.GB23288@infradead.org>
 <b7e8294e3e70d24072883a7e8e5375719d5af870.camel@kernel.crashing.org>
 <20180806094243.GA16032@infradead.org>
 <6c707d6d33ac25a42265c2e9b521c2416d72c739.camel@kernel.crashing.org>
 <20180807062117.GD32709@infradead.org>
 <aa59c7f8556bd4b332394a1dcf2d4a8faf3dc4a2.camel@kernel.crashing.org>
 <20180807135505.GA29034@infradead.org>
 <2103ecfe52d23cec03f185d08a87bfad9c9d82b5.camel@kernel.crashing.org>
 <20180808063158.GA2474@infradead.org>
 <4b596883892b5cb5560bef26fcd249e7107173ac.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b596883892b5cb5560bef26fcd249e7107173ac.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 08:07:49PM +1000, Benjamin Herrenschmidt wrote:
> Qemu virtio bypasses that iommu when the VIRTIO_F_IOMMU_PLATFORM flag
> is not set (default) but there's nothing in the device-tree to tell the
> guest about this since it's a violation of our pseries architecture, so
> we just rely on Linux virtio "knowing" that it happens. It's a bit
> yucky but that's now history...

That is ugly as hell, but it is how virtio works everywhere, so nothing
special so far.

> Essentially pseries "architecturally" does not have the concept of not
> having an iommu in the way and qemu violates that architecture today.
> 
> (Remember it comes from pHyp, our priorietary HV, which we are somewhat
> mimmicing here).

It shouldnt be too hard to have a dt property that communicates this,
should it?

> So if we always set VIRTIO_F_IOMMU_PLATFORM, it *will* force all virtio
> through that iommu and performance will suffer (esp vhost I suspect),
> especially since adding/removing translations in the iommu is a
> hypercall.

Well, we'd nee to make sure that for this particular bus we skip the
actualy iommu.

> > It would not be the same effect.  The problem with that is that you must
> > now assumes that your qemu knows that for example you might be passing
> > a dma offset if the bus otherwise requires it. 
> 
> I would assume that arch_virtio_wants_dma_ops() only returns true when
> no such offsets are involved, at least in our case that would be what
> happens.

That would work, but we're really piling hacĸs ontop of hacks here.

> >  Or in other words:
> > you potentially break the contract between qemu and the guest of always
> > passing down physical addresses.  If we explicitly change that contract
> > through using a flag that says you pass bus address everything is fine.
> 
> For us a "bus address" is behind the iommu so that's what
> VIRTIO_F_IOMMU_PLATFORM does already. We don't have the concept of a
> bus address that is different. I suppose it's an ARMism to have DMA
> offsets that are separate from iommus ? 

No, a lot of platforms support a bus address that has an offset from
the physical address. including a lot of power platforms:

arch/powerpc/kernel/pci-common.c:       set_dma_offset(&dev->dev, PCI_DRAM_OFFSET);
arch/powerpc/platforms/cell/iommu.c:            set_dma_offset(dev, cell_dma_nommu_offset);
arch/powerpc/platforms/cell/iommu.c:            set_dma_offset(dev, addr);
arch/powerpc/platforms/powernv/pci-ioda.c:      set_dma_offset(&pdev->dev, pe->tce_bypass_base);
arch/powerpc/platforms/powernv/pci-ioda.c:                      set_dma_offset(&pdev->dev, (1ULL << 32));
arch/powerpc/platforms/powernv/pci-ioda.c:              set_dma_offset(&dev->dev, pe->tce_bypass_base);
arch/powerpc/platforms/pseries/iommu.c:                         set_dma_offset(dev, dma_offset);
arch/powerpc/sysdev/dart_iommu.c:               set_dma_offset(&dev->dev, DART_U4_BYPASS_BASE);
arch/powerpc/sysdev/fsl_pci.c:          set_dma_offset(dev, pci64_dma_offset);

to make things worse some platforms (at least on arm/arm64/mips/x86) can
also require additional banking where it isn't even a single linear map
but multiples windows.
