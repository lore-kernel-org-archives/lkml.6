Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE46FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BD220870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LWPRBwL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BD220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeG3Mwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 08:52:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54452 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbeG3Mwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 08:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=on+OyK3pSACmjq3MttzOOZBnePfNP7HOM896lfbN8AU=; b=LWPRBwL+V6GFmtug2JtUQo993
        vB/Hwlmy/su9gok7SgCJWfGtC7xQigx29nUFAXCblpvEyif60JImCZMVskBFmL44H7Bkgn56UIelp
        hluGjMGR/y9S2EE8OP2Dn/XxQE0QLfnXKRsiZFQth6pyZipnxDvsYFkweSGEpJL9nQyunoS6Ja+0N
        hxBb60Y63jUfNnJcVLiFDoCHJq4FY4nltCVKKJrJ6SsGJSPxP7OHJjTETPVdg2SRTLEyu2zIjYciM
        /YYo7120rOjtNDLuMf9kXAPzfv+AhTb2J4tmQIr2QnD4FTv1W6KEbIGZ8C6VLRvfmyN70VMUFhKkd
        OxTWJ7USw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fk6Be-0004kH-Es; Mon, 30 Jul 2018 11:18:02 +0000
Date:   Mon, 30 Jul 2018 04:18:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
        linuxram@us.ibm.com, haren@linux.vnet.ibm.com, paulus@samba.org,
        srikar@linux.vnet.ibm.com, robin.murphy@arm.com,
        jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180730111802.GA9830@infradead.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180727095804.GA25592@arm.com>
 <20180730093414.GD26245@infradead.org>
 <20180730125100-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730125100-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 01:28:03PM +0300, Michael S. Tsirkin wrote:
> Let me reply to the "crappy" part first:
> So virtio devices can run on another CPU or on a PCI bus. Configuration
> can happen over mupltiple transports.  There is a discovery protocol to
> figure out where it is. It has some warts but any real system has warts.
> 
> So IMHO virtio running on another CPU isn't "legacy virtual crappy
> virtio". virtio devices that actually sit on a PCI bus aren't "sane"
> simply because the DMA is more convoluted on some architectures.

All of what you said would be true if virtio didn't claim to be
a PCI device.  Once it claims to be a PCI device and we also see
real hardware written to the interface I stand to all what I said
above.

> With this out of my system:
> I agree these approaches are hacky. I think it is generally better to
> have virtio feature negotiation tell you whether device runs on a CPU or
> not rather than rely on platform specific ways for this. To this end
> there was a recent proposal to rename VIRTIO_F_IO_BARRIER to
> VIRTIO_F_REAL_DEVICE.  It got stuck since "real" sounds vague to people,
> e.g.  what if it's a VF - is that real or not? But I can see something
> like e.g. VIRTIO_F_PLATFORM_DMA gaining support.
> 
> We would then rename virtio_has_iommu_quirk to virtio_has_dma_quirk
> and test VIRTIO_F_PLATFORM_DMA in addition to the IOMMU thing.

I don't really care about the exact naming, and indeed a device that
sets the flag doesn't have to be a 'real' device - it just has to act
like one.  I explained all the issues that this means (at least relating
to DMA) in one of the previous threads.

The important bit is that we can specify exact behavior for both
devices that sets the "I'm real!" flag and that ones that don't exactly
in the spec.  And that very much excludes arch-specific (or
Xen-specific) overrides.
