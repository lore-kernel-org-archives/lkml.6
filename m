Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B386CC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9B225E73
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9B225E73
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754973AbeF0QhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:37:14 -0400
Received: from foss.arm.com ([217.140.101.70]:34280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753490AbeF0QhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:37:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A12B218A;
        Wed, 27 Jun 2018 09:37:12 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 72F3A3F318;
        Wed, 27 Jun 2018 09:37:12 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 5C8701AE3692; Wed, 27 Jun 2018 17:37:50 +0100 (BST)
Date:   Wed, 27 Jun 2018 17:37:50 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        pdaly@codeaurora.org
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Add support to use Last level cache
Message-ID: <20180627163749.GA8729@arm.com>
References: <20180615105329.26800-1-vivek.gautam@codeaurora.org>
 <20180615165232.GE2202@arm.com>
 <CAFp+6iFm29ufb2Pr7Gb-2O_aN3GQLH4rcyWhbQGZ3QiwCC8vPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFp+6iFm29ufb2Pr7Gb-2O_aN3GQLH4rcyWhbQGZ3QiwCC8vPg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

On Tue, Jun 19, 2018 at 02:04:44PM +0530, Vivek Gautam wrote:
> On Fri, Jun 15, 2018 at 10:22 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Fri, Jun 15, 2018 at 04:23:29PM +0530, Vivek Gautam wrote:
> >> Qualcomm SoCs have an additional level of cache called as
> >> System cache or Last level cache[1]. This cache sits right
> >> before the DDR, and is tightly coupled with the memory
> >> controller.
> >> The cache is available to all the clients present in the
> >> SoC system. The clients request their slices from this system
> >> cache, make it active, and can then start using it. For these
> >> clients with smmu, to start using the system cache for
> >> dma buffers and related page tables [2], few of the memory
> >> attributes need to be set accordingly.
> >> This change makes the related memory Outer-Shareable, and
> >> updates the MAIR with necessary protection.
> >>
> >> The MAIR attribute requirements are:
> >>     Inner Cacheablity = 0
> >>     Outer Cacheablity = 1, Write-Back Write Allocate
> >>     Outer Shareablity = 1
> >
> > Hmm, so is this cache coherent with the CPU or not?
> 
> Thanks for reviewing.
> Yes, this LLC is cache coherent with CPU, so we mark for Outer-cacheable.
> The different masters such as GPU as able to allocated and activate a slice
> in this Last Level Cache.

What I mean is, for example, if the CPU writes some data using Normal, Inner
Shareable, Inner/Outer Cacheable, Inner/Outer Write-back, Non-transient
Read/Write-allocate and a device reads that data using your MAIR encoding
above, is the device guaranteed to see the CPU writes after the CPU has
executed a DSB instruction?

I don't think so, because the ARM ARM would say that there's a mismatch on
the Inner Cacheability attribute.

> > Why don't normal
> > non-cacheable mappings allocated in the LLC by default?
> 
> Sorry, I couldn't fully understand your question here.
> Few of the masters on qcom socs are not io-coherent, so for them
> the IC has to be marked as 0.

By IC you mean Inner Cacheability? In your MAIR encoding above, it is zero
so I don't understand the problem. What goes wrong if non-coherent devices
use your MAIR encoding for their DMA buffers?

> But they are able to use the LLC with OC marked as 1.

The issue here is that whatever attributes we put in the SMMU need to align
with the attributes used by the CPU in order to avoid introducing mismatched
aliases. Currently, we support three types of mapping in the SMMU:

1. DMA non-coherent (e.g. "dma-coherent" is not set on the device)
	Normal, Inner Shareable, Inner/Outer Non-Cacheable

2. DMA coherent (e.g. "dma-coherent" is set on the device) [IOMMU_CACHE]
	Normal, Inner Shareable, Inner/Outer Cacheable, Inner/Outer
	Write-back, Non-transient Read/Write-allocate

3. MMIO (e.g. MSI doorbell) [IOMMU_MMIO]
	Device-nGnRE (Outer Shareable)

So either you override one of these types (I was suggesting (1)) or you need
to create a new memory type, along with the infrastructure for it to be
recognised on a per-device basis and used by the DMA API so that we don't
get mismatched aliases on the CPU.

Will
