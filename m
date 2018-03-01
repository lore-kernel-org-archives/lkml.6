Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031596AbeCAOm2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:42:28 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:32836 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031350AbeCAOmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:42:25 -0500
X-Google-Smtp-Source: AG47ELvyszFMBiyTTcQZFWHXw0/tijeMsWyHf053zkupA8gQH3gpPA9VQsY22OFfdNo6txU8bgCL3A==
Subject: Re: [PATCH v3] hwmon: g762: handle cleanup with devm_add_action
To: Peng Hao <peng.hao2@zte.com.cn>, jdelvare@suse.com
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1519915710-82397-1-git-send-email-peng.hao2@zte.com.cn>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <f2f23c95-7de3-4701-1691-cdd725e7bc18@roeck-us.net>
Date: Thu, 1 Mar 2018 06:42:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519915710-82397-1-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2018 06:48 AM, Peng Hao wrote:
> Simplify code and use devm_add_action() to handle cleanup.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>

Excellent.

The dummy function for g762_of_clock_disable() is no longer needed,
and the NULL check for ->clk in g762_of_clock_disable() is not needed
anymore either. No need to resend; I fixed that up.

Applied to hwmon-next.

Thanks,
Guenter

> ---
>   drivers/hwmon/g762.c | 58 +++++++++++++++++-----------------------------------
>   1 file changed, 19 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
> index 6d1208b..0f2d468 100644
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
> @@ -594,6 +593,17 @@ static int do_set_fan_startv(struct device *dev, unsigned long val)
>    * call to g762_of_clock_disable(). Note that a reference to clock is kept
>    * in our private data structure to be used in this function.
>    */
> +static void g762_of_clock_disable(void *data)
> +{
> +	struct g762_data *g762 = data;
> +
> +	if (!g762->clk)
> +		return;
> +
> +	clk_disable_unprepare(g762->clk);
> +	clk_put(g762->clk);
> +}
> +
>   static int g762_of_clock_enable(struct i2c_client *client)
>   {
>   	struct g762_data *data;
> @@ -625,7 +635,8 @@ static int g762_of_clock_enable(struct i2c_client *client)
>   
>   	data = i2c_get_clientdata(client);
>   	data->clk = clk;
> -
> +
> +	devm_add_action(&client->dev, g762_of_clock_disable, data);
>   	return 0;
>   
>    clk_unprep:
> @@ -637,17 +648,6 @@ static int g762_of_clock_enable(struct i2c_client *client)
>   	return ret;
>   }
>   
> -static void g762_of_clock_disable(struct i2c_client *client)
> -{
> -	struct g762_data *data = i2c_get_clientdata(client);
> -
> -	if (!data->clk)
> -		return;
> -
> -	clk_disable_unprepare(data->clk);
> -	clk_put(data->clk);
> -}
> -
>   static int g762_of_prop_import_one(struct i2c_client *client,
>   				   const char *pname,
>   				   int (*psetter)(struct device *dev,
> @@ -699,7 +699,7 @@ static int g762_of_clock_enable(struct i2c_client *client)
>   	return 0;
>   }
>   
> -static void g762_of_clock_disable(struct i2c_client *client) { }
> +static void g762_of_clock_disable(void *data) { }
>   #endif
>   
>   /*
> @@ -1054,6 +1054,7 @@ static inline int g762_fan_init(struct device *dev)
>   static int g762_probe(struct i2c_client *client, const struct i2c_device_id *id)
>   {
>   	struct device *dev = &client->dev;
> +	struct device *hwmon_dev;
>   	struct g762_data *data;
>   	int ret;
>   
> @@ -1080,35 +1081,15 @@ static int g762_probe(struct i2c_client *client, const struct i2c_device_id *id)
>   		return ret;
>   	ret = g762_of_prop_import(client);
>   	if (ret)
> -		goto clock_dis;
> +		return ret;
>   	/* ... or platform_data */
>   	ret = g762_pdata_prop_import(client);
>   	if (ret)
> -		goto clock_dis;
> +		return ret;
>   
> -	data->hwmon_dev = hwmon_device_register_with_groups(dev, client->name,
> +	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
>   							    data, g762_groups);
> -	if (IS_ERR(data->hwmon_dev)) {
> -		ret = PTR_ERR(data->hwmon_dev);
> -		goto clock_dis;
> -	}
> -
> -	return 0;
> -
> - clock_dis:
> -	g762_of_clock_disable(client);
> -
> -	return ret;
> -}
> -
> -static int g762_remove(struct i2c_client *client)
> -{
> -	struct g762_data *data = i2c_get_clientdata(client);
> -
> -	hwmon_device_unregister(data->hwmon_dev);
> -	g762_of_clock_disable(client);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
>   }
>   
>   static struct i2c_driver g762_driver = {
> @@ -1117,7 +1098,6 @@ static int g762_remove(struct i2c_client *client)
>   		.of_match_table = of_match_ptr(g762_dt_match),
>   	},
>   	.probe	  = g762_probe,
> -	.remove	  = g762_remove,
>   	.id_table = g762_id,
>   };
>   
> 
