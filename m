Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D699FC282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF3D2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbfBLIb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:31:57 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52277 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728209AbfBLIb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:31:57 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1C8VOwd016393;
        Tue, 12 Feb 2019 09:31:40 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qjfy63dwg-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 12 Feb 2019 09:31:40 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CAFFE38;
        Tue, 12 Feb 2019 08:31:38 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8468A2449;
        Tue, 12 Feb 2019 08:31:38 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.47) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 12 Feb
 2019 09:31:37 +0100
Subject: Re: [PATCH v2 3/3] pwm: core: add consumer device link
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
CC:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <tduszyns@gmail.com>, <mark.rutland@arm.com>,
        <alexandre.torgue@st.com>, <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1549901522-15071-1-git-send-email-fabrice.gasnier@st.com>
 <1549901522-15071-4-git-send-email-fabrice.gasnier@st.com>
 <20190211190628.eisyi6wjus4ltrrn@pengutronix.de>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <b9f1bb5c-36cd-f6e6-e6c6-a0257cf38b7e@st.com>
Date:   Tue, 12 Feb 2019 09:31:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190211190628.eisyi6wjus4ltrrn@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-12_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 8:06 PM, Uwe Kleine-König wrote:
> Hello Fabrice,
> 
> On Mon, Feb 11, 2019 at 05:12:02PM +0100, Fabrice Gasnier wrote:
>> Add a device link between the PWM consumer and the PWM provider. This
>> enforces the PWM user to get suspended before the PWM provider. It
>> allows proper synchronization of suspend/resume sequences: the PWM user
>> is responsible for properly stopping PWM, before the provider gets
>> suspended: see [1]. Add the device link in:
>> - pwm_get()
>> - devm_pwm_get()
>> - devm_of_pwm_get()
>> as it requires a reference to the device for the PWM consumer.
>>
>> [1] https://lkml.org/lkml/2019/2/5/770
>>
>> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>>  drivers/pwm/core.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
>> index 1581f6a..2835e27 100644
>> --- a/drivers/pwm/core.c
>> +++ b/drivers/pwm/core.c
>> @@ -770,8 +770,13 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
>>  	int err;
>>  
>>  	/* look up via DT first */
>> -	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
>> -		return of_pwm_get(dev->of_node, con_id);
>> +	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node) {
>> +		pwm = of_pwm_get(dev->of_node, con_id);
>> +		if (!IS_ERR(pwm))
>> +			device_link_add(dev, pwm->chip->dev,
>> +					DL_FLAG_AUTOREMOVE_CONSUMER);
>> +		return pwm;
>> +	}
>>  
>>  	/*
>>  	 * We look up the provider in the static table typically provided by
>> @@ -851,6 +856,8 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
>>  	pwm->args.period = chosen->period;
>>  	pwm->args.polarity = chosen->polarity;
>>  
>> +	device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
>> +
>>  	return pwm;
>>  }
>>  EXPORT_SYMBOL_GPL(pwm_get);
>> @@ -943,6 +950,8 @@ struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
>>  	if (!IS_ERR(pwm)) {
>>  		*ptr = pwm;
>>  		devres_add(dev, ptr);
>> +		device_link_add(dev, pwm->chip->dev,
>> +				DL_FLAG_AUTOREMOVE_CONSUMER);
> 
> IMHO it's surprising that devm_of_pwm_get() does more than of_pwm_get()
> + devres stuff. I'd put device_link_add() into of_pwm_get().

Hi Uwe,

I also agree with this. But I think this implies modifying the API for
of_pwm_get():
 /**
  * of_pwm_get() - request a PWM via the PWM framework
+ * @dev: device for PWM consumer
  * @np: device node to get the PWM from
  * @con_id: consumer name

It seems there aren't much of_pwm_get() users currently.
Does this look sensible ?

Best regards,
Fabrice

> 
> Best regards
> Uwe
> 
