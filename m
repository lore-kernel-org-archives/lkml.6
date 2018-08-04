Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7740CC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 02:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296F921774
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 02:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296F921774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbeHDELe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 00:11:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:47361 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725722AbeHDELe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 00:11:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w741BGPi022662;
        Fri, 3 Aug 2018 20:11:17 -0500
Message-ID: <ba086ad15679fd59758fb74096c46fcce42dc974.camel@kernel.crashing.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
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
Date:   Fri, 03 Aug 2018 20:11:16 -0500
In-Reply-To: <20180803220443-mutt-send-email-mst@kernel.org>
References: <20180801083639.GF26378@infradead.org>
         <26c1d3d50d8e081eed44fe9940fbefed34598cbd.camel@kernel.crashing.org>
         <20180802182959-mutt-send-email-mst@kernel.org>
         <82ccef6ec3d95ee43f3990a4a2d0aea87eb45e89.camel@kernel.crashing.org>
         <20180802200646-mutt-send-email-mst@kernel.org>
         <e9beb6bba5a7d05741e27e85b24a3b23ba7c2762.camel@kernel.crashing.org>
         <20180802225738-mutt-send-email-mst@kernel.org>
         <de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
         <20180803070507.GA1344@infradead.org>
         <eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
         <20180803220443-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-03 at 22:07 +0300, Michael S. Tsirkin wrote:
> On Fri, Aug 03, 2018 at 10:58:36AM -0500, Benjamin Herrenschmidt wrote:
> > On Fri, 2018-08-03 at 00:05 -0700, Christoph Hellwig wrote:
> > > >   2- Make virtio use the DMA API with our custom platform-provided
> > > > swiotlb callbacks when needed, that is when not using IOMMU *and*
> > > > running on a secure VM in our case.
> > > 
> > > And total NAK the customer platform-provided part of this.  We need
> > > a flag passed in from the hypervisor that the device needs all bus
> > > specific dma api treatment, and then just use the normal plaform
> > > dma mapping setup. 
> > 
> > Christoph, as I have explained already, we do NOT have a way to provide
> > such a flag as neither the hypervisor nor qemu knows anything about
> > this when the VM is created.
> 
> I think the fact you can't add flags from the hypervisor is
> a sign of a problematic architecture, you should look at
> adding that down the road - you will likely need it at some point.

Well, we can later in the boot process. At VM creation time, it's just
a normal VM. The VM firmware, bootloader etc... are just operating
normally etc...

Later on, (we may have even already run Linux at that point,
unsecurely, as we can use Linux as a bootloader under some
circumstances), we start a "secure image".

This is a kernel zImage that includes a "ticket" that has the
appropriate signature etc... so that when that kernel starts, it can
authenticate with the ultravisor, be verified (along with its ramdisk)
etc... and copied (by the UV) into secure memory & run from there.

At that point, the hypervisor is informed that the VM has become
secure.

So at that point, we could exit to qemu to inform it of the change, and
have it walk the qtree and "Switch" all the virtio devices to use the
IOMMU I suppose, but it feels a lot grosser to me.

That's the only other option I can think of.

> However in this specific case, the flag does not need to come from the
> hypervisor, it can be set by arch boot code I think.
> Christoph do you see a problem with that?

The above could do that yes. Another approach would be to do it from a
small virtio "quirk" that pokes a bit in the device to force it to
iommu mode when it detects that we are running in a secure VM. That's a
bit warty on the virito side but probably not as much as having a qemu
one that walks of the virtio devices to change how they behave.

What do you reckon ?

Cheers,
Ben.

> > >  To get swiotlb you'll need to then use the DT/ACPI
> > > dma-range property to limit the addressable range, and a swiotlb
> > > capable plaform will use swiotlb automatically.
> > 
> > This cannot be done as you describe it.
> > 
> > The VM is created as a *normal* VM. The DT stuff is generated by qemu
> > at a point where it has *no idea* that the VM will later become secure
> > and thus will have to restrict which pages can be used for "DMA".
> > 
> > The VM will *at runtime* turn itself into a secure VM via interactions
> > with the security HW and the Ultravisor layer (which sits below the
> > HV). This happens way after the DT has been created and consumed, the
> > qemu devices instanciated etc...
> > 
> > Only the guest kernel knows because it initates the transition. When
> > that happens, the virtio devices have already been used by the guest
> > firmware, bootloader, possibly another kernel that kexeced the "secure"
> > one, etc... 
> > 
> > So instead of running around saying NAK NAK NAK, please explain how we
> > can solve that differently.
> > 
> > Ben.
> > 

