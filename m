Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755497AbeEaO2j (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:28:39 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33670 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755339AbeEaO2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:28:36 -0400
X-Google-Smtp-Source: ADUXVKJzFiCVWfUvQdCqNN3JjSwka0GDziQg9dXSlpNgod7kZ+LUjJ9+4MJxy8mrNzFyk4hv/THC2w==
Subject: Re: [PATCH 2/2] hwmon: (asus_atk0110) Remove unused manual sysfs file
 management
To: Bastian Germann <bastiangermann@fishpost.de>,
        Luca Tettamanti <kronos.it@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180531140136.13969-1-bastiangermann@fishpost.de>
 <20180531140136.13969-2-bastiangermann@fishpost.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <4cf55c08-3470-bb23-efa7-b7ecb70c1bdd@roeck-us.net>
Date: Thu, 31 May 2018 07:28:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180531140136.13969-2-bastiangermann@fishpost.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/31/2018 07:01 AM, Bastian Germann wrote:
> Remove the manual sysfs file creation and deletion that are now taken care
> of by the (un)register calls via an attribute_group array.
> 
> Signed-off-by: Bastian Germann <bastiangermann@fishpost.de>

Ah, there is the removal. That needs to be part of patch #1.

Thanks,
Guenter

> ---
>   drivers/hwmon/asus_atk0110.c | 46 ------------------------------------
>   1 file changed, 46 deletions(-)
> 
> diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
> index 8a35fb27ff50..2f4955ec8437 100644
> --- a/drivers/hwmon/asus_atk0110.c
> +++ b/drivers/hwmon/asus_atk0110.c
> @@ -263,14 +263,6 @@ static ssize_t atk_limit2_show(struct device *dev,
>   	return sprintf(buf, "%lld\n", value);
>   }
>   
> -static ssize_t atk_name_show(struct device *dev,
> -				struct device_attribute *attr, char *buf)
> -{
> -	return sprintf(buf, "atk0110\n");
> -}
> -static struct device_attribute atk_name_attr =
> -		__ATTR(name, 0444, atk_name_show, NULL);
> -
>   static void atk_init_attribute(struct device_attribute *attr, char *name,
>   		sysfs_show_func show)
>   {
> @@ -1194,44 +1186,6 @@ static int atk_enumerate_new_hwmon(struct atk_data *data)
>   	return err;
>   }
>   
> -static int atk_create_files(struct atk_data *data)
> -{
> -	struct atk_sensor_data *s;
> -	int err;
> -
> -	list_for_each_entry(s, &data->sensor_list, list) {
> -		err = device_create_file(data->hwmon_dev, &s->input_attr);
> -		if (err)
> -			return err;
> -		err = device_create_file(data->hwmon_dev, &s->label_attr);
> -		if (err)
> -			return err;
> -		err = device_create_file(data->hwmon_dev, &s->limit1_attr);
> -		if (err)
> -			return err;
> -		err = device_create_file(data->hwmon_dev, &s->limit2_attr);
> -		if (err)
> -			return err;
> -	}
> -
> -	err = device_create_file(data->hwmon_dev, &atk_name_attr);
> -
> -	return err;
> -}
> -
> -static void atk_remove_files(struct atk_data *data)
> -{
> -	struct atk_sensor_data *s;
> -
> -	list_for_each_entry(s, &data->sensor_list, list) {
> -		device_remove_file(data->hwmon_dev, &s->input_attr);
> -		device_remove_file(data->hwmon_dev, &s->label_attr);
> -		device_remove_file(data->hwmon_dev, &s->limit1_attr);
> -		device_remove_file(data->hwmon_dev, &s->limit2_attr);
> -	}
> -	device_remove_file(data->hwmon_dev, &atk_name_attr);
> -}
> -
>   static void atk_free_sensors(struct atk_data *data)
>   {
>   	struct list_head *head = &data->sensor_list;
> 
