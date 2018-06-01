Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbeFAN2e (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:28:34 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:47075 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbeFAN2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:28:32 -0400
X-Google-Smtp-Source: ADUXVKIYfiVm6ueLxi14GRdsf3bVf1ZjbFdCeKvM/RSitmVH/c/Cp328ZrLk41LOne0HuW7ZfZRCaQ==
Subject: Re: [PATCH 1/2] hwmon: (asus_atk0110) Replace deprecated device
 register call
To: Bastian Germann <bastiangermann@fishpost.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Luca Tettamanti <kronos.it@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CAHp75VcZqpQ7qM2aBzSsqa+xYOdevZkWy=h+u8=nhdP2foyH4g@mail.gmail.com>
 <20180601110719.3281-1-bastiangermann@fishpost.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <8afcabf0-94c2-8068-5252-491494108a0c@roeck-us.net>
Date: Fri, 1 Jun 2018 06:28:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180601110719.3281-1-bastiangermann@fishpost.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2018 04:07 AM, Bastian Germann wrote:
> Make the asus_atk0110 driver use hwmon_device_register_with_groups instead
> of the deprecated hwmon_device_register.
> Construct the expected attribute_group array from the sensor list which
> contains all needed attributes.
> Remove the manual sysfs file creation and deletion that are now taken care
> of by the (un)register calls via the attribute_group array.
> 
> Signed-off-by: Bastian Germann <bastiangermann@fishpost.de>

Please version your patches, and provide a change log.

You are forcing me to spend time finding the latest version, and I have
to compare the various versions line by line to find out what changed
and if you addressed all comments.

Thanks,
Guenter

> ---
>   drivers/hwmon/asus_atk0110.c | 75 ++++++++++++------------------------
>   1 file changed, 25 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
> index 975c43d446f8..33748cc07acc 100644
> --- a/drivers/hwmon/asus_atk0110.c
> +++ b/drivers/hwmon/asus_atk0110.c
> @@ -125,6 +125,8 @@ struct atk_data {
>   	int temperature_count;
>   	int fan_count;
>   	struct list_head sensor_list;
> +	struct attribute_group attr_group[2];
> +	const struct attribute_group *attr_groups[2];
>   
>   	struct {
>   		struct dentry *root;
> @@ -262,14 +264,6 @@ static ssize_t atk_limit2_show(struct device *dev,
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
> @@ -1193,42 +1187,30 @@ static int atk_enumerate_new_hwmon(struct atk_data *data)
>   	return err;
>   }
>   
> -static int atk_create_files(struct atk_data *data)
> +static int atk_init_attribute_groups(struct atk_data *data)
>   {
> +	struct device *dev = &data->acpi_dev->dev;
>   	struct atk_sensor_data *s;
> -	int err;
> +	struct attribute **attrs;
> +	int i = 0;
> +	int len = (data->voltage_count + data->temperature_count
> +			+ data->fan_count) * 4 + 1;
> +
> +	attrs = devm_kcalloc(dev, len, sizeof(struct attribute *), GFP_KERNEL);
> +	if (!attrs)
> +		return -ENOMEM;
>   
>   	list_for_each_entry(s, &data->sensor_list, list) {
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
> +		attrs[i++] = &s->input_attr.attr;
> +		attrs[i++] = &s->label_attr.attr;
> +		attrs[i++] = &s->limit1_attr.attr;
> +		attrs[i++] = &s->limit2_attr.attr;
>   	}
>   
> -	err = device_create_file(data->hwmon_dev, &atk_name_attr);
> +	data->attr_group[0].attrs = attrs;
> +	data->attr_groups[0] = data->attr_group;
>   
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
> +	return 0;
>   }
>   
>   static void atk_free_sensors(struct atk_data *data)
> @@ -1245,24 +1227,15 @@ static void atk_free_sensors(struct atk_data *data)
>   static int atk_register_hwmon(struct atk_data *data)
>   {
>   	struct device *dev = &data->acpi_dev->dev;
> -	int err;
>   
>   	dev_dbg(dev, "registering hwmon device\n");
> -	data->hwmon_dev = hwmon_device_register(dev);
> +	data->hwmon_dev = hwmon_device_register_with_groups(dev, "atk0110",
> +							    data,
> +							    data->attr_groups);
>   	if (IS_ERR(data->hwmon_dev))
>   		return PTR_ERR(data->hwmon_dev);
>   
> -	dev_dbg(dev, "populating sysfs directory\n");
> -	err = atk_create_files(data);
> -	if (err)
> -		goto remove;
> -
>   	return 0;
> -remove:
> -	/* Cleanup the registered files */
> -	atk_remove_files(data);
> -	hwmon_device_unregister(data->hwmon_dev);
> -	return err;
>   }
>   
>   static int atk_probe_if(struct atk_data *data)
> @@ -1397,6 +1370,9 @@ static int atk_add(struct acpi_device *device)
>   		goto out;
>   	}
>   
> +	err = atk_init_attribute_groups(data);
> +	if (err)
> +		goto out;
>   	err = atk_register_hwmon(data);
>   	if (err)
>   		goto cleanup;
> @@ -1423,7 +1399,6 @@ static int atk_remove(struct acpi_device *device)
>   
>   	atk_debugfs_cleanup(data);
>   
> -	atk_remove_files(data);
>   	atk_free_sensors(data);
>   	hwmon_device_unregister(data->hwmon_dev);
>   
> 
