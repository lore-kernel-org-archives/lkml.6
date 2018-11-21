Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749DAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CC821479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36CC821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbeKUWhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:37:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51697 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbeKUWhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 17:37:46 -0500
Received: by mail-wm1-f67.google.com with SMTP id w7-v6so5238753wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 04:03:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XYbheAKakOlivcp4YrwepOM6OREG93qw+k19qTFk2Rs=;
        b=CjBo1BHUEceLF6b0PobRHxTMZqSkscXurXj4y0RNlfJcOY6PpweVdyzWlk+nSIzIzL
         Q5iuzOoJ5cYZo7TK22YntA3P2DlfM3P0EKt4XdGpzRNYdfZ8gjNSnEoBO3vTGbUBLe72
         UqouJEh1hb+D7WmZ3CH9CYxbMslVZls58S2f+/hMWq4EoyTsovj8NpGlT8+87I9kw1fg
         4d1BHJB97J465K15HByW1f+2JAYdUwQv2+cNofOUkCJLWGVoY8zw6hXl1TIdxKGZz9dV
         qPPPHvfYW/QNm16MPj2S6A2lv3S+ykD0qnKyitBAsFVslgOKJ4O9mFZQ9QIfMDhlJxfm
         BkPg==
X-Gm-Message-State: AGRZ1gIdm3mQYqlnUbAOTySEaF/HA5jNJePp0mKiOzKZ2F2VDgoFiiIo
        SSvDw1zZvgf5CharoWcA7AvtVRYdMQQ=
X-Google-Smtp-Source: AJdET5dxJ7UQOhG9rFOg4F3OBAb9zN4pmECpYTfGh8GPF1vQHJPJVnHiWL3dwYZ2WZyb9J6821YBNw==
X-Received: by 2002:a7b:c399:: with SMTP id s25mr5737848wmj.90.1542801817089;
        Wed, 21 Nov 2018 04:03:37 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id s15sm525049wmh.16.2018.11.21.04.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 04:03:36 -0800 (PST)
Subject: Re: [PATCH v1 09/15] platform/x86: i2c-multi-instantiate: Count
 I2cSerialBus() resources
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20181120155924.10773-1-andriy.shevchenko@linux.intel.com>
 <20181120155924.10773-10-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0241e59f-f00b-f1be-9861-62d5da184b24@redhat.com>
Date:   Wed, 21 Nov 2018 13:03:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181120155924.10773-10-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20-11-18 16:59, Andy Shevchenko wrote:
> Instead of relying on hard coded and thus expected number of I2C clients,
> count the real amount provided by firmware.
> 
> This allows to support non-fixed amount of the slaves.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/platform/x86/i2c-multi-instantiate.c | 34 ++++++++++++++++++--
>   1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
> index 16a0eabe1e31..d17686e10d08 100644
> --- a/drivers/platform/x86/i2c-multi-instantiate.c
> +++ b/drivers/platform/x86/i2c-multi-instantiate.c
> @@ -12,6 +12,7 @@
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
> +#include <linux/types.h>
>   
>   struct i2c_inst_data {
>   	const char *type;
> @@ -23,6 +24,31 @@ struct i2c_multi_inst_data {
>   	struct i2c_client *clients[0];
>   };
>   
> +static int i2c_multi_inst_count(struct acpi_resource *ares, void *data)
> +{
> +	struct acpi_resource_i2c_serialbus *sb;
> +	int *count = data;
> +
> +	if (i2c_acpi_get_i2c_resource(ares, &sb))
> +		*count = *count + 1;
> +
> +	return 1;
> +}
> +
> +static int i2c_multi_inst_count_resources(struct acpi_device *adev)
> +{
> +	LIST_HEAD(r);
> +	int count = 0;
> +	int ret;
> +
> +	ret = acpi_dev_get_resources(adev, &r, i2c_multi_inst_count, &count);
> +	if (ret < 0)
> +		return ret;
> +
> +	acpi_dev_free_resource_list(&r);
> +	return count;
> +}
> +
>   static int i2c_multi_inst_probe(struct platform_device *pdev)
>   {
>   	struct i2c_multi_inst_data *multi;
> @@ -44,15 +70,17 @@ static int i2c_multi_inst_probe(struct platform_device *pdev)
>   	adev = ACPI_COMPANION(dev);
>   
>   	/* Count number of clients to instantiate */
> -	for (i = 0; inst_data[i].type; i++) {}
> +	ret = i2c_multi_inst_count_resources(adev);
> +	if (ret < 0)
> +		return ret;
>   
>   	multi = devm_kmalloc(dev,
> -			offsetof(struct i2c_multi_inst_data, clients[i]),
> +			offsetof(struct i2c_multi_inst_data, clients[ret]),
>   			GFP_KERNEL);
>   	if (!multi)
>   		return -ENOMEM;
>   
> -	multi->num_clients = i;
> +	multi->num_clients = ret;
>   
>   	for (i = 0; i < multi->num_clients; i++) {
>   		memset(&board_info, 0, sizeof(board_info));

Now you end up indexing inst_data with i without checking that inst_data
holds enough data. Not using all of inst_data in case there are less
I2cSerialBus resources then inst_data entries is fine. But you need to
deal with the case when there are more I2cSerialBus resources then inst_data
entries, either by erroring out or ignoring the extra I2cSerialBus resources.

Also it might be better to make the i2c_multi_inst_count_resources() function
a generic helper under drivers/acpi, so that it can be used in other places,
see my comments to the BOSC0200 patch.

Regards,

Hans

