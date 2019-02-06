Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69A8C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74949217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfBFItH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 03:49:07 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:41189 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727249AbfBFItD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 03:49:03 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x168fNlG019552;
        Wed, 6 Feb 2019 09:48:49 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qfv9n8100-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 06 Feb 2019 09:48:49 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4E6C7231;
        Wed,  6 Feb 2019 08:42:50 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0E711169B;
        Wed,  6 Feb 2019 08:42:50 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.47) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 6 Feb
 2019 09:42:48 +0100
Subject: Re: [PATCH 2/4] pwm: stm32-lp: Add power management support
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <alexandre.torgue@st.com>, <mcoquelin.stm32@gmail.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <vilhelm.gray@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Tomasz Duszynski <tduszyns@gmail.com>
References: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
 <1549370429-19116-3-git-send-email-fabrice.gasnier@st.com>
 <20190205204732.zrbhgyxnvjbwfyw4@pengutronix.de>
 <20190205222522.GB1372@mithrandir>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <6584a59b-657d-adc9-fab2-eb1a9baba05d@st.com>
Date:   Wed, 6 Feb 2019 09:42:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205222522.GB1372@mithrandir>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-06_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/19 11:25 PM, Thierry Reding wrote:
> On Tue, Feb 05, 2019 at 09:47:32PM +0100, Uwe Kleine-König wrote:
>> Hello,
>>
>> On Tue, Feb 05, 2019 at 01:40:27PM +0100, Fabrice Gasnier wrote:
>>> Add suspend/resume PM sleep ops. When going to low power, disable
>>> active PWM channel. Active PWM channel is resumed, by calling
>>> pwm_apply_state(). This is inspired by Thierry's comment in [1].
>>> Don't touch inactive channels, as it may be used by other LPTimer MFD
>>> child driver.
>>> [1]https://lkml.org/lkml/2017/12/5/175
>>>
>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>> ---
>>>  drivers/pwm/pwm-stm32-lp.c | 38 ++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 38 insertions(+)
>>>
>>> diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
>>> index 0059b24c..0c40d48 100644
>>> --- a/drivers/pwm/pwm-stm32-lp.c
>>> +++ b/drivers/pwm/pwm-stm32-lp.c
>>> @@ -13,6 +13,7 @@
>>>  #include <linux/mfd/stm32-lptimer.h>
>>>  #include <linux/module.h>
>>>  #include <linux/of.h>
>>> +#include <linux/pinctrl/consumer.h>
>>>  #include <linux/platform_device.h>
>>>  #include <linux/pwm.h>
>>>  
>>> @@ -20,6 +21,8 @@ struct stm32_pwm_lp {
>>>  	struct pwm_chip chip;
>>>  	struct clk *clk;
>>>  	struct regmap *regmap;
>>> +	struct pwm_state suspend;
>>> +	bool suspended;
>>>  };
>>>  
>>>  static inline struct stm32_pwm_lp *to_stm32_pwm_lp(struct pwm_chip *chip)
>>> @@ -223,6 +226,40 @@ static int stm32_pwm_lp_remove(struct platform_device *pdev)
>>>  	return pwmchip_remove(&priv->chip);
>>>  }
>>>  
>>> +#ifdef CONFIG_PM_SLEEP
>>> +static int stm32_pwm_lp_suspend(struct device *dev)
>>> +{
>>> +	struct stm32_pwm_lp *priv = dev_get_drvdata(dev);
>>> +
>>> +	pwm_get_state(&priv->chip.pwms[0], &priv->suspend);
>>> +	priv->suspended = priv->suspend.enabled;
>>> +
>>> +	/* safe to call pwm_disable() for already disabled pwm */
>>> +	pwm_disable(&priv->chip.pwms[0]);
>>> +
>>> +	return pinctrl_pm_select_sleep_state(dev);
>>
>> IMHO a PWM should not stop if the PWM user didn't call pwm_disable() (or
>> pwm_apply_state() with .enabled = false).
>>
>> I don't understand all the PM details, but I think there is no defined
>> order in which devices are signalled to suspend. If so the PWM might be
>> stopped before its consumer. Then the PWM changes state without the
>> consumer being aware of that.
>>
>> I understand Thierry's position in the link you provided in the commit
>> log consistant with my position here.
> 
> Agreed, we should let users of the PWM take care of resuming the PWM in
> the state and at the point in time that they require so. PWM users will
> also likely do a pwm_disable() during their suspend implementation, so
> doing this again in a PWM ->suspend() is not necessary, even if perhaps
> harmless.
> 
> So this leaves only the pinctrl_pm_select_sleep_state() call. That seems
> fine, but I'm not sure that that's currently guaranteed to work. I think
> we may need to implement device link support in the PWM framework to
> guarantee the proper suspend/resume sequencing. Otherwise you may end up
> in a situation where the PWM is actually suspended before the user and
> glitch the pins before the user has a chance to disable the PWM.

Hi Uwe, Thierry,

I agree with both of you on the analysis.

> 
> I think it'd be fine to merge the driver change here first before we add
> device link support if this works for you. Just mentioning the issue
> here in case you ever run into it.

If you agree with the current approach, I can send a V2 with Tomasz's
suggestion to remove the ifdefs and use __maybe_unused instead.

Thanks for reviewing,
Best Regards,
Fabrice
> 
> Thierry
> 
