Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F343C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C40208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C40208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeK0LR3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:17:29 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:44461 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbeK0LR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 06:17:28 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 433kwn0VdLz1qvNr;
        Tue, 27 Nov 2018 01:21:29 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 433kwm6mPvz1rJqb;
        Tue, 27 Nov 2018 01:21:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 49SQ-BZXilHV; Tue, 27 Nov 2018 01:21:27 +0100 (CET)
X-Auth-Info: LQOpPDedD8azYRxfCdpk5dRPSYlDxD01Zj5qVk0xkN4=
Received: from crub (p5088702D.dip0.t-ipconnect.de [80.136.112.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 27 Nov 2018 01:21:27 +0100 (CET)
Date:   Tue, 27 Nov 2018 01:21:27 +0100
From:   Anatolij Gustschin <agust@denx.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, atull@kernel.org, mdf@kernel.org
Subject: Re: [PATCH v2 2/3] spi: add FTDI MPSSE SPI controller driver
Message-ID: <20181127012127.24e455b6@crub>
In-Reply-To: <20181121124237.GC8059@sirena.org.uk>
References: <20181120002821.12794-1-agust@denx.de>
 <20181120002821.12794-3-agust@denx.de>
 <20181121124237.GC8059@sirena.org.uk>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 12:42:37 +0000
Mark Brown broonie@kernel.org wrote:
...
>>  obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+= spi-zynqmp-gqspi.o
>> +obj-$(CONFIG_SPI_FTDI_MPSSE)		+= spi-ftdi-mpsse.o
>>  
>>  # SPI slave protocol handlers
>>  obj-$(CONFIG_SPI_SLAVE_TIME)		+= spi-slave-time.o  
>
>Please keep the Makefile sorted.

Will fix it in v3.

>> +++ b/drivers/spi/spi-ftdi-mpsse.c
>> @@ -0,0 +1,673 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * FTDI FT232H MPSSE SPI controller driver  
>
>Please make the entire comment block here a C++ one so it looks more
>consistent.

Okay.

>> +	struct gpiod_lookup_table *lookup[13];  
>
>This magic number for the size of the lookup table is not good.

Will fix it in v3.

>> +static void ftdi_spi_chipselect(struct ftdi_spi *priv, struct spi_device *spi,
>> +				bool value)
>> +{
>> +	int cs = spi->chip_select;
>> +
>> +	dev_dbg(&priv->master->dev, "%s: CS %d, cs mode %d, val %d\n",
>> +		__func__, cs, (spi->mode & SPI_CS_HIGH), value);
>> +
>> +	gpiod_set_raw_value_cansleep(priv->cs_gpios[cs], value);
>> +}  
>
>This is just a gpio chip select - can't it be handled by the core chip
>select code?

spi core chip select code doesn't use gpio_desc based API yet.
But it can be handled using .set_cs(), I'll convert the driver
to use .set_cs().

>> +	remaining = len;
>> +	do {
>> +		stride = min_t(size_t, remaining, SZ_64K - 3);  
>
>Rather than having a magic number for the buffer size it would be better
>to either have a driver specific constant that's used consistently or
>just use sizeof() when it's referenced in the code.  That way if the
>buffer size is changed nothing will get missed.

sizeof() is better choice here, will use it in v3.

>> +		/* Last transfer with cs_change set, stop keeping CS */
>> +		if (list_is_last(&t->transfer_list, &msg->transfers)) {
>> +			keep_cs = true;
>> +			break;
>> +		}
>> +		ftdi_spi_chipselect(priv, spi, !(spi->mode & SPI_CS_HIGH));
>> +		usleep_range(10, 15);
>> +		ftdi_spi_chipselect(priv, spi, spi->mode & SPI_CS_HIGH);  
>
>I'm not clear what this is intended to do?  It's overall not clear to me
>that the driver needs to use transfer_one_message and not transfer_one,
>the latter keeps more of the code in common code.

It has been a while since I started with this driver, I don't remember
the intention of this chip select toggling here. I'll convert the
driver to use .transfer_one().

>> +	/* Find max. slave chipselect number */
>> +	num_cs = pd->spi_info_len;
>> +	for (i = 0; i < num_cs; i++) {
>> +		if (max_cs < pd->spi_info[i].chip_select)
>> +			max_cs = pd->spi_info[i].chip_select;
>> +	}
>> +
>> +	if (max_cs > 12) {
>> +		dev_err(dev, "Invalid max CS in platform data: %d\n", max_cs);
>> +		return -EINVAL;
>> +	}
>> +	dev_dbg(dev, "CS count %d, max CS %d\n", num_cs, max_cs);
>> +	max_cs += 1; /* including CS0 */  
>
>Why not just size the array based on the platform data?

The driver must also support multiple SPI slaves with additional control
pins (besides SPI chip-select gpios). There are devices with not adjacent
chip-select gpios or devices with single chip-select gpio starting at
some offset. The array size is not always the number of chip-selects
or the max. chip-select, e.g.:

$ tree /sys/bus/spi/devices/
/sys/bus/spi/devices/
├── spi0.4 -> ../../../devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2.4/2-1.2.4:1.0/ftdi-mpsse-spi.0/spi_master/spi0/spi0.4
├── spi1.0 -> ../../../devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2.3/2-1.2.3:1.0/ftdi-mpsse-spi.1/spi_master/spi1/spi1.0
├── spi1.12 -> ../../../devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2.3/2-1.2.3:1.0/ftdi-mpsse-spi.1/spi_master/spi1/spi1.12
├── spi1.4 -> ../../../devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2.3/2-1.2.3:1.0/ftdi-mpsse-spi.1/spi_master/spi1/spi1.4
└── spi1.8 -> ../../../devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2.3/2-1.2.3:1.0/ftdi-mpsse-spi.1/spi_master/spi1/spi1.8

$ sudo cat /sys/kernel/debug/gpio
gpiochip1: GPIOs 486-498, parent: usb/2-1.2.3:1.0, ftdi-mpsse-gpio.1, can sleep:
 gpio-486 (mpsse.1-CS          |spi-cs              ) out hi ACTIVE LOW
 gpio-487 (mpsse.1-GPIOL0      |confd               ) in  hi 
 gpio-488 (mpsse.1-GPIOL1      |nstat               ) in  hi ACTIVE LOW
 gpio-489 (mpsse.1-GPIOL2      |nconfig             ) out hi ACTIVE LOW
 gpio-490 (mpsse.1-GPIOL3      |spi-cs              ) out hi ACTIVE LOW
 gpio-491 (mpsse.1-GPIOH0      |confd               ) in  hi 
 gpio-492 (mpsse.1-GPIOH1      |nstat               ) in  hi ACTIVE LOW
 gpio-493 (mpsse.1-GPIOH2      |nconfig             ) out hi ACTIVE LOW
 gpio-494 (mpsse.1-GPIOH3      |spi-cs              ) out hi ACTIVE LOW
 gpio-495 (mpsse.1-GPIOH4      |confd               ) in  hi 
 gpio-496 (mpsse.1-GPIOH5      |nstat               ) in  hi ACTIVE LOW
 gpio-497 (mpsse.1-GPIOH6      |nconfig             ) out hi ACTIVE LOW
 gpio-498 (mpsse.1-GPIOH7      |spi-cs              ) out hi 

gpiochip0: GPIOs 499-511, parent: usb/2-1.2.4:1.0, ftdi-mpsse-gpio.0, can sleep:
 gpio-499 (mpsse.0-CS          )
 gpio-500 (mpsse.0-GPIOL0      )
 gpio-501 (mpsse.0-GPIOL1      )
 gpio-502 (mpsse.0-GPIOL2      )
 gpio-503 (mpsse.0-GPIOL3      |spi-cs              ) out hi ACTIVE LOW
 gpio-504 (mpsse.0-GPIOH0      |confd               ) in  hi 
 gpio-505 (mpsse.0-GPIOH1      |nstat               ) in  hi ACTIVE LOW
 gpio-506 (mpsse.0-GPIOH2      |nconfig             ) out hi ACTIVE LOW
 gpio-507 (mpsse.0-GPIOH3      )
 gpio-508 (mpsse.0-GPIOH4      )
 gpio-509 (mpsse.0-GPIOH5      )
 gpio-510 (mpsse.0-GPIOH6      )
 gpio-511 (mpsse.0-GPIOH7      )

Thanks,
Anatolij
