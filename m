Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DED0C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED98B20877
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED98B20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732475AbeGJSSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:18:49 -0400
Received: from verein.lst.de ([213.95.11.211]:49077 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732443AbeGJSSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:18:48 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8913D6FB7B; Tue, 10 Jul 2018 20:02:32 +0200 (CEST)
Date:   Tue, 10 Jul 2018 20:02:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, robh+dt@kernel.org, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, joro@8bytes.org, x86@kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH 0/4] Stop losing firmware-set DMA masks
Message-ID: <20180710180232.GA26285@lst.de>
References: <cover.1531239284.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1531239284.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> These patches attempt to deal with this in the simplest way possible by
> generalising the specific quirk for 32-bit bridges into an arbitrary
> mask which can then also be plumbed into the firmware code. In the
> interest of being minimally invasive, I've only included a point fix
> for the IOMMU issue as seen on arm64 - there may be further tweaks
> needed in DMA ops to catch all possible incarnations of this problem,
> but this initial RFC is mostly about the impact beyond the dma-mapping
> subsystem itself.

Thanks, this looks very nice to me.

In fact it probably solves the RISC-V/Xiling problem as well if we can
just add the dma-ranges property to the device tree for the affected
systems.  Palmer, do you know how easily the DT could be updated for
that case?

> 
> Robin.
> 
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/580804.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-December/474443.html
> 
> Robin Murphy (4):
>   dma-mapping: Generalise dma_32bit_limit flag
>   ACPI/IORT: Set bus DMA mask as appropriate
>   of/device: Set bus DMA mask as appropriate
>   iommu/dma: Respect bus DMA limit for IOVAs
> 
>  arch/x86/kernel/pci-dma.c | 2 +-
>  drivers/acpi/arm64/iort.c | 1 +
>  drivers/iommu/dma-iommu.c | 3 +++
>  drivers/of/device.c       | 1 +
>  include/linux/device.h    | 6 +++---
>  kernel/dma/direct.c       | 2 +-
>  6 files changed, 10 insertions(+), 5 deletions(-)
> 
> -- 
> 2.17.1.dirty
---end quoted text---
