Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FC7C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8004217CB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Zzdz1b2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8004217CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732277AbeHDLDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:03:24 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:57206 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbeHDLDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:03:24 -0400
Date:   Sat, 04 Aug 2018 11:02:57 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 07/18] dmaengine: dma-jz4780: Add support for the
 JZ4770 SoC
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
Message-Id: <1533373377.10806.0@smtp.crapouillou.net>
In-Reply-To: <20180724133229.GG3661@vkoul-mobl>
References: <20180721110643.19624-1-paul@crapouillou.net>
        <20180721110643.19624-8-paul@crapouillou.net>
        <20180724133229.GG3661@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1533373403; bh=rLTL4GAA9J+EJe3+etHrXZuGJOFlqoGpx6OHEgD8+JU=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=Zzdz1b2srda1Tw7UfWZ47QhJBhgpCHIe1QgMv+vJvzqRbPXo/U2x6wQceZliPiiuoiXrLO3jlQq6DU1FhM90hPb2GgWgnFsFQsXKXBIikVlOpSSfC7wQ8rMKateBdGT5UKF4uqhLafeANR1QpNZIkj9xkRE9PvdMomO8Ruh5Ync=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

Le mar. 24 juil. 2018 =E0 15:32, Vinod <vkoul@kernel.org> a =E9crit :
> On 21-07-18, 13:06, Paul Cercueil wrote:
>>  +static inline void jz4780_dma_chan_enable(struct jz4780_dma_dev=20
>> *jzdma,
>>  +	unsigned int chn)
>=20
> right justified and aligned with preceding please. While adding new
> code to a existing driver it is a good idea to conform to existing=20
> style

Well that's exactly what I did, this is the style used in the DMA=20
driver,
so I tried to conform to it.

>>  +{
>>  +	if (jzdma->version =3D=3D ID_JZ4770)
>>  +		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKES, BIT(chn));
>>  +}
>>  +
>>  +static inline void jz4780_dma_chan_disable(struct jz4780_dma_dev=20
>> *jzdma,
>>  +	unsigned int chn)
>>  +{
>>  +	if (jzdma->version =3D=3D ID_JZ4770)
>>  +		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKEC, BIT(chn));
>=20
> so if another version has this feature we would do:
>         if (jzdma->version =3D=3D ID_JZ4770) ||
>                 if (jzdma->version =3D=3D ID_JZXXXX))
>=20
> and so on.. why not add a value, clk_enable in the description and use
> that. For each controller it is set to true or false
>=20
> --
> ~Vinod
=

