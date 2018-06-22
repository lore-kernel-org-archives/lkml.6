Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C508C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE42523F62
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lM2B5d7P";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dXy5qXkr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE42523F62
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932170AbeFVJGk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:06:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34690 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeFVJGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:06:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4192D60AD8; Fri, 22 Jun 2018 09:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529658397;
        bh=YE4rhUQ3uJ70LBOJmOnGF5gqr7snGsyR59OJogHTdz4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lM2B5d7PZmOjPKND2sKXGx1Ds0xpxgMv3tecIRRI3LylBPKLNqrgZ4m28ejHZSSv9
         dC5NxWI2BS5XnBc/j8673kgqMW7vKpBjl+u4zRdJ+CIe+geEkBoC5caKajT6jFZsCi
         4RLTji1thIX0Hjlu34myLN+Y89EkzsG0X/QCDAMc=
Received: from [10.204.66.249] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akhilpo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4322560274;
        Fri, 22 Jun 2018 09:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529658396;
        bh=YE4rhUQ3uJ70LBOJmOnGF5gqr7snGsyR59OJogHTdz4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dXy5qXkr2xP6MdTk6I4Pg3ciZw8FwH/Zxbc7tpL3lUQRMiYEsSfp5pjl9yMZ9PWB1
         ZiEapnSlwnvfsM6PatbCL8guqsADlkRSJTexTyt5maD+n/B7eQ3rYX32oJzmRduS8I
         pr1xXsWqGU2H8SxmCLQDD1WRj/DAWedzG8k2VKbU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4322560274
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=akhilpo@codeaurora.org
Subject: Re: [PATCH v3] PM / devfreq: Fix devfreq_add_device() when drivers
 are built as modules.
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-pm@vger.kernel.org
References: <20180621220430.25644-1-enric.balletbo@collabora.com>
 <0383b4a703a0b619023c0654a4a7637419c72ebd.camel@collabora.com>
 <addc4280-729f-85d7-a314-35afbb7c8bb1@codeaurora.org>
 <36c9720c-7428-0a17-5252-7afbd80bce6b@collabora.com>
From:   Akhil P Oommen <akhilpo@codeaurora.org>
Message-ID: <9ecb2d61-5713-c0dc-9d35-2c926372fd03@codeaurora.org>
Date:   Fri, 22 Jun 2018 14:36:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <36c9720c-7428-0a17-5252-7afbd80bce6b@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/22/2018 1:52 PM, Enric Balletbo i Serra wrote:
> Hi Ezequiel and Akhil,
>
> On 22/06/18 09:03, Akhil P Oommen wrote:
>> On 6/22/2018 6:41 AM, Ezequiel Garcia wrote:
>>> Hey Enric,
>>>
>>> On Fri, 2018-06-22 at 00:04 +0200, Enric Balletbo i Serra wrote:
>>>> When the devfreq driver and the governor driver are built as modules,
>>>> the call to devfreq_add_device() or governor_store() fails because
>>>> the
>>>> governor driver is not loaded at the time the devfreq driver loads.
>>>> The
>>>> devfreq driver has a build dependency on the governor but also should
>>>> have a runtime dependency. We need to make sure that the governor
>>>> driver
>>>> is loaded before the devfreq driver.
>>>>
>>>> This patch fixes this bug by adding a try_then_request_governor()
>>>> function. First tries to find the governor, and then, if it is not
>>>> found,
>>>> it requests the module and tries again.
>>>>
>>>> Fixes: 1b5c1be2c88e (PM / devfreq: map devfreq drivers to governor
>>>> using name)
>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>> ---
>>>>
>>>> Changes in v3:
>>>> - Remove unneded change in dev_err message.
>>>> - Fix err returned value in case to not find the governor.
>>>>
>>>> Changes in v2:
>>>> - Add a new function to request the module and call that function
>>>> from
>>>>     devfreq_add_device and governor_store.
>>>>
>>>>    drivers/devfreq/devfreq.c | 65 ++++++++++++++++++++++++++++++++-----
>>>> -- 
>>> [snip snip]
>>>> -    governor = find_devfreq_governor(devfreq->governor_name);
>>>> +    governor = try_then_request_governor(devfreq-
>>>>> governor_name);
>>>>        if (IS_ERR(governor)) {
>>>>            dev_err(dev, "%s: Unable to find governor for the
>>>> device\n",
>>>>                __func__);
>>>>            err = PTR_ERR(governor);
>>>> -        goto err_init;
>>>> +        goto err_unregister;
>>>>        }
>>>>    +    mutex_lock(&devfreq_list_lock);
>>>> +
>>> I know it's not something we are introducing in this patch,
>>> but still... calling a hook with a mutex held looks
>>> fishy to me.
>>>
>>> This lock should only protect the list, unless I am missing
>>> something.
>>>
> I think so too.
>
>>>>        devfreq->governor = governor;
>>>>        err = devfreq->governor->event_handler(devfreq,
>>>> DEVFREQ_GOV_START,
>>>>                            NULL);
>>>> @@ -663,14 +703,16 @@ struct devfreq *devfreq_add_device(struct
>>>> device *dev,
>>>>                __func__);
>>>>            goto err_init;
>>>>        }
>>>> +
>>>> +    list_add(&devfreq->node, &devfreq_list);
>>>> +
>>>>        mutex_unlock(&devfreq_list_lock);
>>>>          return devfreq;
>>>>      err_init:
>>>> -    list_del(&devfreq->node);
>>>>        mutex_unlock(&devfreq_list_lock);
>>>> -
>>>> +err_unregister:
>>>>        device_unregister(&devfreq->dev);
>>>>    err_dev:
>>>>        if (devfreq)
>>>> @@ -988,12 +1030,13 @@ static ssize_t governor_store(struct device
>>>> *dev, struct device_attribute *attr,
>>>>        if (ret != 1)
>>>>            return -EINVAL;
>>>>    -    mutex_lock(&devfreq_list_lock);
>>>> -    governor = find_devfreq_governor(str_governor);
>>>> +    governor = try_then_request_governor(str_governor);
>>>>        if (IS_ERR(governor)) {
>>>> -        ret = PTR_ERR(governor);
>>>> -        goto out;
>>>> +        return PTR_ERR(governor);
>>>>        }
>>>> +
>>>> +    mutex_lock(&devfreq_list_lock);
>>>> +
>>>>        if (df->governor == governor) {
>>>>            ret = 0;
>>>>            goto out;
>>>> -- 
>>>> 2.17.1
>>>>
>>>>
>>> Regards,
>>> Eze
>> Adding to Ezequiel's point, shouldn't we take more granular lock (devfreq->lock)
>> first and then call devfreq_list_lock at the time of adding to the list?
>>
> Yes, I think so. I think, though, that this should be a separate patch, not sure
> if a pre or post patch to this one, but for sure it's another topic. Current
> patch tries to solve different problem an only tries to follow the current
> locking/unlocking. Anyway this is a maintainer decision I guess.
>
> Thanks,
>   Enric
>
>> -Akhil.
>>
I agree.
-Akhil.
