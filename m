Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76211C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C9F20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C9F20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=skidata.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbeJQD0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 23:26:36 -0400
Received: from mail2.skidata.com ([91.230.2.91]:56463 "EHLO mail2.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbeJQD0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 23:26:35 -0400
X-IronPort-AV: E=Sophos;i="5.54,389,1534802400"; 
   d="scan'208";a="1730246"
Subject: Re: [PATCH 6/7] Input: sx8654 - add sx8650 support
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>
References: <20181016091653.26896-1-richard.leitner@skidata.com>
 <20181016092248.27288-1-richard.leitner@skidata.com>
 <20181016174838.GD230131@dtor-ws>
From:   Richard Leitner <richard.leitner@skidata.com>
Message-ID: <575f935b-e082-7d19-30c1-4db36ed6114d@skidata.com>
Date:   Tue, 16 Oct 2018 21:34:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181016174838.GD230131@dtor-ws>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex5srv.skidata.net (192.168.111.83) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/16/18 7:48 PM, Dmitry Torokhov wrote:
> On Tue, Oct 16, 2018 at 11:22:48AM +0200, Richard Leitner wrote:
>> The sx8654 and sx8650 are quite similar, therefore add support for the
>> sx8650 within the sx8654 driver.
>>

...

>>   
>>   /* bits for I2C_REG_CHANMASK */
>> -#define CONV_X				0x80
>> -#define CONV_Y				0x40
>> +#define CONV_X				BIT(7)
>> +#define CONV_Y				BIT(6)
> 
> If you are using BIT() you need to include include/linux/bitops.h
> 
> I also would prefer conversion to using BIT() as a separate patch.

OK. I'll take it out of this patch.

Should I convert them (and the other #defines where it makes sense) to 
BIT() at all?

> 
>>   
>>   /* coordinates rate: higher nibble of CTRL0 register */
>>   #define RATE_MANUAL			0x00
>> @@ -71,14 +75,110 @@
>>   /* power delay: lower nibble of CTRL0 register */
>>   #define POWDLY_1_1MS			0x0b
>>   
>> +/* for sx8650, as we have no pen release IRQ there: timeout in ns following the
>> + * last PENIRQ after which we assume the pen is lifted.
>> + */
>> +#define SX8650_PENIRQ_TIMEOUT		(80 * 1100 * 1000)
>> +
>>   #define MAX_12BIT			((1 << 12) - 1)
>> +#define MAX_I2C_READ_LEN		10 /* see datasheet section 5.1.5 */
>> +
>> +/* channel definition */
>> +#define CH_X				0x00
>> +#define CH_Y				0x01
>> +
>> +struct sx865x_data {
>> +	u8 cmd_manual;
>> +	u8 chan_mask;
>> +	u8 has_irq_penrelease;
>> +	u8 has_reg_irqmask;
>> +	irq_handler_t irqh;
>> +};
>>   
>>   struct sx8654 {
>>   	struct input_dev *input;
>>   	struct i2c_client *client;
>>   	struct gpio_desc *gpio_reset;
>> +	struct hrtimer timer;
> 
> Does this have to be hrtimer? Can regular timer be used?

I'll check again if it's feasible to reduce the timer delay to something 
below the "normal" jiffy. If not I'll replace the hrtimer with a timer.

> 
>> +
>> +	const struct sx865x_data *data;
>>   };
>>   
>> +static enum hrtimer_restart sx865x_penrelease_timer_handler(struct hrtimer *h)
>> +{
>> +	struct sx8654 *ts = container_of(h, struct sx8654, timer);
>> +
>> +	input_report_key(ts->input, BTN_TOUCH, 0);
>> +	input_sync(ts->input);
>> +	dev_dbg(&ts->client->dev, "penrelease by timer\n");
>> +
>> +	return HRTIMER_NORESTART;
>> +}
>> +

...

>> @@ -196,10 +312,30 @@ static void sx8654_close(struct input_dev *dev)
>>   }
>>   
>>   #ifdef CONFIG_OF
>> +static const struct of_device_id sx8654_of_match[] = {
>> +	{
>> +		.compatible = "semtech,sx8650",
>> +		.data = &sx8650_data,
>> +	}, {
>> +		.compatible = "semtech,sx8654",
>> +		.data = &sx8654_data,
>> +	}, {
>> +		.compatible = "semtech,sx8655",
>> +		.data = &sx8654_data,
>> +	}, {
>> +		.compatible = "semtech,sx8656",
>> +		.data = &sx8654_data,
>> +	}, {},
>> +};
>> +MODULE_DEVICE_TABLE(of, sx8654_of_match);
>> +
>>   static int sx8654_get_ofdata(struct sx8654 *ts)
>>   {
>>   	struct device *dev = &ts->client->dev;
>>   	struct device_node *node = dev->of_node;
>> +	const struct of_device_id *of_id = of_match_device(sx8654_of_match,
>> +							   dev);
> 
> If you use of_device_get_match_data() you do not need to move device
> table around.

Thanks for that hint. I haven't known there's something like this ;-)

> 
>> +	const struct sx865x_data *data = (struct sx865x_data *)of_id->data;
>>   	int err;
>>   
>>   	if (!node) {

...

>> @@ -327,6 +466,7 @@ static int sx8654_probe(struct i2c_client *client,
>>   }
>>   
>>   static const struct i2c_device_id sx8654_id_table[] = {
>> +	{ "semtech_sx8650", 0 },
> 
> Can we add the data here as well?

Does it generate any benefit if we add it? Who should be using it?

I found in other drivers that it's used as a fallback when 
of_device_get_match_data() returns NULL... Should I also implement it 
that way?

> 
>>   	{ "semtech_sx8654", 0 },
>>   	{ "semtech_sx8655", 0 },
>>   	{ "semtech_sx8656", 0 },
>> -- 
>> 2.11.0
>>
> 
> Thanks.
> 

thanks&regards;Richard.L
