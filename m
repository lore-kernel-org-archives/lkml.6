Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC207C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE2520883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cymiPbY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE2520883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732343AbeGLIqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:46:50 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:19353 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbeGLIqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:46:49 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180712083813epoutp0217c4bfe814966504d710b8354b0dbff3~AkkPNrFLO1340013400epoutp02E;
        Thu, 12 Jul 2018 08:38:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180712083813epoutp0217c4bfe814966504d710b8354b0dbff3~AkkPNrFLO1340013400epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1531384693;
        bh=co5MPDMiJy+EnUqkhV6DSg7io5hX1vmrF/OBUkmwAA8=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=cymiPbY6n1R/w6oq4gF38d4RwRFqdcP3kkTCOKYsxykbvQqOhnRMlPIzPj5OYN5mq
         cd2REkl5H1oc7MVLi8toM8zOJriEinbYcdAVtLefUcRRi8xQlrItjPPIbT9Ro3Su/G
         8UdMpZwDuV/HSsfSuvh+jKHayBX41YTDyMxRYi/U=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180712083810epcas1p14a1ea6f9a4e86b443fb44332a43ed281~AkkMnQtTo0190301903epcas1p1B;
        Thu, 12 Jul 2018 08:38:10 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        BF.94.04343.273174B5; Thu, 12 Jul 2018 17:38:10 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180712083810epcas1p2d7936148210bb2439fe94505dfb34ef9~AkkMZfN2W0090500905epcas1p2l;
        Thu, 12 Jul 2018 08:38:10 +0000 (GMT)
X-AuditID: b6c32a38-773ff700000010f7-e3-5b47137280e4
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        09.9D.03915.173174B5; Thu, 12 Jul 2018 17:38:10 +0900 (KST)
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PBQ00G2MVZLK310@mmp1.samsung.com>; Thu, 12 Jul 2018 17:38:09 +0900 (KST)
Subject: Re: [PATCH v5 04/12] PM / devfreq: Add struct devfreq_policy
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
Message-id: <4863cf97-37d9-7d81-f44b-10de3dc8267e@samsung.com>
Date:   Thu, 12 Jul 2018 17:38:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
In-reply-to: <20180706170701.GF129942@google.com>
Content-language: en-US
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDJsWRmVeSWpSXmKPExsWy7bCmnm6RsHu0wexuCYu/k46xW0x/cpnF
        YtPH96wW84+cY7U4u+wgm8Wa24cYLZoXr2ezONv0ht3i/tejjBaXd81hs/jce4TRYun1i0wW
        nzc8ZrS43biCzeLU9c9sFmdOX2K1aN17hN1i41cPByGPNfPWMHr8/jWJ0WN2w0UWjx13lzB6
        bFrVyeZx59oeNo/9c9ewe1w50cTqseVqO4tH35ZVjB6fN8kFcEel2mSkJqakFimk5iXnp2Tm
        pdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAvaakUJaYUwoUCkgsLlbSt7Mpyi8t
        SVXIyC8usVWKNjQ00jM0MNczMgLSxrFWRqZAJQmpGV+nHGQrOKNRseXyDvYGxksKXYwcHBIC
        JhJdS2u6GLk4hAR2MEpsbPnGCuF8Z5R4MPcZkMMJVrTzSysTRGI3o8T57V+YQRK8AoISPybf
        YwGxmQU0JV58mcQCUXSXUeLrgZ1g3cICrhKzf81nA7FFBDQknvw+zwhSxCwwjVWie9p/sASb
        gJbE/hc3wGx+AUWJqz8eM4LcxytgJ/H8PA9ImEVAVeJj80mwZaICERJNz3+yg5RwChhKdEwV
        g7hBXKK59SbUPfISB688B7tHQuAWu8S3hy2MEN+4SBw7vokZwhaWeHV8CzskKKQlLh21hahv
        Z5T48qKZFcKZwCjx4dRmJogGY4lnC7uYIDbwSbz72sMK0cwr0dEmBFHiIfHw2l5oMP5llPh7
        7D7bBEa5WUgBNgspwGYhOXwWksMXMLKsYhRLLSjOTU8tNiww0StOzC0uzUvXS87P3cQITtla
        FjsY95zzOcQowMGoxMPLwe0WLcSaWFZcmXuIUYKDWUmE99IUoBBvSmJlVWpRfnxRaU5q8SFG
        U2BYTmSWEk3OB+aTvJJ4Q1MjY2NjCxNDM1NDQyVx3p7TrtFCAumJJanZqakFqUUwfUwcnFIN
        jPvFDoZYll26eMXiucHflyVnVcXfqYrMuP8wvfl4svqbXjGdvmVS253eMZzws9+XYF4WZXfw
        fMJJhbmhLnPP3JD9Pu/Vk2vaM41FlN/eSdxeXWijxxabPJ8pc7r/ITGp5mmzpmb6TmgyC5Xq
        FNg0f7ljsorhji/rmHUXrnO5Hc4q8j5nc59uhxJLcUaioRZzUXEiACKGFpnvAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t9jAd0iYfdog4WfWSz+TjrGbjH9yWUW
        i00f37NazD9yjtXi7LKDbBZrbh9itGhevJ7N4mzTG3aL+1+PMlpc3jWHzeJz7xFGi6XXLzJZ
        fN7wmNHiduMKNotT1z+zWZw5fYnVonXvEXaLjV89HIQ81sxbw+jx+9ckRo/ZDRdZPHbcXcLo
        sWlVJ5vHnWt72Dz2z13D7nHlRBOrx5ar7SwefVtWMXp83iQXwB3FZZOSmpNZllqkb5fAlfF1
        ykG2gjMaFVsu72BvYLyk0MXIySEhYCKx80srUxcjF4eQwE5GiTvbJzCBJHgFBCV+TL7H0sXI
        wcEsoC4xZUouRM19Rolnd16C1QgLuErM/jWfDcQWEdCQePL7PCOIzSwwg1Vi44UYiIa/jBK7
        7qwAS7AJaEnsf3EDrIFfQFHi6o/HjCALeAXsJJ6f5wEJswioSnxsPskCYosKREjcO/+JDaSE
        U8BQomOqGMR4cYnm1pssELa8xMErz1kmMArOQnL1LISrZyHpmIWkYwEjyypGydSC4tz03GKj
        AsO81HK94sTc4tK8dL3k/NxNjMAI3nZYq28H4/0l8YcYBTgYlXh4N3C4RQuxJpYVV+YeYpTg
        YFYS4b00BSjEm5JYWZValB9fVJqTWnyIUZqDRUmc93besUghgfTEktTs1NSC1CKYLBMHp1QD
        I6/nGo0/v0ImLK6ufyD5c+3fFfwzgj+l1SiavLRMbY4M1vqrPFO556Dx4ze67x0ykzKsHZ8c
        8ZNRsknqa1q6fcb3sw8ivA3XraxbsYC/Wm3lnsMrrkyftGlpw3celdyHuoaPHC9pdXfOFe43
        /OP5QKvYoM/cO7aZ74xw9jT7r39SKy4rar7XUGIpzkg01GIuKk4EAPC3gJrcAgAA
X-CMS-MailID: 20180712083810epcas1p2d7936148210bb2439fe94505dfb34ef9
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180703235030epcas4p423e7bf876628913adb3e41ffdc8ba3cd
References: <20180703234705.227473-1-mka@chromium.org>
        <CGME20180703235030epcas4p423e7bf876628913adb3e41ffdc8ba3cd@epcas4p4.samsung.com>
        <20180703234705.227473-5-mka@chromium.org> <5B3C3632.1010706@samsung.com>
        <20180706170701.GF129942@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018년 07월 07일 02:07, Matthias Kaehlcke wrote:
> Hi,
> 
> On Wed, Jul 04, 2018 at 11:51:30AM +0900, Chanwoo Choi wrote:
>> Hi,
>>
>> On 2018년 07월 04일 08:46, Matthias Kaehlcke wrote:
>>> Move variables related with devfreq policy changes from struct devfreq
>>> to the new struct devfreq_policy and add a policy field to struct devfreq.
>>>
>>> The following variables are moved:
>>>
>>> df->min/max_freq           =>   p->user.min/max_freq
>>> df->scaling_min/max_freq   =>   p->devinfo.min/max_freq
>>> df->governor               =>   p->governor
>>> df->governor_name          =>   p->governor_name
>>>
>>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>>> Reviewed-by: Brian Norris <briannorris@chromium.org>
>>> ---
>>> Changes in v5:
>>> - none
>>>
>>> Changes in v4:
>>> - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
>>>
>>> Changes in v3:
>>> - none
>>>
>>> Changes in v2:
>>> - performance, powersave and simpleondemand governors don't need changes
>>>   with "PM / devfreq: Don't adjust to user limits in governors"
>>> - formatting fixes
>>> ---
>>>  drivers/devfreq/devfreq.c          | 137 ++++++++++++++++-------------
>>>  drivers/devfreq/governor_passive.c |   4 +-
>>>  include/linux/devfreq.h            |  38 +++++---
> 
> 
>>>  3 files changed, 103 insertions(+), 76 deletions(-)
>>>
>>
>> (skip)
>>
>>>  
>>> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
>>> index 3bc29acbd54e..e0987c749ec2 100644
>>> --- a/drivers/devfreq/governor_passive.c
>>> +++ b/drivers/devfreq/governor_passive.c
>>> @@ -99,12 +99,12 @@ static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
>>>  {
>>>  	int ret;
>>>  
>>> -	if (!devfreq->governor)
>>> +	if (!devfreq->policy.governor)
>>>  		return -EINVAL;
>>>  
>>>  	mutex_lock_nested(&devfreq->lock, SINGLE_DEPTH_NESTING);
>>>  
>>> -	ret = devfreq->governor->get_target_freq(devfreq, &freq);
>>> +	ret = devfreq->policy.governor->get_target_freq(devfreq, &freq);
>>>  	if (ret < 0)
>>>  		goto out;
>>>  
>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>> index 3aae5b3af87c..9bf23b976f4d 100644
>>> --- a/include/linux/devfreq.h
>>> +++ b/include/linux/devfreq.h
>>> @@ -109,6 +109,30 @@ struct devfreq_dev_profile {
>>>  	unsigned int max_state;
>>>  };
>>>  
>>> +/**
>>> + * struct devfreq_freq_limits - Devfreq frequency limits
>>> + * @min_freq:	minimum frequency
>>> + * @max_freq:	maximum frequency
>>> + */
>>> +struct devfreq_freq_limits {
>>> +	unsigned long min_freq;
>>> +	unsigned long max_freq;
>>> +};
>>> +
>>> +/**
>>> + * struct devfreq_policy - Devfreq policy
>>> + * @user:	frequency limits requested by the user
>>> + * @devinfo:	frequency limits of the device (available OPPs)
>>> + * @governor:	method how to choose frequency based on the usage.
>>
>> nitpick. remove '.' on the end of line.
> 
> Ok
> 
>>> + * @governor_name:	devfreq governor name for use with this devfreq
>>> + */
>>> +struct devfreq_policy {
>>> +	struct devfreq_freq_limits user;
>>> +	struct devfreq_freq_limits devinfo;
>>> +	const struct devfreq_governor *governor;
>>> +	char governor_name[DEVFREQ_NAME_LEN];
>>> +};
>>> +
>>>  /**
>>>   * struct devfreq - Device devfreq structure
>>>   * @node:	list node - contains the devices with devfreq that have been
>>> @@ -117,8 +141,6 @@ struct devfreq_dev_profile {
>>>   * @dev:	device registered by devfreq class. dev.parent is the device
>>>   *		using devfreq.
>>>   * @profile:	device-specific devfreq profile
>>> - * @governor:	method how to choose frequency based on the usage.
>>> - * @governor_name:	devfreq governor name for use with this devfreq
>>>   * @nb:		notifier block used to notify devfreq object that it should
>>>   *		reevaluate operable frequencies. Devfreq users may use
>>>   *		devfreq.nb to the corresponding register notifier call chain.
>>> @@ -126,10 +148,7 @@ struct devfreq_dev_profile {
>>>   * @previous_freq:	previously configured frequency value.
>>>   * @data:	Private data of the governor. The devfreq framework does not
>>>   *		touch this.
>>> - * @min_freq:	Limit minimum frequency requested by user (0: none)
>>> - * @max_freq:	Limit maximum frequency requested by user (0: none)
>>> - * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
>>> - * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
>>> + * @policy:		Policy for frequency adjustments
>>
>> The devfreq_policy contains the range of frequency and governor information.
>> But, this description focus on the frequency. You need to explain the more
>> correct description of 'policy'.
> 
> I wouldn't say that the focus is on 'frequency', but on 'frequency
> adjustments', and the governor is an integral part of them.

OK. I agree your original description.

> 
> I can change it to "Policy for frequency adjustments, including
> frequency limits and the governor" if you prefer. I'm open to other
> suggestions.

(snip)

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
