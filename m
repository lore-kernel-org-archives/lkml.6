Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4052EC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC1C2150E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC1C2150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387529AbeHFWEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 18:04:13 -0400
Received: from gate.crashing.org ([63.228.1.57]:52721 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731258AbeHFWEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 18:04:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w76JqCAv002188;
        Mon, 6 Aug 2018 14:52:13 -0500
Message-ID: <6c707d6d33ac25a42265c2e9b521c2416d72c739.camel@kernel.crashing.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
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
Date:   Tue, 07 Aug 2018 05:52:12 +1000
In-Reply-To: <20180806094243.GA16032@infradead.org>
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
         <20180806094243.GA16032@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-06 at 02:42 -0700, Christoph Hellwig wrote:
> On Mon, Aug 06, 2018 at 07:16:47AM +1000, Benjamin Herrenschmidt wrote:
> > Who would set this bit ? qemu ? Under what circumstances ?
> 
> I don't really care who sets what.  The implementation might not even
> involved qemu.
> 
> It is your job to write a coherent interface specification that does
> not depend on the used components.  The hypervisor might be PAPR,
> Linux + qemu, VMware, Hyperv or something so secret that you'd have
> to shoot me if you had to tell me.  The guest might be Linux, FreeBSD,
> AIX, OS400 or a Hipster project of the day in Rust.  As long as we
> properly specify the interface it simplify does not matter.

That's the point Christoph. The interface is today's interface. It does
NOT change. That information is not part of the interface.

It's the VM itself that is stashing away its memory in a secret place,
and thus needs to do bounce buffering. There is no change to the virtio
interface per-se.

> > What would be the effect of this bit while VIRTIO_F_IOMMU is NOT set,
> > ie, what would qemu do and what would Linux do ? I'm not sure I fully
> > understand your idea.
> 
> In a perfect would we'd just reuse VIRTIO_F_IOMMU and clarify the
> description which currently is rather vague but basically captures
> the use case.  Currently is is:
> 
> VIRTIO_F_IOMMU_PLATFORM(33)
>     This feature indicates that the device is behind an IOMMU that
>     translates bus addresses from the device into physical addresses in
>     memory. If this feature bit is set to 0, then the device emits
>     physical addresses which are not translated further, even though an
>     IOMMU may be present.
> 
> And I'd change it to something like:
> 
> VIRTIO_F_PLATFORM_DMA(33)
>     This feature indicates that the device emits platform specific
>     bus addresses that might not be identical to physical address.
>     The translation of physical to bus address is platform speific
>     and defined by the plaform specification for the bus that the virtio
>     device is attached to.
>     If this feature bit is set to 0, then the device emits
>     physical addresses which are not translated further, even if
>     the platform would normally require translations for the bus that
>     the virtio device is attached to.
> 
> If we can't change the defintion any more we should deprecate the
> old VIRTIO_F_IOMMU_PLATFORM bit, and require the VIRTIO_F_IOMMU_PLATFORM
> and VIRTIO_F_PLATFORM_DMA to be not set at the same time.

But this doesn't really change our problem does it ?

None of what happens in our case is part of the "interface". The
suggestion to force the iommu ON was simply that it was a "workaround"
as by doing so, we get to override the DMA ops, but that's just a
trick.

Fundamentally, what we need to solve is pretty much entirely a guest
problem.

> > I'm trying to understand because the limitation is not a device side
> > limitation, it's not a qemu limitation, it's actually more of a VM
> > limitation. It has most of its memory pages made inaccessible for
> > security reasons. The platform from a qemu/KVM perspective is almost
> > entirely normal.
> 
> Well, find a way to describe this either in the qemu specification using
> new feature bits, or by using something like the above.

But again, why do you want to involve the interface, and thus the
hypervisor for something that is essentially what the guest is doign to
itself ?

It really is something we need to solve locally to the guest, it's not
part of the interface.

Cheers,
Ben.


