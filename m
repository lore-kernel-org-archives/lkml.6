Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A2199C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62818208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62818208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935794AbeFMODH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:03:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935348AbeFMODG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:03:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B9E7401EF08;
        Wed, 13 Jun 2018 14:03:05 +0000 (UTC)
Received: from redhat.com (ovpn-122-133.rdu2.redhat.com [10.10.122.133])
        by smtp.corp.redhat.com (Postfix) with SMTP id 314791C65F;
        Wed, 13 Jun 2018 14:03:04 +0000 (UTC)
Date:   Wed, 13 Jun 2018 17:03:03 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Ram Pai <linuxram@us.ibm.com>,
        Christoph Hellwig <hch@infradead.org>, robh@kernel.org,
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
Message-ID: <20180613170050-mutt-send-email-mst@kernel.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <20180524072104.GD6139@ram.oc3035372033.ibm.com>
 <0c508eb2-08df-3f76-c260-90cf7137af80@linux.vnet.ibm.com>
 <20180531204320-mutt-send-email-mst@kernel.org>
 <20180607052306.GA1532@infradead.org>
 <20180607185234-mutt-send-email-mst@kernel.org>
 <20180611023909.GA5726@ram.oc3035372033.ibm.com>
 <07b804fccd7373c650be79ac9fa77ae7f2375ced.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07b804fccd7373c650be79ac9fa77ae7f2375ced.camel@kernel.crashing.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 13 Jun 2018 14:03:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 13 Jun 2018 14:03:05 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 01:29:18PM +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2018-06-10 at 19:39 -0700, Ram Pai wrote:
> > 
> > However if the administrator
> > ignores/forgets/deliberatey-decides/is-constrained to NOT enable the
> > flag, virtio will not be able to pass control to the DMA ops associated
> > with the virtio devices. Which means, we have no opportunity to share
> > the I/O buffers with the hypervisor/qemu.
> > 
> > How do you suggest, we handle this case?
> 
> At the risk of repeating myself, let's just do the first pass which is
> to switch virtio over to always using the DMA API in the actual data
> flow code, with a hook at initialization time that replaces the DMA ops
> with some home cooked "direct" ops in the case where the IOMMU flag
> isn't set.

I'm not sure I understand all of the details, will have to
see the patch, but superficially it sounds good to me.

> This will be equivalent to what we have today but avoids having 2
> separate code path all over the driver.
> 
> Then a second stage, I think, is to replace this "hook" so that the
> architecture gets a say in the matter.
> 
> Basically, something like:
> 
> 	arch_virtio_update_dma_ops(pci_dev, qemu_direct_mode).
> 
> IE, virtio would tell the arch whether the "other side" is in fact QEMU
> in a mode that bypasses the IOMMU and is cache coherent with the guest.
> This is our legacy "qemu special" mode. If the performance is
> sufficient we may want to deprecate it over time and have qemu enable
> the iommu by default but we still need it.
> 
> A weak implementation of the above will be provied that just puts in
> the direct ops when qemu_direct_mode is set, and thus provides today's
> behaviour on any arch that doesn't override it. If the flag is not set,
> the ops are left to whatever the arch PCI layer already set.
> 
> This will provide the opportunity for architectures that want to do
> something special, such as in our case, when we want to force even the
> "qemu_direct_mode" to go via bounce buffers, to put our own ops in
> there, while retaining the legacy behaviour otherwise.
> 
> It also means that the "gunk" is entirely localized in that one
> function, the rest of virtio just uses the DMA API normally.
> 
> Christoph, are you actually hacking "stage 1" above already or should
> we produce patches ?
> 
> Cheers,
> Ben.

