Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DC8FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8239320893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8239320893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeG3MCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 08:02:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726809AbeG3MCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 08:02:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E697E402316D;
        Mon, 30 Jul 2018 10:28:09 +0000 (UTC)
Received: from redhat.com (ovpn-117-50.ams2.redhat.com [10.36.117.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3B52510F1C0B;
        Mon, 30 Jul 2018 10:28:04 +0000 (UTC)
Date:   Mon, 30 Jul 2018 13:28:03 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>,
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
Message-ID: <20180730125100-mutt-send-email-mst@kernel.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180727095804.GA25592@arm.com>
 <20180730093414.GD26245@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730093414.GD26245@infradead.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 30 Jul 2018 10:28:10 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 30 Jul 2018 10:28:10 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 02:34:14AM -0700, Christoph Hellwig wrote:
> We really need to distinguish between legacy virtual crappy
> virtio (and that includes v1) that totally ignores the bus it pretends
> to be on, and sane virtio (to be defined) that sit on a real (or
> properly emulated including iommu and details for dma mapping) bus.

Let me reply to the "crappy" part first:
So virtio devices can run on another CPU or on a PCI bus. Configuration
can happen over mupltiple transports.  There is a discovery protocol to
figure out where it is. It has some warts but any real system has warts.

So IMHO virtio running on another CPU isn't "legacy virtual crappy
virtio". virtio devices that actually sit on a PCI bus aren't "sane"
simply because the DMA is more convoluted on some architectures.

Performance impact of the optimizations possible when you know
your "device" is in fact just another CPU has been measured,
it is real, so we aren't interested in adding all that overhead back
just so we can use DMA API. The "correct then fast" mantra doesn't
apply to something that is as widely deployed as virtio.

And I can accept an argument that maybe the DMA API isn't designed to
support such virtual DMA. Whether it should I don't know.

With this out of my system:
I agree these approaches are hacky. I think it is generally better to
have virtio feature negotiation tell you whether device runs on a CPU or
not rather than rely on platform specific ways for this. To this end
there was a recent proposal to rename VIRTIO_F_IO_BARRIER to
VIRTIO_F_REAL_DEVICE.  It got stuck since "real" sounds vague to people,
e.g.  what if it's a VF - is that real or not? But I can see something
like e.g. VIRTIO_F_PLATFORM_DMA gaining support.

We would then rename virtio_has_iommu_quirk to virtio_has_dma_quirk
and test VIRTIO_F_PLATFORM_DMA in addition to the IOMMU thing.

-- 
MST
