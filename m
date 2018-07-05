Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7D0C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AEF24098
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="OdWsqM4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99AEF24098
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753975AbeGESYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:24:06 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:49708 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753769AbeGESYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:24:04 -0400
Date:   Thu, 05 Jul 2018 20:23:41 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 02/14] dmaengine: dma-jz4780: Separate chan/ctrl registers
To:     Paul Burton <paul.burton@mips.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Message-Id: <1530815021.6642.0@smtp.crapouillou.net>
In-Reply-To: <20180703165302.3gdukxwwro5cwqba@pburton-laptop>
References: <20180703123214.23090-1-paul@crapouillou.net>
        <20180703123214.23090-3-paul@crapouillou.net>
        <20180703165302.3gdukxwwro5cwqba@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530815041; bh=GkJ0v/PlN6KmOdXHOdu7cXcDaWHEpMnzgLnjo6vl3lI=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type; b=OdWsqM4UQ/YOVatGIHcfpJ3OL21gi0eytzFYs2F+8EwCDjjwslS43wNo2ItxDEZBoUENn+96tXJp1ZyUORkrTQFHwA1jHbQaFiSgTnLioYqPUsQpCc7AwA5NdB+3jvKQQOq5moBUeglvFCEee25Dia8Wz7teqw+GmdTkOp36g+8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

> Hi Paul,
> 
> On Tue, Jul 03, 2018 at 02:32:02PM +0200, Paul Cercueil wrote:
>>  @@ -804,9 +818,19 @@ static int jz4780_dma_probe(struct 
>> platform_device *pdev)
>>   		return -EINVAL;
>>   	}
>> 
>>  -	jzdma->base = devm_ioremap_resource(dev, res);
>>  -	if (IS_ERR(jzdma->base))
>>  -		return PTR_ERR(jzdma->base);
>>  +	jzdma->chn_base = devm_ioremap_resource(dev, res);
>>  +	if (IS_ERR(jzdma->chn_base))
>>  +		return PTR_ERR(jzdma->chn_base);
>>  +
>>  +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>  +	if (!res) {
>>  +		dev_err(dev, "failed to get I/O memory\n");
>>  +		return -EINVAL;
>>  +	}
>>  +
>>  +	jzdma->ctrl_base = devm_ioremap_resource(dev, res);
>>  +	if (IS_ERR(jzdma->ctrl_base))
>>  +		return PTR_ERR(jzdma->ctrl_base);
> 
> Could we have this failure case fall back to the existing behaviour
> where we only have a single resource covering all the registers? That
> would avoid breaking bisection between this patch & the one that 
> updates
> the JZ4780 DT.
> 
> For example:
> 
> 	#define JZ4780_DMA_CTRL_OFFSET	0x1000
> 
> 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> 	if (res) {
> 		jzdma->ctrl_base = devm_ioremap_resource(dev, res);
> 		if (IS_ERR(jzdma->ctrl_base))
> 			return PTR_ERR(jzdma->ctrl_base);
> 	} else {
> 		jzdma->ctrl_base = jzdma->chn_base + JZ4780_DMA_CTRL_OFFSET;
> 	}
> 
> Then you could remove the fallback after patch 13, to end up with the
> same code you have now but without breaking bisection.
> 
> Most correct might be to move patch 13 to right after this one, so 
> that
> the JZ4780-specific fallback can be removed before adding support for
> any of the other SoCs.

Sure, I can do that for the V2.

Thanks,
-Paul

