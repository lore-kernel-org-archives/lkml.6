Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE24C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111D021734
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111D021734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388692AbeHGJDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:03:00 -0400
Received: from gate.crashing.org ([63.228.1.57]:38906 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727224AbeHGJDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:03:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w776i1Uj029530;
        Tue, 7 Aug 2018 01:44:02 -0500
Message-ID: <7622efcbb499919616f165266968565b1d329a91.camel@kernel.crashing.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
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
Date:   Tue, 07 Aug 2018 16:44:01 +1000
In-Reply-To: <20180807062731.GA23159@infradead.org>
References: <20180803220443-mutt-send-email-mst@kernel.org>
         <051fd78e15595b414839fa8f9d445b9f4d7576c6.camel@kernel.crashing.org>
         <20180805031046-mutt-send-email-mst@kernel.org>
         <fd8fee94cf42e436878f179c7895de3a4dab3355.camel@kernel.crashing.org>
         <20180806164106-mutt-send-email-mst@kernel.org>
         <ef6d5d7c7b812bd797a1c3fd6bc7a26d0074020f.camel@kernel.crashing.org>
         <20180806233024-mutt-send-email-mst@kernel.org>
         <0967fc30001323e6e38ed12c8dba8ee3d1aa13f5.camel@kernel.crashing.org>
         <20180807002857-mutt-send-email-mst@kernel.org>
         <93518075238a07e9f011774d89bdc652c083f1ba.camel@kernel.crashing.org>
         <20180807062731.GA23159@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-06 at 23:27 -0700, Christoph Hellwig wrote:
> On Tue, Aug 07, 2018 at 08:13:56AM +1000, Benjamin Herrenschmidt wrote:
> > It would be indeed ideal if all we had to do was setup some kind of
> > bus_dma_mask on all PCI devices and have virtio automagically insert
> > swiotlb when necessary.
> 
> For 4.20 I plan to remove the swiotlb ops and instead do the bounce
> buffering in the common code, including a direct call to the direct
> ops to avoid retpoline overhead.  For that you still need a flag
> in virtio that instead of blindly working physical addresses it needs
> to be treated like a real device in terms of DMA.

But you will still call the swiotlb infrastructure, right ? IE, I sitll
need to control where/how the swiotlb "pool" is allocated.
> 
> And for powerpc to make use of that I need to get the dma series I
> posted last week reviewed and included, otherwise powerpc will have
> to be excepted (like arm, where rmk didn't like the way the code
> was factored, everything else has already been taken care of).
> 
> https://lists.linuxfoundation.org/pipermail/iommu/2018-July/028989.html

Yes, I saw your series. I'm just back from a week of travel, I plan to
start reviewing it this week if Michael doesn't beat me to it.

Cheers,
Ben.


