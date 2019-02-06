Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1B7C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DD62073F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbfBFOzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:55:15 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:46938 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726767AbfBFOzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:55:15 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x16EpNMb001272;
        Wed, 6 Feb 2019 15:54:53 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qfv9j9k5a-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 06 Feb 2019 15:54:53 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 786D034;
        Wed,  6 Feb 2019 14:54:52 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 488F52C3C;
        Wed,  6 Feb 2019 14:54:52 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.45) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 6 Feb
 2019 15:54:51 +0100
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
 <6584a59b-657d-adc9-fab2-eb1a9baba05d@st.com>
 <20190206085405.pdiwd3c6wjog5hl7@pengutronix.de>
 <20190206125545.GI21676@ulmo>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <ddb93754-2734-e4c2-a209-517984c6d814@st.com>
Date:   Wed, 6 Feb 2019 15:54:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206125545.GI21676@ulmo>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-06_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/19 1:55 PM, Thierry Reding wrote:
> On Wed, Feb 06, 2019 at 09:54:05AM +0100, Uwe Kleine-König wrote:
>> On Wed, Feb 06, 2019 at 09:42:48AM +0100, Fabrice Gasnier wrote:
>>> If you agree with the current approach, I can send a V2 with Tomasz's
>>> suggestion to remove the ifdefs and use __maybe_unused instead.
>>
>> I think the suspend callback should have something like:
>>
>> 	if (is_still_enabled) {
>> 		/*
>> 		 * The consumer didn't stop us, so refuse to suspend.
>> 		 */
>> 		dev_err(dev, "The consumer didn't stop us, so refuse to suspend.\n");
>> 		return -EBUSY;
>> 	}
>>
>> This way there are no bad surprises if the pwm is suspended before its
>> consumer and it's obvious what is missing.

Thierry, Uwe,

When the pwm is suspended before its consumer, the bad surprise is the
suspend request will fail... I'm not sure a new attempt may be better.
So, it looks like the only way to have this clean is by implementing the
device link e.g. via pwm_get() ?

> 
> Something that just occurred to me: perhaps as part of pwm_get() we
> should track where we were being requested from so that we could give
> hints in situations like this as to where the consumer is that forgot
> to suspend the PWM.

The current approach handles the situation where the consumer forgot to
suspend the PWM... I can add some warning about that in the suspend
routine, incl the label.

What do you think? What's the best approach ?

Please advise,
BR,
Fabrice
> 
> I suppose we already have pwm_device.label to help with this, but
> perhaps we could improve things if we stored __builtin_return_address
> during pwm_get() to help users pinpoint where they need to look.
> 
> Thierry
> 
