Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBECC64EB0
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 20:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657172089D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 20:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/J0FX+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657172089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbeJAD3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 23:29:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34604 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbeJAD3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 23:29:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id g12-v6so2298691pgs.1;
        Sun, 30 Sep 2018 13:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rDu36eOsDS1MNpXaGfplBUdNu4gp6zaz+E8K9+WDZFg=;
        b=E/J0FX+U2cutFiRwbl3wEu8MKDT+gcGyKTOUS6oW4Imco6q+mydpOEh5AItdIQVkDz
         inmilyI2T2ROe7G8WlqaDl8s7hdZh/u/vAc31Ol4mNw56L/QdcUrK7a+RbYsiKpIc8lV
         /B5Wmr2SFYr+qYOshAEMp53aClVCLgXJ2Ukz/53YweFYGRsawsr9RVB2ve+hcSiyPzrw
         LGEFm8tynDFiUEeZ48A889lQufu7pKo2gaIScvKYmIO02IxZaubAEWs3bNvXgF/GnrXJ
         BpRCYoT2mHYkSMWzEpE4cywThY69K4hoN2T/nA+TpgPx0hmhzct8tZhlJ3WUgQSHUSma
         ZqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rDu36eOsDS1MNpXaGfplBUdNu4gp6zaz+E8K9+WDZFg=;
        b=FQJ9KEqJK74KJFTRqML2ufgm+AIAlhTrr4X1Yk9JYKwkcMXtJoFQ4be771qhbw7ZjB
         JO9fds46oH8qWbuv2n8SdAcYzE85XjCLelP/F0NHcVDgpnG7zWKcVOoHGODWLnqEite3
         s57jmRzTpTWETS+jYSci+KZJgg6UtOktnGxm94jF+S/M4KQ/J9kk8m6YjMVQ4Z/XhBjO
         XblbBMDwlIG01kiSVbI818mWHYdbzRck+KK1dfzS+G4QB9rjFnXHWV2Bay4Bo1Vjk5Ps
         HIRchZrd6yYMfYfPEwQ2U9H9G/TiG1ZxbsyHHYL2npCnR57XmgOc4zrY03PWpbbIfdPh
         SUVg==
X-Gm-Message-State: ABuFfohCnVCvI7x9BursYCIxmmyE5P42WxA18uqJF/GFsZmPqnd9G9nA
        2SpqGtYuYwZQrJgCQXMCuWTV7kId
X-Google-Smtp-Source: ACcGV60iaFw66uDHEUZ/+NOk75Ig9X5+ZQFqBCjYTErVmAO5ICp4Eo1qLe63xlXoyV3LMy/oMnzsSQ==
X-Received: by 2002:a17:902:722:: with SMTP id 31-v6mr8536744pli.207.1538340920725;
        Sun, 30 Sep 2018 13:55:20 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r81-v6sm2312717pfa.110.2018.09.30.13.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 13:55:19 -0700 (PDT)
Subject: Re: [PATCH v8 2/2] hwmon: ina3221: Read channel input source info
 from DT
To:     Nicolin Chen <nicoleotsuka@gmail.com>, jdelvare@suse.com,
        robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20180929013937.29289-1-nicoleotsuka@gmail.com>
 <20180929013937.29289-3-nicoleotsuka@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ab3a36dc-fa5a-4669-2f99-aa55a4083db2@roeck-us.net>
Date:   Sun, 30 Sep 2018 13:55:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180929013937.29289-3-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolin,

On 09/28/2018 06:39 PM, Nicolin Chen wrote:
> An ina3221 chip has three input ports. Each port is used
> to measure the voltage and current of its input source.
> 
> The DT binding now has defined bindings for their input
> sources, so the driver should read these information and
> handle accordingly.
> 
> This patch adds a new structure of input source specific
> information including input source label, shunt resistor
> value and its connection status. It exposes these labels
> via in[123]_label sysfs nodes upon available, and also
> disables those channels where there are no input source
> being connected. Meanwhile, it also adds in[123]_enable
> sysfs nodes for users to get control of three channels,
> and returns -ENODATA code for any sensor read according
> to hwmon ABI.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

[ ... ]

> +
> +static ssize_t ina3221_set_enable(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
> +	struct ina3221_data *ina = dev_get_drvdata(dev);
> +	unsigned int channel = sd_attr->index;
> +	u16 config = ina->reg_config;
> +	bool enable;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &enable);
> +	if (ret)
> +		return ret;
> +
> +	if (enable)
> +		config |= INA3221_CONFIG_CHx_EN(channel);
> +	else
> +		config &= ~INA3221_CONFIG_CHx_EN(channel);
> +
> +	ret = regmap_write(ina->regmap, INA3221_CONFIG, config);
> +	if (ret)
> +		return ret;
> +
> +	ina->reg_config = config;
> +

Sorry it too me so long to realize this: The code above is racy.
There could be multiple threads enabling and disabling a channel.
Without a mutex, there is no guarantee that the final value of
reg_config matches the value written into the chip.

You'll have to introduce a mutex and implement something like

	...
	ret = kstrtobool(buf, &enable);
	if (ret)
		return ret;

	mutex_lock(&ina->update_lock);
	config = ina->reg_config;
	...
	ret = regmap_write(ina->regmap, INA3221_CONFIG, config);
	if (ret) {
		count = ret;
		goto error;
	}
	ina->reg_config = config;
error:
	mutex_unlock(&ina->update_lock);
	return count;

Guenter
