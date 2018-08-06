Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E50EC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72CF21A5B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72CF21A5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388353AbeHFWqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 18:46:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730055AbeHFWqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 18:46:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3E84C40214E2;
        Mon,  6 Aug 2018 20:35:47 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.7])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2F3762026DE8;
        Mon,  6 Aug 2018 20:35:39 +0000 (UTC)
Date:   Mon, 6 Aug 2018 23:35:39 +0300
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
Message-ID: <20180806233024-mutt-send-email-mst@kernel.org>
References: <20180802225738-mutt-send-email-mst@kernel.org>
 <de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
 <20180803070507.GA1344@infradead.org>
 <eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
 <20180803220443-mutt-send-email-mst@kernel.org>
 <051fd78e15595b414839fa8f9d445b9f4d7576c6.camel@kernel.crashing.org>
 <20180805031046-mutt-send-email-mst@kernel.org>
 <fd8fee94cf42e436878f179c7895de3a4dab3355.camel@kernel.crashing.org>
 <20180806164106-mutt-send-email-mst@kernel.org>
 <ef6d5d7c7b812bd797a1c3fd6bc7a26d0074020f.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef6d5d7c7b812bd797a1c3fd6bc7a26d0074020f.camel@kernel.crashing.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 06 Aug 2018 20:35:47 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 06 Aug 2018 20:35:47 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 05:56:59AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2018-08-06 at 16:46 +0300, Michael S. Tsirkin wrote:
> > 
> > > Right, we'll need some quirk to disable balloons  in the guest I
> > > suppose.
> > > 
> > > Passing something from libvirt is cumbersome because the end user may
> > > not even need to know about secure VMs. There are use cases where the
> > > security is a contract down to some special application running inside
> > > the secure VM, the sysadmin knows nothing about.
> > > 
> > > Also there's repercussions all the way to admin tools, web UIs etc...
> > > so it's fairly wide ranging.
> > > 
> > > So as long as we only need to quirk a couple of devices, it's much
> > > better contained that way.
> > 
> > So just the balloon thing already means that yes management and all the
> > way to the user tools must know this is going on. Otherwise
> > user will try to inflate the balloon and wonder why this does not work.
> 
> There is *dozens* of management systems out there, not even all open
> source, we won't ever be able to see the end of the tunnel if we need
> to teach every single of them, including end users, about platform
> specific new VM flags like that.
> 
> .../...

In the end I suspect you will find you have to.

> > Here's another example: you can't migrate a secure vm to hypervisor
> > which doesn't support this feature. Again management tools above libvirt
> > need to know otherwise they will try.
> 
> There will have to be a new machine type for that I suppose, yes,
> though it's not just the hypervisor that needs to know about the
> modified migration stream, it's also the need to have a compatible
> ultravisor with the right keys on the other side.
> 
> So migration is going to be special and require extra admin work in all
> cases yes. But not all secure VMs are meant to be migratable.
> 
> In any case, back to the problem at hand. What a qemu flag gives us is
> just a way to force iommu at VM creation time.

I don't think a qemu flag is strictly required for a problem at hand.

> This is rather sub-optimal, we don't really want the iommu in the way,
> so it's at best a "workaround", and it's not really solving the real
> problem.

This specific problem, I think I agree.

> As I said replying to Christoph, we are "leaking" into the interface
> something here that is really what's the VM is doing to itself, which
> is to stash its memory away in an inaccessible place.
> 
> Cheers,
> Ben.

I think Christoph merely objects to the specific implementation.  If
instead you do something like tweak dev->bus_dma_mask for the virtio
device I think he won't object.

-- 
MST
