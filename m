Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF5CC43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3927020C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="KdeqVshM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3927020C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390752AbeGKXT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 19:19:58 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:45368 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732195AbeGKXT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 19:19:58 -0400
Date:   Thu, 12 Jul 2018 01:13:05 +0200
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
Message-Id: <1531350785.2021.0@smtp.crapouillou.net>
In-Reply-To: <20180711121655.GS3219@vkoul-mobl>
References: <20180703123214.23090-1-paul@crapouillou.net>
        <20180703123214.23090-3-paul@crapouillou.net>
        <20180709170359.GI22377@vkoul-mobl> <1531237019.17118.1@crapouillou.net>
        <20180711121655.GS3219@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1531350797; bh=WooJveTkznmLjUJQ5TqNtVojk+ltu1x+RlD7ac0DIjg=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=KdeqVshMn2vpfr/2WEETGEUdoqIYLAu2ItaRoXA0vpnN9MSf7e2iFtbSsDPSyo/gDyTQyuVclwtE2RvuEZEDIngn3yZ3CW1x5/mu7WwCv8lprzKGgLIBqyQrw5WtLSg27w8MEx65xjZWq9PWB6oKhY7qsRoRF2O5dDwZS9ETBEg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le mer. 11 juil. 2018 =E0 14:16, Vinod <vkoul@kernel.org> a =E9crit :
> On 10-07-18, 17:36, Paul Cercueil wrote:
>=20
>>  > >  @@ -3,7 +3,8 @@
>>  > >   Required properties:
>>  > >
>>  > >   - compatible: Should be "ingenic,jz4780-dma"
>>  > >  -- reg: Should contain the DMA controller registers location=20
>> and
>>  > > length.
>>  > >  +- reg: Should contain the DMA channel registers location and
>>  > > length, followed
>>  > >  +  by the DMA controller registers location and length.
>>  > >   - interrupts: Should contain the interrupt specifier of the=20
>> DMA
>>  > > controller.
>>  > >   - interrupt-parent: Should be the phandle of the interrupt
>>  > > controller that
>>  > >   - clocks: Should contain a clock specifier for the JZ4780 PDMA
>>  > > clock.
>>  > >  @@ -22,7 +23,8 @@ Example:
>>  > >
>>  > >   dma: dma@13420000 {
>>  > >   	compatible =3D "ingenic,jz4780-dma";
>>  > >  -	reg =3D <0x13420000 0x10000>;
>>  > >  +	reg =3D <0x13420000 0x400
>>  > >  +	       0x13421000 0x40>;
>>  >
>>  > Second should be optional or we break platform which may not have
>>  > updated DT..
>>=20
>>  See comment below.
>>=20
>>  > >  -	jzdma->base =3D devm_ioremap_resource(dev, res);
>>  > >  -	if (IS_ERR(jzdma->base))
>>  > >  -		return PTR_ERR(jzdma->base);
>>  > >  +	jzdma->chn_base =3D devm_ioremap_resource(dev, res);
>>  > >  +	if (IS_ERR(jzdma->chn_base))
>>  > >  +		return PTR_ERR(jzdma->chn_base);
>>  > >  +
>>  > >  +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>  > >  +	if (!res) {
>>  > >  +		dev_err(dev, "failed to get I/O memory\n");
>>  > >  +		return -EINVAL;
>>  > >  +	}
>>  >
>>  > okay and this breaks if you happen to get probed on older DT. I=20
>> think DT
>>  > is treated as ABI so you need to continue support older method=20
>> while
>>  > finding if DT has split resources
>>=20
>>  See my response to PrasannaKumar. All the Ingenic-based boards do=20
>> compile
>>  the devicetree within the kernel, so I think it's still fine to add=20
>> breaking
>>  changes. I'll wait on @Rob to give his point of view on this,=20
>> though.
>>=20
>>  (It's not something hard to change, but I'd like to know what's the=20
>> policy
>>  in that case. I have other DT-breaking patches to submit)
>=20
> The policy is that DT is an ABI and should not break :)
>=20
> Who maintains Ingenic arch. MAINTAINERS doesn't tell me.

Unofficially that would be me :)

Otherwise that would be the MIPS maintainers, Ralf and Paul (Burton).

> --
> ~Vinod
=

