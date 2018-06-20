Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE320C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8201120693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8201120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753622AbeFTKco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:32:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40558 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752595AbeFTKcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:32:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D0541260613
Subject: Re: [PATCH] PM / devfreq: Fix devfreq_add_device() when drivers are
 built as modules.
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        cwchoi00@gmail.com
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>
References: <20180615100452.17466-1-enric.balletbo@collabora.com>
 <CAGTfZH1QkzBjDPfsS23DgVF=EqO1P9RK+YdAnAwt2rDL6eGPTg@mail.gmail.com>
 <CAFqH_5344NDHup+u0QtimTJjKaVVj46YB6UDMKtdMr70JJmkng@mail.gmail.com>
 <CGME20180619082320epcas5p228d76c9e326d24acc1c38b43ff152347@epcas5p2.samsung.com>
 <7eff02c1-3d78-de08-19ab-a4a45c491a86@collabora.com>
 <5B29A43E.2080402@samsung.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <9186fc15-c884-a67b-e2fb-113721613146@collabora.com>
Date:   Wed, 20 Jun 2018 12:32:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5B29A43E.2080402@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 20/06/18 02:47, Chanwoo Choi wrote:
> Hi Enric,
> 
> On 2018년 06월 19일 17:22, Enric Balletbo i Serra wrote:
>> Hi Chanwoo,
>>
>> On 18/06/18 11:02, Enric Balletbo Serra wrote:
>>> Hi Chanwoo,
>>> Missatge de Chanwoo Choi <cwchoi00@gmail.com> del dia dg., 17 de juny
>>> 2018 a les 5:50:
>>>>
>>>> Hi Enric,
>>>>
>>>> This issue will happen on the position to use find_devfreq_governor()
>>>> as following:
>>>> - devfreq_add_governora() and governor_store()
>>>>
>>>> If device driver with module type after loaded want to change the
>>>> scaling governor,
>>>> new governor might be not yet loaded. So, devfreq bettero to consider this case
>>>> in the find_devfreq_governor().
>>>>
>>> Ok, I'll move there and send a v2.
>>>
>>
>> I tried your suggestion but I found one problem, if I move the code in
>> find_devfreq_governor it end up with a deadlock. The reason is the following calls.
>>
>> devfreq_add_device
>>   find_devfreq_governor (!!!)
>>     request_module
>>        devfreq_simple_ondemand_init
>>           devfreq_add_governor
>>              find_devfreq_governor (DEADLOCK)
>>
>> So I am wondering if shouldn't be more easy fix the issue in both places,
>> devfreq_add_device and governor_store.
>>
>> To devfreq_add_device
>>
>> devfreq_add_device
>>   governor = find_devfreq_governor
>>   if (IS_ERR(governor) {
> 
> In this error case, you have to unlock the mutex
> before calling the request_module(). I added the pseudo code
> of my opinion.
> 
>>      request_module
>>      governor = find_devfreq_governor
>>      if (IS_ERR(governor)
>>        return ERR_PTR(governor)
>>   }
>>
>> And the same for governor_store
>>
>> governor_store
>>   governor = find_devfreq_governor
>>   if (IS_ERR(governor) {
>>      request_module
>>      governor = find_devfreq_governor
>>      if (IS_ERR(governor)
>>        return ERR_PTR(governor)
>>   }
>>
>> Maybe all  can go in a new function try_find_devfreq_governor_then_request
> 
> How about modify the find_devfreq_governor() as following?
> I think that it is possible because previous find_devfreq_governor()
> always check whether mutex is locked or not.
> 
> 	find_devfreq_governor() {
> 
> 		// check whether mutex is locked or not		
> 		if (!mutex_is_lock(&devfreq_list_lock)) {
> 			WARN(...)
> 			return -EINVAL
> 		}
> 
> 		// find the registered governor with list_for_each_entry
> 
> 		if (governor is not loaded) {
> 			mutex_unlock()
> 			request_module()

Then the problem is that the find_devfreq_governor is reentrant because the init
function of the governor calls devfreq_add_governor and find_devfreq_governor
again. E.g for simpleondemand governor you will get this loop.

find_devfreq_governor
  -> request_module
      -> devfreq_simple_ondemand_init
         -> devfreq_add_governor
            -> find_devfreq_governor
               -> request_module
                  -> devfreq_simple_ondemand_init
                     -> devfreq_add_governor
                        -> find_devfreq_governor
                           -> request_module
                              ...

Makes sense or I am missing something and there is a way to quit from this loop?

FWIW I checked how the cpufreq driver does this as it should have the same
problem. The find_governor function is just a simple search and instead of
integrating the request_module inside the find_governor function they have a
cpu_parse_governor that calls request module from the userspace call and from
the init call.

store_scaling_governor
  -> cpu_parse_governor
     -> request_module

cpufreq_add_dev_interface
  -> cpu_freq_init_policy
     -> cpu_parse_governor
        -> request_module

Thanks,
- Enric

> 			mutex_lock()	
> 		}
> 
> 	}
> 
> 
>>
>> Other suggestions?
>>
>> - Enric
>>
>>> Thanks
>>>  Enric.
>>>
>>>
>>>> 2018-06-15 19:04 GMT+09:00 Enric Balletbo i Serra
>>>> <enric.balletbo@collabora.com>:
>>>>> When the devfreq driver and the governor driver are built as modules,
>>>>> the call to devfreq_add_device() fails because the governor driver is
>>>>> not loaded at the time the devfreq driver loads. The devfreq driver has
>>>>> a build dependency on the governor but also should have a runtime
>>>>> dependency. We need to make sure that the governor driver is loaded
>>>>> before the devfreq driver.
>>>>>
>>>>> This patch fixes this bug in devfreq_add_device(). First tries to find
>>>>> the governor, and then, if was not found, it requests the module and
>>>>> tries again.
>>>>>
>>>>> Fixes: 1b5c1be2c88e (PM / devfreq: map devfreq drivers to governor using name)
>>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>>> ---
>>>>>
>>>>>  drivers/devfreq/devfreq.c | 36 +++++++++++++++++++++++++++++++-----
>>>>>  1 file changed, 31 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>> index fe2af6aa88fc..1d917f043e30 100644
>>>>> --- a/drivers/devfreq/devfreq.c
>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>> @@ -11,6 +11,7 @@
>>>>>   */
>>>>>
>>>>>  #include <linux/kernel.h>
>>>>> +#include <linux/kmod.h>
>>>>>  #include <linux/sched.h>
>>>>>  #include <linux/errno.h>
>>>>>  #include <linux/err.h>
>>>>> @@ -648,10 +649,35 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>>>
>>>>>         governor = find_devfreq_governor(devfreq->governor_name);
>>>>>         if (IS_ERR(governor)) {
>>>>> -               dev_err(dev, "%s: Unable to find governor for the device\n",
>>>>> -                       __func__);
>>>>> -               err = PTR_ERR(governor);
>>>>> -               goto err_init;
>>>>> +               list_del(&devfreq->node);
>>>>> +               mutex_unlock(&devfreq_list_lock);
>>>>> +
>>>>> +               /*
>>>>> +                * If the governor is not found, then request the module and
>>>>> +                * try again. This can happen when both drivers (the governor
>>>>> +                * driver and the driver that calls devfreq_add_device) are
>>>>> +                * built as modules.
>>>>> +                */
>>>>> +               if (!strncmp(devfreq->governor_name,
>>>>> +                            DEVFREQ_GOV_SIMPLE_ONDEMAND, DEVFREQ_NAME_LEN))
>>>>> +                       err = request_module("governor_%s", "simpleondemand");
>>>>> +               else
>>>>> +                       err = request_module("governor_%s",
>>>>> +                                            devfreq->governor_name);
>>>>> +               if (err)
>>>>> +                       goto err_unregister;
>>>>> +
>>>>> +               mutex_lock(&devfreq_list_lock);
>>>>> +               list_add(&devfreq->node, &devfreq_list);
>>>>> +
>>>>> +               governor = find_devfreq_governor(devfreq->governor_name);
>>>>> +               if (IS_ERR(governor)) {
>>>>> +                       dev_err(dev,
>>>>> +                               "%s: Unable to find governor for the device\n",
>>>>> +                               __func__);
>>>>> +                       err = PTR_ERR(governor);
>>>>> +                       goto err_init;
>>>>> +               }
>>>>>         }
>>>>>
>>>>>         devfreq->governor = governor;
>>>>> @@ -669,7 +695,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>>>  err_init:
>>>>>         list_del(&devfreq->node);
>>>>>         mutex_unlock(&devfreq_list_lock);
>>>>> -
>>>>> +err_unregister:
>>>>>         device_unregister(&devfreq->dev);
>>>>>  err_dev:
>>>>>         if (devfreq)
>>>>> --
>>>>> 2.17.1
>>>>>
>>>>
>>>>
>>>>
>>>> --
>>>> Best Regards,
>>>> Chanwoo Choi
>>>> Samsung Electronics
>>>
>>
>>
>>
> 
> 
