Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932475AbeB1OqB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:46:01 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:32966 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932241AbeB1Op4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:45:56 -0500
X-Google-Smtp-Source: AH8x227iDVdSxoZQ9GaXbO+5KaTjQpug27oiBdwX/Qn1zLzRr54eOey5XxD53R26j6v6ZW82DY0zUQ==
Subject: Re: [PATCH] hwmon: g762: handle cleanup with devm_add_action
To: Peng Hao <peng.hao2@zte.com.cn>, jdelvare@suse.com
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1519833106-74874-1-git-send-email-peng.hao2@zte.com.cn>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <fa30c24f-f637-b800-59a3-8bcea3a3fbec@roeck-us.net>
Date: Wed, 28 Feb 2018 06:45:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519833106-74874-1-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/2018 07:51 AM, Peng Hao wrote:
> Simplify code and use devm_add_action() to handle cleanup.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>

Excellent idea. Some suggestions for improvements below.

> ---
>   drivers/hwmon/g762.c | 30 ++++++++++++++----------------
>   1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
> index 6d1208b..48e60d8 100644
> --- a/drivers/hwmon/g762.c
> +++ b/drivers/hwmon/g762.c
> @@ -128,7 +128,6 @@ enum g762_regs {
>   			 G762_REG_FAN_CMD2_GEAR_MODE_1)) >> 2))
>   
>   struct g762_data {
> -	struct device *hwmon_dev;
>   	struct i2c_client *client;
>   	struct clk *clk;
>   
> @@ -1051,9 +1050,17 @@ static inline int g762_fan_init(struct device *dev)
>   					 data->fan_cmd1);
>   }
>   
> +static void g762_remove(void *data)
> +{
> +	struct g762_data *g762 = data;
> +	struct i2c_client *client = g762->client;
> +
> +	g762_of_clock_disable(client);
> +}

You could instead just modify the arguments of g762_of_clock_disable()
and call it directly.

>   static int g762_probe(struct i2c_client *client, const struct i2c_device_id *id)
>   {
>   	struct device *dev = &client->dev;
> +	struct device *hwmon_dev;
>   	struct g762_data *data;
>   	int ret;
>   
> @@ -1086,10 +1093,12 @@ static int g762_probe(struct i2c_client *client, const struct i2c_device_id *id)
>   	if (ret)
>   		goto clock_dis;
>   
> -	data->hwmon_dev = hwmon_device_register_with_groups(dev, client->name,
> -							    data, g762_groups);
> -	if (IS_ERR(data->hwmon_dev)) {
> -		ret = PTR_ERR(data->hwmon_dev);
> +	devm_add_action(dev, g762_remove, data);

Move this into g762_of_clock_enable(), just before the return, and the
dummy cleanup function can be dropped. You can then also drop the clock_dis:
label amd instead return immediately on errors.

> +
> +	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
> +							   data, g762_groups);
> +	if (IS_ERR(hwmon_dev)) {
> +		ret = PTR_ERR(hwmon_dev);
>   		goto clock_dis;

Either case this would now be wrong since the cleanup is handled automatically.
This can be changed to
	return PTR_ERR_OR_ZERO(hwmon_dev);

>   	}
>   
> @@ -1101,23 +1110,12 @@ static int g762_probe(struct i2c_client *client, const struct i2c_device_id *id)
>   	return ret;
>   }
>   
> -static int g762_remove(struct i2c_client *client)
> -{
> -	struct g762_data *data = i2c_get_clientdata(client);
> -
> -	hwmon_device_unregister(data->hwmon_dev);
> -	g762_of_clock_disable(client);
> -
> -	return 0;
> -}
> -
>   static struct i2c_driver g762_driver = {
>   	.driver = {
>   		.name = DRVNAME,
>   		.of_match_table = of_match_ptr(g762_dt_match),
>   	},
>   	.probe	  = g762_probe,
> -	.remove	  = g762_remove,
>   	.id_table = g762_id,
>   };
>   
> 
