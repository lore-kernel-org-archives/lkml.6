Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B5FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A11120841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A11120841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbeGaWTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:19:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:33652 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbeGaWTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:19:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w6VKaMZd023397;
        Tue, 31 Jul 2018 15:36:23 -0500
Message-ID: <3d6e81511571260de1c8047aaffa8ac4df093d2e.camel@kernel.crashing.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, mpe@ellerman.id.au, linuxram@us.ibm.com,
        haren@linux.vnet.ibm.com, paulus@samba.org,
        srikar@linux.vnet.ibm.com, robin.murphy@arm.com,
        jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Date:   Tue, 31 Jul 2018 15:36:22 -0500
In-Reply-To: <20180731173052.GA17153@infradead.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
         <20180727095804.GA25592@arm.com> <20180730093414.GD26245@infradead.org>
         <20180730125100-mutt-send-email-mst@kernel.org>
         <20180730111802.GA9830@infradead.org>
         <20180730155633-mutt-send-email-mst@kernel.org>
         <20180731173052.GA17153@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-31 at 10:30 -0700, Christoph Hellwig wrote:
> > However the question people raise is that DMA API is already full of
> > arch-specific tricks the likes of which are outlined in your post linked
> > above. How is this one much worse?
> 
> None of these warts is visible to the driver, they are all handled in
> the architecture (possibly on a per-bus basis).
> 
> So for virtio we really need to decide if it has one set of behavior
> as specified in the virtio spec, or if it behaves exactly as if it
> was on a PCI bus, or in fact probably both as you lined up.  But no
> magic arch specific behavior inbetween.

The only arch specific behaviour is needed in the case where it doesn't
behave like PCI. In this case, the PCI DMA ops are not suitable, but in
our secure VMs, we still need to make it use swiotlb in order to bounce
through non-secure pages.

It would be nice if "real PCI" was the default but it's not, VMs are
created in "legacy" mode all the times and we don't know at VM creation
time whether it will become a secure VM or not. The way our secure VMs
work is that they start as a normal VM, load a secure "payload" and
call the Ultravisor to "become" secure.

So we're in a bit of a bind here. We need that one-liner optional arch
hook to make virtio use swiotlb in that "IOMMU bypass" case.

Ben.

