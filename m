Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACE4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264FB2146F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfBSJyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:54:39 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:17718 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725763AbfBSJyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:54:39 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1J9pPpe027674;
        Tue, 19 Feb 2019 10:54:22 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qr6x5jjsk-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 19 Feb 2019 10:54:22 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B2EAA34;
        Tue, 19 Feb 2019 09:54:21 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6AF822750;
        Tue, 19 Feb 2019 09:54:21 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.51) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 19 Feb
 2019 10:54:20 +0100
Subject: Re: [PATCH v4 3/3] pwm: core: add consumer device link
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
CC:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <tduszyns@gmail.com>, <mark.rutland@arm.com>,
        <alexandre.torgue@st.com>, <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1550139951-25788-1-git-send-email-fabrice.gasnier@st.com>
 <1550139951-25788-4-git-send-email-fabrice.gasnier@st.com>
 <20190218172223.lw3e5tn5hzsow6tg@pengutronix.de>
 <53bc3d80-8732-46be-caef-015998c9ad0e@st.com>
 <20190219085516.dz5ux37kdszqkisy@pengutronix.de>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <b4f42c35-df0e-8b61-6132-39a453a3b11c@st.com>
Date:   Tue, 19 Feb 2019 10:54:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190219085516.dz5ux37kdszqkisy@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-19_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/19 9:55 AM, Uwe Kleine-König wrote:
> On Tue, Feb 19, 2019 at 09:46:32AM +0100, Fabrice Gasnier wrote:
>> On 2/18/19 6:22 PM, Uwe Kleine-König wrote:
>>> Hello,
>>>
>>> On Thu, Feb 14, 2019 at 11:25:51AM +0100, Fabrice Gasnier wrote:
>>>> Add a device link between the PWM consumer and the PWM provider. This
>>>> enforces the PWM user to get suspended before the PWM provider. It
>>>> allows proper synchronization of suspend/resume sequences: the PWM user
>>>> is responsible for properly stopping PWM, before the provider gets
>>>> suspended: see [1]. Add the device link in:
>>>> - of_pwm_get()
>>>> - pwm_get()
>>>> - devm_*pwm_get() variants
>>>> as it requires a reference to the device for the PWM consumer.
>>>>
>>>> [1] https://lkml.org/lkml/2019/2/5/770
>>>>
>>>> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
>>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>>> ---
>>>> Changes in v4:
>>>> - rework error handling following Thierry's comments
>>>> - turn/split pr_debug() into dev_err()/pr_warn().
>>>>
>>>> Changes in v3:
>>>> - add struct device to of_get_pwm() arguments to handle device link from
>>>>   there as discussed with Uwe.
>>>> ---
>>>>  drivers/pwm/core.c  | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
>>>>  include/linux/pwm.h |  6 ++++--
>>>>  2 files changed, 51 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
>>>> index 1581f6a..64e10a6 100644
>>>> --- a/drivers/pwm/core.c
>>>> +++ b/drivers/pwm/core.c
>>>> @@ -636,8 +636,35 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
>>>>  	return ERR_PTR(-EPROBE_DEFER);
>>>>  }
>>>>  
>>>> +static struct device_link *pwm_device_link_add(struct device *dev,
>>>> +					       struct pwm_device *pwm)
>>>> +{
>>>> +	struct device_link *dl;
>>>> +
>>>> +	if (!dev) {
>>>> +		/*
>>>> +		 * No device for the PWM consumer has been provided. It may
>>>> +		 * impact the PM sequence ordering: the PWM supplier may get
>>>> +		 * suspended before the consumer.
>>>> +		 */
>>>> +		pr_warn("no consumer dev, can't create device link to %s\n",
>>>> +			dev_name(pwm->chip->dev));
>>>
>>> Maybe use dev_warn(pwm->chip->dev, ...) ?
>>
>> Hi Uwe,
>>
>> I'm wondering a bit about this: In this case, the caller that doesn't
>> provide a struct device *, PWM provider isn't responsible for that. So I
>> just hope this wouldn't be miss-leading ?
> 
> IMHO it's more the wording that might make the message misleading. If
> you use
> 
> 	dev_warn(pwm->chip->dev, "No consumer device specified to create a device link to\n");
> 
> that's completely fine in my eyes.

Thanks for the suggestion, I'll update this as well in v5.

Best regards,
Fabrice
>  
> Best regards
> Uwe
> 
