Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755457AbeEaO11 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:27:27 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45447 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755317AbeEaO1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:27:25 -0400
X-Google-Smtp-Source: ADUXVKK71pxFGuyL21xLII9B1/NvxJUf/CQxBLZSn1r7ZmFMRMfylliXxqxsqQGVvhbn3UTP9c1MRA==
Subject: Re: [PATCH 1/2] hwmon: (asus_atk0110) Replace deprecated device
 register call
To: Bastian Germann <bastiangermann@fishpost.de>,
        Luca Tettamanti <kronos.it@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180531140136.13969-1-bastiangermann@fishpost.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <f885fcb0-d9f3-7702-13ad-5af2913131f0@roeck-us.net>
Date: Thu, 31 May 2018 07:27:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180531140136.13969-1-bastiangermann@fishpost.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bastian,

On 05/31/2018 07:01 AM, Bastian Germann wrote:
> Make the asus_atk0110 driver use hwmon_device_register_with_groups instead
> of the deprecated hwmon_device_register.
> Construct the expected attribute_group array from the sensor list which
> contains all needed attributes.
> 
> Signed-off-by: Bastian Germann <bastiangermann@fishpost.de>
> ---
>   drivers/hwmon/asus_atk0110.c | 71 +++++++++++++++++++++++++++++-------
>   1 file changed, 58 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
> index 975c43d446f8..8a35fb27ff50 100644
> --- a/drivers/hwmon/asus_atk0110.c
> +++ b/drivers/hwmon/asus_atk0110.c
> @@ -125,6 +125,7 @@ struct atk_data {
>   	int temperature_count;
>   	int fan_count;
>   	struct list_head sensor_list;
> +	const struct attribute_group **attr_groups;
>   
>   	struct {
>   		struct dentry *root;
> @@ -1242,27 +1243,67 @@ static void atk_free_sensors(struct atk_data *data)
>   	}
>   }
>   
> +static int atk_init_attribute_groups(struct atk_data *data)
> +{
> +	struct atk_sensor_data *s;
> +	struct attribute **attrs;
> +	struct attribute_group *group;
> +	const struct attribute_group **groups;
> +	int i = 0;
> +	int len = (data->voltage_count + data->temperature_count
> +			+ data->fan_count) * 4 + 1;
> +
> +	attrs = kcalloc(len, sizeof(struct attribute *), GFP_KERNEL);

Please use devm_kcalloc().

> +	if (!attrs)
> +		return -ENOMEM;
> +
> +	list_for_each_entry(s, &data->sensor_list, list) {
> +		attrs[i++] = &s->input_attr.attr;
> +		attrs[i++] = &s->label_attr.attr;
> +		attrs[i++] = &s->limit1_attr.attr;
> +		attrs[i++] = &s->limit2_attr.attr;
> +	}
> +	attrs[i] = NULL;
> +
> +	group = kzalloc(sizeof(*group), GFP_KERNEL);

devm_kzalloc()

> +	if (!group)
> +		goto cleanup;
> +	group->attrs = attrs;
> +
> +	groups = kcalloc(2, sizeof(struct attribute_group *), GFP_KERNEL);

devm_kcalloc()

> +	if (!groups) {
> +		kfree(group);
> +		goto cleanup;
> +	}
> +	groups[0] = group;
> +	groups[1] = NULL;

kcalloc() clears the allocated memory, so this is unnecessary. However,
I would suggest to make group and groups part of struct atk_sensor_data.
The size is static, and the fields will always be needed, so dynamic
allocation doesn't buy anything except overhead.

> +	data->attr_groups = groups;
> + > +	return 0;
> +cleanup:
> +	kfree(attrs);

then you won't need the kfree() calls.

The same should be done with the existing calls of kzalloc(),
but that should be a separate patch.

> +	return -ENOMEM;
> +}
> +
> +static void atk_free_attribute_groups(struct atk_data *data)
> +{
> +	kfree(data->attr_groups[0]->attrs);
> +	kfree(data->attr_groups[0]);
> +	kfree(data->attr_groups);
> +}
> +
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
> @@ -1397,6 +1438,9 @@ static int atk_add(struct acpi_device *device)
>   		goto out;
>   	}
>   
> +	err = atk_init_attribute_groups(data);
> +	if (err)
> +		goto out;
>   	err = atk_register_hwmon(data);
>   	if (err)
>   		goto cleanup;
> @@ -1407,6 +1451,7 @@ static int atk_add(struct acpi_device *device)
>   	return 0;
>   cleanup:
>   	atk_free_sensors(data);
> +	atk_free_attribute_groups(data);
>   out:
>   	if (data->disable_ec)
>   		atk_ec_ctl(data, 0);
> @@ -1423,9 +1468,9 @@ static int atk_remove(struct acpi_device *device)
>   
>   	atk_debugfs_cleanup(data);
>   
> -	atk_remove_files(data);

You should also remove the no longer needed functions as well as the
name attribute.

>   	atk_free_sensors(data);
>   	hwmon_device_unregister(data->hwmon_dev);
> +	atk_free_attribute_groups(data);
>   
>   	if (data->disable_ec) {
>   		if (atk_ec_ctl(data, 0))
> 
