Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A0BC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7724E20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfBDVid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:38:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbfBDVid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 16:38:33 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 143A2A0902;
        Mon,  4 Feb 2019 21:38:32 +0000 (UTC)
Received: from redhat.com (ovpn-116-138.sin2.redhat.com [10.67.116.138])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3FAD81048103;
        Mon,  4 Feb 2019 21:38:23 +0000 (UTC)
Date:   Mon, 4 Feb 2019 16:38:21 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190204152416-mutt-send-email-mst@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
 <87womn8inf.fsf@morokweng.localdomain>
 <20190129134750-mutt-send-email-mst@kernel.org>
 <6c68f7f7-1b28-6eba-9b8b-2c32efac9701@redhat.com>
 <20190129213137-mutt-send-email-mst@kernel.org>
 <20190130074427.GA29516@lst.de>
 <875ztzxvw2.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875ztzxvw2.fsf@morokweng.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 04 Feb 2019 21:38:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 04:15:41PM -0200, Thiago Jung Bauermann wrote:
> 
> Christoph Hellwig <hch@lst.de> writes:
> 
> > On Tue, Jan 29, 2019 at 09:36:08PM -0500, Michael S. Tsirkin wrote:
> >> This has been discussed ad nauseum. virtio is all about compatibility.
> >> Losing a couple of lines of code isn't worth breaking working setups.
> >> People that want "just use DMA API no tricks" now have the option.
> >> Setting a flag in a feature bit map is literally a single line
> >> of code in the hypervisor. So stop pushing for breaking working
> >> legacy setups and just fix it in the right place.
> >
> > I agree with the legacy aspect.  What I am missing is an extremely
> > strong wording that says you SHOULD always set this flag for new
> > hosts, including an explanation why.
> 
> My understanding of ACCESS_PLATFORM is that it means "this device will
> behave in all aspects like a regular device attached to this bus".


Not really. Look it up in the spec:

VIRTIO_F_ACCESS_PLATFORM(33) This feature indicates that the device can be used on a platform
	where device access to data in memory is limited and/or translated. E.g. this is the case if the device
	can be located behind an IOMMU that translates bus addresses from the device into physical addresses
	in memory, if the device can be limited to only access certain memory addresses or if special commands
	such as a cache flush can be needed to synchronise data in memory with the device. Whether accesses
	are actually limited or translated is described by platform-specific means. If this feature bit is set to 0,
	then the device has same access to memory addresses supplied to it as the driver has. In particular, the
	device will always use physical addresses matching addresses used by the driver (typically meaning
	physical addresses used by the CPU) and not translated further, and can access any address supplied
	to it by the driver. When clear, this overrides any platform-specific description of whether device access
	is limited or translated in any way, e.g. whether an IOMMU may be present.



> Is
> that it? Therefore it should be set because it's the sane thing to do?

It's the sane thing to do unless you want the very specific thing that
having it clear means, which is just have it be another CPU.

It was designed to make, when set, as many guests as we can work
correctly, and it seems to be successful in doing exactly that.

Unfortunately there could be legacy guests that do work correctly but
become slow. Whether trying to somehow work around that
can paint us into a corner where things again don't
work for some people is a question worth discussing.


> --
> Thiago Jung Bauermann
> IBM Linux Technology Center
