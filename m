Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A333CC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F14A20852
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEwZQWwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F14A20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732843AbeGKMSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:18:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732503AbeGKMSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:18:16 -0400
Received: from localhost (unknown [106.200.243.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DEF22084A;
        Wed, 11 Jul 2018 12:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531311252;
        bh=9BfqPJy/9QTritHy6541J/y+6FdvNY1b5TuICtLJWWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OEwZQWwe/Xk5gESbjiQgPzmSRJX7L2O2UcxV7TQv/Z/qrzEzd4ybiCzNRtw2KAL5V
         4GqKvjHA99dBZ4912ufdz+S6efTr34r0Bvsjma2KI1RbXSA5T5ZUbgPs1EVeGC271X
         ndU7V0UZhQj0PUjTspnf7HvWoRhOLKDw2isGxz+o=
Date:   Wed, 11 Jul 2018 17:44:03 +0530
From:   Vinod <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
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
Message-ID: <20180711121403.GR3219@vkoul-mobl>
References: <20180703123214.23090-1-paul@crapouillou.net>
 <20180703123214.23090-2-paul@crapouillou.net>
 <20180709165945.GH22377@vkoul-mobl>
 <1531236550.17118.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531236550.17118.0@crapouillou.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 10-07-18, 17:29, Paul Cercueil wrote:
> > >  +static const unsigned int jz4780_dma_nb_channels[] = {
> > >  +	[ID_JZ4780] = 32,
> > >  +};
> > >  +
> > >  +static const struct of_device_id jz4780_dma_dt_match[] = {
> > >  +	{ .compatible = "ingenic,jz4780-dma", .data = (void *)ID_JZ4780 },
> > >  +	{},
> > >  +};
> > 
> > Looking at description I was hoping that channels would be in DT,
> > channels is hardware information, so should come from DT rather than
> > coding the kernel...
> 
> I had a talk with Linus Walleij (GPIO maintainer) about that:
> http://lkml.iu.edu/hypermail/linux/kernel/1701.3/05422.html
> 
> And I agree with him, we shouldn't have in devicetree what we can deduce
> from the compatible string. But there doesn't seem to be an enforced
> policy about it.

Looking at this, yes that can be done as you have implemented but adding
new compatible and tables every time seems not so great to me.

If DT can describe these hardware features then driver can take action generically
and we avoid these tables and skip some patches here..

> 
> @Rob, what do you think?

Rob what is the recommendation here?

> 
> > >  -	jzdma = devm_kzalloc(dev, sizeof(*jzdma), GFP_KERNEL);
> > >  +	if (of_id)
> > >  +		version = (enum jz_version)of_id->data;
> > >  +	else
> > >  +		version = ID_JZ4780; /* Default when not probed from DT */
> > 
> > where else would it be probed from.... ?
> 
> Platform, MFD driver, etc. But not likely to happen.
> I can remove these lines if you want.

Lets add when we land support for those.

-- 
~Vinod
