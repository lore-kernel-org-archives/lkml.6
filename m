Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4209BC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60E420858
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cesnet.cz header.i=@cesnet.cz header.b="A9wflGtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60E420858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cesnet.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbeH2P34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:29:56 -0400
Received: from office2.cesnet.cz ([195.113.144.244]:34652 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeH2P34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:29:56 -0400
Received: from localhost (ip-89-102-27-77.net.upcbroadband.cz [89.102.27.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 735A2400063;
        Wed, 29 Aug 2018 13:33:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2; t=1535542405;
        bh=JmDLKNyTmbXKcmKClmkMFZdZmKvHhYRGgfeN/Po7ltk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=A9wflGtW8J0St83JJ0l18hAiadcWqKNVxdd9C+e5tjhVw7zGSPWFD4C9iLsoAFdze
         +w/kz6PSiwvU0UGdxDdB0/Xdzva3y3XYwALJlD9jmVO076i4iiKV/zVT+WAw1eHVvi
         PVKiCOAT9D+IUp5Dddwps3n9Xn5QzJpgIx3IEThg=
From:   =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To:     Baolin Wang <baolin.wang@linaro.org>, <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <orsonzhai@gmail.com>, <zhang.lyra@gmail.com>,
        <lanqing.liu@spreadtrum.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] spi: Introduce one new field to set word delay
Date:   Wed, 29 Aug 2018 13:33:24 +0200
MIME-Version: 1.0
Message-ID: <01c9b188-5b67-40c0-b08d-99a0543ddf54@cesnet.cz>
In-Reply-To: <a77a6bb8b3abf1c127014c78f71533c24afacd93.1534423916.git.baolin.wang@linaro.org>
References: <a77a6bb8b3abf1c127014c78f71533c24afacd93.1534423916.git.baolin.wang@linaro.org>
Organization: CESNET
User-Agent: Trojita/v0.7-361-gfee56b6f-dirty; Qt/5.11.0; xcb; Linux; Gentoo Base System release 2.4.1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On =C4=8Dtvrtek 16. srpna 2018 14:54:49 CEST, Baolin Wang wrote:
> + * @word_delay: clock cycles to inter word delay after each word size
> + *=09(set by bits_per_word) transmission.

I need a similar functionality for talking to a SPI device from userspace =20=

-- see my attempt for implementing this in spi-orion.c at [1]. The device's=20=

datasheet says that I should wait, e.g., 3=C2=B5s between each two words. I=20=

therefore like this patch :).

The description can be improved because it left me wondering what "clock=20
this is about. I suppose it's about the SPI clock cycles and not CPU clock=20=

cycles, right? I'll be hapy to patch this once Baolin confirms that that is=20=

the intended meaning.

It seems that this is only implemented in one newly added driver. I'm=20
interested in supporting this in spi-orion.c, but that sounds like=20
driver-specific work for something which is pretty generic. How should this=20=

be implemented? Given that drivers for SPI masters can implement a function=20=

which transfers several words at once, there are not that many better=20
possibilities than adding udelay()s, though. Thoughts?

What is your plan to do with drivers which do not implement this (yet)? If=20=

a spi_transfer gets queued which asks for a word_delay delay, it is=20
silently ignored now, AFAIU.

What about userspace support, spidev and spi_ioc_transfer (that's my=20
target, actually)? Is it OK to s/pad/word_delay/ in the spidev code and=20
pass that to the generated struct spi_transfer? In my opinion, once we=20
support specifying this from userspace, one has to definitely check that=20
the SPI controller is ready to honor this request. Do we want a new bit in=20=

spi_controller.flags for this?

With kind regards,
Jan

[1] https://patchwork.kernel.org/patch/10221397/
