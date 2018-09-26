Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF08C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 02:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4991208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 02:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4991208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=electromag.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeIZIlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 04:41:21 -0400
Received: from anchovy2.45ru.net.au ([203.30.46.146]:44121 "EHLO
        anchovy2.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeIZIlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 04:41:21 -0400
Received: (qmail 30136 invoked by uid 5089); 26 Sep 2018 02:30:41 -0000
Received: by simscan 1.2.0 ppid: 30074, pid: 30075, t: 0.3277s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950 spam: 3.1.4
X-RBL:  $rbltext
Received: from unknown (HELO ?192.168.0.122?) (preid@electromag.com.au@203.59.235.95)
  by anchovy3.45ru.net.au with ESMTPA; 26 Sep 2018 02:30:40 -0000
Subject: Re: [PATCH 2/2] iio: magnetometer: Add driver support for PNI RM3100
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        rtresidd@electromag.com.au, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180925031724.21399-1-songqiang1304521@gmail.com>
 <20180925031724.21399-2-songqiang1304521@gmail.com>
 <20180925143054.00007fcb@huawei.com>
 <57d8a9d6-c402-068e-0a21-bbd6c20a7816@electromag.com.au>
 <20180926014951.GA7094@Eros>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <4de691f2-dbc9-6124-efa6-66f2dd7e0f2b@electromag.com.au>
Date:   Wed, 26 Sep 2018 10:30:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926014951.GA7094@Eros>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2018 9:49 AM, Song Qiang wrote:
> On Tue, Sep 25, 2018 at 10:36:54PM +0800, Phil Reid wrote:
>> On 25/09/2018 9:30 PM, Jonathan Cameron wrote:
>>>> +static irqreturn_t rm3100_trigger_handler(int irq, void *p)
>>>> +{
>>>> +	struct iio_poll_func *pf = p;
>>>> +	struct iio_dev *indio_dev = pf->indio_dev;
>>>> +	struct rm3100_data *data = iio_priv(indio_dev);
>>>> +	struct regmap *regmap = data->regmap;
>>>> +	u8 buffer[9];
>>>> +	int ret;
>>>> +	int i;
>>>> +
>>>> +	mutex_lock(&data->lock);
>>>> +	ret = rm3100_wait_measurement(data);
>>>> +	if (ret < 0) {
>>>> +		mutex_unlock(&data->lock);
>>>> +		goto done;
>>>> +	}
>>>> +
>>>> +	ret = regmap_bulk_read(regmap, RM3100_REG_MX2, buffer, sizeof(buffer));
>>>> +	mutex_unlock(&data->lock);
>>>> +	if (ret < 0)
>>>> +		goto done;
>>>> +
>>>> +	/* Convert XXXYYYZZZxxx to XXXxYYYxZZZx. x for padding. */
>>>> +	for (i = 0; i < 3; i++)
>>>> +		memcpy(data->buffer + i * 4, buffer + i * 3, 3);
>>> Firstly X doesn't need copying.
>>> Secondly the copy of Y actually overwrites the value of Z
>>> XXXYYYZZZxxx
>>> XXXxYYYZZxxx
>>> XXXxYYYxYZZx
>>>
>>> I think...
>>>
>>>> +
>>>> +	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>>>> +			iio_get_time_ns(indio_dev));
>>
>> memcpy target is a different buffer so should be ok.
>>
>> But that raises the question of does it need to be?
>> 'buffer' could be 12 bytes long and just shuffle Z then Y.
>> Do the unused bytes need to be zeroed? or does libiio mask them anyway?
>>
>>
>>
>> -- 
>> Regards
>> Phil Reid
> 
> Hi Phil,
> 
> This is interesting, last patch I submitted uses three transactions and
> shuffles X, Y and Z respectively. You said it should be better to use one
> transactions, I thought it makes point, and one transaction may reduce
> IO pressure of the i2c bus. :)
> And that's not necessary for unused bytes to be zero. I'm not familiar
> with libiio, actually just been studying it, can't say anything about
> it.
> 
> yours,
> Song Qiang
> 
> 
G'day Song,

yes the one transaction suggestion was to reduce pressure on the bus.
I think also with 3 calls you can up up with other devices taking over
the i2c / spi bus in between.

We've got a devkit for this part, but haven't got to wiring it up to our system as yet.
We're looking at using the i2c interface which could push things at max samplerate, so yes I'm
keen to see bus pressure reduced as much as possible.

I was thinking something like the following:

u8 buffer[12];
regmap_bulk_read(regmap, RM3100_REG_MX2, buffer, 9);

buffer[10] = buffer[8]; // or memcpy or some other fancy shuffle code.
buffer[9]  = buffer[7];
buffer[8]  = buffer[6];

buffer[6]  = buffer[5];
buffer[5]  = buffer[4];
buffer[4]  = buffer[3];

iio_push_to_buffers_with_timestamp(indio_dev, buffer, iio_get_time_ns(indio_dev));

but I'm unsure if this would be needed:
buffer[7] = 0
buffer[3] = 0

What you've got does the job I think.

I haven't dug into the datasheet in great detail, and my iio knownledge is limited.
Are you sure the RM3100_CHANNEL scantype endianness is IIO_LE.
rm3100_read_mag looks to be doing big endian conversion and the datasheet agrees with that.


-- 
Regards
Phil Reid

