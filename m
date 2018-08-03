Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1CCC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4517217A2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4517217A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732072AbeHCVFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 17:05:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729367AbeHCVFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 17:05:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA1D5401EF13;
        Fri,  3 Aug 2018 19:07:43 +0000 (UTC)
Received: from redhat.com (ovpn-117-153.ams2.redhat.com [10.36.117.153])
        by smtp.corp.redhat.com (Postfix) with SMTP id 943232026D65;
        Fri,  3 Aug 2018 19:07:36 +0000 (UTC)
Date:   Fri, 3 Aug 2018 22:07:35 +0300
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
Message-ID: <20180803220443-mutt-send-email-mst@kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 03 Aug 2018 19:07:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 03 Aug 2018 19:07:43 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 10:58:36AM -0500, Benjamin Herrenschmidt wrote:
> On Fri, 2018-08-03 at 00:05 -0700, Christoph Hellwig wrote:
> > >   2- Make virtio use the DMA API with our custom platform-provided
> > > swiotlb callbacks when needed, that is when not using IOMMU *and*
> > > running on a secure VM in our case.
> > 
> > And total NAK the customer platform-provided part of this.  We need
> > a flag passed in from the hypervisor that the device needs all bus
> > specific dma api treatment, and then just use the normal plaform
> > dma mapping setup. 
> 
> Christoph, as I have explained already, we do NOT have a way to provide
> such a flag as neither the hypervisor nor qemu knows anything about
> this when the VM is created.

I think the fact you can't add flags from the hypervisor is
a sign of a problematic architecture, you should look at
adding that down the road - you will likely need it at some point.

However in this specific case, the flag does not need to come from the
hypervisor, it can be set by arch boot code I think.
Christoph do you see a problem with that?

> >  To get swiotlb you'll need to then use the DT/ACPI
> > dma-range property to limit the addressable range, and a swiotlb
> > capable plaform will use swiotlb automatically.
> 
> This cannot be done as you describe it.
> 
> The VM is created as a *normal* VM. The DT stuff is generated by qemu
> at a point where it has *no idea* that the VM will later become secure
> and thus will have to restrict which pages can be used for "DMA".
> 
> The VM will *at runtime* turn itself into a secure VM via interactions
> with the security HW and the Ultravisor layer (which sits below the
> HV). This happens way after the DT has been created and consumed, the
> qemu devices instanciated etc...
> 
> Only the guest kernel knows because it initates the transition. When
> that happens, the virtio devices have already been used by the guest
> firmware, bootloader, possibly another kernel that kexeced the "secure"
> one, etc... 
> 
> So instead of running around saying NAK NAK NAK, please explain how we
> can solve that differently.
> 
> Ben.
> 
