Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D559C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15402085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFmzmJrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15402085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeJJUal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:30:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45598 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeJJUak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:30:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id u12-v6so2600358pfn.12;
        Wed, 10 Oct 2018 06:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mz2OWczSpg6QKcQUDvh+pWmPeSQSOR71gRiJR0D8bIs=;
        b=AFmzmJrOCm6CFTJJ6ITI1i6vPWPNsRPedxdIYjRm6RDw+4tobNys24KSeJF3RedYkH
         7x6JMdGogmpPYmCUDvHY1Tm77hPYXf6oLscDAYvsnCataoy5qpTFUoyH2WVFo5oTXnJh
         UDVhzO42RYxXPkDVkfjgQy/IrIRwRWrPCgcNh4umMytT7kDEpDgWNf2dHpWUWMc90/7z
         MzeWbfKLabYygznaDEBpmQQ96z6+kVKPIeNwPELYDBW3SlWw1T7TzaxzHE+KSSpenEHr
         Dhgei+9yEloX8I6ISHjOWK8Pv0HBAH+WbCn/YTMTyeowqyO0hbDnKF4IlhownMdkRPgO
         s/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mz2OWczSpg6QKcQUDvh+pWmPeSQSOR71gRiJR0D8bIs=;
        b=eT4IFuSxMyWNr/SFRkOMALvHkdxwoiizjJqWB34hov11KYnFXF3yWLWXZQQWzFGGw6
         1ZJScKlRmbqGTMCGfLzSsWySXZVkHhr7ZWYFXn1hUr3Mw6BR9vWo2aJc6myG3gZbzS13
         9w0ObyfXwS2ePBfughU/h1wztUroEGYFZn4FEfWQR5eIR8uYSzYSUgOTeA3vEef52YjC
         x/WqwKm0kJcpNSdp3M9Gow6iWLsvIbkq7SOhvTK6BErf9s57RAZlhOxNA2MaNjBD+cPr
         WifkpPJWl04PsJrluFKRjQVzwHt/uRyWVEwKrYj/X4D7Xk8JfF7lADhEkAPXlrwo93c2
         jeZQ==
X-Gm-Message-State: ABuFfoioXpEWfRCLNXSbKFY52T/R2u2c5oqRcrUKiCIjQuQZ3fB2GEET
        UBuTvHTaRwQbZT2m9nbjGXuFzPZR
X-Google-Smtp-Source: ACcGV63RITvOCuLawlEzIpS+a2XZrec98c+wTR7k4PT6Ha0Fq8TTyIiw/hA3wer+n4ZrEzj9jb55Jw==
X-Received: by 2002:a62:5103:: with SMTP id f3-v6mr8300672pfb.107.1539176913185;
        Wed, 10 Oct 2018 06:08:33 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id y144-v6sm17134142pfb.81.2018.10.10.06.08.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 06:08:32 -0700 (PDT)
Subject: Re: [PATCH 1/2] hwmon: (core) Add hwmon_mode structure and mode sysfs
 node
To:     Nicolin Chen <nicoleotsuka@gmail.com>, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
References: <20181010043310.30873-1-nicoleotsuka@gmail.com>
 <20181010043310.30873-2-nicoleotsuka@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <2c535925-5b75-75e6-e383-645fdf45f519@roeck-us.net>
Date:   Wed, 10 Oct 2018 06:08:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181010043310.30873-2-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolin,

On 10/09/2018 09:33 PM, Nicolin Chen wrote:
> There are a few hwmon sensors support different operating modes,
> for example, one-shot and continuous modes. So it's probably not
> a bad idea to abstract a mode sysfs node as a common feature in
> the hwmon core.
> 
> Right beside the hwmon device name, this patch adds a new sysfs
> attribute named "mode" and "available_modes" for user to check
> and configure the operating mode. For hwmon device drivers that
> implemented the _with_info API, the change also adds an optional
> hwmon_mode structure in hwmon_chip_info structure so that those
> drivers can pass mode related information.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>   Documentation/hwmon/sysfs-interface | 15 +++++
>   drivers/hwmon/hwmon.c               | 87 ++++++++++++++++++++++++++---
>   include/linux/hwmon.h               | 24 ++++++++
>   3 files changed, 119 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> index 2b9e1005d88b..48d6ca6b9bd4 100644
> --- a/Documentation/hwmon/sysfs-interface
> +++ b/Documentation/hwmon/sysfs-interface
> @@ -92,6 +92,21 @@ name		The chip name.
>   		I2C devices get this attribute created automatically.
>   		RO
>   
> +available_modes The available operating modes of the chip.
> +		This should be short, lowercase string, not containing
> +		whitespace, or the wildcard character '*'.
> +		This attribute shows all the available of the operating modes,
> +		for example, "power-down" "one-shot" and "continuous".
> +		RO
> +
> +mode		The current operating mode of the chip.
> +		This should be short, lowercase string, not containing
> +		whitespace, or the wildcard character '*'.
> +		This attribute shows the current operating mode of the chip.
> +		Writing a valid string from the list of available_modes will
> +		configure the chip to the corresponding operating mode.
> +		RW
> +

No, sorry.

This is not a well defined ABI: The modes would be under full and arbitrary
control by drivers, and be completely driver dependent. It isn't just the sysfs
attribute that makes the ABI, it is also the contents.

Also, being able to set the mode itself (for whatever definition of mode)
is of questionable value. This is not only for the modes suggested here, but
for other possible modes such as comparator mode vs. interrupt mode (which,
if configurable, should be via platform data or devicetree node entries).
For the modes suggested here, more in the other patch.

In short, NACK. I am open to enhancing the ABI, but I don't see the value
of this attribute.

Guenter


>   update_interval	The interval at which the chip will update readings.
>   		Unit: millisecond
>   		RW
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index 975c95169884..5a33b616284b 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -72,25 +72,88 @@ name_show(struct device *dev, struct device_attribute *attr, char *buf)
>   }
>   static DEVICE_ATTR_RO(name);
>   
> +static ssize_t available_modes_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct hwmon_device *hwdev = to_hwmon_device(dev);
> +	const struct hwmon_chip_info *chip = hwdev->chip;
> +	const struct hwmon_mode *mode = chip->mode;
> +	int i;
> +
> +	for (i = 0; i < mode->list_size; i++)
> +		snprintf(buf, PAGE_SIZE, "%s%s ", buf, mode->names[i]);
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n", buf);
> +}
> +static DEVICE_ATTR_RO(available_modes);
> +
> +static ssize_t mode_show(struct device *dev,
> +			 struct device_attribute *attr, char *buf)
> +{
> +	struct hwmon_device *hwdev = to_hwmon_device(dev);
> +	const struct hwmon_chip_info *chip = hwdev->chip;
> +	const struct hwmon_mode *mode = chip->mode;
> +	unsigned int index;
> +	int ret;
> +
> +	ret = mode->get_index(dev, &index);
> +	if (ret)
> +		return ret;
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n", mode->names[index]);
> +}
> +
> +static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
> +			  const char *buf, size_t count)
> +{
> +	struct hwmon_device *hwdev = to_hwmon_device(dev);
> +	const struct hwmon_chip_info *chip = hwdev->chip;
> +	const struct hwmon_mode *mode = chip->mode;
> +	const char **names = mode->names;
> +	unsigned int index;
> +	int ret;
> +
> +	/* Get the corresponding mode index */
> +	for (index = 0; index < mode->list_size; index++) {
> +		if (!strncmp(buf, names[index], strlen(names[index])))
> +			break;
> +	}
> +
> +	if (index >= mode->list_size)
> +		return -EINVAL;
> +
> +	ret = mode->set_index(dev, index);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(mode);
> +
>   static struct attribute *hwmon_dev_attrs[] = {
> -	&dev_attr_name.attr,
> +	&dev_attr_name.attr,		/* index = 0 */
> +	&dev_attr_available_modes.attr,	/* index = 1 */
> +	&dev_attr_mode.attr,		/* index = 2 */
>   	NULL
>   };
>   
> -static umode_t hwmon_dev_name_is_visible(struct kobject *kobj,
> -					 struct attribute *attr, int n)
> +static umode_t hwmon_dev_is_visible(struct kobject *kobj,
> +				    struct attribute *attr, int n)
>   {
>   	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct hwmon_device *hwdev = to_hwmon_device(dev);
>   
> -	if (to_hwmon_device(dev)->name == NULL)
> -		return 0;
> +	if (n == 0 && hwdev->name)
> +		return attr->mode;
> +	else if (n <= 2 && hwdev->chip->mode)
> +		return attr->mode;
>   
> -	return attr->mode;
> +	return 0;
>   }
>   
>   static const struct attribute_group hwmon_dev_attr_group = {
>   	.attrs		= hwmon_dev_attrs,
> -	.is_visible	= hwmon_dev_name_is_visible,
> +	.is_visible	= hwmon_dev_is_visible,
>   };
>   
>   static const struct attribute_group *hwmon_dev_attr_groups[] = {
> @@ -591,6 +654,16 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>   		struct attribute **attrs;
>   		int ngroups = 2; /* terminating NULL plus &hwdev->groups */
>   
> +		/* Validate optional hwmon_mode */
> +		if (chip->mode) {
> +			/* Check mandatory properties */
> +			if (!chip->mode->names || !chip->mode->list_size ||
> +			    !chip->mode->get_index || !chip->mode->set_index) {
> +				err = -EINVAL;
> +				goto free_hwmon;
> +			}
> +		}
> +
>   		if (groups)
>   			for (i = 0; groups[i]; i++)
>   				ngroups++;
> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
> index 99e0c1b0b5fb..06c1940ca98b 100644
> --- a/include/linux/hwmon.h
> +++ b/include/linux/hwmon.h
> @@ -365,14 +365,38 @@ struct hwmon_channel_info {
>   	const u32 *config;
>   };
>   
> +/**
> + * Chip operating mode information
> + * @names:	A list of available operating mode names.
> + * @list_size:	The total number of available operating mode names.
> + * @get_index:	Callback to get current operating mode index. Mandatory.
> + *		Parameters are:
> + *		@dev:	Pointer to hardware monitoring device
> + *		@index:	Pointer to returned mode index
> + *		The function returns 0 on success or a negative error number.
> + * @set_index:	Callback to set operating mode using the index. Mandatory.
> + *		Parameters are:
> + *		@dev:	Pointer to hardware monitoring device
> + *		@index:	Mode index in the mode list
> + *		The function returns 0 on success or a negative error number.
> + */
> +struct hwmon_mode {
> +	const char **names;
> +	unsigned int list_size;
> +	int (*get_index)(struct device *dev, unsigned int *index);
> +	int (*set_index)(struct device *dev, unsigned int index);
> +};
> +
>   /**
>    * Chip configuration
>    * @ops:	Pointer to hwmon operations.
>    * @info:	Null-terminated list of channel information.
> + * @mode:	Pointer to hwmon operating mode (optional).
>    */
>   struct hwmon_chip_info {
>   	const struct hwmon_ops *ops;
>   	const struct hwmon_channel_info **info;
> +	const struct hwmon_mode *mode;
>   };
>   
>   /* hwmon_device_register() is deprecated */
> 

