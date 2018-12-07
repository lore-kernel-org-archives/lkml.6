Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3862C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B182081C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SouL7Pdi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ht7HtNAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B182081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbeLGU3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:29:21 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58030 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLGU3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:29:20 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4E2AB607DC; Fri,  7 Dec 2018 20:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544214559;
        bh=hVs5z3wj+3mwMQk1pou56hc8FiVASkVmV72k1OdjMLA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SouL7PdiVKVLEEAdcvFriVVTL97BG7BFDqWCEFrYwHsNVbNenfXLUUpgMExaZjxym
         1akXHQiMqRYZzD4zi/d7undOA2ZKg0rv/okk4nidVWd9HVdifeASPeck4aDpIsV1GH
         6/w7wG3E5RHiUoS7OVxpfONReWJMCN0L2WDfDVC8=
Received: from [10.134.64.210] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: skannan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F056760241;
        Fri,  7 Dec 2018 20:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544214558;
        bh=hVs5z3wj+3mwMQk1pou56hc8FiVASkVmV72k1OdjMLA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ht7HtNArvWIlF6awEV4XIYq0UJuRpL1D79epMhhHn8x4dS3caH5G/XboPK9D0jSep
         EBVw/VoXUg/0aN3R+9QXYVz2Eyqq6iSHGtWFgG93wt1KVXyWZFCc6PsRL47InL8e34
         8EMqvzbK0d3dXVkmo1JH+Y7q9G5j0HuT1v1swsnI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F056760241
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skannan@codeaurora.org
Subject: Re: [PATCH v3] PM / devfreq: Restart previous governor if new
 governor fails to start
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20161026191715epcas1p311c2c626563a736e14c83fb0504c099e@epcas1p3.samsung.com>
 <1477509425-16936-1-git-send-email-skannan@codeaurora.org>
 <de0f8010-31b2-8cec-f793-393c2199f44d@samsung.com>
 <5820CE7E.40802@codeaurora.org> <5821948B.2010907@samsung.com>
 <58223AF1.2030605@codeaurora.org> <58227CDB.6050907@samsung.com>
 <58228B9E.2090108@samsung.com> <58228C10.3070502@samsung.com>
 <58238840.90802@codeaurora.org> <5823BB01.3090502@samsung.com>
From:   Saravana Kannan <skannan@codeaurora.org>
Message-ID: <5164dea6-ad0c-d817-eb0d-36d9f4a718d4@codeaurora.org>
Date:   Fri, 7 Dec 2018 12:29:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5823BB01.3090502@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/9/16 4:10 PM, Chanwoo Choi wrote:
> Hi,
>
> On 2016년 11월 10일 05:34, Saravana Kannan wrote:
>> On 11/08/2016 06:38 PM, Chanwoo Choi wrote:
>>> On 2016년 11월 09일 11:36, Chanwoo Choi wrote:
>>>> Hi,
>>>>
>>>> On 2016년 11월 09일 10:33, Chanwoo Choi wrote:
>>>>> On 2016년 11월 09일 05:52, Saravana Kannan wrote:
>>>>>> On 11/08/2016 01:02 AM, Chanwoo Choi wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 2016년 11월 08일 03:57, Saravana Kannan wrote:
>>>>>>>> On 10/26/2016 05:06 PM, Chanwoo Choi wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> On 2016년 10월 27일 04:17, Saravana Kannan wrote:
>>>>>>>>>> If the new governor fails to start, switch back to old governor so that the
>>>>>>>>>> devfreq state is not left in some weird limbo.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>>>>>>>>>> ---
>>>>>>>>>> * Fix NULL deref for real this time.
>>>>>>>>>> * Addressed some style preferences.
>>>>>>>>>>
>>>>>>>>>>      drivers/devfreq/devfreq.c | 13 +++++++++++--
>>>>>>>>>>      1 file changed, 11 insertions(+), 2 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>>>>>>> index bf3ea76..77c41a5 100644
>>>>>>>>>> --- a/drivers/devfreq/devfreq.c
>>>>>>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>>>>>>> @@ -919,7 +919,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>>>>>>>>>>          struct devfreq *df = to_devfreq(dev);
>>>>>>>>>>          int ret;
>>>>>>>>>>          char str_governor[DEVFREQ_NAME_LEN + 1];
>>>>>>>>>> -    struct devfreq_governor *governor;
>>>>>>>>>> +    const struct devfreq_governor *governor, *prev_governor;
>>>>>>>>>>
>>>>>>>>>>          ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
>>>>>>>>>>          if (ret != 1)
>>>>>>>>>> @@ -944,12 +944,21 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>>>>>>>>>>                  goto out;
>>>>>>>>>>              }
>>>>>>>>>>          }
>>>>>>>>>> +    prev_governor = df->governor;
>>>>>>>>>>          df->governor = governor;
>>>>>>>>>>          strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
>>>>>>>>>>          ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
>>>>>>>>>> -    if (ret)
>>>>>>>>>> +    if (ret) {
>>>>>>>>>>              dev_warn(dev, "%s: Governor %s not started(%d)\n",
>>>>>>>>>>                   __func__, df->governor->name, ret);
>>>>>>>>>> +        if (prev_governor) {
>>>>>>>>> I think that prev_governor is always set. You don't need to check it.
>>>>>>>>> Why do check it?
>>>>>>>> Not true. Even higher up in this function, we check if df->governor != NULL. Simple example would be that the default governor passed in while adding the device isn't compiled in.
>>>>>>> I don't understand. If device is not registered by devfreq_add_device(),
>>>>>>> you don't change the governor by using governor_store().
>>>>>>>
>>>>>>> If you can change the governor through governor_store(),
>>>>>>> it means that the devfreq instance was added without any problem.
>>>>>>> The added devfreq instance must have the sepecific governor
>>>>>>> on df->governor variable.
>>>>>>>
>>>>>>> So, I think that df->governor is always set and then prev_governor is always set.
>>>>>> Read the code more closely. add_device doesn't (and shouldn't) fail if the governor isn't present. After that, the governor could be changed from user space.
>>>>> If governor is not present during devfreq_add_device(),
>>>>> the devfreq instance is not able to register the devfreq framework.
>>>>> So, the user never touch the sysfs[1] to change the governor
>>>>> because the sysfs[1] is not created by devfreq framework.
>>>>> [1] /sys/class/devfreq/[device name]/governor
>>>>>
>>>>> In summary, if governor is not present during devfreq_add_device(),
>>>>> the devfreq framework doesn't create tye sysfs[1] for governor.
>>>>>
>>>>> The user-space never change the governor through sysfs[1]
>>>>> because there is no any sysfs entry[1].
>>>> I checked the code of devfreq_add_device().
>>>> As you mentioned, if there is no governor,
>>>> devfreq_add_device() don't pass wihtout calling the devfreq->governor->even_handler().
>>> Wrong expression / don't pass -> pass
>>>
>> I think it's correct as is. Just because the governor isn't there (or hasn't registered yet) doesn't mean the device add should fail.
>>
>> That aside, do you care to ack this patch for the way the code is currently?
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>
> After fixing the bug of devfreq_add_device(),
> I'll remove the unneeded 'if statement' of prev_governor in governor_store.

It's been 2 years and this patch still hasn't been picked up. Can we 
please pick this up and get this into the next kernel release?

Thanks,

Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

