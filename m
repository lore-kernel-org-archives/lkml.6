Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3AEC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22167205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qwyE6PQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22167205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503125AbeKWUpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:45:04 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34106 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394542AbeKWUpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:45:02 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181123100125euoutp01b01ad40e748e63bc6772abc1db067956~puJJAyYmw1701017010euoutp01M
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 10:01:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181123100125euoutp01b01ad40e748e63bc6772abc1db067956~puJJAyYmw1701017010euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542967285;
        bh=bD8S15sT6wO96phZM5E1zkxJw9171bQRWbF6b1upQXM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qwyE6PQo9BN/gsxjByCP88WJiaqlAFNv/siiYgxAkInO8qP+HBKdHsLvw6qoFPrSr
         b4o0PkSMsrHQUHcPBkmt4eDETpN5l/xVt9kNDgIlYwOTzgQaK60WBhhHb/boXTPanF
         XNHjDorVeQoKu0As+xYQWsW/aT810TeV5peOWj8Y=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181123100124eucas1p1d85244e297138682259d75537e65ab1d~puJH-RP9m2403924039eucas1p1g;
        Fri, 23 Nov 2018 10:01:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 39.6F.04294.4FFC7FB5; Fri, 23
        Nov 2018 10:01:24 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181123100123eucas1p1e24960e7dc6666c38070bec190d5cdab~puJHDDior1641116411eucas1p1X;
        Fri, 23 Nov 2018 10:01:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181123100123eusmtrp176ce37018e602d4d666e678c5ea8d1bb~puJGyHZ8G1283012830eusmtrp1E;
        Fri, 23 Nov 2018 10:01:23 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-c7-5bf7cff4bd12
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 22.8F.04128.3FFC7FB5; Fri, 23
        Nov 2018 10:01:23 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181123100122eusmtip2a11bb07457a5b06b6b942eca2208e111~puJF8PrbR2096320963eusmtip2p;
        Fri, 23 Nov 2018 10:01:22 +0000 (GMT)
Subject: Re: [PATCH 3/6] devfreq: add support for suspend/resume of a
 devfreq device
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, rjw@rjwysocki.net, len.brown@intel.com,
        pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <734d0941-c885-4d36-274b-23843d6626c1@partner.samsung.com>
Date:   Fri, 23 Nov 2018 11:01:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5BF7419E.90006@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxjGPfcb4jXHC7OvoJt2MxOj4NSE40eMJszcxT/0L7OMJa7KDRhp
        1V5ww5mMSfgQVIg6ZUUtfkVWqEgtFdFCRAq6qgWNk0AKC+B0DjYYhKoQlMvVyH+/9znPm+d9
        kiPQ0ikuSthhSVOsFlOqkQtnPE2vAkuGA6HEpfY7IrlVHUOqiitZcq1qhCVPhp+xxN74gCVZ
        5ys5cq/ATAp7/qFJIHCFJ/cP9PHEdtxLEVfPHyx5VHuKI0OHGxEpDtRRxNkY5MnFJ60U6fi5
        jCPB330T+/6HLMn2NvIkp3yAJX0tncw6g+y54WHlijMVSC7JbGXkosL/kXz+5t+U7HIc5OT6
        0xW8fPXCT/J4Ey+7H+cy8hG3A8ll5SFeHnJ9vFn8JnxNkpK6Y69ijVv7XXhK35FSZnffpz8U
        nLXzmShnTj4KEwCvgA5PD5ePwgUJlyF4lOOk9WEYQc8FP6UPQwiejpaz71eanhUxGkv4EgLf
        yWjd1I/A3u2eNEXgLVB28yWvPURiP4L6+obJEBpn0zA+4J4YBIHDsVDj2KOhiDdAdztouwxe
        AK9DLZzGH+GvIa+rfJJFPBPu/trLaPYwHAMFzlhNprEB2nvtlM6fQFZ1yWQDwL0CZF3+793R
        CfD0+SCtcwS8aHbzOs8B/7FDjM4q3M9zcDrvh9y7Ne88q+F2cyur5dITuZW1cbq8Hpo7vLwm
        A54Bbf0z9RNmwFHPSVqXRcjLkXT3QnAfaqF0ngWXKk7wRchom9LLNqWMbUoZ24fcUsQ4kEFJ
        V83JirrMonwfq5rMarolOXb7LrMLTfxZ/3jzcA2qHdvWgLCAjNPFK1UjiRJr2qtmmBsQCLQx
        UjwwP5QoiUmmjH2KdddWa3qqojagaIExGsQfp/2ZKOFkU5qyU1F2K9b3r5QQFpWJEvKa4uFw
        8ezgqng5xlRiP/PbxdAv458X3z7dRqjOpZvmrVS7Um+0VsuFg+3d/gWhzlKHRJK/rHse7L++
        +OBXCRnBc48HXT7hM2dWkWUsrmv21blV374JROWfLUHebQ/SfG1OKXejL/vhHfOS5fc2jA7u
        OWFIWrHsr4RZHd5/xfgBI6OmmL5YRFtV01tVIK70rwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsVy+t/xe7qfz3+PNrj4ncfi4FZNi40z1rNa
        bN/4jdXi+pfnrBbzj5xjtWhevJ7N4kx3rkX/49fMFufPb2C3ONv0ht1i1pS9TBabHl9jtbi8
        aw6bxefeI4wWM87vY7JYe+Quu8XS6xeZLG43rmCzuHvqKFD/6UusFq17j7BbtK3+wGrx5sI9
        Fgdxj227t7F6rJm3htFjdsNFFo8J/Z8YPRbvecnksWlVJ5vH/rlr2D02L6n3+HeM3WPL1XYW
        j74tqxg9Vqz+zu7xeZNcAG+Unk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+
        nU1Kak5mWWqRvl2CXsabvgUsBW+UK7oXzmdvYGyT6WLk5JAQMJE49nwCSxcjF4eQwFJGifaV
        N5ggEmISk/ZtZ4ewhSX+XOtiA7GFBF4zSpx/ZQZiCwuESXT1/GUHaRYROM0oMeX8KSYQh1mg
        lVni5dtFjBBj7zBJnF1/BmgHBwebgJ7EjlWFICavgJvEo1sSIINYBFQlfn2/ALZAVCBC4uzL
        dYwgNq+AoMTJmU/AOjkFNCW61+qBhJkFzCTmbX7IDGGLS9x6Mp8JwpaXaN46m3kCo9AsJN2z
        kLTMQtIyC0nLAkaWVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIGpZduxn1t2MHa9Cz7EKMDB
        qMTDu2Hjt2gh1sSy4srcQ4wSHMxKIrxNit+jhXhTEiurUovy44tKc1KLDzGaAv02kVlKNDkf
        mPbySuINTQ3NLSwNzY3Njc0slMR5zxtURgkJpCeWpGanphakFsH0MXFwSjUw6n25Lj5bqfr2
        7yWnvkh0PjLd9jZlutzW1zsln3ZoPfWfe8Dd+lJCc+Wcg9em+VQ5bJ/n8+TCFpH/KzeuXip1
        853DtDC3IIbe/LajYeW7uhctVUxLSzkmqX1V1OR8qVDJEeHQKo3234cWcQteYd3XbDd5/T/T
        F7tTO1iOVNzmtlTzsN8mO83SRYmlOCPRUIu5qDgRAC87TN9DAwAA
X-CMS-MailID: 20181123100123eucas1p1e24960e7dc6666c38070bec190d5cdab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181121180204eucas1p1c5891d498aa59c0e10dd3ba4727a4382
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181121180204eucas1p1c5891d498aa59c0e10dd3ba4727a4382
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180204eucas1p1c5891d498aa59c0e10dd3ba4727a4382@eucas1p1.samsung.com>
        <1542823301-23563-4-git-send-email-l.luba@partner.samsung.com>
        <5BF61B3A.9050402@samsung.com>
        <cce4f194-b574-a12c-e876-f11a6f245940@partner.samsung.com>
        <5BF7419E.90006@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo Choi,

On 11/23/18 12:54 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> I add one more comment about devfreq_resume_device().
> 
> On 2018년 11월 22일 20:00, Lukasz Luba wrote:
>>
>>
>> On 11/22/18 3:58 AM, Chanwoo Choi wrote:
>>> On 2018년 11월 22일 03:01, Lukasz Luba wrote:
>>>> The patch adds support for handling suspend/resume process.
>>>> It uses atomic variables to make sure no race condition
>>>> affects the process.
>>>>
>>>> The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
>>>> solve issue with devfreq device's frequency during suspend/resume.
>>>> During the discussion on LKML some corner cases and comments appeared
>>>> related to the design. This patch address them keeping in mind suggestions
>>>> from Chanwoo Choi.
>>>
>>> Please remove the duplicate information about patch history.
>>>
>>>>
>>>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>>>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>>> ---
>>>>    drivers/devfreq/devfreq.c | 45 +++++++++++++++++++++++++++++++++++++++------
>>>>    1 file changed, 39 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>> index cf9c643..7e09de8 100644
>>>> --- a/drivers/devfreq/devfreq.c
>>>> +++ b/drivers/devfreq/devfreq.c
>>>> @@ -872,14 +872,33 @@ EXPORT_SYMBOL(devm_devfreq_remove_device);
>>>>     */
>>>>    int devfreq_suspend_device(struct devfreq *devfreq)
>>>>    {
>>>> -	if (!devfreq)
>>>> -		return -EINVAL;
>>>> +        int ret;
>>>
>>> Move 'ret' definition under 'if (devfreq->suspend_freq) {'
>>> because 'ret' is used if suspend_freq isn't zero.
>> Not only there, 6 lines above 'ret' is used for
>> devfreq->governor->event_handler().
> 
> OK.
> 
>>>
>>>> +        unsigned long prev_freq;
>>>> +        u32 flags = 0;
>>>> +
>>>> +        if (!devfreq)
>>>> +                return -EINVAL;
>>>> +
>>>> +        if (devfreq->governor) {
>>>> +		ret = devfreq->governor->event_handler(devfreq,
>>>> +					DEVFREQ_GOV_SUSPEND, NULL);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +	}
>>>>    
>>>> -	if (!devfreq->governor)
>>>> -		return 0;
>>>> +	if (devfreq->suspend_freq) {
>>>> +		if (atomic_inc_return(&devfreq->suspend_count) > 1)
>>>> +			return 0;
>>>>    
>>>> -	return devfreq->governor->event_handler(devfreq,
>>>> -				DEVFREQ_GOV_SUSPEND, NULL);
>>>> +		ret = devfreq_set_target(devfreq, devfreq->suspend_freq,
>>>> +					 &prev_freq, flags);
>>>
>>> Remove the 'prev_freq' parameter.
>> OK
>>>
>>>> +		if (ret)
>>>> +			return ret;
>>>> +
>>>> +		devfreq->resume_freq = prev_freq;
>>>
>>> As I commented on patch2, if devfreq_set_taget save the current frequency
>>> to 'devfreq->resume_freq', this line is not needed.
>> OK
>>>
>>>
>>>> +	}
>>>> +
>>>> +        return 0;
>>>>    }
>>>>    EXPORT_SYMBOL(devfreq_suspend_device);
>>>>    
>>>> @@ -893,9 +912,23 @@ EXPORT_SYMBOL(devfreq_suspend_device);
>>>>     */
>>>>    int devfreq_resume_device(struct devfreq *devfreq)
>>>>    {
>>>> +        int ret;
>>>
>>> Move 'ret' definition under 'if (devfreq->suspend_freq) {'
>>> because 'ret' is used if suspend_freq isn't zero.
>> OK
> 
> If you change the devfreq_resume_device() according to my new comment,
> please ignore it.
> 
>>>
>>>> +        unsigned long prev_freq;
>>>
>>> Remove prev_freq variable which is not used on this function.
>>> After calling devfreq_set_target, prev_freq is not used.
>> OK
>>>
>>>> +        u32 flags = 0;
>>>> +
>>>>    	if (!devfreq)
>>>>    		return -EINVAL;
>>>>    
>>>> +	if (devfreq->suspend_freq) {
>>>> +		if (atomic_dec_return(&devfreq->suspend_count) >= 1)
>>>> +			return 0;
>>>> +
>>>> +		ret = devfreq_set_target(devfreq, devfreq->resume_freq,
>>>> +					 &prev_freq, flags);
>>>
>>> Remove the 'prev_freq' parameter.
>> OK
>>>
>>>> +		if (ret)
>>>> +			return ret;
>>>> +	}
>>>> +
>>>>    	if (!devfreq->governor)
>>>>    		return 0;
> 
> Please change the code as following because you uses the following type
> in the devfreq_suspend_device(). If there is any special issue, please
> keep the same format in order to improve the readability.
> 
> 	if (devfreq->governor) {
> 		ret = devfreq->governor->event_handler(devfreq,
> 				DEVFREQ_GOV_RESUME, NULL);
> 		if (ret)
> 			return ret;
> 	}
> 
> 
OK, I will change the code to keep the same format.
Thank you for the review.

Regards,
Lukasz

