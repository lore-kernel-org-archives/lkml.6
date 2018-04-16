Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753058AbeDPRsM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 13:48:12 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:58399 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752826AbeDPRsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 13:48:11 -0400
Subject: Re: [PATCH 1/1] hwmon: (ina2xx) initialize mutex before locking
To: Guenter Roeck <linux@roeck-us.net>
CC: <jdelvare@suse.com>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        chombour <Cedric_Hombourger@mentor.com>,
        ahsann <Noor_Ahsan@mentor.com>, <m.purski@samsung.com>
References: <f286b0f4-948f-74a7-6dc1-90ca88f3dcdc@mentor.com>
 <20180416172858.GA9447@roeck-us.net>
From: Ahsan Hussain <ahsan_hussain@mentor.com>
Organization: Mentor Graphics
Message-ID: <78aeafda-03f2-de62-f6bd-6bd7b81ea201@mentor.com>
Date: Mon, 16 Apr 2018 22:48:03 +0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180416172858.GA9447@roeck-us.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [137.202.0.87]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/16/2018 10:28 PM, Guenter Roeck wrote:
> On Mon, Apr 16, 2018 at 10:08:19PM +0500, Ahsan Hussain wrote:
>>
>> Upstream commit
>>
>> 8d008c0c ("hwmon: (ina2xx) Make calibration register value fixed")
>>
> This doesn't have to be on separate lines; as written, it just causes
> confusion.
> 
Will do in my next email.
>> makes ina2xx_set_shunt() call mutex_lock on an un-initialized mutex.
>> Initialize it prior so we don't get a NULL pointer dereference error
>>
>> Signed-off-by: Ahsan Hussain <ahsan_hussain@mentor.com>
> 
> Good find, but your patch is corrupted to the point where any attenpt to
> fix it up on my side failed. Please resend without corruption, and please
> provide a Fixes: line.
Appologies. This must be Thunderbird, I've been trying to coax into
doing otherwise. Will send the corrected patch shortly.
> 
> Thanks,
> Guenter
> 
>> ---
>>  drivers/hwmon/ina2xx.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
>> index a629f7c..1304f01 100644
>> --- a/drivers/hwmon/ina2xx.c
>> +++ b/drivers/hwmon/ina2xx.c
>> @@ -457,6 +457,8 @@ static int ina2xx_probe(struct i2c_client *client,
>>  			val = INA2XX_RSHUNT_DEFAULT;
>>  	}
>>  +	mutex_init(&data->config_lock);
>> +
>>  	ina2xx_set_shunt(data, val);
>>   	ina2xx_regmap_config.max_register = data->config->registers;
>> @@ -473,8 +475,6 @@ static int ina2xx_probe(struct i2c_client *client,
>>  		return -ENODEV;
>>  	}
>>  -	mutex_init(&data->config_lock);
>> -
>>  	data->groups[group++] = &ina2xx_group;
>>  	if (id->driver_data == ina226)
>>  		data->groups[group++] = &ina226_group;
>> -- 
>> 2.7.4
>>
