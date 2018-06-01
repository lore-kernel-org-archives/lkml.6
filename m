Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbeFAQfj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:35:39 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:42897 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbeFAQfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:35:36 -0400
Date: Fri, 1 Jun 2018 09:35:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Bastian Germann <bastiangermann@fishpost.de>
Cc: Luca Tettamanti <kronos.it@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] hwmon: (asus_atk0110) Replace deprecated device
 register call
Message-ID: <20180601163535.GB4946@roeck-us.net>
References: <8afcabf0-94c2-8068-5252-491494108a0c@roeck-us.net>
 <20180601151419.15820-1-bastiangermann@fishpost.de>
 <20180601151419.15820-2-bastiangermann@fishpost.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601151419.15820-2-bastiangermann@fishpost.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 05:14:18PM +0200, Bastian Germann wrote:
> Make the asus_atk0110 driver use hwmon_device_register_with_groups instead
> of the deprecated hwmon_device_register.
> Construct the expected attribute_group array from the sensor list which
> contains all needed attributes.
> Remove the manual sysfs file creation and deletion that are now taken care
> of by the (un)register calls via the attribute_group array.
> 
> Signed-off-by: Bastian Germann <bastiangermann@fishpost.de>

Nicely done.

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/asus_atk0110.c | 75 ++++++++++++------------------------
>  1 file changed, 25 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
> index 975c43d446f8..33748cc07acc 100644
> --- a/drivers/hwmon/asus_atk0110.c
> +++ b/drivers/hwmon/asus_atk0110.c
> @@ -125,6 +125,8 @@ struct atk_data {
>  	int temperature_count;
>  	int fan_count;
>  	struct list_head sensor_list;
> +	struct attribute_group attr_group;
> +	const struct attribute_group *attr_groups[2];
>  
>  	struct {
>  		struct dentry *root;
> @@ -262,14 +264,6 @@ static ssize_t atk_limit2_show(struct device *dev,
>  	return sprintf(buf, "%lld\n", value);
>  }
>  
> -static ssize_t atk_name_show(struct device *dev,
> -				struct device_attribute *attr, char *buf)
> -{
> -	return sprintf(buf, "atk0110\n");
> -}
> -static struct device_attribute atk_name_attr =
> -		__ATTR(name, 0444, atk_name_show, NULL);
> -
>  static void atk_init_attribute(struct device_attribute *attr, char *name,
>  		sysfs_show_func show)
>  {
> @@ -1193,42 +1187,30 @@ static int atk_enumerate_new_hwmon(struct atk_data *data)
>  	return err;
>  }
>  
> -static int atk_create_files(struct atk_data *data)
> +static int atk_init_attribute_groups(struct atk_data *data)
>  {
> +	struct device *dev = &data->acpi_dev->dev;
>  	struct atk_sensor_data *s;
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
>  	list_for_each_entry(s, &data->sensor_list, list) {
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
>  	}
>  
> -	err = device_create_file(data->hwmon_dev, &atk_name_attr);
> +	data->attr_group.attrs = attrs;
> +	data->attr_groups[0] = &data->attr_group;
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
>  }
>  
>  static void atk_free_sensors(struct atk_data *data)
> @@ -1245,24 +1227,15 @@ static void atk_free_sensors(struct atk_data *data)
>  static int atk_register_hwmon(struct atk_data *data)
>  {
>  	struct device *dev = &data->acpi_dev->dev;
> -	int err;
>  
>  	dev_dbg(dev, "registering hwmon device\n");
> -	data->hwmon_dev = hwmon_device_register(dev);
> +	data->hwmon_dev = hwmon_device_register_with_groups(dev, "atk0110",
> +							    data,
> +							    data->attr_groups);
>  	if (IS_ERR(data->hwmon_dev))
>  		return PTR_ERR(data->hwmon_dev);
>  
> -	dev_dbg(dev, "populating sysfs directory\n");
> -	err = atk_create_files(data);
> -	if (err)
> -		goto remove;
> -
>  	return 0;
> -remove:
> -	/* Cleanup the registered files */
> -	atk_remove_files(data);
> -	hwmon_device_unregister(data->hwmon_dev);
> -	return err;
>  }
>  
>  static int atk_probe_if(struct atk_data *data)
> @@ -1397,6 +1370,9 @@ static int atk_add(struct acpi_device *device)
>  		goto out;
>  	}
>  
> +	err = atk_init_attribute_groups(data);
> +	if (err)
> +		goto out;
>  	err = atk_register_hwmon(data);
>  	if (err)
>  		goto cleanup;
> @@ -1423,7 +1399,6 @@ static int atk_remove(struct acpi_device *device)
>  
>  	atk_debugfs_cleanup(data);
>  
> -	atk_remove_files(data);
>  	atk_free_sensors(data);
>  	hwmon_device_unregister(data->hwmon_dev);
>  
> -- 
> 2.17.1
> 
