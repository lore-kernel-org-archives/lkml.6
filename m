Return-Path: <groeck7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521691667; cv=none;
        d=google.com; s=arc-20160816;
        b=MZ0xH7INMwo1wcaCjP0FQ4KT24UamZS3jNHavDUNSF8lYjQfk5aJrJYI9OxRCSVxMp
         ZOYDaUjkzfXPEkFOXz+N8Oj0ktuFuSCW+XbgoV2vT9mp/Ueh8O1C4kOrA11gNHT2kOsi
         KKko+eR0aYSLblnMV06CV26VNwu8xA1IseImbfGD8VjEkBaGu9BbPl86KBUjq23LIkKX
         cKVTHKZdRPeJA6jH3bQT+Vb8PCt3CoRQJzIOQJbwZz8M9vZupnYDVPYJap9kDoRLEFoa
         7r9nEj+GnWvAG2T64DFSVlMytec+sFf8TWlWPoo8HlYXVh38nJvHfO+kNISY2PTi2n5p
         8/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:sender
         :dkim-signature:arc-authentication-results;
        bh=EIefom0UBsIRkKTqb0uceBnxOOpDDdPe4b9kXfm8Rys=;
        b=uGUeBPBbXoxSI5C3V+cqR9+TSIp+obqbRbxdbzMtiBC1gaiIaAVOJaF1E8FdwGbKQG
         HzYtgw1xdnhQN7nYym2h2Uvxh+EZYZPs7D5Ao9i7DCoHtfr3eX5EwQwJc69CWVRzyx18
         tpMpYpOvoxrG8RuXMmrQl/bZCpDpjbZkAHJpb5OLN/t9T4yNAcvcY5HnHZQK/FQou1py
         8j9LTHYl1HEou5Q5L420n4hDeBUUpc3VfBqL8bfr3jsVinjD47H0T5Z7XeuCdvkbvtK7
         ImwQbmFug3j8Z87pUUaPUPaRrFnv9i0TVFglCRt84hnSjiOuvuqUGJnSfbWS9c5JL186
         siMw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qLN9OnFP;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qLN9OnFP;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-Google-Smtp-Source: AG47ELtCqFbG8Yogz69dBbyKdyw8NNByDqxvnsjcYun6E6yFA8MYLDuVcFmAaaO4s0DaCJ7KyQ/SAA==
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v5 3/5] power: supply: Add 'usb_type' property and
 supporting code
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Jun Li <jun.li@nxp.com>
Cc: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, support.opensource@diasemi.com
References: <cover.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
 <3774272cd49908e88b56a1c4bbf3b363b851ebdd.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <225f9a2f-48cc-e6e4-1240-28507f7b3ab7@roeck-us.net>
Date: Wed, 21 Mar 2018 21:07:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <3774272cd49908e88b56a1c4bbf3b363b851ebdd.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595467552152043580?=
X-GMAIL-MSGID: =?utf-8?q?1595609361597760468?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/20/2018 07:33 AM, Adam Thomson wrote:
> This commit adds the 'usb_type' property to represent USB supplies
> which can report a number of different types based on a connection
> event.
> 
> Examples of this already exist in drivers whereby the existing 'type'
> property is updated, based on an event, to represent what was
> connected (e.g. USB, USB_DCP, USB_ACA, ...). Current implementations
> however don't show all supported connectable types, so this knowledge
> has to be exlicitly known for each driver that supports this.
> 
> The 'usb_type' property is intended to fill this void and show users
> all possible USB types supported by a driver. The property, when read,
> shows all available types for the driver, and the one currently chosen
> is highlighted/bracketed. It is expected that the 'type' property
> would then just show the top-level type 'USB', and this would be
> static.
> 
> Currently the 'usb_type' enum contains all of the USB variant types
> that exist for the 'type' enum at this time, and in addition has
> SDP and PPS types. The mirroring is intentional so as to not impact
> existing usage of the 'type' property.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>   Documentation/ABI/testing/sysfs-class-power | 12 +++++++
>   drivers/power/supply/power_supply_sysfs.c   | 50 +++++++++++++++++++++++++++++
>   include/linux/power_supply.h                | 16 +++++++++
>   3 files changed, 78 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index e046566..5e23e22 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -409,6 +409,18 @@ Description:
>   		Access: Read
>   		Valid values: Represented in 1/10 Degrees Celsius
>   
> +What: 		/sys/class/power_supply/<supply_name>/usb_type
> +Date:		March 2018
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports what type of USB connection is currently active for
> +		the supply, for example it can show if USB-PD capable source
> +		is attached.
> +
> +		Access: Read-Only
> +		Valid values: "Unknown", "SDP", "DCP", "CDP", "ACA", "C", "PD",
> +			      "PD_DRP", "PD_PPS", "BrickID"
> +
>   What: 		/sys/class/power_supply/<supply_name>/voltage_max
>   Date:		January 2008
>   Contact:	linux-pm@vger.kernel.org
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 5204f11..b68def4 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -46,6 +46,11 @@
>   	"USB_PD", "USB_PD_DRP", "BrickID"
>   };
>   
> +static const char * const power_supply_usb_type_text[] = {
> +	"Unknown", "SDP", "DCP", "CDP", "ACA", "C",
> +	"PD", "PD_DRP", "PD_PPS", "BrickID"
> +};
> +
>   static const char * const power_supply_status_text[] = {
>   	"Unknown", "Charging", "Discharging", "Not charging", "Full"
>   };
> @@ -73,6 +78,46 @@
>   	"Unknown", "System", "Device"
>   };
>   
> +static ssize_t power_supply_show_usb_type(struct device *dev,
> +					  enum power_supply_usb_type *usb_types,
> +					  ssize_t num_usb_types,
> +					  union power_supply_propval *value,
> +					  char *buf)
> +{
> +	enum power_supply_usb_type usb_type;
> +	ssize_t count = 0;
> +	bool match = false;
> +	int i;
> +
> +	if ((!usb_types) || (num_usb_types <= 0)) {

Unnecessary ( )

> +		dev_warn(dev, "driver has no valid connected types\n");

Are those warnings useful or do they just clog the log ? Either case, if that happens,
wouldn't it be better to detect the situation during registration and abort ?

> +		return -ENODATA;
> +	}
> +
> +	for (i = 0; i < num_usb_types; ++i) {
> +		usb_type = usb_types[i];
> +
> +		if (value->intval == usb_type) {
> +			count += sprintf(buf + count, "[%s] ",
> +					 power_supply_usb_type_text[usb_type]);
> +			match = true;
> +		} else {
> +			count += sprintf(buf + count, "%s ",
> +					 power_supply_usb_type_text[usb_type]);
> +		}
> +	}
> +
> +	if (!match) {
> +		dev_warn(dev, "driver reporting unsupported connected type\n");
> +		return -EINVAL;
> +	}
> +
> +	if (count)
> +		buf[count - 1] = '\n';
> +
> +	return count;
> +}
> +
>   static ssize_t power_supply_show_property(struct device *dev,
>   					  struct device_attribute *attr,
>   					  char *buf) {
> @@ -115,6 +160,10 @@ static ssize_t power_supply_show_property(struct device *dev,
>   	else if (off == POWER_SUPPLY_PROP_TYPE)
>   		return sprintf(buf, "%s\n",
>   			       power_supply_type_text[value.intval]);
> +	else if (off == POWER_SUPPLY_PROP_USB_TYPE)
> +		return power_supply_show_usb_type(dev, psy->desc->usb_types,
> +						  psy->desc->num_usb_types,
> +						  &value, buf);
>   	else if (off == POWER_SUPPLY_PROP_SCOPE)
>   		return sprintf(buf, "%s\n",
>   			       power_supply_scope_text[value.intval]);
> @@ -241,6 +290,7 @@ static ssize_t power_supply_store_property(struct device *dev,
>   	POWER_SUPPLY_ATTR(time_to_full_now),
>   	POWER_SUPPLY_ATTR(time_to_full_avg),
>   	POWER_SUPPLY_ATTR(type),
> +	POWER_SUPPLY_ATTR(usb_type),
>   	POWER_SUPPLY_ATTR(scope),
>   	POWER_SUPPLY_ATTR(precharge_current),
>   	POWER_SUPPLY_ATTR(charge_term_current),
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 79e90b3..4ca8876 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -145,6 +145,7 @@ enum power_supply_property {
>   	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
>   	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
>   	POWER_SUPPLY_PROP_TYPE, /* use power_supply.type instead */
> +	POWER_SUPPLY_PROP_USB_TYPE,
>   	POWER_SUPPLY_PROP_SCOPE,
>   	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
>   	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
> @@ -170,6 +171,19 @@ enum power_supply_type {
>   	POWER_SUPPLY_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
>   };
>   
> +enum power_supply_usb_type {
> +	POWER_SUPPLY_USB_TYPE_UNKNOWN = 0,
> +	POWER_SUPPLY_USB_TYPE_SDP,		/* Standard Downstream Port */
> +	POWER_SUPPLY_USB_TYPE_DCP,		/* Dedicated Charging Port */
> +	POWER_SUPPLY_USB_TYPE_CDP,		/* Charging Downstream Port */
> +	POWER_SUPPLY_USB_TYPE_ACA,		/* Accessory Charger Adapters */
> +	POWER_SUPPLY_USB_TYPE_C,		/* Type C Port */
> +	POWER_SUPPLY_USB_TYPE_PD,		/* Power Delivery Port */
> +	POWER_SUPPLY_USB_TYPE_PD_DRP,		/* PD Dual Role Port */
> +	POWER_SUPPLY_USB_TYPE_PD_PPS,		/* PD Programmable Power Supply */
> +	POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
> +};
> +
>   enum power_supply_notifier_events {
>   	PSY_EVENT_PROP_CHANGED,
>   };
> @@ -196,6 +210,8 @@ struct power_supply_config {
>   struct power_supply_desc {
>   	const char *name;
>   	enum power_supply_type type;
> +	enum power_supply_usb_type *usb_types;
> +	size_t num_usb_types;
>   	enum power_supply_property *properties;
>   	size_t num_properties;
>   
> 
