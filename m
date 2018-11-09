Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C43BC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6997120855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6997120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeKJDqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:46:36 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35916 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbeKJDqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:46:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EA5AA78;
        Fri,  9 Nov 2018 10:04:55 -0800 (PST)
Received: from [10.37.10.101] (unknown [10.37.10.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9D433F718;
        Fri,  9 Nov 2018 10:04:53 -0800 (PST)
Subject: Re: [PATCH v2 3/4] coresight: etm3x: Deal with CLAIM tag before and
 after accessing HW
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1541632132-1252-1-git-send-email-mathieu.poirier@linaro.org>
 <1541632132-1252-4-git-send-email-mathieu.poirier@linaro.org>
 <102c6181-189e-0ce4-02be-15c1a2744334@arm.com>
 <CANLsYkxbzk3=uA0Tx6HNNoXGBnDUPAhgnWZM9Q7jqLSzBhDr-g@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <0928085c-cf9c-5437-2806-1b027ea428ff@arm.com>
Date:   Fri, 9 Nov 2018 18:06:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CANLsYkxbzk3=uA0Tx6HNNoXGBnDUPAhgnWZM9Q7jqLSzBhDr-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2018 05:59 PM, Mathieu Poirier wrote:
> On Thu, 8 Nov 2018 at 10:13, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> Hi,
>>
>> On 07/11/2018 23:08, Mathieu Poirier wrote:
>>> This patch moves access to the CLAIM tag so that no modification to the HW
>>> happens before and after the CLAIM operation has been carried.
>>>
>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> ---
>>>    drivers/hwtracing/coresight/coresight-etm3x.c | 16 ++++++++--------
>>>    1 file changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
>>> index fd5c4cca7db5..4f638d81a66a 100644
>>> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
>>> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
>>> @@ -363,15 +363,16 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
>>>
>>>        CS_UNLOCK(drvdata->base);
>>>
>>> +     rc = coresight_claim_device_unlocked(drvdata->base);
>>> +     if (rc)
>>> +             goto done;
>>> +
>>>        /* Turn engine on */
>>>        etm_clr_pwrdwn(drvdata);
>>>        /* Apply power to trace registers */
>>>        etm_set_pwrup(drvdata);
>>>        /* Make sure all registers are accessible */
>>>        etm_os_unlock(drvdata);
>>> -     rc = coresight_claim_device_unlocked(drvdata->base);
>>> -     if (rc)
>>> -             goto done;
>>>
>>>        etm_set_prog(drvdata);
>>>
>>> @@ -422,12 +423,11 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
>>>        etm_clr_prog(drvdata);
>>>
>>>    done:
>>> -     if (rc)
>>> -             etm_set_pwrdwn(drvdata);
>>>        CS_LOCK(drvdata->base);
>>>
>>> -     dev_dbg(drvdata->dev, "cpu: %d enable smp call done: %d\n",
>>> -             drvdata->cpu, rc);
>>> +     if (!rc)
>>> +             dev_dbg(drvdata->dev, "cpu: %d enable smp call done: %d\n",
>>> +                     drvdata->cpu, rc);
>>
>> Isn't it good to report the failure case too ? Anyway it is dev_dbg and
>> will be a useful info when we debug issues. Otherwise,
> 
> Simply removing the "if (!rc)" will do the trick.  Can I do the
> modification and add your tag or you prefer to see another revision?

I am fine with that change folded in, no need to respin it.

> 
>>
>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>


Cheers
Suzuki


>>
>>>        return rc;
>>>    }
>>>
>>> @@ -577,9 +577,9 @@ static void etm_disable_hw(void *info)
>>>        for (i = 0; i < drvdata->nr_cntr; i++)
>>>                config->cntr_val[i] = etm_readl(drvdata, ETMCNTVRn(i));
>>>
>>> +     etm_set_pwrdwn(drvdata);
>>>        coresight_disclaim_device_unlocked(drvdata->base);
>>>
>>> -     etm_set_pwrdwn(drvdata);
>>>        CS_LOCK(drvdata->base);
>>>
>>>        dev_dbg(drvdata->dev, "cpu: %d disable smp call done\n", drvdata->cpu);
>>>
>>

