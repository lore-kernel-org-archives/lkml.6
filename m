Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886C5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B82A206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B82A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731707AbeGTOFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:05:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730996AbeGTOFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:05:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C1714070497;
        Fri, 20 Jul 2018 13:17:03 +0000 (UTC)
Received: from redhat.com (ovpn-121-184.rdu2.redhat.com [10.10.121.184])
        by smtp.corp.redhat.com (Postfix) with SMTP id 64B092156700;
        Fri, 20 Jul 2018 13:16:59 +0000 (UTC)
Date:   Fri, 20 Jul 2018 16:16:57 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
        hch@infradead.org, linuxram@us.ibm.com, haren@linux.vnet.ibm.com,
        paulus@samba.org, srikar@linux.vnet.ibm.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180720161541-mutt-send-email-mst@kernel.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 20 Jul 2018 13:17:03 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 20 Jul 2018 13:17:03 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 09:29:37AM +0530, Anshuman Khandual wrote:
> This patch series is the follow up on the discussions we had before about
> the RFC titled [RFC,V2] virtio: Add platform specific DMA API translation
> for virito devices (https://patchwork.kernel.org/patch/10417371/). There
> were suggestions about doing away with two different paths of transactions
> with the host/QEMU, first being the direct GPA and the other being the DMA
> API based translations.
> 
> First patch attempts to create a direct GPA mapping based DMA operations
> structure called 'virtio_direct_dma_ops' with exact same implementation
> of the direct GPA path which virtio core currently has but just wrapped in
> a DMA API format. Virtio core must use 'virtio_direct_dma_ops' instead of
> the arch default in absence of VIRTIO_F_IOMMU_PLATFORM flag to preserve the
> existing semantics. The second patch does exactly that inside the function
> virtio_finalize_features(). The third patch removes the default direct GPA
> path from virtio core forcing it to use DMA API callbacks for all devices.
> Now with that change, every device must have a DMA operations structure
> associated with it. The fourth patch adds an additional hook which gives
> the platform an opportunity to do yet another override if required. This
> platform hook can be used on POWER Ultravisor based protected guests to
> load up SWIOTLB DMA callbacks to do the required (as discussed previously
> in the above mentioned thread how host is allowed to access only parts of
> the guest GPA range) bounce buffering into the shared memory for all I/O
> scatter gather buffers to be consumed on the host side.
> 
> Please go through these patches and review whether this approach broadly
> makes sense. I will appreciate suggestions, inputs, comments regarding
> the patches or the approach in general. Thank you.

I like how patches 1-3 look. Could you test performance
with/without to see whether the extra indirection through
use of DMA ops causes a measurable slow-down?

> Anshuman Khandual (4):
>   virtio: Define virtio_direct_dma_ops structure
>   virtio: Override device's DMA OPS with virtio_direct_dma_ops selectively
>   virtio: Force virtio core to use DMA API callbacks for all virtio devices
>   virtio: Add platform specific DMA API translation for virito devices
> 
>  arch/powerpc/include/asm/dma-mapping.h |  6 +++
>  arch/powerpc/platforms/pseries/iommu.c |  6 +++
>  drivers/virtio/virtio.c                | 72 ++++++++++++++++++++++++++++++++++
>  drivers/virtio/virtio_pci_common.h     |  3 ++
>  drivers/virtio/virtio_ring.c           | 65 +-----------------------------
>  5 files changed, 89 insertions(+), 63 deletions(-)
> 
> -- 
> 2.9.3
