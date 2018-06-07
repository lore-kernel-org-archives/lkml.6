Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id r5CoEDpdGVv1KAAAmS7hNA
	; Thu, 07 Jun 2018 16:28:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 574CA608B8; Thu,  7 Jun 2018 16:28:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BDE4D6074D;
	Thu,  7 Jun 2018 16:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BDE4D6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932601AbeFGQ2m (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:28:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932160AbeFGQ2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:28:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D6938401EF1B;
        Thu,  7 Jun 2018 16:28:38 +0000 (UTC)
Received: from redhat.com (ovpn-120-226.rdu2.redhat.com [10.10.120.226])
        by smtp.corp.redhat.com (Postfix) with SMTP id DE301213AF01;
        Thu,  7 Jun 2018 16:28:35 +0000 (UTC)
Date: Thu, 7 Jun 2018 19:28:35 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>, robh@kernel.org, aik@ozlabs.ru,
        jasowang@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, joe@perches.com,
        linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net,
        david@gibson.dropbear.id.au, cohuck@redhat.com, pawel.moll@arm.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Rustad, Mark D" <mark.d.rustad@intel.com>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
Message-ID: <20180607185234-mutt-send-email-mst@kernel.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <20180524072104.GD6139@ram.oc3035372033.ibm.com>
 <0c508eb2-08df-3f76-c260-90cf7137af80@linux.vnet.ibm.com>
 <20180531204320-mutt-send-email-mst@kernel.org>
 <20180607052306.GA1532@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607052306.GA1532@infradead.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 07 Jun 2018 16:28:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 07 Jun 2018 16:28:38 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 10:23:06PM -0700, Christoph Hellwig wrote:
> On Thu, May 31, 2018 at 08:43:58PM +0300, Michael S. Tsirkin wrote:
> > Pls work on a long term solution. Short term needs can be served by
> > enabling the iommu platform in qemu.
> 
> So, I spent some time looking at converting virtio to dma ops overrides,
> and the current virtio spec, and the sad through I have to tell is that
> both the spec and the Linux implementation are complete and utterly fucked
> up.

Let me restate it: DMA API has support for a wide range of hardware, and
hardware based virtio implementations likely won't benefit from all of
it.

And given virtio right now is optimized for specific workloads, improving
portability without regressing performance isn't easy.

I think it's unsurprising since it started a strictly a guest/host
mechanism.  People did implement offloads on specific platforms though,
and they are known to work. To improve portability even further,
we might need to make spec and code changes.

I'm not really sympathetic to people complaining that they can't even
set a flag in qemu though. If that's the case the stack in question is
way too inflexible.



> Both in the flag naming and the implementation there is an implication
> of DMA API == IOMMU, which is fundamentally wrong.

Maybe we need to extend the meaning of PLATFORM_IOMMU or rename it.

It's possible that some setups will benefit from a more
fine-grained approach where some aspects of the DMA
API are bypassed, others aren't.

This seems to be what was being asked for in this thread,
with comments claiming IOMMU flag adds too much overhead.


> The DMA API does a few different things:
> 
>  a) address translation
> 
> 	This does include IOMMUs.  But it also includes random offsets
> 	between PCI bars and system memory that we see on various
> 	platforms.

I don't think you mean bars. That's unrelated to DMA.

>  Worse so some of these offsets might be based on
> 	banks, e.g. on the broadcom bmips platform.  It also deals
> 	with bitmask in physical addresses related to memory encryption
> 	like AMD SEV.  I'd be really curious how for example the
> 	Intel virtio based NIC is going to work on any of those
> 	plaforms.

SEV guys report that they just set the iommu flag and then it all works.
I guess if there's translation we can think of this as a kind of iommu.
Maybe we should rename PLATFORM_IOMMU to PLARTFORM_TRANSLATION?

And apparently some people complain that just setting that flag makes
qemu check translation on each access with an unacceptable performance
overhead.  Forcing same behaviour for everyone on general principles
even without the flag is unlikely to make them happy.

>   b) coherency
> 
> 	On many architectures DMA is not cache coherent, and we need
> 	to invalidate and/or write back cache lines before doing
> 	DMA.  Again, I wonder how this is every going to work with
> 	hardware based virtio implementations.


You mean dma_Xmb and friends?
There's a new feature VIRTIO_F_IO_BARRIER that's being proposed
for that.


>  Even worse I think this
> 	is actually broken at least for VIVT event for virtualized
> 	implementations.  E.g. a KVM guest is going to access memory
> 	using different virtual addresses than qemu, vhost might throw
> 	in another different address space.

I don't really know what VIVT is. Could you help me please?

>   c) bounce buffering
> 
> 	Many DMA implementations can not address all physical memory
> 	due to addressing limitations.  In such cases we copy the
> 	DMA memory into a known addressable bounc buffer and DMA
> 	from there.

Don't do it then?


>   d) flushing write combining buffers or similar
> 
> 	On some hardware platforms we need workarounds to e.g. read
> 	from a certain mmio address to make sure DMA can actually
> 	see memory written by the host.

I guess it isn't an issue as long as WC isn't actually used.
It will become an issue when virtio spec adds some WC capability -
I suspect we can ignore this for now.

> 
> All of this is bypassed by virtio by default despite generally being
> platform issues, not particular to a given device.

It's both a device and a platform issue. A PV device is often more like
another CPU than like a PCI device.



-- 
MST
