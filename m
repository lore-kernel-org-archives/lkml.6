Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3479EC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA99620850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA99620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934773AbeFRMAN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:00:13 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:63700 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933079AbeFRMAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:00:10 -0400
X-IronPort-AV: E=Sophos;i="5.51,239,1526367600"; 
   d="scan'208";a="15349764"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Jun 2018 05:00:09 -0700
Received: from [10.145.6.76] (10.10.76.4) by chn-sv-exch04.mchp-main.com
 (10.10.76.105) with Microsoft SMTP Server id 14.3.352.0; Mon, 18 Jun 2018
 05:00:08 -0700
Subject: Re: [PATCH v2] mtd: atmel-quadspi: add suspend/resume hooks
To:     Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <richard@nod.at>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1528101993-4772-1-git-send-email-claudiu.beznea@microchip.com>
 <20180618114920.654647c0@bbrezillon>
 <8474a744-5552-932f-7ba8-85b7d95368ea@gmail.com>
From:   Claudiu Beznea <Claudiu.Beznea@microchip.com>
Message-ID: <0be344a2-9878-2b92-9436-bc2f4d4fd6e0@microchip.com>
Date:   Mon, 18 Jun 2018 15:00:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <8474a744-5552-932f-7ba8-85b7d95368ea@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.06.2018 12:53, Marek Vasut wrote:
> On 06/18/2018 11:49 AM, Boris Brezillon wrote:
>> Hi Claudiu,
>>
>> The subject prefix should be "mtd: spi-nor: atmel-quadspi: ". No need
>> to send a new version just for that, I'll fix it when applying the
>> patch.
>>
Hi Boris,

Thank you!

>> Looks good otherwise. Marek, any objection? If not, can you add your
>> Acked-by?
> 
> Will this work if you have ie. ubifs mounted on that QSPI NOR and you
> suspect and resume during IO ? I think it would, but just curious if
> there could be some problem.

Hi Marek,

I tested only with read/writes while suspending, simple scripts, but not
having ubifs mounted on QSPI NOR. I will double check also with ubifs
mounted on QSPI NOR and come back with the results.

Thank you,
Claudiu

> 
>> Thanks,
>>
>> Boris
>>
>> On Mon, 4 Jun 2018 11:46:33 +0300
>> Claudiu Beznea <claudiu.beznea@microchip.com> wrote:
>>
>>> Implement suspend/resume hooks.
>>>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>>> ---
>>>
>>> Changes in v2:
>>> - use __maybe_unused instead of #ifdef CONFIG_PM_SLEEP
>>>
>>>  drivers/mtd/spi-nor/atmel-quadspi.c | 21 +++++++++++++++++++++
>>>  1 file changed, 21 insertions(+)
>>>
>>> diff --git a/drivers/mtd/spi-nor/atmel-quadspi.c b/drivers/mtd/spi-nor/atmel-quadspi.c
>>> index 6c5708bacad8..ceaaef47f02e 100644
>>> --- a/drivers/mtd/spi-nor/atmel-quadspi.c
>>> +++ b/drivers/mtd/spi-nor/atmel-quadspi.c
>>> @@ -737,6 +737,26 @@ static int atmel_qspi_remove(struct platform_device *pdev)
>>>  	return 0;
>>>  }
>>>  
>>> +static int __maybe_unused atmel_qspi_suspend(struct device *dev)
>>> +{
>>> +	struct atmel_qspi *aq = dev_get_drvdata(dev);
>>> +
>>> +	clk_disable_unprepare(aq->clk);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int __maybe_unused atmel_qspi_resume(struct device *dev)
>>> +{
>>> +	struct atmel_qspi *aq = dev_get_drvdata(dev);
>>> +
>>> +	clk_prepare_enable(aq->clk);
>>> +
>>> +	return atmel_qspi_init(aq);
>>> +}
>>> +
>>> +static SIMPLE_DEV_PM_OPS(atmel_qspi_pm_ops, atmel_qspi_suspend,
>>> +			 atmel_qspi_resume);
>>>  
>>>  static const struct of_device_id atmel_qspi_dt_ids[] = {
>>>  	{ .compatible = "atmel,sama5d2-qspi" },
>>> @@ -749,6 +769,7 @@ static struct platform_driver atmel_qspi_driver = {
>>>  	.driver = {
>>>  		.name	= "atmel_qspi",
>>>  		.of_match_table	= atmel_qspi_dt_ids,
>>> +		.pm	= &atmel_qspi_pm_ops,
>>>  	},
>>>  	.probe		= atmel_qspi_probe,
>>>  	.remove		= atmel_qspi_remove,
> 
> 
