Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753625AbeDRMi6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 08:38:58 -0400
Received: from www381.your-server.de ([78.46.137.84]:58010 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752617AbeDRMiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 08:38:55 -0400
Subject: Re: [PATCH v3 06/11] iio: inkern: add module put/get on iio dev
 module when requesting channels
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Eugen Hristev <eugen.hristev@microchip.com>,
        Jonathan Cameron <jic23@kernel.org>, ludovic.desroches@microchip.com,
        alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        nicolas.ferre@microchip.com, robh@kernel.org
References: <1523350677-27106-1-git-send-email-eugen.hristev@microchip.com>
 <1523350677-27106-7-git-send-email-eugen.hristev@microchip.com>
 <20180415203321.1aaaf91e@archlinux> <20180416235821.GF77055@dtor-ws>
 <67771f4c-d30c-4a28-2a9b-d5585186d60a@microchip.com>
 <20180417191906.GB67621@dtor-ws> <20180418103548.000078b7@huawei.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <79d51d4e-eea7-7295-7e32-26149d6aeadd@metafoo.de>
Date: Wed, 18 Apr 2018 14:37:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418103548.000078b7@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18/2018 11:35 AM, Jonathan Cameron wrote:
> On Tue, 17 Apr 2018 12:19:06 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
>> Hi Eugen,
>>
>> On Tue, Apr 17, 2018 at 10:39:24AM +0300, Eugen Hristev wrote:
>>>
>>>
>>> On 17.04.2018 02:58, Dmitry Torokhov wrote:  
>>>> On Sun, Apr 15, 2018 at 08:33:21PM +0100, Jonathan Cameron wrote:  
>>>>> On Tue, 10 Apr 2018 11:57:52 +0300
>>>>> Eugen Hristev <eugen.hristev@microchip.com> wrote:
>>>>>   
>>>>>> When requesting channels for a particular consumer device,
>>>>>> besides requesting the device (incrementing the reference counter), also
>>>>>> do it for the driver module of the iio dev. This will avoid the situation
>>>>>> where the producer IIO device can be removed and the consumer is still
>>>>>> present in the kernel.
>>>>>>
>>>>>> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
>>>>>> ---
>>>>>>   drivers/iio/inkern.c | 8 +++++++-
>>>>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
>>>>>> index ec98790..68d9b87 100644
>>>>>> --- a/drivers/iio/inkern.c
>>>>>> +++ b/drivers/iio/inkern.c
>>>>>> @@ -11,6 +11,7 @@
>>>>>>   #include <linux/slab.h>
>>>>>>   #include <linux/mutex.h>
>>>>>>   #include <linux/of.h>
>>>>>> +#include <linux/module.h>
>>>>>>   #include <linux/iio/iio.h>
>>>>>>   #include "iio_core.h"
>>>>>> @@ -152,6 +153,7 @@ static int __of_iio_channel_get(struct iio_channel *channel,
>>>>>>   	if (index < 0)
>>>>>>   		goto err_put;
>>>>>>   	channel->channel = &indio_dev->channels[index];
>>>>>> +	try_module_get(channel->indio_dev->driver_module);  
>>>>>
>>>>> And if it fails? (the module we are trying to get is going away...)
>>>>>
>>>>> We should try and handle it I think. Be it by just erroring out of here.  
>>>>
>>>> Even more, this has nothing to do with modules. A device can go away for
>>>> any number of reasons (we unbind it manually via sysfs, we pull the USB
>>>> plug from the host in case it is USB-connected device, we unload I2C
>>>> adapter for the bus device resides on, we kick underlying PCI device)
>>>> and we should be able to handle this in some fashion. Handling errors
>>>> from reads and ignoring garbage is one of methods.
>>>>
>>>> FWIW this is a NACK from me.
>>>>
>>>> Thanks.  
>>> Hello,
>>>
>>> This patch is actually a "best effort attempt" for the consumer driver
>>> (touch driver) to get a reference to the producer of the data (the IIO
>>> device), when it requests the specific channels.
>>> As of this moment, there is no attempt whatsoever for the consumer to have a
>>> reference on the producer driver. Thus, the producer can be removed at any
>>> time, and the consumer will fail ungraciously.  
>>
>> This is the root of the issue. The consumer should be prepared to handle
>> errors from producer.
>>
>>> I can change the perspective from "best effort" to "mandatory" to get a
>>> reference to the producer, or you wish to stop trying to get any reference
>>> at all (remove this patch completely) ?  
>>
>> You should take reference to the device itself (if it is not taken
>> already), so it does not disappear completely and you can continue using
>> IIO API to access it, and IIO API should be prepared to deal with "dead"
>> devices, but as I pointed in my other email, trying to pin the driver
>> is quite pointless as there are myriad other ways of device stopping
>> working besides module unloading.
>>
>> In any case, I think this problem is outside of the scope of this
>> patchset that adds a generic resistive touchscreen, so if you want to
>> continue working on this I'd recommend moving it into a separate series.
>>
>> Thanks.
>>
> Agreed, this one has come up a number of times before.  Quite a lot of
> work got done by (IIRC) Lars Peter Clausen to stabilize things in various
> unexpected 'going away' events.  Of course there may be paths we have
> added since that (it was years ago) that can cause trouble...
> 
> Anyhow, separate issue as Dmitry says, let's deal with it separately.

We do properly get a ref to the device. Not getting a ref to the module is
on purpose. Cause as Dmitry said it does nothing the device can disappear at
any point either way. I second the NACK.
