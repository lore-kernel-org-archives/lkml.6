Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237B6C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64D52154D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Br5Enw3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64D52154D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388885AbeIUG2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 02:28:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41591 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbeIUG2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 02:28:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id b12-v6so5113516plr.8;
        Thu, 20 Sep 2018 17:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zyH5WLQWiRUSDn4bQE9fheFvIq3f57MuKH80+fYBgrE=;
        b=Br5Enw3aYknhBorZ21GZ0NrDCE6OCtxIWrw6cfcP3fyY0m3RX+Ka1fLTUnEBfg7SAn
         8Puo3MvvD5fYfYCP6vFInpxafz0zBGdhIKoA3KpsYG9okH9TJWBYs3V5orkMxzWG48Bh
         Od5XGbUfk9lMDgL7DqvIGq5uPKoCnn4HqqC7wszGZltbv/3wvC/U+Hy4niZ1C1SXPpLf
         EtOr0xBlKwy+Y8YxWUnifeTJ6hWFYjHpScF4FZgjDRGrLxQFn0tzv7FXLxhTTr9CEM4d
         Xukm6xHiNwjO5XeKZvRnFkH66qxSj7rQTsMWIuhpKEpxzigoBjxWwieYKhP9NkPaRjuT
         omZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zyH5WLQWiRUSDn4bQE9fheFvIq3f57MuKH80+fYBgrE=;
        b=AZC/gpqkiGpDXny2Vrms+F21EK3eMlLBPZ4SDyI75uqzfoBm+7q/ae/QD65QEpHVfo
         GoTPsRPgo4fj0kwMDiKnjNHjVUO6vV2IgkWfj4LA0f7on+VufRnb9PykeitDnNGgakod
         0YLPjGROAeyS/ApzSwBnH0XZtKZtR9b/hngyZ9sZ7Lhrh3abb3TsF2zapRnnVB9GaPWm
         x1C5y8dMvtAuzC//5BDf0nmt8HvLAU90IrTCJW3ul7b66RcPx+XfD+QET6AXnq0vsbPB
         Yb3w8uIOYGUmj4qvt9YUYLMmoDddISpnXwVC3Zh01F/O+bnZcmC4bxDsgx4sXlL9PyeX
         oh2A==
X-Gm-Message-State: APzg51DNY1t6/HqIp0cwVPdzjxoQFKkr+k6hcV0vMfXZXbu79rXeQaw4
        j88p2PiQdJgv4d57Mozq88c+krFW
X-Google-Smtp-Source: ANB0VdYB55epJcgmRH4intDyIskIFDw3RgiVc5+J72T1SFLRvU6EWoUvmlzWMfd3UXkJwWYo+TVKrQ==
X-Received: by 2002:a17:902:b81:: with SMTP id 1-v6mr42090722plr.319.1537490511049;
        Thu, 20 Sep 2018 17:41:51 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id v72-v6sm42444433pfj.22.2018.09.20.17.41.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 17:41:49 -0700 (PDT)
Subject: Re: [PATCH 2/2] hwmon: ina3221: Get channel names from DT node
To:     Nicolin Chen <nicoleotsuka@gmail.com>, jdelvare@suse.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180921000753.21846-1-nicoleotsuka@gmail.com>
 <20180921000753.21846-3-nicoleotsuka@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <21a6e8f3-c95d-43d0-ca3f-3f91ddfeff07@roeck-us.net>
Date:   Thu, 20 Sep 2018 17:41:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180921000753.21846-3-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/20/2018 05:07 PM, Nicolin Chen wrote:
> The connection of channels are usually descirbed in the
> schematics, which then should be indicated in DT binding
> as well, and further should get exposed to sysfs so as
> to help driver users understand what channels are really
> monitoring respectively.
> 
> Meanwhile, channels could be left unconnected based on
> the hardware design. So the channel name should support
> NC so the driver could disable the channel accordingly.
> 

I am not in favor of such indirect settings. If a channel is
to be disconnected, define a property for it.

I am personally also not in favor of using devicetree to define
channel names like this, much less so for a single driver.

> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>   drivers/hwmon/ina3221.c | 88 +++++++++++++++++++++++++++++++++++++----
>   1 file changed, 80 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index e6b49500c52a..5d487e205260 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -41,9 +41,12 @@
>   #define INA3221_CONFIG_MODE_SHUNT	BIT(1)
>   #define INA3221_CONFIG_MODE_BUS		BIT(2)
>   #define INA3221_CONFIG_MODE_CONTINUOUS	BIT(3)
> +#define INA3221_CONFIG_CHx_EN(x)	BIT(14 - (x))
>   
>   #define INA3221_RSHUNT_DEFAULT		10000
>   
> +#define INA3221_NOT_CONNECTED		"NC"
> +
>   enum ina3221_fields {
>   	/* Configuration */
>   	F_RST,
> @@ -91,11 +94,20 @@ static const unsigned int register_channel[] = {
>    * @regmap: Register map of the device
>    * @fields: Register fields of the device
>    * @shunt_resistors: Array of resistor values per channel
> + * @attr_group: attribute groups for sysfs node
> + *              (leave one space at the end for NULL termination)
> + * @channel_name: channel names
> + * @enable: enable or disable channels
>    */
>   struct ina3221_data {
>   	struct regmap *regmap;
>   	struct regmap_field *fields[F_MAX_FIELDS];
>   	int shunt_resistors[INA3221_NUM_CHANNELS];
> +
> +	const struct attribute_group *attr_group[INA3221_NUM_CHANNELS + 1];
> +	const char *channel_name[INA3221_NUM_CHANNELS];
> +
> +	bool enable[INA3221_NUM_CHANNELS];
>   };
>   
>   static int ina3221_read_value(struct ina3221_data *ina, unsigned int reg,
> @@ -253,6 +265,24 @@ static ssize_t ina3221_show_alert(struct device *dev,
>   	return snprintf(buf, PAGE_SIZE, "%d\n", regval);
>   }
>   
> +static ssize_t ina3221_show_name(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
> +	struct ina3221_data *ina = dev_get_drvdata(dev);
> +	unsigned int channel = sd_attr->index;
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n", ina->channel_name[channel]);
> +}
> +
> +/* channel name */
> +static SENSOR_DEVICE_ATTR(name1_input, 0444,
> +		ina3221_show_name, NULL, INA3221_CHANNEL1);
> +static SENSOR_DEVICE_ATTR(name2_input, 0444,
> +		ina3221_show_name, NULL, INA3221_CHANNEL2);
> +static SENSOR_DEVICE_ATTR(name3_input, 0444,
> +		ina3221_show_name, NULL, INA3221_CHANNEL3);
> +
>   /* bus voltage */
>   static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO,
>   		ina3221_show_bus_voltage, NULL, INA3221_BUS1);
> @@ -317,8 +347,8 @@ static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO,
>   static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO,
>   		ina3221_show_shunt_voltage, NULL, INA3221_SHUNT3);
>   
> -static struct attribute *ina3221_attrs[] = {
> -	/* channel 1 */
> +static struct attribute *ina3221_channel1_attrs[] = {
> +	&sensor_dev_attr_name1_input.dev_attr.attr,
>   	&sensor_dev_attr_in1_input.dev_attr.attr,
>   	&sensor_dev_attr_curr1_input.dev_attr.attr,
>   	&sensor_dev_attr_shunt1_resistor.dev_attr.attr,
> @@ -328,7 +358,11 @@ static struct attribute *ina3221_attrs[] = {
>   	&sensor_dev_attr_curr1_max_alarm.dev_attr.attr,
>   	&sensor_dev_attr_in4_input.dev_attr.attr,
>   
> -	/* channel 2 */
> +	NULL,
> +};
> +
> +static struct attribute *ina3221_channel2_attrs[] = {
> +	&sensor_dev_attr_name2_input.dev_attr.attr,
>   	&sensor_dev_attr_in2_input.dev_attr.attr,
>   	&sensor_dev_attr_curr2_input.dev_attr.attr,
>   	&sensor_dev_attr_shunt2_resistor.dev_attr.attr,
> @@ -338,7 +372,11 @@ static struct attribute *ina3221_attrs[] = {
>   	&sensor_dev_attr_curr2_max_alarm.dev_attr.attr,
>   	&sensor_dev_attr_in5_input.dev_attr.attr,
>   
> -	/* channel 3 */
> +	NULL,
> +};
> +
> +static struct attribute *ina3221_channel3_attrs[] = {
> +	&sensor_dev_attr_name3_input.dev_attr.attr,
>   	&sensor_dev_attr_in3_input.dev_attr.attr,
>   	&sensor_dev_attr_curr3_input.dev_attr.attr,
>   	&sensor_dev_attr_shunt3_resistor.dev_attr.attr,
> @@ -350,7 +388,12 @@ static struct attribute *ina3221_attrs[] = {
>   
>   	NULL,
>   };
> -ATTRIBUTE_GROUPS(ina3221);
> +
> +static const struct attribute_group ina3221_group[INA3221_NUM_CHANNELS] = {
> +	{ .attrs = ina3221_channel1_attrs, },
> +	{ .attrs = ina3221_channel2_attrs, },
> +	{ .attrs = ina3221_channel3_attrs, },
> +};
>   
>   static const struct regmap_range ina3221_yes_ranges[] = {
>   	regmap_reg_range(INA3221_SHUNT1, INA3221_BUS3),
> @@ -373,10 +416,14 @@ static const struct regmap_config ina3221_regmap_config = {
>   static int ina3221_probe(struct i2c_client *client,
>   			 const struct i2c_device_id *id)
>   {
> +	const struct device_node *np = client->dev.of_node;
>   	struct device *dev = &client->dev;
>   	struct ina3221_data *ina;
>   	struct device *hwmon_dev;
> -	int i, ret;
> +	u16 mask = 0, val = 0;
> +	const char *str;
> +	char prop[32];
> +	int i, g, ret;
>   
>   	ina = devm_kzalloc(dev, sizeof(*ina), GFP_KERNEL);
>   	if (!ina)
> @@ -407,9 +454,34 @@ static int ina3221_probe(struct i2c_client *client,
>   		return ret;
>   	}
>   
> +	/* Fetch hardware information from Device Tree */
> +	for (i = 0, g = 0; i < INA3221_NUM_CHANNELS; i++) {
> +		/* Fetch the channel name */
> +		sprintf(prop, "ti,channel%d-name", i + 1);
> +		/* Set a default name on failure */
> +		if (of_property_read_string(np, prop, &str))
> +			str = "unknown";

So if there are no devicetree entries, the user now gets a sequence of
"unknown" sensors ? I don't think so. Please keep in mind that there are
users of this chip who don't have devicetree systems, and other users
may not want to specify any specific name properties (or they use sensors3.conf
to do it).

> +		/* Ignore unconnected channels */
> +		if (!strcmp(str, INA3221_NOT_CONNECTED))
> +			continue;

Sorry, I won't accept this. I am sure we can come up with some useful means
to define in devicetree if individual channels of a hardware monitoring chip
are enabled or not, but a channel name of "NC" won't be it.

> +		/* Log connected channels */
> +		ina->attr_group[g++] = &ina3221_group[i];
> +		ina->channel_name[i] = str;
> +		ina->enable[i] = true;

I also don't see the need for defining the group dynamically. The
is_visible callback is very well suited for handling optional sysfs
attributes.

> +	}
> +
> +	/* Disable unconnected channels */
> +	for (i = 0; i < INA3221_NUM_CHANNELS; i++) {
> +		mask |= INA3221_CONFIG_CHx_EN(i);
> +		val |= ina->enable[i] ? INA3221_CONFIG_CHx_EN(i) : 0;
> +	}
> +	ret = regmap_update_bits(ina->regmap, INA3221_CONFIG, mask, val);
> +	if (ret)
> +		return ret;
> +
>   	hwmon_dev = devm_hwmon_device_register_with_groups(dev,
> -							   client->name,
> -							   ina, ina3221_groups);
> +							   client->name, ina,
> +							   ina->attr_group);
>   	if (IS_ERR(hwmon_dev)) {
>   		dev_err(dev, "Unable to register hwmon device\n");
>   		return PTR_ERR(hwmon_dev);
> 

