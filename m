Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7947C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733EA21A12
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 733EA21A12
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbeHGBgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:36:10 -0400
Received: from gate.crashing.org ([63.228.1.57]:56567 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730444AbeHGBgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:36:09 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w76NIiUI013364;
        Mon, 6 Aug 2018 18:18:45 -0500
Message-ID: <8e985b8117407b256e2dd8f1c0a5c2e560ef03d7.camel@kernel.crashing.org>
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
Date:   Tue, 07 Aug 2018 09:18:44 +1000
In-Reply-To: <20180806233024-mutt-send-email-mst@kernel.org>
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
         <20180806233024-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-06 at 23:35 +0300, Michael S. Tsirkin wrote:
> On Tue, Aug 07, 2018 at 05:56:59AM +1000, Benjamin Herrenschmidt wrote:
> > On Mon, 2018-08-06 at 16:46 +0300, Michael S. Tsirkin wrote:
> > > 
> > > > Right, we'll need some quirk to disable balloons  in the guest I
> > > > suppose.
> > > > 
> > > > Passing something from libvirt is cumbersome because the end user may
> > > > not even need to know about secure VMs. There are use cases where the
> > > > security is a contract down to some special application running inside
> > > > the secure VM, the sysadmin knows nothing about.
> > > > 
> > > > Also there's repercussions all the way to admin tools, web UIs etc...
> > > > so it's fairly wide ranging.
> > > > 
> > > > So as long as we only need to quirk a couple of devices, it's much
> > > > better contained that way.
> > > 
> > > So just the balloon thing already means that yes management and all the
> > > way to the user tools must know this is going on. Otherwise
> > > user will try to inflate the balloon and wonder why this does not work.
> > 
> > There is *dozens* of management systems out there, not even all open
> > source, we won't ever be able to see the end of the tunnel if we need
> > to teach every single of them, including end users, about platform
> > specific new VM flags like that.
> > 
> > .../...
> 
> In the end I suspect you will find you have to.

Maybe... we'll tackle this if/when we have to.

For balloon I suspect it's not such a big deal because once secure, all
the guest memory goes into the secure memory which isn't visible or
accounted by the hypervisor, so there's nothing to steal but the guest
is also using no HV memory (other than the few "non-secure" pages used
for swiotlb and a couple of other kernel things).

Future versions of our secure architecture might allow to turn
arbitrary pages of memory secure/non-secure rather than relying on a
separate physical pool, in which case, the balloon will be able to work
normally.

Cheers,
Ben.


