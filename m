Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF50C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D73C208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Q6HBURlr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D73C208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934193AbeGJPhG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:37:06 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:59652 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933475AbeGJPhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:37:05 -0400
Date:   Tue, 10 Jul 2018 17:36:58 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 02/14] dmaengine: dma-jz4780: Separate chan/ctrl registers
To:     Vinod <vkoul@kernel.org>
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
Message-Id: <1531237019.17118.1@crapouillou.net>
In-Reply-To: <20180709170359.GI22377@vkoul-mobl>
References: <20180703123214.23090-1-paul@crapouillou.net>
        <20180703123214.23090-3-paul@crapouillou.net>
        <20180709170359.GI22377@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1531237023; bh=cNGXnj5AABh9INizic9jqncTaQ9PKFkhO1FquUWNflw=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=Q6HBURlrhkQIX60y/N+RswUBy3BMqmJACYilheYlO3Hy1b+zFMSJvAi70Jk3jkG04RWaqLPLHH6PYjccKAHt31YfXpUjYEtevLBu0TFb1/P2cs+eF1hSlLkuXpqhrbtKN7cKkrLvGlvxVQ133hnL9DLiRpk0g2lrZP6AmDbqGJk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le lun. 9 juil. 2018 =E0 19:03, Vinod <vkoul@kernel.org> a =E9crit :
> On 03-07-18, 14:32, Paul Cercueil wrote:
>>  The register area of the JZ4780 DMA core can be split into different
>>  sections for different purposes:
>>=20
>>  * one set of registers is used to perform actions at the DMA core=20
>> level,
>>  that will generally affect all channels;
>>=20
>>  * one set of registers per DMA channel, to perform actions at the=20
>> DMA
>>  channel level, that will only affect the channel in question.
>>=20
>>  The problem rises when trying to support new versions of the JZ47xx
>>  Ingenic SoC. For instance, the JZ4770 has two DMA cores, each one
>>  with six DMA channels, and the register sets are interleaved:
>>  <DMA0 chan regs> <DMA1 chan regs> <DMA0 ctrl regs> <DMA1 ctrl regs>
>>=20
>>  By using one memory resource for the channel-specific registers and
>>  one memory resource for the core-specific registers, we can support
>>  the JZ4770, by initializing the driver once per DMA core with=20
>> different
>>  addresses.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   .../devicetree/bindings/dma/jz4780-dma.txt    |   6 +-
>=20
> Pls move to separate patch.

OK.

>>   drivers/dma/dma-jz4780.c                      | 106=20
>> +++++++++++-------
>>   2 files changed, 69 insertions(+), 43 deletions(-)
>>=20
>>  diff --git a/Documentation/devicetree/bindings/dma/jz4780-dma.txt=20
>> b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
>>  index f25feee62b15..f9b1864f5b77 100644
>>  --- a/Documentation/devicetree/bindings/dma/jz4780-dma.txt
>>  +++ b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
>>  @@ -3,7 +3,8 @@
>>   Required properties:
>>=20
>>   - compatible: Should be "ingenic,jz4780-dma"
>>  -- reg: Should contain the DMA controller registers location and=20
>> length.
>>  +- reg: Should contain the DMA channel registers location and=20
>> length, followed
>>  +  by the DMA controller registers location and length.
>>   - interrupts: Should contain the interrupt specifier of the DMA=20
>> controller.
>>   - interrupt-parent: Should be the phandle of the interrupt=20
>> controller that
>>   - clocks: Should contain a clock specifier for the JZ4780 PDMA=20
>> clock.
>>  @@ -22,7 +23,8 @@ Example:
>>=20
>>   dma: dma@13420000 {
>>   	compatible =3D "ingenic,jz4780-dma";
>>  -	reg =3D <0x13420000 0x10000>;
>>  +	reg =3D <0x13420000 0x400
>>  +	       0x13421000 0x40>;
>=20
> Second should be optional or we break platform which may not have
> updated DT..

See comment below.

>>  -	jzdma->base =3D devm_ioremap_resource(dev, res);
>>  -	if (IS_ERR(jzdma->base))
>>  -		return PTR_ERR(jzdma->base);
>>  +	jzdma->chn_base =3D devm_ioremap_resource(dev, res);
>>  +	if (IS_ERR(jzdma->chn_base))
>>  +		return PTR_ERR(jzdma->chn_base);
>>  +
>>  +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>  +	if (!res) {
>>  +		dev_err(dev, "failed to get I/O memory\n");
>>  +		return -EINVAL;
>>  +	}
>=20
> okay and this breaks if you happen to get probed on older DT. I think=20
> DT
> is treated as ABI so you need to continue support older method while
> finding if DT has split resources

See my response to PrasannaKumar. All the Ingenic-based boards do=20
compile
the devicetree within the kernel, so I think it's still fine to add=20
breaking
changes. I'll wait on @Rob to give his point of view on this, though.

(It's not something hard to change, but I'd like to know what's the=20
policy
in that case. I have other DT-breaking patches to submit)

> --
> ~Vinod
=

