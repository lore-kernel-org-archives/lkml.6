Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0650C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A9F2089B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y03W5gBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A9F2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933574AbeGIQ74 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:59:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933274AbeGIQ7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:59:54 -0400
Received: from localhost (unknown [106.201.46.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 313D420883;
        Mon,  9 Jul 2018 16:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531155593;
        bh=x33olNrU2w/2rVY14c1ksA7c+T26jGkdIJl2PQPrtr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y03W5gBVMOqylqr50pg8kdezTzO8SvcuQ3rlWKkJUnOhBR7odr8B/VlW3i3JX0I72
         0NAx3nqeDSU7eL+SeX4Rg7lbs/Si323kdlI67KjaZ7acwus87sPnhArwPmlaP08zHw
         1QqObgRrO9Pp/KmJlAmLYiOw2mE15pwCz8VmUKVQ=
Date:   Mon, 9 Jul 2018 22:29:45 +0530
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
Subject: Re: [PATCH 01/14] dmaengine: dma-jz4780: Avoid hardcoding number of
 channels
Message-ID: <20180709165945.GH22377@vkoul-mobl>
References: <20180703123214.23090-1-paul@crapouillou.net>
 <20180703123214.23090-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703123214.23090-2-paul@crapouillou.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-07-18, 14:32, Paul Cercueil wrote:

>  struct jz4780_dma_dev {
>  	struct dma_device dma_device;
>  	void __iomem *base;
>  	struct clk *clk;
>  	unsigned int irq;
> +	unsigned int nb_channels;
> +	enum jz_version version;
>  
>  	uint32_t chan_reserved;
> -	struct jz4780_dma_chan chan[JZ_DMA_NR_CHANNELS];
> +	struct jz4780_dma_chan chan[];

why array, why not channel pointer?

> +static const unsigned int jz4780_dma_nb_channels[] = {
> +	[ID_JZ4780] = 32,
> +};
> +
> +static const struct of_device_id jz4780_dma_dt_match[] = {
> +	{ .compatible = "ingenic,jz4780-dma", .data = (void *)ID_JZ4780 },
> +	{},
> +};

Looking at description I was hoping that channels would be in DT,
channels is hardware information, so should come from DT rather than
coding the kernel...

> -	jzdma = devm_kzalloc(dev, sizeof(*jzdma), GFP_KERNEL);
> +	if (of_id)
> +		version = (enum jz_version)of_id->data;
> +	else
> +		version = ID_JZ4780; /* Default when not probed from DT */

where else would it be probed from.... ?
-- 
~Vinod
