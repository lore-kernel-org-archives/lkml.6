Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE41C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1EE208B2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1EE208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387450AbeHAXoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:44:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60362 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725956AbeHAXoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:44:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A60084219DA9;
        Wed,  1 Aug 2018 21:56:18 +0000 (UTC)
Received: from redhat.com (ovpn-121-8.rdu2.redhat.com [10.10.121.8])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8E8E02142F20;
        Wed,  1 Aug 2018 21:56:14 +0000 (UTC)
Date:   Thu, 2 Aug 2018 00:56:13 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
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
Message-ID: <20180802003823-mutt-send-email-mst@kernel.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180727095804.GA25592@arm.com>
 <20180730093414.GD26245@infradead.org>
 <20180730125100-mutt-send-email-mst@kernel.org>
 <20180730111802.GA9830@infradead.org>
 <20180730155633-mutt-send-email-mst@kernel.org>
 <20180731173052.GA17153@infradead.org>
 <3d6e81511571260de1c8047aaffa8ac4df093d2e.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d6e81511571260de1c8047aaffa8ac4df093d2e.camel@kernel.crashing.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 01 Aug 2018 21:56:18 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 01 Aug 2018 21:56:18 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 03:36:22PM -0500, Benjamin Herrenschmidt wrote:
> On Tue, 2018-07-31 at 10:30 -0700, Christoph Hellwig wrote:
> > > However the question people raise is that DMA API is already full of
> > > arch-specific tricks the likes of which are outlined in your post linked
> > > above. How is this one much worse?
> > 
> > None of these warts is visible to the driver, they are all handled in
> > the architecture (possibly on a per-bus basis).
> > 
> > So for virtio we really need to decide if it has one set of behavior
> > as specified in the virtio spec, or if it behaves exactly as if it
> > was on a PCI bus, or in fact probably both as you lined up.  But no
> > magic arch specific behavior inbetween.
> 
> The only arch specific behaviour is needed in the case where it doesn't
> behave like PCI. In this case, the PCI DMA ops are not suitable, but in
> our secure VMs, we still need to make it use swiotlb in order to bounce
> through non-secure pages.
> 
> It would be nice if "real PCI" was the default

I think you are mixing "real PCI" which isn't coded up yet and IOMMU
bypass which is. IOMMU bypass will maybe with time become unnecessary
since it seems that one can just program an IOMMU in a bypass mode
instead.

It's hard to blame you since right now if you disable IOMMU bypass
you get a real PCI mode. But they are distinct and to allow people
to enable IOMMU by default we will need to teach someone
(virtio or DMA API) about this mode that does follow
translation and protection rules in the IOMMU but runs
on a CPU and so does not need cache flushes and whatnot.

OTOH real PCI mode as opposed to default hypervisor mode does not perform as
well when what you actually have is a hypervisor.

So we'll likely have a mix of these two modes for a while.

> but it's not, VMs are
> created in "legacy" mode all the times and we don't know at VM creation
> time whether it will become a secure VM or not. The way our secure VMs
> work is that they start as a normal VM, load a secure "payload" and
> call the Ultravisor to "become" secure.
> 
> So we're in a bit of a bind here. We need that one-liner optional arch
> hook to make virtio use swiotlb in that "IOMMU bypass" case.
> 
> Ben.

And just to make sure I understand, on your platform DMA APIs do include
some of the cache flushing tricks and this is why you don't want to
declare iommu support in the hypervisor?

-- 
MST
