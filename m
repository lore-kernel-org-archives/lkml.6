Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75221ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFE720852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFE720852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388375AbeGWQCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:02:54 -0400
Received: from 18.mo5.mail-out.ovh.net ([178.33.45.10]:35715 "EHLO
        18.mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387852AbeGWQCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:02:54 -0400
X-Greylist: delayed 2217 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Jul 2018 12:02:53 EDT
Received: from player755.ha.ovh.net (unknown [10.109.143.183])
        by mo5.mail-out.ovh.net (Postfix) with ESMTP id A6BAA1D1790
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 16:24:25 +0200 (CEST)
Received: from bahia (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player755.ha.ovh.net (Postfix) with ESMTPSA id 1D6A92600A2;
        Mon, 23 Jul 2018 16:24:15 +0200 (CEST)
Date:   Mon, 23 Jul 2018 16:24:14 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] 9p: Use a slab for allocating requests
Message-ID: <20180723162414.2c119be2@bahia>
In-Reply-To: <20180723122531.GA9773@nautica>
References: <20180711210225.19730-1-willy@infradead.org>
        <20180711210225.19730-6-willy@infradead.org>
        <20180718100554.GA21781@nautica>
        <20180723135220.08ec45bf@bahia>
        <20180723122531.GA9773@nautica>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 16508225909114902784
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtiedrjedvgdejgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2018 14:25:31 +0200
Dominique Martinet <asmadeus@codewreck.org> wrote:

> Greg Kurz wrote on Mon, Jul 23, 2018:
> > The patch is quite big and I'm not sure I can find time to review it
> > carefully, but I'll try to help anyway.  
> 
> No worry, thanks for this already.
> 
> > > Sorry for coming back to this patch now, I just noticed something that's
> > > actually probably a fairly big hit on performance...
> > > 
> > > While the slab is just as good as the array for the request itself, this
> > > makes every single request allocate "fcalls" everytime instead of
> > > reusing a cached allocation.
> > > The default msize is 8k and these allocs probably are fairly efficient,
> > > but some transports like RDMA allow to increase this to up to 1MB... And  
> > 
> > It can be even bigger with virtio:
> > 
> > #define VIRTQUEUE_NUM	128
> > 
> > 	.maxsize = PAGE_SIZE * (VIRTQUEUE_NUM - 3),
> > 
> > On a typical ppc64 server class setup with 64KB pages, this is nearly 8MB.  
> 
> I don't think I'll be able to test 64KB pages, and it's "just" 500k with
> 4K pages so I'll go with IB.
> I just finished reinstalling my IB-enabled VMs, now to get some iops
> test running (dbench maybe) and I'll get some figures to be able to play
> with different models and evaluate the impact of these.
> 

Sounds like a good plan.

> > > One thing is that the buffers are all going to be the same size for a
> > > given client (.... except virtio zc buffers, I wonder what I'm missing
> > > or why that didn't blow up before?)  
> > 
> > ZC allocates a 4KB buffer, which is more than enough to hold the 7-byte 9P
> > header and the "dqd" part of all messages that may use ZC, ie, 16 bytes.
> > So I'm not sure to catch what could blow up.  
> 
> ZC requests won't blow up, but from what I can see with the current
> (old) request cache array, if a ZC request has a not-yet used tag it'll
> allocate a new 4k buffer, then if a normal request uses that tag it'll
> get the 4k buffer instead of an msize sized one.
> 

Indeed.

> On the client size the request would be posted with req->rc->capacity
> which would correctly be 4k, but I'm not sure what would happen if qemu
> tries to write more than the given size to that request?
> 

QEMU would detect that the sg list doesn't have enough capacity.
Old QEMUs used to return a RERROR or RLERROR message with ENOBUFS
in this case. This didn't made sense to hijack the 9P protocol, which
is transport agnostic to report misconfigured buffers. Especially, in
the worst case, maybe we wouldn't even have enough space for the error
response... So, since QEMU 2.10, we put the virtio 9p device into
broken state instead, ie, inoperative until it gets reset.


I guess this situation was never hit because server responses mostly
need less than 4KB...

> > > It's a shame because I really like that patch, I'll try to find time to
> > > run some light benchmark with varying msizes eventually but I'm not sure
> > > when I'll find time for that... Hopefully before the 4.19 merge window!
> > >   
> > 
> > Yeah, the open-coded cache we have now really obfuscates things.
> > 
> > Maybe have a per-client kmem_cache object for non-ZC requests with
> > size msize [*], and a global kmem_cache object for ZC requests with
> > fixed size P9_ZC_HDR_SZ.
> > 
> > [*] the server can require a smaller msize during version negotiation,
> >     so maybe we should change the kmem_cache object in this case.  
> 
> Yeah, if we're going to want to accomodate non-power of two buffers, I
> think we'll need a separate kmem_cache for them.
> The ZC requests could be made into exactly 4k and these could come with
> regular kmalloc just fine, it looks like trying to create a cache of
> that size would just return the same cache used by kmalloc anyway so
> it's probably easier to fall back to kmalloc if requested alloc size
> doesn't match what we were hoping for.
> 

You're right, ZC requests could rely on kmalloc() directly.

> I'll try to get figures for various approaches before the merge window
> for 4.19 starts, it's getting closer though...
> 

Great thanks for your effort, but we've been leaving with this code
since the beginning. If this misses the 4.19 merge window, we'll have
more time to validate the approach and polish the fix for 4.20 :)

Cheers,

--
Greg
