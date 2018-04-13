Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753300AbeDMChf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 22:37:35 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45045 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752920AbeDMChd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 22:37:33 -0400
X-Google-Smtp-Source: AIpwx4+kwV9YjLnz5Qi7q/ULX5Z93L7ogOjRX++GyclLEmDKCMBAS3DAJWp2q3qWDbLbRGkhZc1AZQ==
Subject: Re: [PATCH] PM / devfreq: use put_device() instead of kfree()
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
References: <CGME20180330114418epcas5p1affd1c3d97e7422dd33e6d3ca73073be@epcas5p1.samsung.com>
 <d8d8708d2283349c2c4f3e9f3c9fd5f47126d2bc.1522410143.git.arvind.yadav.cs@gmail.com>
 <5AD001C5.2040406@samsung.com> <5AD0041D.2050506@samsung.com>
 <5AD012CB.7030003@gmail.com> <5AD0160E.7050601@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
From: arvindY <arvind.yadav.cs@gmail.com>
Message-ID: <5AD017E8.7020901@gmail.com>
Date: Fri, 13 Apr 2018 08:07:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <5AD0160E.7050601@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday 13 April 2018 07:59 AM, Chanwoo Choi wrote:
> On 2018년 04월 13일 11:15, arvindY wrote:
>> Hi Chanwoo,
>>
>> On Friday 13 April 2018 06:43 AM, Chanwoo Choi wrote:
>>> On 2018년 04월 13일 10:03, Chanwoo Choi wrote:
>>>> Hi,
>>>>
>>>> I'm sorry for the late reply.
>>>>
>>>> On 2018년 03월 30일 20:44, Arvind Yadav wrote:
>>>>> Never directly free @dev after calling device_register() or
>>>>> device_unregister(), even if device_register() returned an error.
>>>>> Always use put_device() to give up the reference initialized.
>>>>>
>>>>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>>>>> ---
>>>>>    drivers/devfreq/devfreq.c | 4 +++-
>>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>> index fe2af6a..a225b94 100644
>>>>> --- a/drivers/devfreq/devfreq.c
>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>> @@ -625,7 +625,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>>>        err = device_register(&devfreq->dev);
>>>>>        if (err) {
>>>>>            mutex_unlock(&devfreq->lock);
>>>>> -        goto err_dev;
>>>>> +        put_device(&devfreq->dev);
>>>>> +        goto err_out;
>>>> why do you change the goto postion?
>>>> err_out is correct to free the memory of devfreq instance.
>>> Sorry. err_dev is correct instead of err_out.
>> If you will see the comment for device_register(drivers/base/core.c)
>> there is mentioned that 'NOTE: _Never_ directly free @dev
>> after calling this function, even if it returned an error!
>> Always use put_device() to give up the reference initialized
>> in this function instead. Here  put_device() will decrement
>> the last reference and then free the memory by calling dev->release.
>> Internally put_device() -> kobject_put() -> kobject_cleanup() which
>> is responsible to call 'dev -> release' and also free other kobject resources.
>>
>> We are releasing devfreq in devfreq_dev_release(). So no need
>> to call kfree() again. It'll be redundant.  'err_out' is correct.
> You're right. err_out is correct.
> put_device() -> dev->release() -> devfreq_dev_release() -> kfree(devfreq)
>
>>>>>        }
>>>>>          devfreq->trans_table =    devm_kzalloc(&devfreq->dev,
>>>>> @@ -671,6 +672,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>>>        mutex_unlock(&devfreq_list_lock);
>>>>>          device_unregister(&devfreq->dev);
>>>>> +    devfreq = NULL;
>>>> It is wrong. If you initialize the devfreq as NULL,
>>>> never free the 'devfreq' instance.
>> No need to release memory after device_unregister().
>> driver core will take care of this. It will release memory
>> So no need to call free again.
> If you have to initialize the devfreq instance as NULL,
> I think that you better to init in the devfreq_dev_release()
> as following:
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index fe2af6aa88fc..8c52a13d3887 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -543,6 +543,7 @@ static void devfreq_dev_release(struct device *dev)
>   
>          mutex_destroy(&devfreq->lock);
>          kfree(devfreq);
> +       devfreq = NULL;
>   }

Yes, You are right. I will share a update patch.
Thanks for reviewing.
>
>>>>>    err_dev:
>>>>>        if (devfreq)
>>>>>            kfree(devfreq);
>>>>>
>> ~arvind
>>
>>
>>
>
