Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1940C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA2B20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+V+cfq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA2B20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406649AbeKWFyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 00:54:46 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37763 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbeKWFyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 00:54:46 -0500
Received: by mail-pf1-f195.google.com with SMTP id u3-v6so2305683pfm.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 11:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uqYI9VCBr4NaR1JV4t+8oryutpf7YY4uvo9zto+A2wg=;
        b=U+V+cfq+RUJ89kecPOtQ+Nzk86z0on9LnKh6F4auQ7TvJ7gA7xtq+D1KKcy/tI/lWy
         ZdTYoJb31TqziYODfQwq3D11d9iNboKfE2MUXKG1S4+iRy/0krdjuxQR29zzjw0ZwkFs
         B2ACrVaGzv1tOmmV8MidOwBLGR+FZxbJvfYm5n98WiwhvSMqJMxXL96s0GQLYjre6Pzz
         HNYdzUZoQ2rBY63YTi5osTR99HouxpLBPEy+r/SmnbQoO4Ydh5eQu4gDzfUn4qwxN1ln
         4SSsoIF+dyZiOZPF8P+R5etc0BSTENsm0kJ09+vvsVDSK1XnKb0ht2jbwX8T/emKtXw9
         BzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uqYI9VCBr4NaR1JV4t+8oryutpf7YY4uvo9zto+A2wg=;
        b=eQ298ZOYwbKl99w5OQZm+uJcvmSSFZFGmAG/uGokiwaVoWcm9npupXYxHaq7CeaVSs
         HzOXnb88DQBYojGtJc/eYXNtTeKpabXYrDIV1U7J8Bc4rEac2GKWcgow4rxgpRINcinL
         ggvQHtLLnaqHTwyOgt2dlhwRCOENuW3kT+EwdO0F6YzZu8s+rhyheyI0SmWg2yU7ESI4
         eWFjeQfzqAJbW4DbS5IwZUYUr4ghX34SCRbnZC+JD0CJu8HDjVSaxp1S9zA4EssDw3Z+
         rrBa+RurFIUoR4Ud5oVxC/Z6IG3eWSAKzxuOhBI8BswpHxNH2UkZq1jZifJYqvv1WJUa
         8WRQ==
X-Gm-Message-State: AGRZ1gIl+EN/2RVhGnKsoccXvshogaSeggYxIGg30tPw+omskotQchuB
        yi771cc1rmTxXWlmE/HB1vw=
X-Google-Smtp-Source: AJdET5fmeT3FVDqPzK/sLSr/J1/udyyEEqfD1SDHX8GbbsTFPraev7YowkElSU5mvRNWUQZ/XhiA5A==
X-Received: by 2002:a62:7892:: with SMTP id t140mr12665683pfc.237.1542914042818;
        Thu, 22 Nov 2018 11:14:02 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 11-v6sm78544803pfr.55.2018.11.22.11.14.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 11:14:02 -0800 (PST)
Date:   Thu, 22 Nov 2018 11:14:01 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lee.jones@linaro.org, gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 6/7] mfd / platform: cros_ec: instantiate only if th EC
 has a VBC NVRAM.
Message-ID: <20181122191401.GA2106@roeck-us.net>
References: <20181122113356.23610-1-enric.balletbo@collabora.com>
 <20181122113356.23610-7-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122113356.23610-7-enric.balletbo@collabora.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 12:33:55PM +0100, Enric Balletbo i Serra wrote:
> The cros-ec-vbc driver is DT-only and there is a DT property that
> indicates if the EC has the VCB NVRAM, in such case instantiate the
> driver but don't instantiate on the other cases.
> 
> To do this move the check code to its parent instead of play with the
> attribute group visibility. This changes a bit the actual behaviour.
> Before the patch if an EC doesn't have a VBC NVRAM an empty vbc folder
> is created in /sys/class/chromeos/<ec device>, after the patch the empty
> folder is not created, so, the folder is only created if the vbc is set.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  drivers/mfd/cros_ec_dev.c             | 24 +++++++++++++++++++++++-
>  drivers/platform/chrome/cros_ec_vbc.c | 16 ----------------
>  2 files changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index fc235af6da65..a63588953760 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -21,6 +21,7 @@
>  #include <linux/mfd/core.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/slab.h>
> @@ -400,7 +401,10 @@ static const struct mfd_cell cros_ec_platform_cells[] = {
>  	{ .name = "cros-ec-debugfs" },
>  	{ .name = "cros-ec-lightbar" },
>  	{ .name = "cros-ec-sysfs" },
> -	{ .name = "cros-ec-vbc" },
> +};
> +
> +static const struct mfd_cell cros_ec_vbc_cells[] = {
> +	{ .name = "cros-ec-vbc" }
>  };
>  
>  static int ec_device_probe(struct platform_device *pdev)
> @@ -409,6 +413,7 @@ static int ec_device_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct cros_ec_platform *ec_platform = dev_get_platdata(dev);
>  	struct cros_ec_dev *ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
> +	struct device_node *node;
>  
>  	if (!ec)
>  		return retval;
> @@ -492,6 +497,23 @@ static int ec_device_probe(struct platform_device *pdev)
>  		dev_err(ec->dev,
>  			"failed to add cros-ec platform devices: %d\n", retval);
>  
> +	/* Check whether this EC instance has a VBC NVRAM */
> +	node = ec->ec_dev->dev->of_node;
> +	if (IS_ENABLED(CONFIG_OF) && node) {

Is IS_ENABLED() necessary here ? Seems to me node should always be NULL
in this case.

> +		if (of_property_read_bool(node, "google,has-vbc-nvram")) {
> +			dev_err(dev, "device VBC found.\n");

dev_err ?

> +			retval = devm_mfd_add_devices(ec->dev,
> +					PLATFORM_DEVID_AUTO,
> +					cros_ec_vbc_cells,
> +					ARRAY_SIZE(cros_ec_vbc_cells),
> +					NULL, 0, NULL);
> +			if (retval)
> +				dev_err(ec->dev,
> +					"failed to add VBC devices: %d\n",
> +					retval);

Since the error is ignored, maybe better dev_warn() ?

> +		}
> +	}
> +
>  	return 0;
>  
>  failed:
> diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
> index 374153e3dc13..b7b81fe0fb25 100644
> --- a/drivers/platform/chrome/cros_ec_vbc.c
> +++ b/drivers/platform/chrome/cros_ec_vbc.c
> @@ -108,21 +108,6 @@ static ssize_t vboot_context_write(struct file *filp, struct kobject *kobj,
>  	return data_sz;
>  }
>  
> -static umode_t cros_ec_vbc_is_visible(struct kobject *kobj,
> -				      struct bin_attribute *a, int n)
> -{
> -	struct device *dev = container_of(kobj, struct device, kobj);
> -	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
> -	struct device_node *np = ec->ec_dev->dev->of_node;
> -
> -	if (IS_ENABLED(CONFIG_OF) && np) {
> -		if (of_property_read_bool(np, "google,has-vbc-nvram"))
> -			return a->attr.mode;
> -	}
> -
> -	return 0;
> -}
> -
>  static BIN_ATTR_RW(vboot_context, 16);
>  
>  static struct bin_attribute *cros_ec_vbc_bin_attrs[] = {
> @@ -133,7 +118,6 @@ static struct bin_attribute *cros_ec_vbc_bin_attrs[] = {
>  struct attribute_group cros_ec_vbc_attr_group = {
>  	.name = "vbc",
>  	.bin_attrs = cros_ec_vbc_bin_attrs,
> -	.is_bin_visible = cros_ec_vbc_is_visible,
>  };
>  
>  static int cros_ec_vbc_probe(struct platform_device *pd)
