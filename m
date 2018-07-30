Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEF713F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3662020870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3662020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbeG3PBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:01:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726570AbeG3PBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:01:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D2C24219DBF;
        Mon, 30 Jul 2018 13:26:39 +0000 (UTC)
Received: from redhat.com (ovpn-117-43.ams2.redhat.com [10.36.117.43])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4886E2142F20;
        Mon, 30 Jul 2018 13:26:33 +0000 (UTC)
Date:   Mon, 30 Jul 2018 16:26:32 +0300
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
Message-ID: <20180730155633-mutt-send-email-mst@kernel.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180727095804.GA25592@arm.com>
 <20180730093414.GD26245@infradead.org>
 <20180730125100-mutt-send-email-mst@kernel.org>
 <20180730111802.GA9830@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730111802.GA9830@infradead.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 30 Jul 2018 13:26:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 30 Jul 2018 13:26:39 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 04:18:02AM -0700, Christoph Hellwig wrote:
> On Mon, Jul 30, 2018 at 01:28:03PM +0300, Michael S. Tsirkin wrote:
> > Let me reply to the "crappy" part first:
> > So virtio devices can run on another CPU or on a PCI bus. Configuration
> > can happen over mupltiple transports.  There is a discovery protocol to
> > figure out where it is. It has some warts but any real system has warts.
> > 
> > So IMHO virtio running on another CPU isn't "legacy virtual crappy
> > virtio". virtio devices that actually sit on a PCI bus aren't "sane"
> > simply because the DMA is more convoluted on some architectures.
> 
> All of what you said would be true if virtio didn't claim to be
> a PCI device.  

There's nothing virtio claims to be.  It's a PV device that uses PCI for
its configuration.  Configuration is enumerated on the virtual PCI bus.
That part of the interface is emulated PCI. Data path is through a
PV device enumerated on the virtio bus.

> Once it claims to be a PCI device and we also see
> real hardware written to the interface I stand to all what I said
> above.

Real hardware would reuse parts of the interface but by necessity it
needs to behave slightly differently on some platforms.  However for
some platforms (such as x86) a PV virtio driver will by luck work with a
PCI device backend without changes. As these platforms and drivers are
widely deployed, some people will deploy hardware like that.  Should be
a non issue as by definition it's transparent to guests.

> > With this out of my system:
> > I agree these approaches are hacky. I think it is generally better to
> > have virtio feature negotiation tell you whether device runs on a CPU or
> > not rather than rely on platform specific ways for this. To this end
> > there was a recent proposal to rename VIRTIO_F_IO_BARRIER to
> > VIRTIO_F_REAL_DEVICE.  It got stuck since "real" sounds vague to people,
> > e.g.  what if it's a VF - is that real or not? But I can see something
> > like e.g. VIRTIO_F_PLATFORM_DMA gaining support.
> > 
> > We would then rename virtio_has_iommu_quirk to virtio_has_dma_quirk
> > and test VIRTIO_F_PLATFORM_DMA in addition to the IOMMU thing.
> 
> I don't really care about the exact naming, and indeed a device that
> sets the flag doesn't have to be a 'real' device - it just has to act
> like one.  I explained all the issues that this means (at least relating
> to DMA) in one of the previous threads.

I believe you refer to this:
https://lkml.org/lkml/2018/6/7/15
that was a very helpful list outlining the problems we need to solve,
thanks a lot for that!

> The important bit is that we can specify exact behavior for both
> devices that sets the "I'm real!" flag and that ones that don't exactly
> in the spec.

I would very much like that, yes.

> And that very much excludes arch-specific (or
> Xen-specific) overrides.

We already committed to a xen specific hack but generally I prefer
devices that describe how they work instead of platforms magically
guessing, yes.

However the question people raise is that DMA API is already full of
arch-specific tricks the likes of which are outlined in your post linked
above. How is this one much worse?

-- 
MST
