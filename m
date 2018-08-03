Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA237C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 18:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95323217A2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 18:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95323217A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbeHCU50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 16:57:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:53125 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727532AbeHCU50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 16:57:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w73Iwk4A008560;
        Fri, 3 Aug 2018 13:58:47 -0500
Message-ID: <22310f58605169fe9de83abf78b59f593ff7fbb7.camel@kernel.crashing.org>
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
Date:   Fri, 03 Aug 2018 13:58:46 -0500
In-Reply-To: <20180803160246.GA13794@infradead.org>
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
         <20180803160246.GA13794@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-03 at 09:02 -0700, Christoph Hellwig wrote:
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
> Well, if your setup is so fucked up I see no way to support it in Linux.
> 
> Let's end the discussion right now then.

You are saying something along the lines of "I don't like an
instruction in your ISA, let's not support your entire CPU architecture
in Linux".

Our setup is not fucked. It makes a LOT of sense and it's a very
sensible design. It's hitting a problem due to a corner case oddity in
virtio bypassing the MMU, we've worked around such corner cases many
times in the past without any problem, I fail to see what the problem
is here.

We aren't going to cancel years of HW and SW development for our
security infrastructure bcs you don't like a 2 lines hook into virtio
to make things work and aren't willing to even consider the options.

Ben.
 

