Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B55C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B48121872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbfAXRd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:33:57 -0500
Received: from gateway30.websitewelcome.com ([192.185.145.3]:44319 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727573AbfAXRd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:33:56 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 4544C46784
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 11:33:53 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id miszg14bx2PzOmiszgbH2j; Thu, 24 Jan 2019 11:33:53 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=42518 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gmisy-0004nO-V3; Thu, 24 Jan 2019 11:33:53 -0600
Subject: Re: [PATCH] cpufreq: e_powersaver: Use struct_size() in kzalloc()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190107173343.GA4258@embeddedor>
 <20190108050056.quckhd2d5ah4ywax@vireshk-i7>
 <1645829.9I2fkU6ktd@aspire.rjw.lan>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Message-ID: <cc4d5cb2-8e37-2b97-240b-96d712373ed2@embeddedor.com>
Date:   Thu, 24 Jan 2019 11:33:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1645829.9I2fkU6ktd@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gmisy-0004nO-V3
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.130.205]:42518
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/19 4:34 AM, Rafael J. Wysocki wrote:
> On Tuesday, January 8, 2019 6:00:56 AM CET Viresh Kumar wrote:
>> On 07-01-19, 11:33, Gustavo A. R. Silva wrote:
>>> One of the more common cases of allocation size calculations is finding the
>>> size of a structure that has a zero-sized array at the end, along with memory
>>> for some number of elements for that array. For example:
>>>
>>> struct foo {
>>>     int stuff;
>>>     void *entry[];
>>> };
>>>
>>> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
>>>
>>> Instead of leaving these open-coded and prone to type mistakes, we can now
>>> use the new struct_size() helper:
>>>
>>> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
>>>
>>> This code was detected with the help of Coccinelle.
>>>
>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>> ---
>>>  drivers/cpufreq/e_powersaver.c | 5 ++---
>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
>>> index 60bea302abbe..2d3ef208dd70 100644
>>> --- a/drivers/cpufreq/e_powersaver.c
>>> +++ b/drivers/cpufreq/e_powersaver.c
>>> @@ -323,9 +323,8 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
>>>  		states = 2;
>>>  
>>>  	/* Allocate private data and frequency table for current cpu */
>>> -	centaur = kzalloc(sizeof(*centaur)
>>> -		    + (states + 1) * sizeof(struct cpufreq_frequency_table),
>>> -		    GFP_KERNEL);
>>> +	centaur = kzalloc(struct_size(centaur, freq_table, states + 1),
>>> +			  GFP_KERNEL);
>>>  	if (!centaur)
>>>  		return -ENOMEM;
>>>  	eps_cpu[0] = centaur;
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Patch applied, thanks!
> 

Thank you both, Viresh and Rafael.

--
Gustavo

