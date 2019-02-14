Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD96C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6E7222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406388AbfBNKaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:30:46 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:35645 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388383AbfBNKaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:30:46 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EAQRM3011458;
        Thu, 14 Feb 2019 11:30:29 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qmy1naajq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 14 Feb 2019 11:30:28 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 57C5434;
        Thu, 14 Feb 2019 10:30:28 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 24B514E3C;
        Thu, 14 Feb 2019 10:30:28 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.45) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 14 Feb
 2019 11:30:26 +0100
Subject: Re: [PATCH v3 3/3] pwm: core: add consumer device link
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <robh+dt@kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <tduszyns@gmail.com>, <mark.rutland@arm.com>,
        <alexandre.torgue@st.com>, <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1550055012-23348-1-git-send-email-fabrice.gasnier@st.com>
 <1550055012-23348-4-git-send-email-fabrice.gasnier@st.com>
 <20190213125353.GI647@ulmo> <dc7396d4-d458-0a19-b996-2e1fa41a2fb7@st.com>
Message-ID: <410eb559-fa7d-0eae-5666-328f09b483da@st.com>
Date:   Thu, 14 Feb 2019 11:30:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <dc7396d4-d458-0a19-b996-2e1fa41a2fb7@st.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/19 4:17 PM, Fabrice Gasnier wrote:
> On 2/13/19 1:53 PM, Thierry Reding wrote:
>> On Wed, Feb 13, 2019 at 11:50:12AM +0100, Fabrice Gasnier wrote:
>>> Add a device link between the PWM consumer and the PWM provider. This
>>> enforces the PWM user to get suspended before the PWM provider. It
>>> allows proper synchronization of suspend/resume sequences: the PWM user
>>> is responsible for properly stopping PWM, before the provider gets
>>> suspended: see [1]. Add the device link in:
>>> - of_pwm_get()
>>> - pwm_get()
>>> - devm_ variants
>>> as it requires a reference to the device for the PWM consumer.
>>>
>>> [1] https://lkml.org/lkml/2019/2/5/770
>>>
>>> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>> ---
>>> Changes in v3:
>>> - add struct device to of_get_pwm() arguments to handle device link from
>>>   there.
>>> ---
>>>  drivers/pwm/core.c  | 14 +++++++++++---
>>>  include/linux/pwm.h |  6 ++++--
>>>  2 files changed, 15 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
>>> index 1581f6a..8cb5d4bc 100644
>>> --- a/drivers/pwm/core.c
>>> +++ b/drivers/pwm/core.c
>>> @@ -638,6 +638,7 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
>>>  
>>>  /**
>>>   * of_pwm_get() - request a PWM via the PWM framework
>>> + * @dev: device for PWM consumer
>>>   * @np: device node to get the PWM from
>>>   * @con_id: consumer name
>>>   *
>>> @@ -655,7 +656,8 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
>>>   * Returns: A pointer to the requested PWM device or an ERR_PTR()-encoded
>>>   * error code on failure.
>>>   */
>>> -struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
>>> +struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
>>> +			      const char *con_id)
>>>  {
>>>  	struct pwm_device *pwm = NULL;
>>>  	struct of_phandle_args args;
>>> @@ -689,6 +691,9 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
>>>  	if (IS_ERR(pwm))
>>>  		goto put;
>>>  
>>> +	if (!device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
>>> +		pr_debug("%s(): device link not added\n", __func__);
>>
>> I think it's better to turn this into dev_dbg(dev, ...) and maybe
>> mention which supplier it failed to link to, something like:
>>
>> 	if (!device_link_add(...))
>> 		dev_dbg(dev, "failed to create device link to %s\n",
>> 			pwm->chip->dev);
> 
> Hi Thierry,
> 
> Thanks for reviewing.
> 
> I can update this: I used pr_debug() as there are pr_err() calls
> elsewhere in this routine.
> BTW, do you wish an additional patch to turn pr_err() into dev_err() in
> of_pwm_get()?
> 
>>
>> Also, I wonder if this should perhaps be dev_err(). Under what
>> circumstances does this fail?
> 
> Well, here is a comment from "device_link_add()" routine:
> "
> /*
>  * If the supplier has not been fully registered yet or there is a
>  * reverse dependency between the consumer and the supplier already in
>  * the graph, return NULL.
>  */
> "
> 
> => Here the PWM supplier is already registered. (It seems a probe defer
> can be returned few lines above otherwise.)
> 
> Other possibilities: kzalloc() failed, no consumer or supplier has been
> provided (or invalid flags, but this is hardcoded here.).
> 
> So, I see two case here:
> 1 - The caller provided a 'dev' for PWM consumer... So, NULL link is an
> error when consumer & supplier has been passed correctly.
> => I can add a check on 'dev' for PWM consumer and report an error here:
>    return -EINVAL
> 
> 2 - The caller can't provide a 'dev' for PWM consumer as you mention
> bellow: "to allow code to get at the PWM if they didn't have..."
> => We should probably add a dev_warn() here, with no error ?
> Please see here after.
> 
>>
>>> +
>>>  	/*
>>>  	 * If a consumer name was not given, try to look it up from the
>>>  	 * "pwm-names" property if it exists. Otherwise use the name of
>>> @@ -771,7 +776,7 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
>>>  
>>>  	/* look up via DT first */
>>>  	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
>>> -		return of_pwm_get(dev->of_node, con_id);
>>> +		return of_pwm_get(dev, dev->of_node, con_id);
>>>  
>>>  	/*
>>>  	 * We look up the provider in the static table typically provided by
>>> @@ -851,6 +856,9 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
>>>  	pwm->args.period = chosen->period;
>>>  	pwm->args.polarity = chosen->polarity;
>>>  
>>> +	if (!device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
>>> +		pr_debug("%s(): device link not added\n", __func__);
>>
>> Same here. Also: not sure if we really need to include __func__ in the
>> message.
>>
>>> +
>>>  	return pwm;
>>>  }
>>>  EXPORT_SYMBOL_GPL(pwm_get);
>>> @@ -939,7 +947,7 @@ struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
>>>  	if (!ptr)
>>>  		return ERR_PTR(-ENOMEM);
>>>  
>>> -	pwm = of_pwm_get(np, con_id);
>>> +	pwm = of_pwm_get(dev, np, con_id);
>>>  	if (!IS_ERR(pwm)) {
>>>  		*ptr = pwm;
>>>  		devres_add(dev, ptr);
>>> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
>>> index d5199b5..895e074 100644
>>> --- a/include/linux/pwm.h
>>> +++ b/include/linux/pwm.h
>>> @@ -406,7 +406,8 @@ struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *pc,
>>>  		const struct of_phandle_args *args);
>>>  
>>>  struct pwm_device *pwm_get(struct device *dev, const char *con_id);
>>> -struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id);
>>> +struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
>>> +			      const char *con_id);
>>
>> I'm slightly concerned about this. I think one of the reasons why this
>> was introduced was to allow code to get at the PWM if they didn't have
>> a struct device * available. However, it doesn't seem like there are any
>> users of that function, so this seems fine.
> 
> The git blame pointed out commit 8eb961279960:
> "
> pwm: core: Rename of_pwm_request() to of_pwm_get() and export it
> 
> Allow client driver to use of_pwm_get() to get the PWM they need. This
> is needed for drivers which handle more than one PWM separately, like
> leds-pwm driver, which have:
> "
> ...
> 
> For instance, I tested the leds-pwm driver. It uses the devm_* variant
> now (as others), there is a struct device * available. So yes, it seems
> fine.
> 
> The only thing maybe out of tree code? This is where I have a doubt on
> having a mandatory struct device * to enforce consumer link creation...
> or make it optional (e.g. behave as a 'legacy' API) and warn the caller.
> 
> Please let me know your feeling.

Hi Thierry,

I just sent a v4 to update the error handling following the cases
described above.

BR,
Fabrice
> Best regards,
> Fabrice
> 
>>
>> Thierry
>>
>>>  void pwm_put(struct pwm_device *pwm);
>>>  
>>>  struct pwm_device *devm_pwm_get(struct device *dev, const char *con_id);
>>> @@ -494,7 +495,8 @@ static inline struct pwm_device *pwm_get(struct device *dev,
>>>  	return ERR_PTR(-ENODEV);
>>>  }
>>>  
>>> -static inline struct pwm_device *of_pwm_get(struct device_node *np,
>>> +static inline struct pwm_device *of_pwm_get(struct device *dev,
>>> +					    struct device_node *np,
>>>  					    const char *con_id)
>>>  {
>>>  	return ERR_PTR(-ENODEV);
>>> -- 
>>> 1.9.1
>>>
