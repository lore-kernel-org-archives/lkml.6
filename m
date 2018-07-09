Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF6AC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B41208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzexXNFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B41208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933633AbeGIREK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:04:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933287AbeGIREI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:04:08 -0400
Received: from localhost (unknown [106.201.46.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08BEA208A2;
        Mon,  9 Jul 2018 17:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531155847;
        bh=FWVzE+ZhWgS1LzSatExJjSjS4NiclU90mwFI0yMlPF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AzexXNFjFQlUVcS9nREVhyu5mm2Qy8vc6/AI6y1j2JuKddFdXZGvMSJdLPPfLq6bH
         FR4G/VRmyTXnT8A9bdQsZ2010n3DmFVCpeo9lQga16jyZqIuGJJvTPu0Fd8O70VYKi
         9vDy4fwhH1bmeAFMRwDmlx0roSuSodwunD1tZMWE=
Date:   Mon, 9 Jul 2018 22:33:59 +0530
From:   Vinod <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 02/14] dmaengine: dma-jz4780: Separate chan/ctrl registers
Message-ID: <20180709170359.GI22377@vkoul-mobl>
References: <20180703123214.23090-1-paul@crapouillou.net>
 <20180703123214.23090-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703123214.23090-3-paul@crapouillou.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-07-18, 14:32, Paul Cercueil wrote:
> The register area of the JZ4780 DMA core can be split into different
> sections for different purposes:
> 
> * one set of registers is used to perform actions at the DMA core level,
> that will generally affect all channels;
> 
> * one set of registers per DMA channel, to perform actions at the DMA
> channel level, that will only affect the channel in question.
> 
> The problem rises when trying to support new versions of the JZ47xx
> Ingenic SoC. For instance, the JZ4770 has two DMA cores, each one
> with six DMA channels, and the register sets are interleaved:
> <DMA0 chan regs> <DMA1 chan regs> <DMA0 ctrl regs> <DMA1 ctrl regs>
> 
> By using one memory resource for the channel-specific registers and
> one memory resource for the core-specific registers, we can support
> the JZ4770, by initializing the driver once per DMA core with different
> addresses.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../devicetree/bindings/dma/jz4780-dma.txt    |   6 +-

Pls move to separate patch.

>  drivers/dma/dma-jz4780.c                      | 106 +++++++++++-------
>  2 files changed, 69 insertions(+), 43 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/jz4780-dma.txt b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
> index f25feee62b15..f9b1864f5b77 100644
> --- a/Documentation/devicetree/bindings/dma/jz4780-dma.txt
> +++ b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
> @@ -3,7 +3,8 @@
>  Required properties:
>  
>  - compatible: Should be "ingenic,jz4780-dma"
> -- reg: Should contain the DMA controller registers location and length.
> +- reg: Should contain the DMA channel registers location and length, followed
> +  by the DMA controller registers location and length.
>  - interrupts: Should contain the interrupt specifier of the DMA controller.
>  - interrupt-parent: Should be the phandle of the interrupt controller that
>  - clocks: Should contain a clock specifier for the JZ4780 PDMA clock.
> @@ -22,7 +23,8 @@ Example:
>  
>  dma: dma@13420000 {
>  	compatible = "ingenic,jz4780-dma";
> -	reg = <0x13420000 0x10000>;
> +	reg = <0x13420000 0x400
> +	       0x13421000 0x40>;

Second should be optional or we break platform which may not have
updated DT..

> -	jzdma->base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(jzdma->base))
> -		return PTR_ERR(jzdma->base);
> +	jzdma->chn_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(jzdma->chn_base))
> +		return PTR_ERR(jzdma->chn_base);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res) {
> +		dev_err(dev, "failed to get I/O memory\n");
> +		return -EINVAL;
> +	}

okay and this breaks if you happen to get probed on older DT. I think DT
is treated as ABI so you need to continue support older method while
finding if DT has split resources

-- 
~Vinod
