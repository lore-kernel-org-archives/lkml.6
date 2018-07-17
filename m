Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F06AECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03C420C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="i7x45M6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03C420C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbeGQLcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:32:46 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:47088 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730429AbeGQLcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:32:46 -0400
Date:   Tue, 17 Jul 2018 13:00:29 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 05/14] dmaengine: dma-jz4780: Add support for the JZ4740
 SoC
To:     Rob Herring <robh@kernel.org>
Cc:     Vinod <vkoul@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Message-Id: <1531825229.5992.0@smtp.crapouillou.net>
In-Reply-To: <20180716213339.GA19161@rob-hp-laptop>
References: <20180703123214.23090-1-paul@crapouillou.net>
        <20180703123214.23090-6-paul@crapouillou.net>
        <20180709171226.GK22377@vkoul-mobl> <20180716213339.GA19161@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1531825239; bh=aEZbmjqPBJqaEsjPMfUzrceU4haKjosnEaqcb+UBvtA=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=i7x45M6BeTXgcHXrZzOYUCwum1Nm7KcCCLDCwDR7w0Bio+7iMWF8wGyvgq/Eep/Os1creiQ64lvTEIvkq+dc8C6OszRHXh81p3zh/idyMxVAEAuQbpJ3RMZ/iDhFv0Uvw7BXKtEaupI8nbtbNioyyoaRQUtQPuVi1RlaLaQb3ak=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le lun. 16 juil. 2018 =E0 23:33, Rob Herring <robh@kernel.org> a =E9crit :
> On Mon, Jul 09, 2018 at 10:42:26PM +0530, Vinod wrote:
>>  On 03-07-18, 14:32, Paul Cercueil wrote:
>>=20
>>  >  enum jz_version {
>>  > +	ID_JZ4740,
>>  >  	ID_JZ4770,
>>  >  	ID_JZ4780,
>>  >  };
>>  > @@ -247,6 +248,7 @@ static void jz4780_dma_desc_free(struct=20
>> virt_dma_desc *vdesc)
>>  >  }
>>  >
>>  >  static const unsigned int jz4780_dma_ord_max[] =3D {
>>  > +	[ID_JZ4740] =3D 5,
>>  >  	[ID_JZ4770] =3D 6,
>>  >  	[ID_JZ4780] =3D 7,
>>  >  };
>>  > @@ -801,11 +803,13 @@ static struct dma_chan=20
>> *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
>>  >  }
>>  >
>>  >  static const unsigned int jz4780_dma_nb_channels[] =3D {
>>  > +	[ID_JZ4740] =3D 6,
>>  >  	[ID_JZ4770] =3D 6,
>>  >  	[ID_JZ4780] =3D 32,
>>  >  };
>>=20
>>  I feel these should be done away with if we describe hardware in DT
>=20
> The compatible property can imply things like this.
>=20
> But how this is structured is a bit strange. Normally you have a per
> compatible struct with these as elements and the compatible matching
> selects the struct.

You're right, I'll change that.

>>=20
>>  >
>>  >  static const struct of_device_id jz4780_dma_dt_match[] =3D {
>>  > +	{ .compatible =3D "ingenic,jz4740-dma", .data =3D (void *)ID_JZ4740=
=20
>> },
>>=20
>>  adding .compatible should be the only thing required, if at all for=20
>> this
>>  addition :)
>>=20
>>  --
>>  ~Vinod
=

