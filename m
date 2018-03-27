Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752935AbeC0QHN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 12:07:13 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52077 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752559AbeC0QHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 12:07:06 -0400
X-Google-Smtp-Source: AIpwx4+MgZ7DbO/hkbSF/18/j8fE00y2nBHtZypiZ4XwQbXQhKimsdwM0A4MS2ce9CYF4ZHNHx5Iv3IGuZLcxLEfPsM=
MIME-Version: 1.0
In-Reply-To: <5AB9ACDA.9090207@gmail.com>
References: <d5a326b6c284f7389301b265716dc58fda492c98.1521358552.git.arvind.yadav.cs@gmail.com>
 <CANLsYkymOF2oG7TmKbRTakYKw0ECN_DXfkX5b8WjmS0Lz0sfig@mail.gmail.com> <5AB9ACDA.9090207@gmail.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Tue, 27 Mar 2018 10:07:04 -0600
Message-ID: <CANLsYkw0v-vVpf1M1Ae+y=Hq5cqqp+_Sjq41pDS+=Xv9zesHAw@mail.gmail.com>
Subject: Re: [PATCH] coresight: use put_device() instead of kfree()
To: arvindY <arvind.yadav.cs@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 March 2018 at 20:30, arvindY <arvind.yadav.cs@gmail.com> wrote:
>
>
> On Tuesday 27 March 2018 03:16 AM, Mathieu Poirier wrote:
>>
>> drivers/hwtracing/coresight/coresight.c
>> On 18 March 2018 at 01:38, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
>>>
>>> Never directly free @dev after calling device_register(), even
>>> if it returned an error. Always use put_device() to give up the
>>> reference initialized.
>>>
>>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>>> ---
>>>   drivers/hwtracing/coresight/coresight.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight.c
>>> b/drivers/hwtracing/coresight/coresight.c
>>> index 389c4ba..132dfbc 100644
>>> --- a/drivers/hwtracing/coresight/coresight.c
>>> +++ b/drivers/hwtracing/coresight/coresight.c
>>> @@ -1026,8 +1026,10 @@ struct coresight_device *coresight_register(struct
>>> coresight_desc *desc)
>>>          dev_set_name(&csdev->dev, "%s", desc->pdata->name);
>>>
>>>          ret = device_register(&csdev->dev);
>>> -       if (ret)
>>> -               goto err_device_register;
>>> +       if (ret) {
>>> +               put_device(&csdev->dev);
>>> +               goto err_kzalloc_csdev;
>>> +       }
>>>
>>>          mutex_lock(&coresight_mutex);
>>>
>>> @@ -1038,8 +1040,6 @@ struct coresight_device *coresight_register(struct
>>> coresight_desc *desc)
>>>
>>>          return csdev;
>>>
>>> -err_device_register:
>>> -       kfree(conns);
>>
>> Apologies for the late reply, I was travelling.
>>
>> I suggest to simply replace kfree() with put_device() in order to
>> concentrate the error handling code in the same area and make sure
>> that memory allocated for @conns and @refcnts is freed.
>>
>> Thanks,
>> Mathieu
>
>
> If you will see the comment for device_register(drivers/base/core.c)
> there is mentioned that 'NOTE: _Never_ directly free @dev
> after calling this function, even if it returned an error!
> Always use put_device() to give up the reference initialized
> in this function instead.

I have read the notice and in full agreement with the put_device() part.

> Here  put_device() will decrement the last reference and then
> free the memory by calling dev->release.  Internally
> put_device() -> kobject_put() -> kobject_cleanup() which is
> responsible to call 'dev -> release' and also free other kobject
> resources.

Memory would be automatically freed if it would have been allocated
with the devm_XYZ() helpers but it is not the case here.  As such it
has to be freed explicitly.  Reading your patch again (and the jetlag
somewhat fading) I think you've done the right thing except for the
"goto" that should still point to "err_device_register".

>we should always avoid kfree() if device_register()
> returned an error. Otherwise it'll not do clean up of other
> kobject resources.
>
> ~arvind
>>>
>>>   err_kzalloc_conns:
>>>          kfree(refcnts);
>>>   err_kzalloc_refcnts:
>>> --
>>> 2.7.4
>>>
>
