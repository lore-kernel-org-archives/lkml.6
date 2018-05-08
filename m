Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754135AbeEHF1h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 01:27:37 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.31]:32179 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752332AbeEHF1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 01:27:36 -0400
X-Authority-Reason: nr=8
Subject: Re: [PATCH v2 2/2] pinctrl: generic: improve apply_setting error
 verbosity
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <201805011855.LvT1SKBS%fengguang.wu@intel.com>
 <1525201801-25682-1-git-send-email-matheus@castello.eng.br>
 <1525201801-25682-3-git-send-email-matheus@castello.eng.br>
 <CACRpkda0cztaOQb0yfC-s96Lyw4dyADJz_qWmg8dVuK-exp6nA@mail.gmail.com>
From: Matheus Castello <matheus@castello.eng.br>
Message-ID: <938ef29c-a1e3-06e6-1c90-d2b933d2342f@castello.eng.br>
Date: Tue, 8 May 2018 01:27:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACRpkda0cztaOQb0yfC-s96Lyw4dyADJz_qWmg8dVuK-exp6nA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.189.21.134
X-Source-L: No
X-Exim-ID: 1fFv9y-002qfF-G8
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.11]) [191.189.21.134]:23999
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 2
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

thanks for the tips, I will study this to break dependency from OF.

Best Regards,
Matheus Castello

On 05/02/2018 08:51 AM, Linus Walleij wrote:
> On Tue, May 1, 2018 at 9:10 PM, Matheus Castello
> <matheus@castello.eng.br> wrote:
> 
>> For generic pinconf: print the dev_error with the pinctrl vendor
>> driver name, error code, the sub-node property name used and the
>> pin that was tried to set.
>>
>> Improves the undestading of the error if use a generic sub-node
>> property that generic-pinconf can do parse but the vendor pinctrl
>> driver does not support.
>>
>> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> 
>> +#include <linux/pinctrl/pinconf-generic.h>
>>   #include "core.h"
>>   #include "pinconf.h"
>>
>> @@ -169,9 +170,21 @@ int pinconf_apply_setting(const struct pinctrl_setting *setting)
>>                                  setting->data.configs.configs,
>>                                  setting->data.configs.num_configs);
>>                  if (ret < 0) {
>> +#ifdef CONFIG_OF
> 
> This doesn't seem right.
> 
> If this is restricted for OF only the root cause to why it is
> like that needs to be found and the code refactored to fit anyone,
> there is also ACPI support in the works I think, surely they should
> be able to get verbose messages.
> 
>>                          dev_err(pctldev->dev,
>> -                               "pin_config_set op failed for pin %d\n",
>> +                               "%s error %d setting %s for pin %d\n",
>> +                               pctldev->desc->name, ret,
>> +                               pinconf_generic_get_param_property_name(
>> +                                       pctldev, setting->data.configs.num_configs,
>> +                                       setting->data.configs.configs),
>>                                  setting->data.configs.group_or_pin);
> 
> This doesn't seem right. First argument is a %d, yet this
> is pctldev->desc->name?
> 
> Something is fishy with the argument list.
> 
> Yours,
> Linus Walleij
> 
