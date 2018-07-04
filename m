Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7C3C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35D223D3E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35D223D3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964774AbeGDIQt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:16:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36508 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934099AbeGDIQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:16:43 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 96605278640
Subject: Re: [PATCH v4] PM / devfreq: Fix devfreq_add_device() when drivers
 are built as modules.
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-pm@vger.kernel.org
References: <CGME20180703132943epcas1p25b68c00ca1143d5eabcc2285c2ce27a0@epcas1p2.samsung.com>
 <20180703132931.14389-1-enric.balletbo@collabora.com>
 <5B3C1DA6.7040507@samsung.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <7fcd3fa4-4f57-9013-b6ff-808600eeb612@collabora.com>
Date:   Wed, 4 Jul 2018 10:16:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5B3C1DA6.7040507@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 04/07/18 03:06, Chanwoo Choi wrote:
> Hi Enric,
> 
> On 2018년 07월 03일 22:29, Enric Balletbo i Serra wrote:
>> When the devfreq driver and the governor driver are built as modules,
>> the call to devfreq_add_device() or governor_store() fails because the
>> governor driver is not loaded at the time the devfreq driver loads. The
>> devfreq driver has a build dependency on the governor but also should
>> have a runtime dependency. We need to make sure that the governor driver
>> is loaded before the devfreq driver.
>>
>> This patch fixes this bug by adding a try_then_request_governor()
>> function. First tries to find the governor, and then, if it is not found,
>> it requests the module and tries again.
>>
>> Fixes: 1b5c1be2c88e (PM / devfreq: map devfreq drivers to governor using name)
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> Changes in v4:
>> - Kept "locked" devfreq_list from the return of find_devfreq_governor() to
>>   the unlock of governor_store(). Requested by MyungJoo Ham.
>>
>> Changes in v3:
>> - Remove unneded change in dev_err message.
>> - Fix err returned value in case to not find the governor.
>>
>> Changes in v2:
>> - Add a new function to request the module and call that function from
>>   devfreq_add_device and governor_store.
>>
>>  drivers/devfreq/devfreq.c | 53 ++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 47 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 0b5b3abe054e..4ea6b19879a1 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -11,6 +11,7 @@
>>   */
>>  
>>  #include <linux/kernel.h>
>> +#include <linux/kmod.h>
>>  #include <linux/sched.h>
>>  #include <linux/errno.h>
>>  #include <linux/err.h>
>> @@ -221,6 +222,46 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
>>  	return ERR_PTR(-ENODEV);
>>  }
>>  
>> +/**
>> + * try_then_request_governor() - Try to find the governor and request the
>> + *                               module if is not found.
>> + * @name:	name of the governor
> 
> Usually, devfreq used 'governor_name' indicating the name of governor.
> you better to use 'governor_name' instead of 'name' for more readability.
> 

I don't mind to change if you want. But let me try to convince you first. I used
name for two reasons:
1. I saw that you are using governor_name sometimes, but find_devfreq_governor
uses name not governor_name. IMHO the function name in these two specific cases
'try_then_request_governor(name)' is enough readable.
2. If we want to use governor_name and then do not have the line exceeding the
80 characters I need to split the function in two lines. For me the readability
is better when you have all in one line.

If I did not convince you, just let me now and I'll change for governor_name :)

>> + *
>> + * Search the list of devfreq governors and request the module and try again
>> + * if is not found. This can happen when both drivers (the governor driver
>> + * and the driver that call devfreq_add_device) are built as modules.
>> + * devfreq_list_lock should be held by the caller.
>> + *
>> + * Return: The matched governor's pointer.
> 
> Usually, devfreq.c didn;t use the 'Return: ...'. So, you better to explain
> what is returned from this function with function description.
> 

OK.

>> + */
>> +static struct devfreq_governor *try_then_request_governor(const char *name)
> 
> ditto. (name -> governor_name)
> 

I convinced you? ;)

>> +{
>> +	struct devfreq_governor *governor;
>> +	int err = 0;
> 
> You have to check whether governor name is NULL or not.
> 
> 	if (IS_ERR_OR_NULL(name)) {                                             
> 		pr_err("DEVFREQ: %s: Invalid parameters\n", __func__);          
> 		return ERR_PTR(-EINVAL);
> 	}
> 

Right.

>> +
>> +	WARN(!mutex_is_locked(&devfreq_list_lock),
>> +	     "devfreq_list_lock must be locked.");
>> +
>> +	governor = find_devfreq_governor(name);
>> +	if (IS_ERR(governor)) {
>> +		mutex_unlock(&devfreq_list_lock);
>> +
>> +		if (!strncmp(name, DEVFREQ_GOV_SIMPLE_ONDEMAND,
>> +			     DEVFREQ_NAME_LEN))
>> +			err = request_module("governor_%s", "simpleondemand");
>> +		else
>> +			err = request_module("governor_%s", name);
>> +		if (err)
>> +			return NULL;
> 
> When error happen, you unlock the mutex. If failed to request module,
> you should restore the previous state. Please mutex_lock(&devfreq_list_lock)
> before return.
> 

Oh right, my bad.

>> +
>> +		mutex_lock(&devfreq_list_lock);
>> +
>> +		governor = find_devfreq_governor(name);
>> +	}
>> +
>> +	return governor;
>> +}
>> +
>>  static int devfreq_notify_transition(struct devfreq *devfreq,
>>  		struct devfreq_freqs *freqs, unsigned int state)
>>  {
>> @@ -643,11 +684,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  	srcu_init_notifier_head(&devfreq->transition_notifier_list);
>>  
>>  	mutex_unlock(&devfreq->lock);
>> -
> 
> This change is not related to this patch.
> 
Ack.
>>  	mutex_lock(&devfreq_list_lock);
>> -	list_add(&devfreq->node, &devfreq_list);
>>  
>> -	governor = find_devfreq_governor(devfreq->governor_name);
>> +	governor = try_then_request_governor(devfreq->governor_name);
>>  	if (IS_ERR(governor)) {
>>  		dev_err(dev, "%s: Unable to find governor for the device\n",
>>  			__func__);
>> @@ -663,14 +702,15 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  			__func__);
>>  		goto err_init;
>>  	}
>> +
>> +	list_add(&devfreq->node, &devfreq_list);
>> +
>>  	mutex_unlock(&devfreq_list_lock);
>>  
>>  	return devfreq;
>>  
>>  err_init:
>> -	list_del(&devfreq->node);
>>  	mutex_unlock(&devfreq_list_lock);
>> -
> 
> This change is not related to this patch.
> 

Ack.

>>  	device_unregister(&devfreq->dev);
>>  err_dev:
>>  	if (devfreq)
>> @@ -989,7 +1029,8 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>>  		return -EINVAL;
>>  
>>  	mutex_lock(&devfreq_list_lock);
>> -	governor = find_devfreq_governor(str_governor);
>> +
> 
> Don't need to add the blank line. It is enough to change the function
> from find_devfreq_governor to try_then_request_governor.
> 
>> +	governor = try_then_request_governor(str_governor);
>>  	if (IS_ERR(governor)) {
>>  		ret = PTR_ERR(governor);
>>  		goto out;
>>
> 
>

Preparing next version, many thanks for the review.

 Enric
