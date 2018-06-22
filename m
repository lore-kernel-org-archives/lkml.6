Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E15C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2A923EE9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2A923EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754134AbeFVIWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:22:43 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52520 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751393AbeFVIWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:22:39 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D5ADD28A5E1
Subject: Re: [PATCH v3] PM / devfreq: Fix devfreq_add_device() when drivers
 are built as modules.
To:     Akhil P Oommen <akhilpo@codeaurora.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-pm@vger.kernel.org
References: <20180621220430.25644-1-enric.balletbo@collabora.com>
 <0383b4a703a0b619023c0654a4a7637419c72ebd.camel@collabora.com>
 <addc4280-729f-85d7-a314-35afbb7c8bb1@codeaurora.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <36c9720c-7428-0a17-5252-7afbd80bce6b@collabora.com>
Date:   Fri, 22 Jun 2018 10:22:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <addc4280-729f-85d7-a314-35afbb7c8bb1@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ezequiel and Akhil,

On 22/06/18 09:03, Akhil P Oommen wrote:
> 
> On 6/22/2018 6:41 AM, Ezequiel Garcia wrote:
>> Hey Enric,
>>
>> On Fri, 2018-06-22 at 00:04 +0200, Enric Balletbo i Serra wrote:
>>> When the devfreq driver and the governor driver are built as modules,
>>> the call to devfreq_add_device() or governor_store() fails because
>>> the
>>> governor driver is not loaded at the time the devfreq driver loads.
>>> The
>>> devfreq driver has a build dependency on the governor but also should
>>> have a runtime dependency. We need to make sure that the governor
>>> driver
>>> is loaded before the devfreq driver.
>>>
>>> This patch fixes this bug by adding a try_then_request_governor()
>>> function. First tries to find the governor, and then, if it is not
>>> found,
>>> it requests the module and tries again.
>>>
>>> Fixes: 1b5c1be2c88e (PM / devfreq: map devfreq drivers to governor
>>> using name)
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> ---
>>>
>>> Changes in v3:
>>> - Remove unneded change in dev_err message.
>>> - Fix err returned value in case to not find the governor.
>>>
>>> Changes in v2:
>>> - Add a new function to request the module and call that function
>>> from
>>>    devfreq_add_device and governor_store.
>>>
>>>   drivers/devfreq/devfreq.c | 65 ++++++++++++++++++++++++++++++++-----
>>> -- 
>> [snip snip]
>>> -    governor = find_devfreq_governor(devfreq->governor_name);
>>> +    governor = try_then_request_governor(devfreq-
>>>> governor_name);
>>>       if (IS_ERR(governor)) {
>>>           dev_err(dev, "%s: Unable to find governor for the
>>> device\n",
>>>               __func__);
>>>           err = PTR_ERR(governor);
>>> -        goto err_init;
>>> +        goto err_unregister;
>>>       }
>>>   +    mutex_lock(&devfreq_list_lock);
>>> +
>> I know it's not something we are introducing in this patch,
>> but still... calling a hook with a mutex held looks
>> fishy to me.
>>
>> This lock should only protect the list, unless I am missing
>> something.
>>

I think so too.

>>>       devfreq->governor = governor;
>>>       err = devfreq->governor->event_handler(devfreq,
>>> DEVFREQ_GOV_START,
>>>                           NULL);
>>> @@ -663,14 +703,16 @@ struct devfreq *devfreq_add_device(struct
>>> device *dev,
>>>               __func__);
>>>           goto err_init;
>>>       }
>>> +
>>> +    list_add(&devfreq->node, &devfreq_list);
>>> +
>>>       mutex_unlock(&devfreq_list_lock);
>>>         return devfreq;
>>>     err_init:
>>> -    list_del(&devfreq->node);
>>>       mutex_unlock(&devfreq_list_lock);
>>> -
>>> +err_unregister:
>>>       device_unregister(&devfreq->dev);
>>>   err_dev:
>>>       if (devfreq)
>>> @@ -988,12 +1030,13 @@ static ssize_t governor_store(struct device
>>> *dev, struct device_attribute *attr,
>>>       if (ret != 1)
>>>           return -EINVAL;
>>>   -    mutex_lock(&devfreq_list_lock);
>>> -    governor = find_devfreq_governor(str_governor);
>>> +    governor = try_then_request_governor(str_governor);
>>>       if (IS_ERR(governor)) {
>>> -        ret = PTR_ERR(governor);
>>> -        goto out;
>>> +        return PTR_ERR(governor);
>>>       }
>>> +
>>> +    mutex_lock(&devfreq_list_lock);
>>> +
>>>       if (df->governor == governor) {
>>>           ret = 0;
>>>           goto out;
>>> -- 
>>> 2.17.1
>>>
>>>
>>
>> Regards,
>> Eze
> 
> Adding to Ezequiel's point, shouldn't we take more granular lock (devfreq->lock)
> first and then call devfreq_list_lock at the time of adding to the list?
> 

Yes, I think so. I think, though, that this should be a separate patch, not sure
if a pre or post patch to this one, but for sure it's another topic. Current
patch tries to solve different problem an only tries to follow the current
locking/unlocking. Anyway this is a maintainer decision I guess.

Thanks,
 Enric

> -Akhil.
> 
