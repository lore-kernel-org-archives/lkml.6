Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C88ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2258F2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2258F2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbeGRJlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 05:41:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59072 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeGRJlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 05:41:35 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id F2177279648
Subject: Re: [PATCH v5] PM / devfreq: Fix devfreq_add_device() when drivers
 are built as modules.
To:     cwchoi00@gmail.com
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, kernel@collabora.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>
References: <20180704084550.7565-1-enric.balletbo@collabora.com>
 <CAGTfZH315DM0r4qxZ28rW=0SpWOJHjFoBij0=c8-OTG5BxeLAQ@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <91722bc1-6174-4a79-4bf6-4f2e91240676@collabora.com>
Date:   Wed, 18 Jul 2018 11:04:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAGTfZH315DM0r4qxZ28rW=0SpWOJHjFoBij0=c8-OTG5BxeLAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi MyungJoo,

On 05/07/18 02:13, Chanwoo Choi wrote:
> Hi Enric,
> 
> 2018-07-04 17:45 GMT+09:00 Enric Balletbo i Serra
> <enric.balletbo@collabora.com>:
>> When the devfreq driver and the governor driver are built as modules,
>> the call to devfreq_add_device() or governor_store() fails because the
>> governor driver is not loaded at the time the devfreq driver loads. The
>> devfreq driver has a build dependency on the governor but also should
>> have a runtime dependency. We need to make sure that the governor driver
>> is loaded before the devfreq driver.
>>
>> This patch fixes this bug by adding a try_then_request_governor()
>> function. First tries to find the governor, and then, if it is not found,
>> it requests the module and tries again.
>>
>> Fixes: 1b5c1be2c88e (PM / devfreq: map devfreq drivers to governor using name)
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> Changes in v5:
>> - Requested by MyungJoo and Chanwoo.
>>   - Fix returning without the lock acquired after request_module.
>> - Requested by Chanwoo.
>>   - In request governor function check if governor name is NULL or not.
>>   - Remove some unrelated changes (added/removed some blank lines).
>>
>> Changes in v4:
>> - Kept "locked" devfreq_list from the return of find_devfreq_governor() to
>>   the unlock of governor_store(). Requested by MyungJoo Ham.
>>
>> Changes in v3:
>> - Remove unneded change in dev_err message.
>> - Fix err returned value in case to not find the governor.
>>
>> Changes in v2:
>> - Add a new function to request the module and call that function from
>>   devfreq_add_device and governor_store.
>>
>>  drivers/devfreq/devfreq.c | 53 ++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 49 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 0b5b3abe054e..aa92fbf9f0dd 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
> 
> (snip)
> 
> Looks good to me.
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> 

I was expecting see also this patch in the pull request you did but I didn't
see. Is because of will be merged as a fix in current cycle? or has been forgotten?

Best regards,
 Enric


> Best Regards,
> Chanwoo Choi
> 
