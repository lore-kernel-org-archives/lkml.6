Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8791C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E0720877
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E0720877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732461AbeGJSSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:18:49 -0400
Received: from verein.lst.de ([213.95.11.211]:49076 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732298AbeGJSSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:18:48 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3DFDD68B97; Tue, 10 Jul 2018 20:04:33 +0200 (CEST)
Date:   Tue, 10 Jul 2018 20:04:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, robh+dt@kernel.org, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, joro@8bytes.org, x86@kernel.org
Subject: Re: [RFC PATCH 1/4] dma-mapping: Generalise dma_32bit_limit flag
Message-ID: <20180710180433.GB26285@lst.de>
References: <cover.1531239284.git.robin.murphy@arm.com> <a85a5fe22fced65b2960251fc6e8d8f1e68f828a.1531239284.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a85a5fe22fced65b2960251fc6e8d8f1e68f828a.1531239284.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 06:17:16PM +0100, Robin Murphy wrote:
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 8be8106270c2..95e185347e34 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -183,7 +183,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
>  	 * Various PCI/PCIe bridges have broken support for > 32bit DMA even
>  	 * if the device itself might support it.
>  	 */
> -	if (dev->dma_32bit_limit && mask > DMA_BIT_MASK(32))
> +	if (dev->bus_dma_mask && mask > dev->bus_dma_mask)
>  		return 0;

The comment above this check needs an updated (or just be removed).

Also we still have a few architectures not using dma-direct. I guess
most were doing fine without such limits anyway, but at least arm
will probably need an equivalent check.
