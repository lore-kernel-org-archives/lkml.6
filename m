Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2389C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 08:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D96B20835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 08:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D96B20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbeJNPxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 11:53:50 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53629 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeJNPxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 11:53:50 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gBbWl-0000BJ-Tg; Sun, 14 Oct 2018 10:13:32 +0200
Date:   Sun, 14 Oct 2018 10:13:31 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christoph Hellwig <hch@lst.de>
cc:     x86@kernel.org, tedheadster@gmail.com, konrad.wilk@oracle.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: enable swiotlb for > 4GiG ram on 32-bit kernels
In-Reply-To: <20181014075208.2715-1-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1810141012510.1438@nanos.tec.linutronix.de>
References: <20181014075208.2715-1-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Oct 2018, Christoph Hellwig wrote:

> We already build the swiotlb code for 32b-t kernels with PAE support,
> but the code to actually use swiotlb has only been enabled for 64-bit
> kernel for an unknown reason.
> 
> Before Linux 4.18 we papers over this fact because the networking code,
> the scsi layer and some random block drivers implenented their own
> bounce buffering scheme.
> 
> Fixes: 21e07dba ("scsi: reduce use of block bounce buffers")
> Fixes: ab74cfeb ("net: remove the PCI_DMA_BUS_IS_PHYS check in illegal_highdma")
> Reported-by: tedheadster <tedheadster@gmail.com>
> Tested-by: tedheadster <tedheadster@gmail.com>

I'll add your SOB when picking this up :)

> ---
>  arch/x86/kernel/pci-swiotlb.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
> index 661583662430..71c0b01d93b1 100644
> --- a/arch/x86/kernel/pci-swiotlb.c
> +++ b/arch/x86/kernel/pci-swiotlb.c
> @@ -42,10 +42,8 @@ IOMMU_INIT_FINISH(pci_swiotlb_detect_override,
>  int __init pci_swiotlb_detect_4gb(void)
>  {
>  	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
> -#ifdef CONFIG_X86_64
>  	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN)
>  		swiotlb = 1;
> -#endif
>  
>  	/*
>  	 * If SME is active then swiotlb will be set to 1 so that bounce
> -- 
> 2.19.1
> 
> 
