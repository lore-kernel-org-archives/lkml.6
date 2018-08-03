Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95D5C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823FD2172A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hHeZHMSx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823FD2172A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbeHCJAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:00:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55022 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbeHCJAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QFDPXfsNUSkr/U7nsDqhReqF93tITmzrfvB4raa6Fc4=; b=hHeZHMSxqkBhSYewy8zrYszVI
        Px6HFjtOhI6MbSRJvixsRY12wYXPh/hXp22Vq6EyCjZNJVrx3oevtDMRi6S1HlIKELi7E8KBE0gsC
        s+Lr1Rq4emnYur7B7bwEYv00w+1hoV8C/YML0jb4OrVXg8IPGEdSyWfnIwR2JNxH1tEiwh4ClWMv2
        Jk5lkECt+1Pk0O3YHO9wRfwTdhP1kyhgUTsoGUvFz3TPw7gbuoIERo976pdFh4GVdnNaCHUXcXD76
        Yztimd5rHQNx2CX8Z1KWFEkJ9FKYmv0NOosfpEUuG8AQfIxsc5WUX4O0QpuiMaJ6+0gcTyjjDOthu
        tw11n+D8g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flU95-0001RE-7y; Fri, 03 Aug 2018 07:05:07 +0000
Date:   Fri, 3 Aug 2018 00:05:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
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
Message-ID: <20180803070507.GA1344@infradead.org>
References: <3d6e81511571260de1c8047aaffa8ac4df093d2e.camel@kernel.crashing.org>
 <20180801081637.GA14438@arm.com>
 <20180801083639.GF26378@infradead.org>
 <26c1d3d50d8e081eed44fe9940fbefed34598cbd.camel@kernel.crashing.org>
 <20180802182959-mutt-send-email-mst@kernel.org>
 <82ccef6ec3d95ee43f3990a4a2d0aea87eb45e89.camel@kernel.crashing.org>
 <20180802200646-mutt-send-email-mst@kernel.org>
 <e9beb6bba5a7d05741e27e85b24a3b23ba7c2762.camel@kernel.crashing.org>
 <20180802225738-mutt-send-email-mst@kernel.org>
 <de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 04:13:09PM -0500, Benjamin Herrenschmidt wrote:
> So let's differenciate the two problems of having an IOMMU (real or
> emulated) which indeeds adds overhead etc... and using the DMA API.
> 
> At the moment, virtio does this all over the place:
> 
> 	if (use_dma_api)
> 		dma_map/alloc_something(...)
> 	else
> 		use_pa
> 
> The idea of the patch set is to do two, somewhat orthogonal, changes
> that together achieve what we want. Let me know where you think there
> is "a bunch of issues" because I'm missing it:
> 
>  1- Replace the above if/else constructs with just calling the DMA API,
> and have virtio, at initialization, hookup its own dma_ops that just
> "return pa" (roughly) when the IOMMU stuff isn't used.
> 
> This adds an indirect function call to the path that previously didn't
> have one (the else case above). Is that a significant/measurable
> overhead ?

If you call it often enough it does:

https://www.spinics.net/lists/netdev/msg495413.html

>  2- Make virtio use the DMA API with our custom platform-provided
> swiotlb callbacks when needed, that is when not using IOMMU *and*
> running on a secure VM in our case.

And total NAK the customer platform-provided part of this.  We need
a flag passed in from the hypervisor that the device needs all bus
specific dma api treatment, and then just use the normal plaform
dma mapping setup.  To get swiotlb you'll need to then use the DT/ACPI
dma-range property to limit the addressable range, and a swiotlb
capable plaform will use swiotlb automatically.
