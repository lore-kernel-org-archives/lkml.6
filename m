Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B128EC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666EE26C74
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666EE26C74
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935260AbeFZOoe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:44:34 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:34813 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934936AbeFZOoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:44:32 -0400
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="16369667"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 26 Jun 2018 07:44:31 -0700
Received: from localhost.localdomain (10.10.76.4) by
 CHN-SV-EXCH01.mchp-main.com (10.10.76.37) with Microsoft SMTP Server id
 14.3.352.0; Tue, 26 Jun 2018 07:44:30 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [RFC PATCH 1/2] spi: Add QuadSPI driver for Atmel SAMA5D2
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Piotr Bugalski <bugalski.piotr@gmail.com>
CC:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
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
Message-ID: <455adb76-530a-1fd5-303c-cfa158ad7870@microchip.com>
Date:   Tue, 26 Jun 2018 17:44:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180622093905.62a3b936@bbrezillon>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Piotr,

General things to consider for the limitation in performance:
- is the serial flash memory operating in Quad SPI?
- QSCLK should be as high as possible
- transfer delays - I checked them, they have default values, we should be good.
- use DMA, as you suggested

On 06/22/2018 10:39 AM, Boris Brezillon wrote:
> [...]
> 
>>>> +/*
>>>> + * Atmel SAMA5D2 QuadSPI driver.
>>>> + *
>>>> + * Copyright (C) 2018 Cryptera A/S  
>>>
>>> A non-negligible portion of this code has been copied from the existing
>>> driver. Please keep the existing copyright (you can still add Cryptera's
>>> one).
>>>  
>>
>> Technically this driver were written from scratch, with spi-fsl-qspi
>> as example of new interface. Hence the name and code structure.
>> But it's the same peripheral as Atmel's driver uses so code looks
>> similar. I can unify the code to make comparsion even simpler and
>> then update copyright.
> 
> Hm, ok. Some constructs really looked like they were copied
> from the old driver, hence my comment. I'll let Nicolas give his
> opinion on this aspect.

This driver will be a conversion of the legacy one to the spi-mem interface. I
would keep the legacy copyright and add Cryptera's below, as Boris suggested.

[...]

>>>> +#define QSPI_SR_CMD_COMPLETED           (QSPI_SR_INSTRE | QSPI_SR_CSR)  
>>>
>>> Do you really to wait for both INSTRE and CSR to consider the command
>>> as complete?
>>>  
>>
>> This part were really copied from Atmel driver. I wasn't sure so I
>> used tested solution.
> 
> Okay. I guess that's a question for Cyrille and/or Tudor then.

We have to wait for both INSTRE and CSR.

Best,
ta
