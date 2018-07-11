Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FA9C43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D63220C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="AHpNzfXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D63220C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390760AbeGKXUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 19:20:40 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:46398 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732195AbeGKXUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 19:20:39 -0400
Date:   Thu, 12 Jul 2018 01:13:55 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 06/14] dmaengine: dma-jz4780: Add support for the JZ4725B
 SoC
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
Message-Id: <1531350835.2021.1@smtp.crapouillou.net>
In-Reply-To: <20180711121818.GT3219@vkoul-mobl>
References: <20180703123214.23090-1-paul@crapouillou.net>
        <20180703123214.23090-7-paul@crapouillou.net>
        <20180709171458.GL22377@vkoul-mobl> <1531237502.17118.3@crapouillou.net>
        <20180711121818.GT3219@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1531350841; bh=3IQoraoleuUeQ63djCofqFXR2MJYkQlo2+8Sv8HIKRg=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=AHpNzfXC8Qk059jiK9VSb4qqtVv9cn4PV/OiNjjMZtH+MgFWRdRovTGD3EIgXI5RfqjWmjsEeSHeg+b7s3fgoOb49kJLnM3Iw2Q/22ADfMKPTcUvUWPSTGKTfEmuvep1GFHW3Y6HzrSLPLVVJbICtOjw/ymL4G/Q8JZedd4WmDw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le mer. 11 juil. 2018 =E0 14:18, Vinod <vkoul@kernel.org> a =E9crit :
> On 10-07-18, 17:45, Paul Cercueil wrote:
>>=20
>>=20
>>  Le lun. 9 juil. 2018 =E0 19:14, Vinod <vkoul@kernel.org> a =E9crit :
>>  > On 03-07-18, 14:32, Paul Cercueil wrote:
>>  > >  The JZ4725B has one DMA core starring six DMA channels.
>>  > >  As for the JZ4770, each DMA channel's clock can be enabled with
>>  > >  a register write, the difference here being that once started,=20
>> it
>>  > >  is not possible to turn it off.
>>  >
>>  > ok so disable for this, right..
>>  >
>>  > >  @@ -204,6 +205,8 @@ static inline void
>>  > > jz4780_dma_chan_enable(struct jz4780_dma_dev *jzdma,
>>  > >   {
>>  > >   	if (jzdma->version =3D=3D ID_JZ4770)
>>  > >   		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKES, BIT(chn));
>>  > >  +	else if (jzdma->version =3D=3D ID_JZ4725B)
>>  > >  +		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKE, BIT(chn));
>>  >
>>  > but you are writing to a different register here..
>>=20
>>  Yes. SoCs >=3D JZ4770 have the DCKE read-only register, and=20
>> DCKES/DCKEC to
>>  set/clear bits in DCKE.
>>  On JZ4725B, DCKE is read/write, but the zeros written are ignored=20
>> (at least
>>  that's what the
>>  documentation says).
>=20
> and that was not documented in the log... so i though it maybe a typo.

Right, I will add a comment in-code to explain that it's normal.

> --
> ~Vinod

Thanks,
-Paul
=

