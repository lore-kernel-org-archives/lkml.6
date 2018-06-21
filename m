Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BB9C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EF822449
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25EF822449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933738AbeFUVkU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:40:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50140 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933382AbeFUVkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:40:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A715C275394
Subject: Re: [PATCH v2] PM / devfreq: Fix devfreq_add_device() when drivers
 are built as modules.
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-pm@vger.kernel.org
References: <20180621211900.12510-1-enric.balletbo@collabora.com>
Message-ID: <226db773-7b77-f98b-3bff-311f81ef4ec5@collabora.com>
Date:   Thu, 21 Jun 2018 23:40:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621211900.12510-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/06/18 23:19, Enric Balletbo i Serra wrote:
> When the devfreq driver and the governor driver are built as modules,
> the call to devfreq_add_device() or governor_store() fails because the
> governor driver is not loaded at the time the devfreq driver loads. The
> devfreq driver has a build dependency on the governor but also should
> have a runtime dependency. We need to make sure that the governor driver
> is loaded before the devfreq driver.
> 
> This patch fixes this bug by adding a try_then_request_governor()
> function. First tries to find the governor, and then, if it is not found,
> it requests the module and tries again.
> 
> Fixes: 1b5c1be2c88e (PM / devfreq: map devfreq drivers to governor using name)
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> Changes in v2:
> - Add a new function to request the module and call that function from
>   devfreq_add_device and governor_store.
> 
>  drivers/devfreq/devfreq.c | 69 +++++++++++++++++++++++++++++++--------
>  1 file changed, 56 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0b5b3abe054e..dfdf9fc9c212 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -11,6 +11,7 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/kmod.h>
>  #include <linux/sched.h>
>  #include <linux/errno.h>
>  #include <linux/err.h>
> @@ -221,6 +222,46 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
>  	return ERR_PTR(-ENODEV);
>  }
>  
> +/**
> + * try_then_request_governor() - Try to find the governor and request the
> + *                               module if is not found.
> + * @name:	name of the governor
> + *
> + * Search the list of devfreq governors and request the module and try again
> + * if is not found. This can happen when both drivers (the governor driver
> + * and the driver that call devfreq_add_device) are built as modules.
> + *
> + * Return: The matched governor's pointer.
> + */
> +static struct devfreq_governor *try_then_request_governor(const char *name)
> +{
> +	struct devfreq_governor *governor;
> +	int err = 0;
> +
> +	mutex_lock(&devfreq_list_lock);
> +
> +	governor = find_devfreq_governor(name);
> +	if (IS_ERR(governor)) {
> +		mutex_unlock(&devfreq_list_lock);
> +
> +		if (!strncmp(name, DEVFREQ_GOV_SIMPLE_ONDEMAND,
> +			     DEVFREQ_NAME_LEN))
> +			err = request_module("governor_%s", "simpleondemand");
> +		else
> +			err = request_module("governor_%s", name);
> +		if (err)
> +			return NULL;
> +
> +		mutex_lock(&devfreq_list_lock);
> +
> +		governor = find_devfreq_governor(name);
> +	}
> +
> +	mutex_unlock(&devfreq_list_lock);
> +
> +	return governor;
> +}
> +
>  static int devfreq_notify_transition(struct devfreq *devfreq,
>  		struct devfreq_freqs *freqs, unsigned int state)
>  {
> @@ -644,17 +685,16 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  
>  	mutex_unlock(&devfreq->lock);
>  
> -	mutex_lock(&devfreq_list_lock);
> -	list_add(&devfreq->node, &devfreq_list);
> -
> -	governor = find_devfreq_governor(devfreq->governor_name);
> +	governor = try_then_request_governor(devfreq->governor_name);
>  	if (IS_ERR(governor)) {
> -		dev_err(dev, "%s: Unable to find governor for the device\n",
> +		dev_err(dev,
> +			"%s: Unable to find governor for the device\n",
>  			__func__);

Just noticed this unneeded change.

> -		err = PTR_ERR(governor);

and that I broke the error set. I will send a v3.

> -		goto err_init;
> +		goto err_unregister;
>  	}
>  
> +	mutex_lock(&devfreq_list_lock);
> +
>  	devfreq->governor = governor;
>  	err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
>  						NULL);
> @@ -663,14 +703,16 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  			__func__);
>  		goto err_init;
>  	}
> +
> +	list_add(&devfreq->node, &devfreq_list);
> +
>  	mutex_unlock(&devfreq_list_lock);
>  
>  	return devfreq;
>  
>  err_init:
> -	list_del(&devfreq->node);
>  	mutex_unlock(&devfreq_list_lock);
> -
> +err_unregister:
>  	device_unregister(&devfreq->dev);
>  err_dev:
>  	if (devfreq)
> @@ -988,12 +1030,13 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  	if (ret != 1)
>  		return -EINVAL;
>  
> -	mutex_lock(&devfreq_list_lock);
> -	governor = find_devfreq_governor(str_governor);
> +	governor = try_then_request_governor(str_governor);
>  	if (IS_ERR(governor)) {
> -		ret = PTR_ERR(governor);
> -		goto out;
> +		return PTR_ERR(governor);
>  	}
> +
> +	mutex_lock(&devfreq_list_lock);
> +
>  	if (df->governor == governor) {
>  		ret = 0;
>  		goto out;
> 
