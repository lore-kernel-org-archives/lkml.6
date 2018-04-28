Return-Path: <arvind.yadav.cs@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524889820; cv=none;
        d=google.com; s=arc-20160816;
        b=zjPc0FtNhCbXZdQCboD8Qr01IbqtbNpPbhk5zOT8E9pE9hhs1kV749FgGg6iSX12Jc
         nxRHyGvc1fdN/8GsU4b9PAaM9zVT3rAzw4Bg1pxurYK4u3i/Hcu+UPykLnS1W0AJMyFi
         99RYID359Aniyizf6fktb60a3z/p9k/XmVUBh/deThq5Oy+iv/jZ9VNVRLo0nM37hu5R
         z+x3BbLapaBKBToFSPBvxcaAfY66ctA0xYE0FPp1w/EHZgAYz6uPJLpxgwvpFA9DzSes
         enTMyde9JxO/cZC7o3DtPItWoZo8nGIoDT+EBb2NvnO/KQfQvKELBe8MRWKM2HpEJscP
         Vb+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:dkim-signature
         :arc-authentication-results;
        bh=HQOu/P4Cz+meYRpi9u2hUhzV+ow9ekkmsm0L9/8yo0Y=;
        b=vo4V+7puvBs/wSlb5UrYRuWncYq3JweAHYnzqaOStA6YTCxvQ4McfhbaZ0ma3Rmd6F
         sX3Z+HPemDGDkzIqzNzbILVIWouS3Hd51xCOed8qhUZzIRmQWVhAmxqJ6xfrgLB6niYK
         Cl9PtGMbhP24jRgcCGcFPuikfw1i5MOWJn/fpFOsssnquN4HwM4hVDAt8eI0rYA8/nyg
         egkeGPgy3iha4QGtpKl56G1fxcFkfZ6aDLgYDilo6AmwvvzWRkphbGdpkPFcJlqW2i+W
         mdrFVfN8FDr0xUlAX9deaRTwK/3P/tUl+hENjoQKRAKy3DLr0+LxiPEN9pjyl83aG4iE
         WUFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Q+GE3IzO;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Q+GE3IzO;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZr38O9u4Kf+qjATKlfjQ41tEOCquackS1zANUWpN5t9KgqrOpKo0Xo9UKriLJ3YD5GB7lmBIg==
Subject: Re: [greybus-dev] [PATCH] staging: greybus: Use gpio_is_valid()
To: Alex Elder <elder@linaro.org>, hvaibhav.linux@gmail.com,
 johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org
References: <785eda4d65f396b353393e9538eba21095ce876e.1524825902.git.arvind.yadav.cs@gmail.com>
 <7ebee672-6413-6f1d-fe57-2e278c90cf9e@linaro.org>
 <3910023d-143e-7618-1fd4-f3bdffbfb3ec@gmail.com>
 <c5417345-d409-ebe5-c56e-baaf2333bae1@linaro.org>
Cc: devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
 linux-kernel@vger.kernel.org
From: arvindY <arvind.yadav.cs@gmail.com>
Message-ID: <5AE3F8D7.6080007@gmail.com>
Date: Sat, 28 Apr 2018 10:00:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <c5417345-d409-ebe5-c56e-baaf2333bae1@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598896358310387815?=
X-GMAIL-MSGID: =?utf-8?q?1598962868771294195?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Friday 27 April 2018 06:32 PM, Alex Elder wrote:
> On 04/27/2018 07:50 AM, Arvind Yadav wrote:
>>
>> On Friday 27 April 2018 05:47 PM, Alex Elder wrote:
>>> On 04/27/2018 05:52 AM, Arvind Yadav wrote:
>>>> Replace the manual validity checks for the GPIO with the
>>>> gpio_is_valid().
>>> I haven't looked through the code paths very closely, but I
>>> think that get_named_gpio() might return -EPROBE_DEFER, which
>>> would be something we want to pass to the caller.
>> Yes of_get_name_gpio() can return other error value apart from
>> -EPROBE_DEFER.
>>> So rather than returning -ENODEV and hiding the reason the
>>> call to of_get_named_gpio() failed, you should continue
>>> returning the errno it supplies (if not a valid gpio number).
>>>
>>>                      -Alex
>> I have return -ENODEV because invalid gpio pin can be positive.
>> static inline bool gpio_is_valid(int number)
>> {
>>      return number >= 0 && number < ARCH_NR_GPIOS;
>> }
>> Here if number > ARCH_NR_GPIOS then it's invalid but return value
>> will be positive.
> Your reasoning is good.  However in all three of these cases,
> the GPIO number you're checking is the value returned from
> of_get_named_gpio().  The return value is a "GPIO number to
> use with Linux generic GPIO API, or one of the errno value."
>
> So unless the API of of_get_named_gpio() changes, you can be
> sure that if the value returned is invalid, it is a negative
> errno.  (And if the API did change, the person making that
> change would be responsible for fixing all callers to ensure
> the change didn't break them.)
>
> This distinction may be why the code you're changing was only
> testing for negative, rather than using gpio_is_valid() (you'll
> see it's used elsewhere in the Greybus code--even in the same
> source files.)
>
> Anyway, changing the code to use gpio_is_valid() is fine.  But
> you should avoid obscuring the reason for the error that the
> return value from of_get_named_gpio() provides.
>
> 					-Alex

Yes, It'll be fine to return a invalid gpio as error instead of
-ENODEV. I will send an updated patch.

~arvind
>
>> We can return like this
>>      " return (gpio > 0) ? -ENODEV: gpio;"
>>
>> But not sure this is worth to handle this.
>>
>> ~arvind
>>>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>>>> ---
>>>>    drivers/staging/greybus/arche-platform.c | 12 ++++++------
>>>>    1 file changed, 6 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
>>>> index 83254a7..fc6bf60 100644
>>>> --- a/drivers/staging/greybus/arche-platform.c
>>>> +++ b/drivers/staging/greybus/arche-platform.c
>>>> @@ -448,9 +448,9 @@ static int arche_platform_probe(struct platform_device *pdev)
>>>>        arche_pdata->svc_reset_gpio = of_get_named_gpio(np,
>>>>                                "svc,reset-gpio",
>>>>                                0);
>>>> -    if (arche_pdata->svc_reset_gpio < 0) {
>>>> +    if (!gpio_is_valid(arche_pdata->svc_reset_gpio)) {
>>>>            dev_err(dev, "failed to get reset-gpio\n");
>>>> -        return arche_pdata->svc_reset_gpio;
>>>> +        return -ENODEV;
>>>>        }
>>>>        ret = devm_gpio_request(dev, arche_pdata->svc_reset_gpio, "svc-reset");
>>>>        if (ret) {
>>>> @@ -468,9 +468,9 @@ static int arche_platform_probe(struct platform_device *pdev)
>>>>        arche_pdata->svc_sysboot_gpio = of_get_named_gpio(np,
>>>>                                  "svc,sysboot-gpio",
>>>>                                  0);
>>>> -    if (arche_pdata->svc_sysboot_gpio < 0) {
>>>> +    if (!gpio_is_valid(arche_pdata->svc_sysboot_gpio)) {
>>>>            dev_err(dev, "failed to get sysboot gpio\n");
>>>> -        return arche_pdata->svc_sysboot_gpio;
>>>> +        return -ENODEV;
>>>>        }
>>>>        ret = devm_gpio_request(dev, arche_pdata->svc_sysboot_gpio, "sysboot0");
>>>>        if (ret) {
>>>> @@ -487,9 +487,9 @@ static int arche_platform_probe(struct platform_device *pdev)
>>>>        arche_pdata->svc_refclk_req = of_get_named_gpio(np,
>>>>                                "svc,refclk-req-gpio",
>>>>                                0);
>>>> -    if (arche_pdata->svc_refclk_req < 0) {
>>>> +    if (!gpio_is_valid(arche_pdata->svc_refclk_req)) {
>>>>            dev_err(dev, "failed to get svc clock-req gpio\n");
>>>> -        return arche_pdata->svc_refclk_req;
>>>> +        return -ENODEV;
>>>>        }
>>>>        ret = devm_gpio_request(dev, arche_pdata->svc_refclk_req,
>>>>                    "svc-clk-req");
>>>>
