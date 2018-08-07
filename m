Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723BAC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A197217B7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QL3nJ9jV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A197217B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389359AbeHGQJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:09:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732141AbeHGQJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sjc6qVLlnS7MNzp4S2oiRbv92h0kueFo92fuyJ8QGeg=; b=QL3nJ9jV0qjzlhC1av8lYnoxs
        A3ATxoB56BRe5kTmeTt/BSuXDQkeoofmFZOXGR/MDdnG4zm/wKpyRisbG+AHRK7gR4zpFgsSKM4qw
        t7Aeq/ozeL+yTvpnFkAOc9kgf1+Pg3mvJ4nHmyXm+bsGVrhcX4XtelSeLrcWR+7M6paKEnJXERp9J
        IxxcbQ2jtUzq5AVeqUDyTQ5pOp8pW/hS9bX7UsWuyyhY0MVYYL0N/DuVdXHartJfOFjq4ymbexjf5
        oMJsp7zbdEAZsBNZ7rVrY1PbcDoIwklPHIsgQMk1acllIbx2asWOGOeo1oQi7ajLQTixyltE7IDdA
        FB4i9gpWQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fn2S2-0008J0-38; Tue, 07 Aug 2018 13:55:06 +0000
Date:   Tue, 7 Aug 2018 06:55:05 -0700
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
Message-ID: <20180807135505.GA29034@infradead.org>
References: <20180803160246.GA13794@infradead.org>
 <22310f58605169fe9de83abf78b59f593ff7fbb7.camel@kernel.crashing.org>
 <20180804082120.GB4421@infradead.org>
 <a3ec0a454928e880dabc3782ea906e318634abf9.camel@kernel.crashing.org>
 <20180805072930.GB23288@infradead.org>
 <b7e8294e3e70d24072883a7e8e5375719d5af870.camel@kernel.crashing.org>
 <20180806094243.GA16032@infradead.org>
 <6c707d6d33ac25a42265c2e9b521c2416d72c739.camel@kernel.crashing.org>
 <20180807062117.GD32709@infradead.org>
 <aa59c7f8556bd4b332394a1dcf2d4a8faf3dc4a2.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa59c7f8556bd4b332394a1dcf2d4a8faf3dc4a2.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 04:42:44PM +1000, Benjamin Herrenschmidt wrote:
> Note that I can make it so that the same DMA ops (basically standard
> swiotlb ops without arch hacks) work for both "direct virtio" and
> "normal PCI" devices.
> 
> The trick is simply in the arch to setup the iommu to map the swiotlb
> bounce buffer pool 1:1 in the iommu, so the iommu essentially can be
> ignored without affecting the physical addresses.
> 
> If I do that, *all* I need is a way, from the guest itself (again, the
> other side dosn't know anything about it), to force virtio to use the
> DMA ops as if there was an iommu, that is, use whatever dma ops were
> setup by the platform for the pci device.

In that case just setting VIRTIO_F_IOMMU_PLATFORM in the flags should
do the work (even if that isn't strictly what the current definition
of the flag actually means).  On the qemu side you'll need to make
sure you have a way to set VIRTIO_F_IOMMU_PLATFORM without emulating
an iommu, but with code to take dma offsets into account if your
plaform has any (various power plaforms seem to have them, not sure
if it affects your config).
