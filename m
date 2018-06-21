Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652CAC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1220D20846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBRBwy+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1220D20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754423AbeFUKwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:52:15 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38016 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeFUKwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:52:12 -0400
Received: by mail-lf0-f67.google.com with SMTP id i83-v6so4089656lfh.5;
        Thu, 21 Jun 2018 03:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=vB+m2EfDSHdw5ax2bMpPS8oPlk/j6fnisyWJFH3rwvs=;
        b=GBRBwy+7hJ6pwGOqKf/ZxUecQW2ebQVsKiC7tLKt4HHZyisCeMSlzkO1htw+l+cU0u
         +jJfAegKS1ZxrphrEdfoasE3BzFlrVUa7ADFYm1rRs4VJadxcvoXlQdId5VKV32I8zmX
         hR0qer+lJQXPEqVVwHnc2WIyvQyMJ90UtwZgPvDHT+FNWEo+g1OSSJ16RTsKMufmtG5B
         cVGsj4I78nykJ6W/DYnTnfl76ePBXrDyBhAYrghm9hpI7eRKmAO4KkyeD2LDOPMPfQiw
         dzgjNnTF4/5YNouJB5s6sCIvwN1mZVNVqJ2ASPN6f8v3K8V4MCApl5Omoj/xrbrNJQAt
         PxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=vB+m2EfDSHdw5ax2bMpPS8oPlk/j6fnisyWJFH3rwvs=;
        b=EwRDEM1mfWBGLg8fY6pdudswSzJ30j2ZCQtroCI7LLRV7StnfMlOe0OzJZ0CCkTs3f
         6ECMUDKNFSLAcJjxSDZ9Um/2tXZUFCRBZ3XIiDNdpDDVFlJe5GkUQmiUFTi/9ZrHYEts
         vKBQ5H6az0OHdxjG/DVow3TEgYU9ubxvAeQ2P9zASLmRPIItLBsa/U38DLftCODXxLy1
         RA3+lAN1X/helu4Hgy6C+1dKy1+IfJhL/6/UKbXBIdDTmJKc3jFtuFGd/cX4GSLXIiDE
         1AAMcnYAfchh1TBrKFx7kg026maATaA+uymvvL7BbRHHNbIfhBkUWhbQd8ceqe1667Fk
         aEiQ==
X-Gm-Message-State: APt69E3zTTdPZFfxicYLFCKHspU3nTg3E/M3IjAoDcPp+o8dwTm1/i/5
        rcZL0NBOBpN+qtdKTr1JsCHX4ZA=
X-Google-Smtp-Source: ADUXVKIIBE7ZgZd6ePq5Ni8j/Az5/yYSFPgkSr7BSnbFaNMtpuL4DCOGMyuk4YBXrhUYLHvQJhontw==
X-Received: by 2002:a2e:8990:: with SMTP id c16-v6mr1231039lji.123.1529578330502;
        Thu, 21 Jun 2018 03:52:10 -0700 (PDT)
Received: from [192.168.0.4] (89-64-25-103.dynamic.chello.pl. [89.64.25.103])
        by smtp.gmail.com with ESMTPSA id i78-v6sm882011lfg.73.2018.06.21.03.52.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 03:52:09 -0700 (PDT)
From:   Piotr Bugalski <bugalski.piotr@gmail.com>
X-Google-Original-From: Piotr Bugalski <elvis@carbonite>
Date:   Thu, 21 Jun 2018 12:52:07 +0200 (CEST)
To:     Boris Brezillon <boris.brezillon@bootlin.com>
cc:     Piotr Bugalski <bugalski.piotr@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [RFC PATCH 0/2] New QuadSPI driver for Atmel SAMA5D2
In-Reply-To: <20180620165438.39608554@bbrezillon>
Message-ID: <alpine.DEB.2.20.1806211239590.28763@carbonite>
References: <20180618162124.21749-1-bugalski.piotr@gmail.com> <20180620165438.39608554@bbrezillon>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Boris,

Thank you very much for quick response.

On Wed, 20 Jun 2018, Boris Brezillon wrote:

> Hi Piotr,
>
> On Mon, 18 Jun 2018 18:21:22 +0200
> Piotr Bugalski <bugalski.piotr@gmail.com> wrote:
>
>> Hello,
>>
>> Atmel SAMA5D2 is equipped with two QSPI interfaces. These interfaces can
>> work as in SPI-compatible mode or use two / four lines to improve
>> communication speed. At the moment there is QSPI driver strongly tied to
>> NOR-flash memory and MTD subsystem.
>> Intention of this change is to provide new driver which will not be tied
>> to MTD and allows using QSPI with NAND-flash memory or other peripherals
>> New spi-mem API provides abstraction layer which can disconnect QSPI
>> from MTD. This driver doesn't support regular SPI interface, it should
>> be used with spi-mem interface only.
>
> Glad to see that people are starting to convert their SPI NOR
> controller drivers to the SPI mem approach.
>
>> Unfortunately SAMA5D2 hardware by default supports only NOR-flash
>> memory. It allows 24- and 32-bit addressing while NAND-flash requires
>> 16-bit long. To workaround hardware limitation driver is a bit more
>> complicated.
>>
>> Request to spi-mem contains three fiels: opcode (command), address,
>> dummy bytes. SAMA5D2 QSPI hardware supports opcode, address, dummy and
>> option byte where address field can only be 24- or 32- bytes long.
>> Handling 8-bits long addresses is done using option field. For 16-bits
>> address behaviour depends of number of requested dummy bits. If there
>> are 8 or more dummy cycles, address is shifted and sent with first dummy
>> byte. Otherwise opcode is disabled and first byte of address contains
>> command opcode (works only if opcode and address use the same buswidth).
>> The limitation is when 16-bit address is used without enough dummy
>> cycles and opcode is using different buswidth than address. Other modes
>> are supported with described workaround.
>>
>> It looks like hardware has some limitation in performance. The same issue
>> exists in current QSPI driver (MTD/nor-flash) and soft-pack (bare-metal
>> library from Atmel). Without using DMA read speed is much worse than
>> maximum bandwidth (efficiency 30-40%). Any help with performance
>> improvement is highly welcome, especially for NAND-flash memories which
>> offers higher capacity than NOR-flash used with previous driver.
>>
>> Best Regards,
>> Piotr
>>
>> Piotr Bugalski (2):
>>   spi: Add QuadSPI driver for Atmel SAMA5D2
>>   dt-bindings: spi: QuadSPI driver for Atmel SAMA5D2 documentation
>>
>>  .../devicetree/bindings/spi/spi_atmel-qspi.txt     |  41 ++
>>  drivers/spi/Kconfig                                |   9 +
>>  drivers/spi/Makefile                               |   1 +
>>  drivers/spi/spi-atmel-qspi.c                       | 480 +++++++++++++++++++++
>
> I'd like a solution where we remove the old driver. I definitely don't
> want to have both in parallel. Did you test the new driver with a SPI
> NOR to check if it still works correctly? If you did, then I'd suggest
> that you add a patch updating defconfigs where the SPI_ATMEL_QUADSPI is
> selected and another patch removing the old driver.
>

I misunderstood a bit your idea. My main concern was NAND-flash with
QSPI interface and I expected original nor-flash driver to stay
untouched - at least now. However idea of replacement older driver
with spi-mem approach makes a lot of sense to me.
I'll test nor-flash with new driver first, it should work but I prefer
to be sure. In next version I'll follow your suggestion and replace
old nor-flash driver.

>>  4 files changed, 531 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/spi/spi_atmel-qspi.txt
>
> This should be a simple mv from
> Documentation/devicetree/bindings/mtd/atmel-quadspi.txt to
> Documentation/devicetree/bindings/spi/spi-atmel-qspi.txt
>
>>  create mode 100644 drivers/spi/spi-atmel-qspi.c
>>
>
> Thanks,
>
> Boris
>

Thank you for comments,
Piotr
