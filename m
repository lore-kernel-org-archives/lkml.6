Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4B9C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696C520989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="o45fCBIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfA1TKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:10:09 -0500
Received: from mout01.posteo.de ([185.67.36.65]:36450 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfA1TKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:10:08 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 338AB16005E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 20:10:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1548702605; bh=RnVTsv4U1o6/599BTc0A4JAbZ0xwy7rQI8+74Gv8nhY=;
        h=Date:From:To:Cc:Subject:From;
        b=o45fCBISonZZZf47XmN0kljiqwUIkOHLFAwUQydXZHRZaSeDPYr5AavxSGFlrcV84
         bfF6SW/cqC6FttXjRu5+ii12S9+sB5QS1GSDgVoHZAm0Lxn2t5AyyNgPlAaHfEd+lK
         Gf28rZVatwwGsAf9qrkVqbnVcwK30YncWN5iRHfbmGaiUBRrhDONB+1xFEDhRP7XDV
         EHomCF1C9NeVKL+NwwELXonrKBbj8NXqVVrGKCMzHpMpprbQA4C42IEMxMYgPabv23
         stxcMXBZDs3slTSnp2Vv4hM4GrBLpIjWONrqjVo8EnZON5o6PrXb711cZHbykX/Hfa
         T0z5PUMN/N+ZA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43pK2K5rJgz6tn7;
        Mon, 28 Jan 2019 20:10:01 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 28 Jan 2019 20:10:00 +0100
From:   Martin Kepplinger <martink@posteo.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: Re: [PATCH 2/3] Input: st1232 - add support for st1633
In-Reply-To: <20190128190334.GA34692@dtor-ws>
References: <20190128084449.16070-1-martink@posteo.de>
 <20190128084449.16070-2-martink@posteo.de> <20190128190334.GA34692@dtor-ws>
Message-ID: <894cb7d4749835325c4e0f9c65d31a63@posteo.de>
X-Sender: martink@posteo.de
User-Agent: Posteo Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 28.01.2019 20:03 schrieb Dmitry Torokhov:
> Hi Martin,
> 
> On Mon, Jan 28, 2019 at 09:44:48AM +0100, Martin Kepplinger wrote:
>> From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
>> 
>> Add support for the Sitronix ST1633 touchscreen controller to the 
>> st1232
>> driver. A protocol spec can be found here:
>> www.ampdisplay.com/documents/pdf/AM-320480B6TZQW-TC0H.pdf
>> 
>> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
>> ---
>>  drivers/input/touchscreen/Kconfig  |   6 +-
>>  drivers/input/touchscreen/st1232.c | 122 
>> +++++++++++++++++++++--------
>>  2 files changed, 94 insertions(+), 34 deletions(-)
>> 
>> diff --git a/drivers/input/touchscreen/Kconfig 
>> b/drivers/input/touchscreen/Kconfig
>> index 068dbbc610fc..7c597a49c265 100644
>> --- a/drivers/input/touchscreen/Kconfig
>> +++ b/drivers/input/touchscreen/Kconfig
>> @@ -1168,11 +1168,11 @@ config TOUCHSCREEN_SIS_I2C
>>  	  module will be called sis_i2c.
>> 
>>  config TOUCHSCREEN_ST1232
>> -	tristate "Sitronix ST1232 touchscreen controllers"
>> +	tristate "Sitronix ST1232 or ST1633 touchscreen controllers"
>>  	depends on I2C
>>  	help
>> -	  Say Y here if you want to support Sitronix ST1232
>> -	  touchscreen controller.
>> +	  Say Y here if you want to support the Sitronix ST1232
>> +	  or ST1633 touchscreen controller.
>> 
>>  	  If unsure, say N.
>> 
>> diff --git a/drivers/input/touchscreen/st1232.c 
>> b/drivers/input/touchscreen/st1232.c
>> index 11ff32c68025..19a665d48dad 100644
>> --- a/drivers/input/touchscreen/st1232.c
>> +++ b/drivers/input/touchscreen/st1232.c
>> @@ -23,13 +23,15 @@
>>  #include <linux/types.h>
>> 
>>  #define ST1232_TS_NAME	"st1232-ts"
>> +#define ST1633_TS_NAME	"st1633-ts"
>> +
>> +enum {
>> +	st1232,
>> +	st1633,
>> +};
> 
> This enum seems no longer needed, I dropped it.
> 
>> 
>>  #define MIN_X		0x00
>>  #define MIN_Y		0x00
> 
> Given we no longer have constant MAX_X/Y I simply used 0 in
> input_set_abs_params() and dropped MIN-X/Y.
> 
>> -#define MAX_X		0x31f	/* (800 - 1) */
>> -#define MAX_Y		0x1df	/* (480 - 1) */
>> -#define MAX_AREA	0xff
>> -#define MAX_FINGERS	2
>> 
>>  struct st1232_ts_finger {
>>  	u16 x;
>> @@ -38,12 +40,24 @@ struct st1232_ts_finger {
>>  	bool is_valid;
>>  };
>> 
>> +struct st_chip_info {
>> +	bool	have_z;
>> +	u16	max_x;
>> +	u16	max_y;
>> +	u16	max_area;
>> +	u16	max_fingers;
>> +	u8	start_reg;
>> +};
>> +
>>  struct st1232_ts_data {
>>  	struct i2c_client *client;
>>  	struct input_dev *input_dev;
>> -	struct st1232_ts_finger finger[MAX_FINGERS];
>>  	struct dev_pm_qos_request low_latency_req;
>>  	int reset_gpio;
> 
> Could you please create an additional patch converting this to gpiod?
> Instead of doing of_get_gpio()/gpio_is_valid()/devm_gpio_request() 
> smply
> do
> 
> 	ts->reset_gpio = devm_gpiod_get_optional();
> 	if (IS_ERR(ts->reset_gpio)) {
> 		...
> 	}
> 
> and later
> 
> 	if (ts->reset_gpio)
> 		...
> 
> Looking at the code it looks like reset is as usual active low, so you
> will need to invert the logic as gpiod takes care of convertion logical
> value to proper level (active low or high).

I'll test your applied changes and get back to this tomorrow.

thanks.

> 
>> +	const struct st_chip_info *chip_info;
>> +	int read_buf_len;
>> +	u8 *read_buf;
>> +	struct st1232_ts_finger *finger;
>>  };
>> 
>>  static int st1232_ts_read_data(struct st1232_ts_data *ts)
>> @@ -52,40 +66,35 @@ static int st1232_ts_read_data(struct 
>> st1232_ts_data *ts)
>>  	struct i2c_client *client = ts->client;
>>  	struct i2c_msg msg[2];
>>  	int error;
>> -	u8 start_reg;
>> -	u8 buf[10];
>> +	int i, y;
>> +	u8 start_reg = ts->chip_info->start_reg;
>> +	u8 *buf = ts->read_buf;
>> 
>> -	/* read touchscreen data from ST1232 */
>> +	/* read touchscreen data */
>>  	msg[0].addr = client->addr;
>>  	msg[0].flags = 0;
>>  	msg[0].len = 1;
>>  	msg[0].buf = &start_reg;
>> -	start_reg = 0x10;
>> 
>>  	msg[1].addr = ts->client->addr;
>>  	msg[1].flags = I2C_M_RD;
>> -	msg[1].len = sizeof(buf);
>> +	msg[1].len = ts->read_buf_len;
>>  	msg[1].buf = buf;
>> 
>>  	error = i2c_transfer(client->adapter, msg, 2);
>>  	if (error < 0)
>>  		return error;
>> 
>> -	/* get "valid" bits */
>> -	finger[0].is_valid = buf[2] >> 7;
>> -	finger[1].is_valid = buf[5] >> 7;
>> +	for (i = 0, y = 0; i < ts->chip_info->max_fingers; i++, y += 3) {
>> +		finger[i].is_valid = buf[i + y] >> 7;
>> +		if (finger[i].is_valid) {
>> +			finger[i].x = ((buf[i + y] & 0x0070) << 4) | buf[i + 1];
>> +			finger[i].y = ((buf[i + y] & 0x0007) << 8) | buf[i + 2];
>> 
>> -	/* get xy coordinate */
>> -	if (finger[0].is_valid) {
>> -		finger[0].x = ((buf[2] & 0x0070) << 4) | buf[3];
>> -		finger[0].y = ((buf[2] & 0x0007) << 8) | buf[4];
>> -		finger[0].t = buf[8];
>> -	}
>> -
>> -	if (finger[1].is_valid) {
>> -		finger[1].x = ((buf[5] & 0x0070) << 4) | buf[6];
>> -		finger[1].y = ((buf[5] & 0x0007) << 8) | buf[7];
>> -		finger[1].t = buf[9];
>> +			/* st1232 includes a z-axis / touch strength */
>> +			if (ts->chip_info->have_z)
>> +				finger[i].t = buf[i + 6];
>> +		}
>>  	}
>> 
>>  	return 0;
>> @@ -104,11 +113,14 @@ static irqreturn_t st1232_ts_irq_handler(int 
>> irq, void *dev_id)
>>  		goto end;
>> 
>>  	/* multi touch protocol */
>> -	for (i = 0; i < MAX_FINGERS; i++) {
>> +	for (i = 0; i < ts->chip_info->max_fingers; i++) {
>>  		if (!finger[i].is_valid)
>>  			continue;
>> 
>> -		input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR, finger[i].t);
>> +		if (ts->chip_info->have_z)
>> +			input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR,
>> +					 finger[i].t);
>> +
>>  		input_report_abs(input_dev, ABS_MT_POSITION_X, finger[i].x);
>>  		input_report_abs(input_dev, ABS_MT_POSITION_Y, finger[i].y);
>>  		input_mt_sync(input_dev);
>> @@ -142,12 +154,40 @@ static void st1232_ts_power(struct 
>> st1232_ts_data *ts, bool poweron)
>>  		gpio_direction_output(ts->reset_gpio, poweron);
>>  }
>> 
>> +static const struct st_chip_info st1232_chip_info = {
>> +		.have_z = true,
>> +		.max_x = 0x31f, /* 800 - 1 */
>> +		.max_y = 0x1df, /* 480 -1 */
>> +		.max_area = 0xff,
>> +		.max_fingers = 2,
>> +		.start_reg = 0x12,
>> +};
>> +
>> +static const struct st_chip_info st1633_chip_info = {
>> +		.have_z = false,
>> +		.max_x = 0x13f, /* 320 - 1 */
>> +		.max_y = 0x1df, /* 480 -1 */
>> +		.max_area = 0x00,
>> +		.max_fingers = 5,
>> +		.start_reg = 0x12,
>> +};
>> +
>>  static int st1232_ts_probe(struct i2c_client *client,
>>  			   const struct i2c_device_id *id)
>>  {
>>  	struct st1232_ts_data *ts;
>> +	struct st1232_ts_finger *finger;
>>  	struct input_dev *input_dev;
>>  	int error;
>> +	const struct st_chip_info *match = NULL;
> 
> There is no need to initialize with NULL given that we do unconditional
> assignment below. I removed initialization.
> 
>> +
>> +	match = device_get_match_data(&client->dev);
>> +	if (!match && id)
>> +		match = (const void *)id->driver_data;
>> +	if (!match) {
>> +		dev_err(&client->dev, "unknown device model\n");
>> +		return -ENODEV;
>> +	}
>> 
>>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
>>  		dev_err(&client->dev, "need I2C_FUNC_I2C\n");
>> @@ -163,6 +203,19 @@ static int st1232_ts_probe(struct i2c_client 
>> *client,
>>  	if (!ts)
>>  		return -ENOMEM;
>> 
>> +	ts->chip_info = match;
>> +	ts->finger = devm_kzalloc(&client->dev,
>> +				  sizeof(*finger) * ts->chip_info->max_fingers,
>> +				  GFP_KERNEL);
> 
> I replaced it with devm_kcalloc(&client->dev,
> 				ts->chip_info->max_fingers, sizeof(*finger),
> 				GFP_KERNEL);
> 
> and applied.
> 
>> +	if (!ts->finger)
>> +		return -ENOMEM;
>> +
>> +	/* allocate a buffer according to the number of registers to read */
>> +	ts->read_buf_len = ts->chip_info->max_fingers * 4;
>> +	ts->read_buf = devm_kzalloc(&client->dev, ts->read_buf_len, 
>> GFP_KERNEL);
>> +	if (!ts->read_buf)
>> +		return -ENOMEM;
>> +
>>  	input_dev = devm_input_allocate_device(&client->dev);
>>  	if (!input_dev)
>>  		return -ENOMEM;
>> @@ -192,9 +245,14 @@ static int st1232_ts_probe(struct i2c_client 
>> *client,
>>  	__set_bit(EV_KEY, input_dev->evbit);
>>  	__set_bit(EV_ABS, input_dev->evbit);
>> 
>> -	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, MAX_AREA, 0, 
>> 0);
>> -	input_set_abs_params(input_dev, ABS_MT_POSITION_X, MIN_X, MAX_X, 0, 
>> 0);
>> -	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, MIN_Y, MAX_Y, 0, 
>> 0);
>> +	if (ts->chip_info->have_z)
>> +		input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0,
>> +				     ts->chip_info->max_area, 0, 0);
>> +
>> +	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
>> +			     MIN_X, ts->chip_info->max_x, 0, 0);
>> +	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
>> +			     MIN_Y, ts->chip_info->max_y, 0, 0);
>> 
>>  	error = devm_request_threaded_irq(&client->dev, client->irq,
>>  					  NULL, st1232_ts_irq_handler,
>> @@ -261,13 +319,15 @@ static SIMPLE_DEV_PM_OPS(st1232_ts_pm_ops,
>>  			 st1232_ts_suspend, st1232_ts_resume);
>> 
>>  static const struct i2c_device_id st1232_ts_id[] = {
>> -	{ ST1232_TS_NAME, 0 },
>> +	{ ST1232_TS_NAME, (unsigned long)&st1232_chip_info },
>> +	{ ST1633_TS_NAME, (unsigned long)&st1633_chip_info },
>>  	{ }
>>  };
>>  MODULE_DEVICE_TABLE(i2c, st1232_ts_id);
>> 
>>  static const struct of_device_id st1232_ts_dt_ids[] = {
>> -	{ .compatible = "sitronix,st1232", },
>> +	{ .compatible = "sitronix,st1232", .data = &st1232_chip_info },
>> +	{ .compatible = "sitronix,st1633", .data = &st1633_chip_info },
>>  	{ }
>>  };
>>  MODULE_DEVICE_TABLE(of, st1232_ts_dt_ids);
>> --
>> 2.20.1
>> 
> 
> Thanks.

