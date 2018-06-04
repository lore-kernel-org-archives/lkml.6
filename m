Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753399AbeFDNy0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:54:26 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46923 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753063AbeFDNyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:54:24 -0400
X-Google-Smtp-Source: ADUXVKKje2KzhWlrocfe4dZ/5uUtdJFb3aIvQ0TZpldywA/j8sHG+rg9ZaJWmmYIY7E3TKoj1P3EWw==
Subject: Re: [PATCH v2] of: platform: stop accessing invalid dev in
 of_platform_device_destroy
To: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Banajit Goswami <bgoswami@codeaurora.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Rohit Kumar <rohkumar@qti.qualcomm.com>
References: <20180602000343.20045-1-srinivas.kandagatla@linaro.org>
 <CAL_JsqJ9AMDiYCfgGgHZ=XL_1yJjTdSA4Jb_GqHAZML3jwB6+Q@mail.gmail.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <467d5a5d-bb58-299e-a1fc-06e6974b7a0f@linaro.org>
Date: Mon, 4 Jun 2018 14:54:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJ9AMDiYCfgGgHZ=XL_1yJjTdSA4Jb_GqHAZML3jwB6+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/06/18 14:44, Rob Herring wrote:
> On Fri, Jun 1, 2018 at 7:03 PM, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>> Immediately after the platform_device_unregister() the device will be cleaned up.
>> Accessing the freed pointer immediately after that will crash the system.
>>
>> Found this bug when kernel is built with CONFIG_PAGE_POISONING and testing
>> loading/unloading audio drivers in a loop on Qcom platforms.
> 
> Curious, does the unittest not catch this too?
> 
Not sure!
>>
>> Fix this by removing accessing the dev pointer.
>> Below is the carsh trace:
> 
> s/carsh/crash/
Yep.
> 
> [...]
> 
>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>> index c00d81dfac0b..84c5c899187b 100644
>> --- a/drivers/of/platform.c
>> +++ b/drivers/of/platform.c
>> @@ -529,10 +529,13 @@ arch_initcall_sync(of_platform_default_populate_init);
>>
>>   int of_platform_device_destroy(struct device *dev, void *data)
>>   {
>> +       struct device_node *np;
>> +
>>          /* Do not touch devices not populated from the device tree */
>>          if (!dev->of_node || !of_node_check_flag(dev->of_node, OF_POPULATED))
>>                  return 0;
>>
>> +       np = dev->of_node;
>>          /* Recurse for any nodes that were treated as busses */
>>          if (of_node_check_flag(dev->of_node, OF_POPULATED_BUS))
>>                  device_for_each_child(dev, NULL, of_platform_device_destroy);
>> @@ -544,8 +547,8 @@ int of_platform_device_destroy(struct device *dev, void *data)
>>                  amba_device_unregister(to_amba_device(dev));
>>   #endif
>>
>> -       of_node_clear_flag(dev->of_node, OF_POPULATED);
>> -       of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
> 
> Just move these 2 lines to before unregister calls.
Make sense.. I will do that in v3.

thanks,
srini
> 
>> +       of_node_clear_flag(np, OF_POPULATED);
>> +       of_node_clear_flag(np, OF_POPULATED_BUS);
>>          return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(of_platform_device_destroy);

>> --
>> 2.16.2
>>
