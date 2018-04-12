Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbeDLUK4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 16:10:56 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:43977 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbeDLUKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 16:10:55 -0400
Subject: Re: [PATCH 10/14] gpio: omap: Drop the concept of gpio banks not
 being able to lose context.
To: Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>
CC: <linus.walleij@linaro.org>, <t-kristo@ti.com>, <Russ.Dill@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ssantosh@kernel.org>, <haojian.zhuang@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <d-gerlach@ti.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
 <1523505239-16229-11-git-send-email-j-keerthy@ti.com>
 <20180412142257.GW5700@atomide.com>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <3b01e345-6939-f28c-c648-7316d0a410c4@ti.com>
Date: Thu, 12 Apr 2018 15:10:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180412142257.GW5700@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/12/2018 09:22 AM, Tony Lindgren wrote:
> * Keerthy <j-keerthy@ti.com> [180412 03:56]:
>> From: Russ Dill <Russ.Dill@ti.com>
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -68,7 +68,7 @@ struct gpio_bank {
>>   	bool dbck_enabled;
>>   	bool is_mpuio;
>>   	bool dbck_flag;
>> -	bool loses_context;
>> +
>>   	bool context_valid;
>>   	int stride;
>>   	u32 width;
> 
> For some SoCs GPIO bank1 won't lose the context ever. So I'd like to
> keep loses_context flag around to avoid pointless save and restore.
> But maybe this still happens with get_context_loss_count and I'm
> misreading this patch?
> 

Agree with Tony here. More over, even if platform supports RTC suspend
(gpio1 context loss) it might support suspend to RAM - gpio1 will not lose context.

Not sure how to handle this correctly now - always-on gpio bank should not be touched 
by omap device framework during suspend otherwise it may hit "in transition" state forever.
>From another side it must be handled the same way as other gpio banks in case of RTC suspend.
Q: How to know if current suspend is RTC suspend and not regular suspend to mem?

> However..
> 
>> @@ -1198,15 +1198,9 @@ static int omap_gpio_probe(struct platform_device *pdev)
>>   #ifdef CONFIG_OF_GPIO
>>   	bank->chip.of_node = of_node_get(node);
>>   #endif
>> -	if (node) {
>> -		if (!of_property_read_bool(node, "ti,gpio-always-on"))
>> -			bank->loses_context = true;
>> -	} else {
>> -		bank->loses_context = pdata->loses_context;
>> -
>> -		if (bank->loses_context)
>> -			bank->get_context_loss_count =
>> -				pdata->get_context_loss_count;
>> +	if (!node) {
>> +		bank->get_context_loss_count =
>> +			pdata->get_context_loss_count;
>>   	}
>>   
>>   	if (bank->regs->set_dataout && bank->regs->clr_dataout)
> 
> .. I do have a patch ready here that I'll post after -rc1 to remove
> CONFIG_OMAP_PM_NOOP related stuff, turns out that's noop anyways :)
> 
> So yeah the pdata->get_context_loss_count parts are noop and can
> be just removed.
> 

-- 
regards,
-grygorii
