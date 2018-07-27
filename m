Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3DDC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EF020895
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92EF020895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbeG0K7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:59:01 -0400
Received: from foss.arm.com ([217.140.101.70]:39664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729431AbeG0K7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:59:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5093715A2;
        Fri, 27 Jul 2018 02:37:58 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1E7153F575;
        Fri, 27 Jul 2018 02:37:58 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 95D741AE17A0; Fri, 27 Jul 2018 10:37:58 +0100 (BST)
Date:   Fri, 27 Jul 2018 10:37:58 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LinuxArm <linuxarm@huawei.com>
Subject: Re: [PATCH v3 0/6] add non-strict mode support for arm-smmu-v3
Message-ID: <20180727093758.GL28088@arm.com>
References: <1531376312-2192-1-git-send-email-thunder.leizhen@huawei.com>
 <aace9ec9-a36a-79a8-98eb-bbedd06f11a4@arm.com>
 <5B594399.1080404@huawei.com>
 <f54dd9e0-6d4b-5daa-f6f6-be610393b487@arm.com>
 <5B5A8857.9040907@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B5A8857.9040907@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 10:49:59AM +0800, Leizhen (ThunderTown) wrote:
> On 2018/7/26 22:16, Robin Murphy wrote:
> > On 2018-07-26 4:44 AM, Leizhen (ThunderTown) wrote:
> >> Passthrough is not enough to support VFIO, and virtualization need
> >> the later.
> > 
> > Huh? The whole point of passthrough mode is that the IOMMU can still be
> > used for VFIO, but without imposing the overhead of dynamic mapping on
> > host DMA.
> 
> I said that from my experience. Userspace do not known the PA, so I think
> the user can not fill dma_map.iova correctly.
> 
> 	/* Allocate some space and setup a DMA mapping */
> 	dma_map.vaddr = (__u64)mmap(0, 0x1000, PROT_READ | PROT_WRITE,
> 			     MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> 	dma_map.size = 0x1000;
> 	dma_map.iova = 0x2f00000000UL;						/* user specified */
> 	dma_map.flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE;
> 
> 	ioctl(container, VFIO_IOMMU_MAP_DMA, &dma_map);

Hmm, I'm pretty sure that's not the case. When passthrough is configured
via iommu.passthrough, it only applies to the default domain and therefore
won't affect the unmanaged domain that VFIO manages explicitly. So VFIO
will continue to use translation and userspace can't pass whatever it likes
for the iova.

Will
