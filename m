Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBAEC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE69F216F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OZihnDF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE69F216F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeHHIuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:50:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37218 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeHHIuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KJcs7fpiBXgr92FYi2pkhhJzmwvYibnEJz3umdBbiLU=; b=OZihnDF3O0pbYzStK3ziGfkAP
        t14a2ExXplP3eFqGwljWBoWMOlqyascmX8X6DHJaM3Krc00kNKwa57xdiZh6X/xIXK4UvsjmaQVRb
        eW8yTX9r+XgpgGPfvolIpjKIg/T+bHY4TwCrsip+IVbGfTC9cJDCDV7zgnVYjWSI240bzWGgjwVnG
        uhcrakOSxNnMcSz3XxbjnaMzXCqEAvFzjv7U2p7RravZs7sWjmvsWVM5+q8EetT0XJtxHURXth1qW
        +8g7VyYV80YfxMGKNzqM2tsFqv+zAvu5brGMb8ZGfqafiU1d9EGL0+sIKTC7moPu0WeLfuudl+nv0
        QGR+Scbuw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fnI0l-0002UU-5L; Wed, 08 Aug 2018 06:31:59 +0000
Date:   Tue, 7 Aug 2018 23:31:58 -0700
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
Message-ID: <20180808063158.GA2474@infradead.org>
References: <20180804082120.GB4421@infradead.org>
 <a3ec0a454928e880dabc3782ea906e318634abf9.camel@kernel.crashing.org>
 <20180805072930.GB23288@infradead.org>
 <b7e8294e3e70d24072883a7e8e5375719d5af870.camel@kernel.crashing.org>
 <20180806094243.GA16032@infradead.org>
 <6c707d6d33ac25a42265c2e9b521c2416d72c739.camel@kernel.crashing.org>
 <20180807062117.GD32709@infradead.org>
 <aa59c7f8556bd4b332394a1dcf2d4a8faf3dc4a2.camel@kernel.crashing.org>
 <20180807135505.GA29034@infradead.org>
 <2103ecfe52d23cec03f185d08a87bfad9c9d82b5.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2103ecfe52d23cec03f185d08a87bfad9c9d82b5.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 06:32:45AM +1000, Benjamin Herrenschmidt wrote:
> As for the flag itself, while we could set it from qemu when we get
> notified that the guest is going secure, both Michael and I think it's
> rather gross, it requires qemu to go iterate all virtio devices and
> "poke" something into them.

You don't need to set them the time you go secure.  You just need to
set the flag from the beginning on any VM you might want to go secure.
Or for simplicity just any VM - if the DT/ACPI tables exposed by
qemu are good enough that will always exclude a iommu and not set a
DMA offset, so nothing will change on the qemu side of he processing,
and with the new direct calls for the direct dma ops performance in
the guest won't change either.

> It's nicer if we have a way in the guest virtio driver to do something
> along the lines of
> 
> 	if ((flags & VIRTIO_F_IOMMU_PLATFORM) || arch_virtio_wants_dma_ops())
> 
> Which would have the same effect and means the issue is entirely
> contained in the guest.

It would not be the same effect.  The problem with that is that you must
now assumes that your qemu knows that for example you might be passing
a dma offset if the bus otherwise requires it.  Or in other words:
you potentially break the contract between qemu and the guest of always
passing down physical addresses.  If we explicitly change that contract
through using a flag that says you pass bus address everything is fine.

Note that in practice your scheme will probably just work for your
initial prototype, but chances are it will get us in trouble later on.
