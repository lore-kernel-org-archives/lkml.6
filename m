Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BFCC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04747208F7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="DqSrVO4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04747208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934256AbeGJPpL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:45:11 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:39258 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933501AbeGJPpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:45:09 -0400
Date:   Tue, 10 Jul 2018 17:45:02 +0200
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
Message-Id: <1531237502.17118.3@crapouillou.net>
In-Reply-To: <20180709171458.GL22377@vkoul-mobl>
References: <20180703123214.23090-1-paul@crapouillou.net>
        <20180703123214.23090-7-paul@crapouillou.net>
        <20180709171458.GL22377@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1531237507; bh=WjTJmSBBrurN9JyF9IyWDMyPaD+mqwPGq8mYopQDoG8=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=DqSrVO4z5BhlGLAOU7Z7L7XLCxV2kHd9ITCUDKWOvlkRE+7O0nP2/683PCeGYv3cWc3IJg75AogCbLYK/lEnrvC2CDpXNh/7qnaTqTTlxitVmskMLN6u8CHblLLIT36BaR2eRDLMn7z9CBmhWFHhg82K+V0WC6boUZNfTN4v+K0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le lun. 9 juil. 2018 =E0 19:14, Vinod <vkoul@kernel.org> a =E9crit :
> On 03-07-18, 14:32, Paul Cercueil wrote:
>>  The JZ4725B has one DMA core starring six DMA channels.
>>  As for the JZ4770, each DMA channel's clock can be enabled with
>>  a register write, the difference here being that once started, it
>>  is not possible to turn it off.
>=20
> ok so disable for this, right..
>=20
>>  @@ -204,6 +205,8 @@ static inline void=20
>> jz4780_dma_chan_enable(struct jz4780_dma_dev *jzdma,
>>   {
>>   	if (jzdma->version =3D=3D ID_JZ4770)
>>   		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKES, BIT(chn));
>>  +	else if (jzdma->version =3D=3D ID_JZ4725B)
>>  +		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKE, BIT(chn));
>=20
> but you are writing to a different register here..

Yes. SoCs >=3D JZ4770 have the DCKE read-only register, and DCKES/DCKEC=20
to set/clear bits in DCKE.
On JZ4725B, DCKE is read/write, but the zeros written are ignored (at=20
least that's what the
documentation says).

> --
> ~Vinod

Thanks,
-Paul
=

