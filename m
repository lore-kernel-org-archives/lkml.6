Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24212C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A631A20883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kMIjYapw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A631A20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeGLIxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:53:15 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:26158 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeGLIxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:53:14 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180712084436epoutp031e02f3ba7a9fafadcf20952c1edfe648~Akp0d28pt0233202332epoutp03R;
        Thu, 12 Jul 2018 08:44:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180712084436epoutp031e02f3ba7a9fafadcf20952c1edfe648~Akp0d28pt0233202332epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1531385076;
        bh=7BcvqNkwXpTvzDop9jX8fV60L76kLs5GenhgrnjoWZE=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=kMIjYapwLnE3/PkKxWYIuHKruY6ojv2LRpAuYYZgC4zMeGwSKGb8EV80t5qfVdJZF
         E1jAtlwgqNJ8qDl/hk7/3xs75xDm9r02a3mQxPm1UKTaXFh0gjPZowmma9RzLVfjsM
         ejn2Nxlf5jRuY8hvLKLhmUmH87RJXVmabU066CQY=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180712084434epcas1p49bf54ecd95642bfc0f75e17d532427cf~AkpyRCzb10043700437epcas1p4P;
        Thu, 12 Jul 2018 08:44:34 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.26.04343.2F4174B5; Thu, 12 Jul 2018 17:44:34 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180712084434epcas1p49625b4e18142768d96f6329352370473~Akpx5XONV0741207412epcas1p4c;
        Thu, 12 Jul 2018 08:44:34 +0000 (GMT)
X-AuditID: b6c32a38-78bff700000010f7-48-5b4714f222a4
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 11.CD.03915.1F4174B5; Thu, 12 Jul
        2018 17:44:33 +0900 (KST)
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PBQ00A8AWA9M940@mmp2.samsung.com>; Thu, 12 Jul 2018 17:44:33 +0900 (KST)
Subject: Re: [PATCH v5 05/12] PM / devfreq: Add support for policy notifiers
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-id: <5399c191-e140-e2b8-629b-72ddfbf99b0f@samsung.com>
Date:   Thu, 12 Jul 2018 17:44:33 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
In-reply-to: <20180706175301.GG129942@google.com>
Content-language: en-US
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLJsWRmVeSWpSXmKPExsWy7bCmvu4nEfdog6/3xC3+TjrGbjH9yWUW
        i00f37NazD9yjtXi7LKDbBZrbh9itGhevJ7N4mzTG3aL+1+PMlpc3jWHzeJz7xFGi6XXLzJZ
        fN7wmNHiduMKNotT1z+zWZw5fYnVonXvEXaLjV89HIQ81sxbw+jx+9ckRo/ZDRdZPHbcXcLo
        sWlVJ5vHnWt72Dz2z13D7nHlRBOrx5ar7SwefVtWMXp83iQXwB2VapORmpiSWqSQmpecn5KZ
        l26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkD9JqSQlliTilQKCCxuFhJ386mKL+0
        JFUhI7+4xFYp2tDQSM/QwFzPyAhIG8daGZkClSSkZhy82MVWsNOs4mbzLvYGxq26XYycHBIC
        JhIT905g6mLk4hAS2MEocWjqMlYI5zuQ828eSxcjB1jV2TMREPENjBL39l5nBOnmFRCU+DH5
        HguIzSygKfHiyyQWiKK7jBKzXzxiAkkIC/hI3Ov4zApiiwhoSDz5fZ4RpIhZYBqrRPe0/2wg
        CTYBLYn9L26A2fwCihJXfzyG2mAnMXf/XTCbRUBVYvaSfrAaUYEIiabnP9lBbE4BQ4m2trdM
        EFeISzS33oS6SF7i4JXnYBdJCFxjl9jw+g0TxNMuEmeXTmWDsIUlXh3fwg7xprTEpaO2EPXt
        jBJfXjSzQjgTGCU+nNoM1Wws8WxhF9Q2Pol3X3tYIZp5JTrahCBMD4lpE2shIfGXUaK1ZwXz
        BEa5WUghNgspxGYhuXsWkrsXMLKsYhRLLSjOTU8tNiww0StOzC0uzUvXS87P3cQITtpaFjsY
        95zzOcQowMGoxMPLwe0WLcSaWFZcmXuIUYKDWUmE99IUoBBvSmJlVWpRfnxRaU5q8SFGU2BY
        TmSWEk3OB2aUvJJ4Q1MjY2NjCxNDM1NDQyVx3p7TrtFCAumJJanZqakFqUUwfUwcnFINjF1/
        GT257tyT3dhyUWZuR6LJnofN809bsl8yyLc41+y1d3dgMo9zXfqq5TPW6ZxTUxJ94jTz+j1N
        7+54mXvnou32Pw7//euJhI/787t6M/kKO3IOnrRx+nHnSpnt+xzeINW5z14Ylst3+0/fbvRR
        4eyGs1amjZIBRpevJDdPmvnvzYIJHZvuOCuxFGckGmoxFxUnAgAkoY4a8AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t9jQd2PIu7RBl/6rC3+TjrGbjH9yWUW
        i00f37NazD9yjtXi7LKDbBZrbh9itGhevJ7N4mzTG3aL+1+PMlpc3jWHzeJz7xFGi6XXLzJZ
        fN7wmNHiduMKNotT1z+zWZw5fYnVonXvEXaLjV89HIQ81sxbw+jx+9ckRo/ZDRdZPHbcXcLo
        sWlVJ5vHnWt72Dz2z13D7nHlRBOrx5ar7SwefVtWMXp83iQXwB3FZZOSmpNZllqkb5fAlXHw
        YhdbwU6zipvNu9gbGLfqdjFycEgImEicPRPRxcjFISSwjlHi6/3NLF2MnBy8AoISPybfYwGp
        YRZQl5gyJRei5j6jxOWVk8FqhAV8JO51fGYFsUUENCSe/D7PCGIzC8xgldh4IQai4S+jxP0b
        h8CK2AS0JPa/uMEGYvMLKEpc/fGYEWKZncTc/XfBbBYBVYnZS/rBakQFIiTunf8EZnMKGEq0
        tb1lglggLtHcepMFwpaXOHjlOcsERsFZSO6ehXD3LCQds5B0LGBkWcUomVpQnJueW2xUYJiX
        Wq5XnJhbXJqXrpecn7uJERjD2w5r9e1gvL8k/hCjAAejEg/vBg63aCHWxLLiytxDjBIczEoi
        vJemAIV4UxIrq1KL8uOLSnNSiw8xSnOwKInz3s47FikkkJ5YkpqdmlqQWgSTZeLglGpg5Ivt
        XvrJaLfTcrXz+Qtql7cUPrps+1tO8+vNoKuXVr4td9S7MflH1+arfN8N/0/awlB2KnBmYXTZ
        zk8ctyQf/vm8Rno6n/a7hLw/3yRvrXKa6PZauaWB+3GI0CX/j3lCno2Pnf3P9vj5rK+5sMNg
        Huc3ZsO6wu8vuiMl17ufUXKUEEoS+XLQX4mlOCPRUIu5qDgRAN/3ywbdAgAA
X-CMS-MailID: 20180712084434epcas1p49625b4e18142768d96f6329352370473
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180703234900epcas1p1cda806bab6bbe69228ca5ee56bc33f36
References: <20180703234705.227473-1-mka@chromium.org>
        <CGME20180703234900epcas1p1cda806bab6bbe69228ca5ee56bc33f36@epcas1p1.samsung.com>
        <20180703234705.227473-6-mka@chromium.org> <5B3C6C2A.1070205@samsung.com>
        <20180706175301.GG129942@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018년 07월 07일 02:53, Matthias Kaehlcke wrote:
> Hi Chanwoo,
> 
> On Wed, Jul 04, 2018 at 03:41:46PM +0900, Chanwoo Choi wrote:
> 
>> Firstly,
>> I'm not sure why devfreq needs the devfreq_verify_within_limits() function.
>>
>> devfreq already used the OPP interface as default. It means that
>> the outside of 'drivers/devfreq' can disable/enable the frequency
>> such as drivers/thermal/devfreq_cooling.c. Also, when some device
>> drivers disable/enable the specific frequency, the devfreq core
>> consider them.
>>
>> So, devfreq doesn't need to devfreq_verify_within_limits() because
>> already support some interface to change the minimum/maximum frequency
>> of devfreq device. 
>>
>> In case of cpufreq subsystem, cpufreq only provides 'cpufreq_verify_with_limits()'
>> to change the minimum/maximum frequency of cpu. some device driver cannot
>> change the minimum/maximum frequency through OPP interface.
>>
>> But, in case of devfreq subsystem, as I explained already, devfreq support
>> the OPP interface as default way. devfreq subsystem doesn't need to add
>> other way to change the minimum/maximum frequency.
> 
> Using the OPP interface exclusively works as long as a
> enabling/disabling of OPPs is limited to a single driver
> (drivers/thermal/devfreq_cooling.c). When multiple drivers are
> involved you need a way to resolve conflicts, that's the purpose of
> devfreq_verify_within_limits(). Please let me know if there are
> existing mechanisms for conflict resolution that I overlooked.
> 
> Possibly drivers/thermal/devfreq_cooling.c could be migrated to use
> devfreq_verify_within_limits() instead of the OPP interface if
> desired, however this seems beyond the scope of this series.

Actually, if we uses this approach, it doesn't support the multiple drivers too.
If non throttler drivers uses devfreq_verify_within_limits(), the conflict
happen.

To resolve the conflict for multiple device driver, maybe OPP interface
have to support 'usage_count' such as clk_enable/disable().

> 
>> Secondly,
>> This patch send the 'struct devfreq_policy' instance as the data
>> when sending the notification as following:
>>
>> 	srcu_notifier_call_chain(&devfreq->policy_notifier_list,
>> 			DEVFREQ_ADJUST, policy);
>>
>> But, I think that if devfreq core sends the 'struct devfreq_freq_limits'
>> instance instead of 'struct devfreq_policy', it is enough.
>> Because receiver of DEVFREQ_ADJUST just will use the min_freq/max_freq variables.
>>
>> So, I tried to find the cpufreq's case. The some device drivers using
>> CPUFREQ_POLICY_NOTIFIER uses following variables of 'struct cpufreq_policy'.
>> It means that receiver of CPUFREQ_POLICY_NOTIFIER don't need to other
>> information/variables except for min/max frequency.
>>
>> - policy->min
>> - policy->max
>> - policy->cpuinfo.max_freq
>> - policy->cpuinfo.min_freq
>> - policy->cpu : not related to devfreq)
>> - policy->related_cpus : not related to devfreq)
>>
>> - list of device drivers using CPUFREQ_POLICY_NOTIFIER (linux kernel is v4.18-rc1)
>> $ grep -rn "CPUFREQ_POLICY_NOTIFIER" .
>> ./drivers/macintosh/windfarm_cpufreq_clamp.c
>> ./drivers/thermal/cpu_cooling.c
>> ./drivers/thermal/cpu_cooling.c
>> ./drivers/acpi/processor_thermal.c
>> ./drivers/acpi/processor_thermal.c
>> ./drivers/acpi/processor_perflib.c
>> ./drivers/acpi/processor_perflib.c
>> ./drivers/base/arch_topology.c
>> ./drivers/base/arch_topology.c
>> ./drivers/video/fbdev/sa1100fb.c
>> ./drivers/video/fbdev/pxafb.c
>> ./drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
>> ./drivers/cpufreq/cpufreq.c
>> ./drivers/cpufreq/cpufreq.c
>> ./drivers/cpufreq/cpufreq.c
>> ./drivers/cpufreq/cpufreq.c
> 
> Thanks for your investigation.
> 
> I decided to mirror the cpufreq interface for consistency, but I agree
> that 'struct devfreq_freq_limits' could be passed instead of the
> policy object. I'm fine with changing that.
> 
>> On 2018년 07월 04일 08:46, Matthias Kaehlcke wrote:
>>> Policy notifiers are called before a frequency change and may narrow
>>> the min/max frequency range in devfreq_policy, which is used to adjust
>>> the target frequency if it is beyond this range.
>>>
>>> Also add a few helpers:
>>>  - devfreq_verify_within_[dev_]limits()
>>>     - should be used by the notifiers for policy adjustments.
>>>  - dev_to_devfreq()
>>>     - lookup a devfreq strict from a device pointer
>>>
>>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>>> Reviewed-by: Brian Norris <briannorris@chromium.org>
>>> ---
>>> Changes in v5:
>>> - none
>>>
>>> Changes in v4:
>>> - Fixed typo in commit message: devfreg => devfreq
>>> - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
>>>
>>> Changes in v3:
>>> - devfreq.h: fixed misspelling of struct devfreq_policy
>>>
>>> Changes in v2:
>>> - performance, powersave and simpleondemand governors don't need changes
>>>   with "PM / devfreq: Don't adjust to user limits in governors"
>>> - formatting fixes
>>> ---
>>>  drivers/devfreq/devfreq.c | 48 ++++++++++++++++++++++-------
>>>  include/linux/devfreq.h   | 65 +++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 102 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 21604d6ae2b8..4cbaa7ad1972 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -72,6 +72,21 @@ static struct devfreq *find_device_devfreq(struct device *dev)
>>>  	return ERR_PTR(-ENODEV);
>>>  }
>>>  
>>> +/**
>>> + * dev_to_devfreq() - find devfreq struct using device pointer
>>> + * @dev:	device pointer used to lookup device devfreq.
>>> + */
>>> +struct devfreq *dev_to_devfreq(struct device *dev)
>>> +{
>>> +	struct devfreq *devfreq;
>>> +
>>> +	mutex_lock(&devfreq_list_lock);
>>> +	devfreq = find_device_devfreq(dev);
>>> +	mutex_unlock(&devfreq_list_lock);
>>> +
>>> +	return devfreq;
>>> +}
>>> +
>>>  static unsigned long find_available_min_freq(struct devfreq *devfreq)
>>>  {
>>>  	struct dev_pm_opp *opp;
>>> @@ -269,20 +284,21 @@ int update_devfreq(struct devfreq *devfreq)
>>>  	if (!policy->governor)
>>>  		return -EINVAL;
>>>  
>>> +	policy->min = policy->devinfo.min_freq;
>>> +	policy->max = policy->devinfo.max_freq;
>>
>> Why don't you consider 'policy->user.max/min_freq' as following?
>> As I already commented, I think that 'struct devfreq_freq_limits' is enough
>> instead of 'struct devfreq_policy'.
>>
>> 	->max_freq = MIN(policy->devinfo.max_freq, policy->user.max_freq);
>> 	->min_freq = MAX(policy->devinfo.min_freq, policy->user.min_freq);
> 
> You mean limiting the frequency range with user.min/max before
> DEVFREQ_ADJUST instead of adjusting it afterwards? That's fine with
> me.
> 
> Thanks
> 
> Matthias
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
