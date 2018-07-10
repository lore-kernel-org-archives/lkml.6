Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17103C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26AF208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="TtFbvyld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26AF208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934386AbeGJPle (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:41:34 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:35710 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933737AbeGJPld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:41:33 -0400
Date:   Tue, 10 Jul 2018 17:41:26 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 04/14] dmaengine: dma-jz4780: Add support for the JZ4770
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
Message-Id: <1531237286.17118.2@crapouillou.net>
In-Reply-To: <20180709171032.GJ22377@vkoul-mobl>
References: <20180703123214.23090-1-paul@crapouillou.net>
        <20180703123214.23090-5-paul@crapouillou.net>
        <20180709171032.GJ22377@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1531237291; bh=d6WE7oAW3jTKnldJTv4nfQHOE3iDxU8Ba4ktfujz9hc=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=TtFbvyldGrWPA010Fu8NOoUy8G3lf4isV0/xHdwMbVgUeaOzenH/5dY+UbGhP7GjcBSXA/7Y4PWI1U82h5BjDYmH+u6YH1dgPyV7eJWZwYFG9ZpBGwbOsBidGK/0BrzPWJqoggaUzzrbSimfZ170hFxbXN7+vAT5p36iHk+NLPk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le lun. 9 juil. 2018 =E0 19:10, Vinod <vkoul@kernel.org> a =E9crit :
> On 03-07-18, 14:32, Paul Cercueil wrote:
>=20
>>  +static inline void jz4780_dma_chan_disable(struct jz4780_dma_dev=20
>> *jzdma,
>>  +	unsigned int chn)
>>  +{
>>  +	if (jzdma->version =3D=3D ID_JZ4770)
>>  +		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKEC, BIT(chn));
>>  +}
>=20
> this sounds as hardware behaviour, so why not describe as a property=20
> in
> DT?

See my response to your message on patch 1.

>>  +
>>   static struct jz4780_dma_desc *jz4780_dma_desc_alloc(
>>   	struct jz4780_dma_chan *jzchan, unsigned int count,
>>   	enum dma_transaction_type type)
>>  @@ -228,8 +246,15 @@ static void jz4780_dma_desc_free(struct=20
>> virt_dma_desc *vdesc)
>>   	kfree(desc);
>>   }
>>=20
>>  -static uint32_t jz4780_dma_transfer_size(unsigned long val,=20
>> uint32_t *shift)
>>  +static const unsigned int jz4780_dma_ord_max[] =3D {
>>  +	[ID_JZ4770] =3D 6,
>>  +	[ID_JZ4780] =3D 7,
>>  +};
>=20
> So this gives the transfer length supported?

Yes, exactly. The maximum transfer size is (1 << ord).

> --
> ~Vinod
=

