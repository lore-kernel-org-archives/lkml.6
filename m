Return-Path: <elder@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524834171; cv=none;
        d=google.com; s=arc-20160816;
        b=I+mrR0yZ5ON4IgSjyrvgrFJAH/jARZ3bvdP35aMFKWBEJeo6Yl3MSVqYvb2I09Avt/
         QJ7ZCaxSOx1/TfSQ2NhseZybNWXFY+BROm+fLX0y1qjp2pO1l4IZ+e4x1h0pLQWkQ5/y
         hSUziksxCipn22YF8YrM+mmL0VSjPZF33Ad3YiXVrUU4wWzC4c8lYDmXdY2w9tNMVjih
         M7wcf37XEIAZu9tUZEHMuxWS+peo1Pqh8SPhOF4Qf1m9/Qy8jOq3zkZxPXYxNf8JblLf
         ulrDA7V0ZxsXImHdrFVJ/eFqFG7EilqvraI6n4Oe4FfwssWhaRr1iK63j8SD358ImCP9
         5iAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=InviwTA61RrYQknFBxHkrnva0BOePyXJU34AaIN+xu4=;
        b=OhVx7FMoSc/b+3qS2hvT35xcI0fuo7KcPjfT7gMb/ae0jp1zmgpnxKsQwmvup+6Y6A
         aqnVDdeSSMxm3q4gIYPnQYhHyFqSKgnbDobjdlPT7bB7rEUyMKmbS5n8112suPpBYIDK
         XkCBTfeAbEEs/rEYidU/2RxhQBaz6GvZQ41gcAy90M9vZJ7L27Ppyu8n81XJmRUr+iwG
         R4vk9gBtlAm51amgCRG6f2ao7rmHwdX/MQQJcfffRYfuSj54YCfsiA/aKkjQR2k56ctb
         xyBNX2Hh+c+tdQalkdszlxUEtmb1iwWjelUP2uXYOw77lTbE/5pR2bF14jodVxVhxeTO
         kjLw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=JQAYxGem;
       spf=pass (google.com: domain of elder@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=elder@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=JQAYxGem;
       spf=pass (google.com: domain of elder@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=elder@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZo6rGQ/cWaQsOHaILrVEGv8bJlYVW2bGc3ZaSnqqlIID4kQzLGdM0roQeJtt4jGpF7E4wF/FA==
Subject: Re: [greybus-dev] [PATCH] staging: greybus: Use gpio_is_valid()
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, hvaibhav.linux@gmail.com,
 johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
 linux-kernel@vger.kernel.org
References: <785eda4d65f396b353393e9538eba21095ce876e.1524825902.git.arvind.yadav.cs@gmail.com>
 <7ebee672-6413-6f1d-fe57-2e278c90cf9e@linaro.org>
 <3910023d-143e-7618-1fd4-f3bdffbfb3ec@gmail.com>
From: Alex Elder <elder@linaro.org>
Message-ID: <c5417345-d409-ebe5-c56e-baaf2333bae1@linaro.org>
Date: Fri, 27 Apr 2018 08:02:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <3910023d-143e-7618-1fd4-f3bdffbfb3ec@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598896358310387815?=
X-GMAIL-MSGID: =?utf-8?q?1598904516537781305?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/27/2018 07:50 AM, Arvind Yadav wrote:
> 
> 
> On Friday 27 April 2018 05:47 PM, Alex Elder wrote:
>> On 04/27/2018 05:52 AM, Arvind Yadav wrote:
>>> Replace the manual validity checks for the GPIO with the
>>> gpio_is_valid().
>> I haven't looked through the code paths very closely, but I
>> think that get_named_gpio() might return -EPROBE_DEFER, which
>> would be something we want to pass to the caller.
> Yes of_get_name_gpio() can return other error value apart from
> -EPROBE_DEFER.
>> So rather than returning -ENODEV and hiding the reason the
>> call to of_get_named_gpio() failed, you should continue
>> returning the errno it supplies (if not a valid gpio number).
>>
>>                     -Alex
> I have return -ENODEV because invalid gpio pin can be positive.
> static inline bool gpio_is_valid(int number)
> {
>     return number >= 0 && number < ARCH_NR_GPIOS;
> }
> Here if number > ARCH_NR_GPIOS then it's invalid but return value
> will be positive.

Your reasoning is good.  However in all three of these cases,
the GPIO number you're checking is the value returned from
of_get_named_gpio().  The return value is a "GPIO number to
use with Linux generic GPIO API, or one of the errno value."

So unless the API of of_get_named_gpio() changes, you can be
sure that if the value returned is invalid, it is a negative
errno.  (And if the API did change, the person making that
change would be responsible for fixing all callers to ensure
the change didn't break them.)

This distinction may be why the code you're changing was only
testing for negative, rather than using gpio_is_valid() (you'll
see it's used elsewhere in the Greybus code--even in the same
source files.)

Anyway, changing the code to use gpio_is_valid() is fine.  But
you should avoid obscuring the reason for the error that the
return value from of_get_named_gpio() provides.

					-Alex

> We can return like this
>     " return (gpio > 0) ? -ENODEV: gpio;"
> 
> But not sure this is worth to handle this.
> 
> ~arvind
>>
>>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>>> ---
>>>   drivers/staging/greybus/arche-platform.c | 12 ++++++------
>>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
>>> index 83254a7..fc6bf60 100644
>>> --- a/drivers/staging/greybus/arche-platform.c
>>> +++ b/drivers/staging/greybus/arche-platform.c
>>> @@ -448,9 +448,9 @@ static int arche_platform_probe(struct platform_device *pdev)
>>>       arche_pdata->svc_reset_gpio = of_get_named_gpio(np,
>>>                               "svc,reset-gpio",
>>>                               0);
>>> -    if (arche_pdata->svc_reset_gpio < 0) {
>>> +    if (!gpio_is_valid(arche_pdata->svc_reset_gpio)) {
>>>           dev_err(dev, "failed to get reset-gpio\n");
>>> -        return arche_pdata->svc_reset_gpio;
>>> +        return -ENODEV;
>>>       }
>>>       ret = devm_gpio_request(dev, arche_pdata->svc_reset_gpio, "svc-reset");
>>>       if (ret) {
>>> @@ -468,9 +468,9 @@ static int arche_platform_probe(struct platform_device *pdev)
>>>       arche_pdata->svc_sysboot_gpio = of_get_named_gpio(np,
>>>                                 "svc,sysboot-gpio",
>>>                                 0);
>>> -    if (arche_pdata->svc_sysboot_gpio < 0) {
>>> +    if (!gpio_is_valid(arche_pdata->svc_sysboot_gpio)) {
>>>           dev_err(dev, "failed to get sysboot gpio\n");
>>> -        return arche_pdata->svc_sysboot_gpio;
>>> +        return -ENODEV;
>>>       }
>>>       ret = devm_gpio_request(dev, arche_pdata->svc_sysboot_gpio, "sysboot0");
>>>       if (ret) {
>>> @@ -487,9 +487,9 @@ static int arche_platform_probe(struct platform_device *pdev)
>>>       arche_pdata->svc_refclk_req = of_get_named_gpio(np,
>>>                               "svc,refclk-req-gpio",
>>>                               0);
>>> -    if (arche_pdata->svc_refclk_req < 0) {
>>> +    if (!gpio_is_valid(arche_pdata->svc_refclk_req)) {
>>>           dev_err(dev, "failed to get svc clock-req gpio\n");
>>> -        return arche_pdata->svc_refclk_req;
>>> +        return -ENODEV;
>>>       }
>>>       ret = devm_gpio_request(dev, arche_pdata->svc_refclk_req,
>>>                   "svc-clk-req");
>>>
> 
