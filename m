Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F14D2C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B058C208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B058C208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935754AbeFMN7r (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:59:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39730 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934436AbeFMN7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:59:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A88F0818BAED;
        Wed, 13 Jun 2018 13:59:43 +0000 (UTC)
Received: from redhat.com (ovpn-122-133.rdu2.redhat.com [10.10.122.133])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2869F2166BB2;
        Wed, 13 Jun 2018 13:59:42 +0000 (UTC)
Date:   Wed, 13 Jun 2018 16:59:41 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ram Pai <linuxram@us.ibm.com>, robh@kernel.org,
        pawel.moll@arm.com, Tom Lendacky <thomas.lendacky@amd.com>,
        aik@ozlabs.ru, jasowang@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, joe@perches.com,
        "Rustad, Mark D" <mark.d.rustad@intel.com>,
        david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org,
        elfring@users.sourceforge.net,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
Message-ID: <20180613164500-mutt-send-email-mst@kernel.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <20180524072104.GD6139@ram.oc3035372033.ibm.com>
 <0c508eb2-08df-3f76-c260-90cf7137af80@linux.vnet.ibm.com>
 <20180531204320-mutt-send-email-mst@kernel.org>
 <20180607052306.GA1532@infradead.org>
 <20180607185234-mutt-send-email-mst@kernel.org>
 <20180611023909.GA5726@ram.oc3035372033.ibm.com>
 <07b804fccd7373c650be79ac9fa77ae7f2375ced.camel@kernel.crashing.org>
 <20180613074141.GA12033@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613074141.GA12033@infradead.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 13 Jun 2018 13:59:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 13 Jun 2018 13:59:43 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 12:41:41AM -0700, Christoph Hellwig wrote:
> On Mon, Jun 11, 2018 at 01:29:18PM +1000, Benjamin Herrenschmidt wrote:
> > At the risk of repeating myself, let's just do the first pass which is
> > to switch virtio over to always using the DMA API in the actual data
> > flow code, with a hook at initialization time that replaces the DMA ops
> > with some home cooked "direct" ops in the case where the IOMMU flag
> > isn't set.
> > 
> > This will be equivalent to what we have today but avoids having 2
> > separate code path all over the driver.
> > 
> > Then a second stage, I think, is to replace this "hook" so that the
> > architecture gets a say in the matter.
> 
> I don't think we can actually use dma_direct_ops.  It still allows
> architectures to override parts of the dma setup, which virtio seems
> to blindly assume phys == dma and not cache flushing.
> 
> I think the right way forward is to either add a new
> VIRTIO_F_IS_PCI_DEVICE (or redefine the existing iommu flag if deemed
> possible).

Given this is exactly what happens now, this seems possible, but maybe
we want a non-PCI specific name.

>  And then make sure recent qemu always sets it.

I don't think that part is going to happen, sorry.

Hypervisors can set it when they *actually have* a real PCI device.
People emulate systems which have a bunch of overhead in the DMA API
which is required for real DMA. Your proposal would double that overhead
by first doing it in guest then re-doing it in host.

I don't think it's justified when 99% of the world doesn't need it.
-- 
MST
