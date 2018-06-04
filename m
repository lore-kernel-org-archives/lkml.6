Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751993AbeFDJuY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:50:24 -0400
Received: from gate.crashing.org ([63.228.1.57]:47776 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751097AbeFDJuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:50:23 -0400
Message-ID: <d5df613d6347fe2f9bb6ea65bc6f6be05650ca6f.camel@kernel.crashing.org>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, jasowang@redhat.com, mpe@ellerman.id.au,
        hch@infradead.org
Date: Mon, 04 Jun 2018 19:48:54 +1000
In-Reply-To: <20180604085742.GQ4251@umbus>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
         <20180523213703-mutt-send-email-mst@kernel.org>
         <f77638ddef3af52dd71341083707c9e3745dd505.camel@kernel.crashing.org>
         <20180604085742.GQ4251@umbus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-04 at 18:57 +1000, David Gibson wrote:
> 
> > - First qemu doesn't know that the guest will switch to "secure mode"
> > in advance. There is no difference between a normal and a secure
> > partition until the partition does the magic UV call to "enter secure
> > mode" and qemu doesn't see any of it. So who can set the flag here ?
> 
> This seems weird to me.  As a rule HV calls should go through qemu -
> or be allowed to go directly to KVM *by* qemu.

It's not an HV call, it's a UV call, qemu won't see it, qemu isn't
trusted. Now the UV *will* reflect that to the HV via some synthetized
HV calls, and we *could* have those do a pass by qemu, however, so far,
our entire design doesn't rely on *any* qemu knowledge whatsoever and
it would be sad to add it just for that purpose.

Additionally, this is rather orthogonal, see my other email, the
problem we are trying to solve is *not* a qemu problem and it doesn't
make sense to leak that into qemu.

>   We generally reserve
> the latter for hot path things.  Since this isn't a hot path, having
> the call handled directly by the kernel seems wrong.
>
> Unless a "UV call" is something different I don't know about.

Yes, a UV call goes to the Ultravisor, not the Hypervisor. The
Hypervisor isn't trusted.

> > - Second, when using VIRTIO_F_IOMMU_PLATFORM, we also make qemu (or
> > vhost) go through the emulated MMIO for every access to the guest,
> > which adds additional overhead.
> 
Ben.
