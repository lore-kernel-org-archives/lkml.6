Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AC546C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D874208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fm5olaNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D874208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934610AbeFMHlw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:41:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47882 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754476AbeFMHlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oohRmM6XIpwCupB6S6+SVaE2yvOq+ENRUZwzW+aYdzI=; b=Fm5olaNB4WseSDN76h0KPd4ey
        OMa1qq7Wef/kJM7pMgld3a7URE+YER+MzAKgpp5GxXeUiFZ8++ro6Zb8UYsGyaoXDp8RDI6HeZu+Y
        XMIkAJqxp4i7Nmc27tzhGv2FN2IH1fzyHKnhDEJUUMxxR/qRX3rJtFC8wdZzcOjPrDQD7qWX2BKXa
        gb7MeCIkIa/wziAms6lKLqQ5M4QCIklvK2sjwheO5yEkEADHDB28sy3YTdUNMGr9XbtcVKX8dtLxc
        KuBX+UV2/eXEQOEXKAADGxOyVoFScS79vIcrrx73tR0syqb1qnq79hgjM0rFA4TotFNoIsy8e9qV6
        llHZHkI9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fT0PW-0006Yd-4h; Wed, 13 Jun 2018 07:41:42 +0000
Date:   Wed, 13 Jun 2018 00:41:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Ram Pai <linuxram@us.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>, robh@kernel.org,
        pawel.moll@arm.com, Tom Lendacky <thomas.lendacky@amd.com>,
        aik@ozlabs.ru, jasowang@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, joe@perches.com,
        "Rustad, Mark D" <mark.d.rustad@intel.com>,
        david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org,
        elfring@users.sourceforge.net,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
Message-ID: <20180613074141.GA12033@infradead.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <20180524072104.GD6139@ram.oc3035372033.ibm.com>
 <0c508eb2-08df-3f76-c260-90cf7137af80@linux.vnet.ibm.com>
 <20180531204320-mutt-send-email-mst@kernel.org>
 <20180607052306.GA1532@infradead.org>
 <20180607185234-mutt-send-email-mst@kernel.org>
 <20180611023909.GA5726@ram.oc3035372033.ibm.com>
 <07b804fccd7373c650be79ac9fa77ae7f2375ced.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07b804fccd7373c650be79ac9fa77ae7f2375ced.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 01:29:18PM +1000, Benjamin Herrenschmidt wrote:
> At the risk of repeating myself, let's just do the first pass which is
> to switch virtio over to always using the DMA API in the actual data
> flow code, with a hook at initialization time that replaces the DMA ops
> with some home cooked "direct" ops in the case where the IOMMU flag
> isn't set.
> 
> This will be equivalent to what we have today but avoids having 2
> separate code path all over the driver.
> 
> Then a second stage, I think, is to replace this "hook" so that the
> architecture gets a say in the matter.

I don't think we can actually use dma_direct_ops.  It still allows
architectures to override parts of the dma setup, which virtio seems
to blindly assume phys == dma and not cache flushing.

I think the right way forward is to either add a new
VIRTIO_F_IS_PCI_DEVICE (or redefine the existing iommu flag if deemed
possible).  And then make sure recent qemu always sets it.
