Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663EEC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20913219F1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ORv4zRuH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20913219F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeHFLvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:51:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57644 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbeHFLvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EgQtvh47saY414Iw87zIkUIINH3oaR52STBodGpR46I=; b=ORv4zRuHAqpS0ppQrvzQKuvmF
        ZMqVqxCRRA+Kfw9oqpZCMTTmsgvZ6HmiGvumRU4zGEiZKOBVrUW/IgYycGu43ns6DB1HjKu3+LZrl
        bNXMrtWG+KN197xqhaM34gu/2vQOSUvghnX3wJzDK5fU5cfuxxdXtNIL9QXxgwMPHBNMolqUbgZHD
        LQW8xzzORVNHE6aRQUocNMrVeVwtsiiCgpowaBogZiNm/8u0xlC8eyfjPME3WIB1pVyf6nP6Rj6Aw
        XUNngUOZe1EhjvFS6aegPQ2Uf4oLzFng4wKolr2KK95QxoVwr7HH0liWeAT6py/3rV5XplyvjkfIR
        nbfpGY6sw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmc2G-0008R2-0s; Mon, 06 Aug 2018 09:42:44 +0000
Date:   Mon, 6 Aug 2018 02:42:43 -0700
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
Message-ID: <20180806094243.GA16032@infradead.org>
References: <20180802225738-mutt-send-email-mst@kernel.org>
 <de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
 <20180803070507.GA1344@infradead.org>
 <eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
 <20180803160246.GA13794@infradead.org>
 <22310f58605169fe9de83abf78b59f593ff7fbb7.camel@kernel.crashing.org>
 <20180804082120.GB4421@infradead.org>
 <a3ec0a454928e880dabc3782ea906e318634abf9.camel@kernel.crashing.org>
 <20180805072930.GB23288@infradead.org>
 <b7e8294e3e70d24072883a7e8e5375719d5af870.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7e8294e3e70d24072883a7e8e5375719d5af870.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 07:16:47AM +1000, Benjamin Herrenschmidt wrote:
> Who would set this bit ? qemu ? Under what circumstances ?

I don't really care who sets what.  The implementation might not even
involved qemu.

It is your job to write a coherent interface specification that does
not depend on the used components.  The hypervisor might be PAPR,
Linux + qemu, VMware, Hyperv or something so secret that you'd have
to shoot me if you had to tell me.  The guest might be Linux, FreeBSD,
AIX, OS400 or a Hipster project of the day in Rust.  As long as we
properly specify the interface it simplify does not matter.

> What would be the effect of this bit while VIRTIO_F_IOMMU is NOT set,
> ie, what would qemu do and what would Linux do ? I'm not sure I fully
> understand your idea.

In a perfect would we'd just reuse VIRTIO_F_IOMMU and clarify the
description which currently is rather vague but basically captures
the use case.  Currently is is:

VIRTIO_F_IOMMU_PLATFORM(33)
    This feature indicates that the device is behind an IOMMU that
    translates bus addresses from the device into physical addresses in
    memory. If this feature bit is set to 0, then the device emits
    physical addresses which are not translated further, even though an
    IOMMU may be present.

And I'd change it to something like:

VIRTIO_F_PLATFORM_DMA(33)
    This feature indicates that the device emits platform specific
    bus addresses that might not be identical to physical address.
    The translation of physical to bus address is platform speific
    and defined by the plaform specification for the bus that the virtio
    device is attached to.
    If this feature bit is set to 0, then the device emits
    physical addresses which are not translated further, even if
    the platform would normally require translations for the bus that
    the virtio device is attached to.

If we can't change the defintion any more we should deprecate the
old VIRTIO_F_IOMMU_PLATFORM bit, and require the VIRTIO_F_IOMMU_PLATFORM
and VIRTIO_F_PLATFORM_DMA to be not set at the same time.

> I'm trying to understand because the limitation is not a device side
> limitation, it's not a qemu limitation, it's actually more of a VM
> limitation. It has most of its memory pages made inaccessible for
> security reasons. The platform from a qemu/KVM perspective is almost
> entirely normal.

Well, find a way to describe this either in the qemu specification using
new feature bits, or by using something like the above.
