Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0B1C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D063320856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ltOr6WCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D063320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbeGXQL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:11:57 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:58588 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388172AbeGXQL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:11:56 -0400
Date:   Tue, 24 Jul 2018 17:04:55 +0200
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
Message-Id: <1532444695.2610.1@smtp.crapouillou.net>
In-Reply-To: <20180724133229.GG3661@vkoul-mobl>
References: <20180721110643.19624-1-paul@crapouillou.net>
        <20180721110643.19624-8-paul@crapouillou.net>
        <20180724133229.GG3661@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532444700; bh=IqocOiyKOEeKG29E9sBB05Z8CWIQGYK6CZPqTO3/t4I=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=ltOr6WCF6u59Oi0NYPZO06a64uetxdOmtCL4mJC5SfsBkAjSmDttrar4dEsI/A6DTS0cEgAw5RGKEcO3Jp5A866FWwwpnD2oV8X5f7XkJgVuH2YRs1dTiihw+ovasviWJfw7FBmS6uevVUiPm+rtuFoHpxydB3eoRAtRR2Mu9VQ=
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

OK.

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

I agree with what you said in your other answers.
However here I still need to check the "version", because on JZ4725B=20
and JZ4770+
the way to start/stop each DMA channel's clock is different, so I can't=20
use a boolean.

> --
> ~Vinod

Thanks,
-Paul
=

