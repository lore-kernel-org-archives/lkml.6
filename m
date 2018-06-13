Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C2F1DC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77BC020020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77BC020020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935521AbeFMM1W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:27:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:45826 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935286AbeFMM1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:27:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5DCPUcS031471;
        Wed, 13 Jun 2018 07:25:32 -0500
Message-ID: <5dbcafa73b065bc619fd6adc9ef47eb6367b8378.camel@kernel.crashing.org>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ram Pai <linuxram@us.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, robh@kernel.org,
        pawel.moll@arm.com, Tom Lendacky <thomas.lendacky@amd.com>,
        aik@ozlabs.ru, jasowang@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, joe@perches.com,
        "Rustad, Mark D" <mark.d.rustad@intel.com>,
        david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org,
        elfring@users.sourceforge.net,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date:   Wed, 13 Jun 2018 22:25:30 +1000
In-Reply-To: <20180613074141.GA12033@infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-13 at 00:41 -0700, Christoph Hellwig wrote:
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

By direct ops I didn't mean *the* dma_direct_ops but a virtio-local
variants that effectively reproduces the existing expectations (ie,
virtio-dma-legacy-ops or something).

> I think the right way forward is to either add a new
> VIRTIO_F_IS_PCI_DEVICE (or redefine the existing iommu flag if deemed
> possible).  And then make sure recent qemu always sets it.

Ben.
