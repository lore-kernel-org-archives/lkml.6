Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id XyEtO9HsHVv4MAAAmS7hNA
	; Mon, 11 Jun 2018 03:30:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4FC2D60792; Mon, 11 Jun 2018 03:30:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D7F31604D4;
	Mon, 11 Jun 2018 03:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D7F31604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932612AbeFKDao (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 23:30:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:47585 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932328AbeFKDam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 23:30:42 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5B3TIbr013800;
        Sun, 10 Jun 2018 22:29:20 -0500
Message-ID: <07b804fccd7373c650be79ac9fa77ae7f2375ced.camel@kernel.crashing.org>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ram Pai <linuxram@us.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, robh@kernel.org,
        pawel.moll@arm.com, Tom Lendacky <thomas.lendacky@amd.com>,
        aik@ozlabs.ru, jasowang@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, joe@perches.com,
        "Rustad, Mark D" <mark.d.rustad@intel.com>,
        david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org,
        elfring@users.sourceforge.net,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Mon, 11 Jun 2018 13:29:18 +1000
In-Reply-To: <20180611023909.GA5726@ram.oc3035372033.ibm.com>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
         <20180523213703-mutt-send-email-mst@kernel.org>
         <20180524072104.GD6139@ram.oc3035372033.ibm.com>
         <0c508eb2-08df-3f76-c260-90cf7137af80@linux.vnet.ibm.com>
         <20180531204320-mutt-send-email-mst@kernel.org>
         <20180607052306.GA1532@infradead.org>
         <20180607185234-mutt-send-email-mst@kernel.org>
         <20180611023909.GA5726@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-06-10 at 19:39 -0700, Ram Pai wrote:
> 
> However if the administrator
> ignores/forgets/deliberatey-decides/is-constrained to NOT enable the
> flag, virtio will not be able to pass control to the DMA ops associated
> with the virtio devices. Which means, we have no opportunity to share
> the I/O buffers with the hypervisor/qemu.
> 
> How do you suggest, we handle this case?

At the risk of repeating myself, let's just do the first pass which is
to switch virtio over to always using the DMA API in the actual data
flow code, with a hook at initialization time that replaces the DMA ops
with some home cooked "direct" ops in the case where the IOMMU flag
isn't set.

This will be equivalent to what we have today but avoids having 2
separate code path all over the driver.

Then a second stage, I think, is to replace this "hook" so that the
architecture gets a say in the matter.

Basically, something like:

	arch_virtio_update_dma_ops(pci_dev, qemu_direct_mode).

IE, virtio would tell the arch whether the "other side" is in fact QEMU
in a mode that bypasses the IOMMU and is cache coherent with the guest.
This is our legacy "qemu special" mode. If the performance is
sufficient we may want to deprecate it over time and have qemu enable
the iommu by default but we still need it.

A weak implementation of the above will be provied that just puts in
the direct ops when qemu_direct_mode is set, and thus provides today's
behaviour on any arch that doesn't override it. If the flag is not set,
the ops are left to whatever the arch PCI layer already set.

This will provide the opportunity for architectures that want to do
something special, such as in our case, when we want to force even the
"qemu_direct_mode" to go via bounce buffers, to put our own ops in
there, while retaining the legacy behaviour otherwise.

It also means that the "gunk" is entirely localized in that one
function, the rest of virtio just uses the DMA API normally.

Christoph, are you actually hacking "stage 1" above already or should
we produce patches ?

Cheers,
Ben.
