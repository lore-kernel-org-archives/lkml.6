Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753622AbeE3PO0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:14:26 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.134]:23892 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbeE3POV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:14:21 -0400
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx2zAOrX/r2ZbrrxoyOl37jyAS87PDYJ9azvnITHNpDem7ChLghAqCJU8ykdftsfK97"
X-RZG-CLASS-ID: mo05
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at, miquel.raynal@bootlin.com,
        broonie@kernel.org, david.wolfe@nxp.com, fabio.estevam@nxp.com,
        prabhakar.kushwaha@nxp.com, yogeshnarayan.gaur@nxp.com, han.xu@nxp.com,
        linux-kernel@vger.kernel.org
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
 <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
 <20180530165816.371dc39c@bbrezillon>
From: Frieder Schrempf <frieder.schrempf@exceet.de>
Message-ID: <e55af89e-71ac-136e-09c6-98d20e133b78@exceet.de>
Date: Wed, 30 May 2018 17:13:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180530165816.371dc39c@bbrezillon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 30.05.2018 16:58, Boris Brezillon wrote:
> Hi Frieder,
> 
> On Wed, 30 May 2018 15:14:32 +0200
> Frieder Schrempf <frieder.schrempf@exceet.de> wrote:
> 
>> +
>> +static const char *fsl_qspi_get_name(struct spi_mem *mem)
>> +{
>> +	struct fsl_qspi *q = spi_controller_get_devdata(mem->spi->master);
>> +	struct device *dev = &mem->spi->dev;
>> +	const char *name;
>> +
>> +	/*
>> +	 * In order to keep mtdparts compatible with the old MTD driver at
>> +	 * mtd/spi-nor/fsl-quadspi.c, we set a custom name derived from the
>> +	 * platform_device of the controller.
>> +	 */
>> +	if (of_get_available_child_count(q->dev->of_node) == 1)
>> +		name = dev_name(q->dev);
>> +	else
>> +		name = devm_kasprintf(dev, GFP_KERNEL,
>> +				      "%s-%d", dev_name(q->dev),
>> +				      mem->spi->chip_select);
>> +
>> +	if (!name) {
>> +		dev_err(dev, "failed to get memory for custom flash name\n");
>> +		return dev_name(q->dev);
> 
> Hm, not sure that's what we want. We should probably fail when the
> allocation fails.

Right, we should definitely fail when the allocation fails.

> 
> How about letting ->get_name() return an error pointer or NULL in case
> of error. With the other I made suggestion in my review of patch 1
> (calling ->get_name() at probe time) you could refuse to probe the
> device when ->get_name() fails.

Ok, I will change that.

Thanks,

Frieder

> 
>> +	}
>> +
>> +	return name;
>> +}
>> +
> 
> Regards,
> 
> Boris
> 
