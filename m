Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7730AC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364EE270E3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364EE270E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeF1IhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 04:37:19 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:61068 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbeF1IhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 04:37:14 -0400
X-IronPort-AV: E=Sophos;i="5.51,282,1526367600"; 
   d="scan'208";a="13559370"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Jun 2018 01:37:13 -0700
Received: from localhost.localdomain (10.10.76.4) by
 chn-sv-exch06.mchp-main.com (10.10.76.107) with Microsoft SMTP Server id
 14.3.352.0; Thu, 28 Jun 2018 01:37:12 -0700
Subject: Re: [RFC PATCH 1/2] spi: Add QuadSPI driver for Atmel SAMA5D2
To:     Piotr Bugalski <bugalski.piotr@gmail.com>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Piotr Bugalski <pbu@cryptera.com>
References: <20180618162124.21749-1-bugalski.piotr@gmail.com>
 <20180618162124.21749-2-bugalski.piotr@gmail.com>
 <20180621233321.0f25f572@bbrezillon>
 <alpine.DEB.2.20.1806220719190.21824@carbonite>
 <20180622093905.62a3b936@bbrezillon>
 <455adb76-530a-1fd5-303c-cfa158ad7870@microchip.com>
 <alpine.DEB.2.20.1806270940500.32198@carbonite>
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
Message-ID: <1d736934-b3e7-7b23-0f34-1d22d36b2b18@microchip.com>
Date:   Thu, 28 Jun 2018 11:37:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1806270940500.32198@carbonite>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Piotr,

On 06/27/2018 10:52 AM, Piotr Bugalski wrote:
> 
>> General things to consider for the limitation in performance:
>> - is the serial flash memory operating in Quad SPI?
> 
> Yes, I've checked signal using logic analyzer, data is transferred using
> all four lines.
> 
>> - QSCLK should be as high as possible
> 
> Sure, but when we are using lower frequency CPU impact should be
> negligible while efficiency is crap on every speed.
> 
>> - transfer delays - I checked them, they have default values, we should be good.
>> - use DMA, as you suggested
>>
> 
> I don't understand one thing. While CPU is not busy and during my tests
> 100% of CPU can be used for communication, efficiency is still very low.
> Why DMA has such impact?
> 
> It is very interesting to observe signals using logic analyzer.
> When CPU is used for communication, there are long delays after
> every byte transferred. These delays are  much longer than it should be only because of writing next value by CPU.

Are those consecutive transfers (same peripheral without removing chip select)?
The delays between consecutive transfers can be set just in SPI mode. It would
be strange to see this kind of delays in serial memory mode.

> I tried to change SPI frequency. If delay were CPU related,
> delay time should stay the same. Unfortunately results were different -
> lowering SPI freqency extends delay time.

If QSCK is less than f-perif-clock/2, then setting DLYBS to 1 will shorten the
DLYBS delay, but this is peanuts.

Thanks,
ta

> Using DMA makes these delays to disappear, but how to acheive CPU
> communication without delays?
