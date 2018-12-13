Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E03C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241282146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241282146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbeLMLzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:55:04 -0500
Received: from mail-sz2.amlogic.com ([211.162.65.114]:56120 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbeLMLzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 06:55:02 -0500
Received: from [10.28.18.96] (10.28.18.96) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 13 Dec
 2018 19:55:15 +0800
Subject: Re: [PATCH v2 1/3] spi: meson-axg: support MAX 80M clock
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Mark Brown <broonie@kernel.org>
CC:     Yixun Lan <yixun.lan@amlogic.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        <linux-spi@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
 <1544690354-16409-2-git-send-email-sunny.luo@amlogic.com>
 <2d438907-91b5-7443-24f9-57a406aaa040@baylibre.com>
From:   Sunny Luo <sunny.luo@amlogic.com>
Message-ID: <13e10889-50ce-4f67-cf60-f7a4917f84f5@amlogic.com>
Date:   Thu, 13 Dec 2018 19:55:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <2d438907-91b5-7443-24f9-57a406aaa040@baylibre.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.18.96]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On 2018/12/13 16:49, Neil Armstrong wrote:
> Hi Sunny,
> 
> On 13/12/2018 09:39, Sunny Luo wrote:
>> The SPICC controller in Meson-AXG is capable of running at 80M clock.
>> The ASIC IP is improved and the clock is actually running higher than
>> previous old SoCs.
>>
>> Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>   drivers/spi/spi-meson-spicc.c | 37 +++++++++++++++++++++++++++++--------
>>   1 file changed, 29 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
>> index 7fe4488..b56249d 100644
>> --- a/drivers/spi/spi-meson-spicc.c
>> +++ b/drivers/spi/spi-meson-spicc.c
>> @@ -9,11 +9,13 @@
>>   
>>   #include <linux/bitfield.h>
>>   #include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>>   #include <linux/device.h>
>>   #include <linux/io.h>
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>> +#include <linux/of_device.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/spi/spi.h>
>>   #include <linux/types.h>
>> @@ -34,7 +36,6 @@
>>    *   to have a CS go down over the full transfer
>>    */
>>   
>> -#define SPICC_MAX_FREQ	30000000
>>   #define SPICC_MAX_BURST	128
>>   
>>   /* Register Map */
>> @@ -120,6 +121,10 @@
>>   #define SPICC_BURST_MAX	16
>>   #define SPICC_FIFO_HALF 10
>>   
>> +struct meson_spicc_data {
>> +	unsigned int			max_speed_hz;
>> +};
>> +
>>   struct meson_spicc_device {
>>   	struct spi_master		*master;
>>   	struct platform_device		*pdev;
>> @@ -127,6 +132,7 @@ struct meson_spicc_device {
>>   	struct clk			*core;
>>   	struct spi_message		*message;
>>   	struct spi_transfer		*xfer;
>> +	const struct meson_spicc_data	*data;
>>   	u8				*tx_buf;
>>   	u8				*rx_buf;
>>   	unsigned int			bytes_per_word;
>> @@ -517,6 +523,9 @@ static int meson_spicc_probe(struct platform_device *pdev)
>>   	spicc->pdev = pdev;
>>   	platform_set_drvdata(pdev, spicc);
>>   
>> +	spicc->data = (const struct meson_spicc_data *)
>> +		of_device_get_match_data(&pdev->dev);
>> +
>>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>   	spicc->base = devm_ioremap_resource(&pdev->dev, res);
>>   	if (IS_ERR(spicc->base)) {
>> @@ -567,11 +576,9 @@ static int meson_spicc_probe(struct platform_device *pdev)
>>   	master->unprepare_transfer_hardware = meson_spicc_unprepare_transfer;
>>   	master->transfer_one = meson_spicc_transfer_one;
>>   
>> -	/* Setup max rate according to the Meson GX datasheet */
>> -	if ((rate >> 2) > SPICC_MAX_FREQ)
>> -		master->max_speed_hz = SPICC_MAX_FREQ;
>> -	else
>> -		master->max_speed_hz = rate >> 2;
>> +	/* Setup max rate according to the Meson datasheet */
>> +	master->max_speed_hz = min_t(unsigned int, rate >> 1,
>> +				     spicc->data->max_speed_hz);
> 
> I think "rate >> 1" here depends on patch 3, either move patch 3 before this one
> or keep "rate >> 2" and change it back to "rate >> 1" on patch 3.
> 
Yes, this change should be in patch 3.

>>   
>>   	ret = devm_spi_register_master(&pdev->dev, master);
>>   	if (ret) {
>> @@ -602,9 +609,23 @@ static int meson_spicc_remove(struct platform_device *pdev)
>>   	return 0;
>>   }
>>   
>> +static const struct meson_spicc_data meson_spicc_gx_data = {
>> +	.max_speed_hz	= 30000000,
>> +};
>> +
>> +static const struct meson_spicc_data meson_spicc_axg_data = {
>> +	.max_speed_hz	= 80000000,
>> +};
>> +
>>   static const struct of_device_id meson_spicc_of_match[] = {
>> -	{ .compatible = "amlogic,meson-gx-spicc", },
>> -	{ .compatible = "amlogic,meson-axg-spicc", },
>> +	{
>> +		.compatible	= "amlogic,meson-gx-spicc",
>> +		.data		= &meson_spicc_gx_data,
>> +	},
>> +	{
>> +		.compatible = "amlogic,meson-axg-spicc",
>> +		.data		= &meson_spicc_axg_data,
>> +	},
>>   	{ /* sentinel */ }
>>   };
>>   MODULE_DEVICE_TABLE(of, meson_spicc_of_match);
>>
> 
> .
> 
