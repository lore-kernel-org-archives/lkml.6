Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6690C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B5F240F1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B5F240F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loewensteinmedical.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932413AbeGBGxH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 02:53:07 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:38288 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753339AbeGBGxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 02:53:05 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 9496E41BAC; Mon,  2 Jul 2018 08:53:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 8C5CC40B88;
        Mon,  2 Jul 2018 08:53:00 +0200 (CEST)
Date:   Mon, 2 Jul 2018 08:53:00 +0200 (CEST)
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
X-X-Sender: nv@fox.voss.local
To:     Jonathan Cameron <jic23@kernel.org>
cc:     "Voss, Dr. Nikolaus" <Nikolaus.Dr.Voss@loewensteinmedical.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] IIO: st_accel_i2c.c: Use fallback if DT/ACPI enum
 failed
In-Reply-To: <20180630162803.3a2ad759@archlinux>
Message-ID: <alpine.DEB.2.20.1807020843100.31768@fox.voss.local>
References: <cover.1530268235.git.nikolaus.voss@loewensteinmedical.de> <a84243a1a15d11511061eeae2f09c0ad8154d093.1530268235.git.nikolaus.voss@loewensteinmedical.de> <20180630162803.3a2ad759@archlinux>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jun 2018, Jonathan Cameron wrote:

> On Fri, 29 Jun 2018 10:10:10 +0200
> Nikolaus Voss <nikolaus.voss@loewensteinmedical.de> wrote:
>
>> Currently, the driver bails out if not explicitly referred to in
>> DT or ACPI tables. This prevents fallback mechanisms from coming
>> into effect, e.g. I2C device ID table match via DT or ACPI
>> PRP0001 HID. However DT/ACPI enum should take precedence over
>> the fallback, so evaluate that first.
>>
>> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
>
> Is the change to probe_new actually related to the rest of the change?
>
> I can't immediately see why...  If not I would prefer that as a separate
> change.

Well, it is, because the id table pointer of the old probe() is not 
used any more.

>
>> ---
>>  drivers/iio/accel/st_accel_i2c.c | 21 ++++++++++++---------
>>  1 file changed, 12 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
>> index 6bdec8c451e0..e360da407027 100644
>> --- a/drivers/iio/accel/st_accel_i2c.c
>> +++ b/drivers/iio/accel/st_accel_i2c.c
>> @@ -138,8 +138,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
>>  };
>>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
>>
>> -static int st_accel_i2c_probe(struct i2c_client *client,
>> -						const struct i2c_device_id *id)
>> +static int st_accel_i2c_probe(struct i2c_client *client)
>>  {
>>  	struct iio_dev *indio_dev;
>>  	struct st_sensor_data *adata;
>> @@ -156,14 +155,18 @@ static int st_accel_i2c_probe(struct i2c_client *client,
>>  					 client->name, sizeof(client->name));
>>  	} else if (ACPI_HANDLE(&client->dev)) {
>>  		ret = st_sensors_match_acpi_device(&client->dev);
>> -		if ((ret < 0) || (ret >= ST_ACCEL_MAX))
>> -			return -ENODEV;
>> -
>> -		strlcpy(client->name, st_accel_id_table[ret].name,
>> +		if ((ret >= 0) && (ret < ST_ACCEL_MAX))
>> +			strlcpy(client->name, st_accel_id_table[ret].name,
>>  				sizeof(client->name));
>> -	} else if (!id)
>> -		return -ENODEV;
>> +	}
>>
>> +	/*
>> +	 * If OF and ACPI enumeration failed, there could still be platform
>> +	 * information via fallback enumeration or explicit instantiation, so
>> +	 * check if id table has been matched via client->name.
>> +	 */
>> +	if (!client->name)
>> +		return -ENODEV;
>>
>>  	st_sensors_i2c_configure(indio_dev, client, adata);
>>
>> @@ -187,7 +190,7 @@ static struct i2c_driver st_accel_driver = {
>>  		.of_match_table = of_match_ptr(st_accel_of_match),
>>  		.acpi_match_table = ACPI_PTR(st_accel_acpi_match),
>>  	},
>> -	.probe = st_accel_i2c_probe,
>> +	.probe_new = st_accel_i2c_probe,
>>  	.remove = st_accel_i2c_remove,
>>  	.id_table = st_accel_id_table,
>>  };
>
>
