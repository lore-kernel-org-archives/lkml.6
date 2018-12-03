Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237E4C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A712147C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="j5lOUEsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A712147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbeLCOGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:06:24 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37419 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeLCOGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:06:24 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181203140514euoutp023d5cf79e4cffba73cd500f5f6c7c6cb0~s164PWkcL2491924919euoutp024
        for <linux-kernel@vger.kernel.org>; Mon,  3 Dec 2018 14:05:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181203140514euoutp023d5cf79e4cffba73cd500f5f6c7c6cb0~s164PWkcL2491924919euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543845914;
        bh=4XTGEwSLqTxYOaFkZGwe6FCXg8g2lq0yX2XPPQZs+kE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=j5lOUEspNMwTJZLpPQXjj4u7iNA5XBQQSKRJk1fzM9Wq0bSSGQ62jyvF8v25EeKBR
         KPjCJ7rA40R02eNoYw0Ik2/gTM3HEuo/Rgms5kY2kIOQywioKGuWMTxsWTwaq23PM2
         p5yKVLhxlxJXCdBLiZYJErAZLmpqMLUQPKQjQbNY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181203140513eucas1p1d5807c493d4fbe8f07d3ba8b8a9f3576~s163KQ7uE3174631746eucas1p1w;
        Mon,  3 Dec 2018 14:05:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6D.50.04806.918350C5; Mon,  3
        Dec 2018 14:05:13 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181203140512eucas1p19d36dff812fd391107d679e180f230cf~s162a71z91445614456eucas1p1h;
        Mon,  3 Dec 2018 14:05:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181203140512eusmtrp147fc00d887152dfba7092c09d4af13a9~s162KvK1v0748507485eusmtrp1j;
        Mon,  3 Dec 2018 14:05:12 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-92-5c0538199710
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C1.D4.04128.818350C5; Mon,  3
        Dec 2018 14:05:12 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181203140511eusmtip2d53337947f88fa5271296a6d674f8e92~s161NcpWc3120731207eusmtip2F;
        Mon,  3 Dec 2018 14:05:11 +0000 (GMT)
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
Message-ID: <1aaf315b-f262-dad1-0e82-548410d10b5e@partner.samsung.com>
Date:   Mon, 3 Dec 2018 15:05:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5BFB3C17.40502@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se1BMcRj1u+8am2uL/eS94w+ZUQjzGxpv5prxB2YYQ6NW3Um0qb2FMCPP
        Qmgw1HrEbJIts6xtrWqLpJ1tS+URQiE0HmuwnsPEXjej/853znfmO2fm40j1KSaUS0xOEw3J
        uiQtE0jZ637cGjsI09Hj7rWH4utlYfhSnoXGVy59pfH9z100Lqi9ReMdJguDG/bp8cHOtyRu
        arrI4sbt71hsPOIksLWzlcZ3yk8w2Le/FuG8pioCX6h9wuKz91sI/GhbMYOf1N/0+z23abzL
        Wcvi3SUfaPyuuZ2aoRHsFXZaKD1VioTjmS2UkHvwExJMla8JwWrewwjVJ0tZ4XLhVqG7jhVs
        97Io4YDNjITikm+s4LMOW6haHhgVLyYlrhcNEdNiA1d/tN0lU86HbXQb85hM1DZiLwrggJ8I
        bstDYi8K5NR8MYJ20ytaFtT8ZwTdBWGK4EOQt6+M+udo6vBSinAOganoGVIGL4LWnJd/7cH8
        Uiiu/M7KQgjvQVBdXcPIA8nvIqH7g80/cBzDh4PDnCobVPw8OFBVRciY4kdB+dU2VsYD+GWQ
        3VHCKDv9wZ3/4m+MAD4M3hdWIBmTvAbaXhQQCh4OO8qOk/It4B9zcO3nIVbJPQcuWtp7cDC8
        cdl68BDwHM7p6SZBY7aZUfAWyHI7enamwg1XCy1nJv2HLeURCj0TXI+crEwDHwQPvP2VCEFw
        yH6MVGgVZO9WK9ujwZbTTCh4IJwrPcrmIq2xVzFjrzLGXmWM/++eRpQZacR0SZ8gSpHJ4oZw
        SaeX0pMTwuPW6a3I/7WebtcXB6r6taoG8RzS9lXNiKGi1bRuvZShr0HAkdoQVUqqn1LF6zI2
        iYZ1MYb0JFGqQYM5SqtRbe7zdIWaT9CliWtFMUU0/FMJLiA0Exmw41NWVH65ZWNL2RR7aHb9
        Q/PdqLmFi2efHop9I7L6dax5vCV2QUxqUdexAScyPEfprabl84sS3COrmyctiW8cSiyY3Nmg
        qXBclqbPcXmtXYN2JvqO1DtzG+oKIxYFjdq+M/h9qzNu1vMb3tw0YcjsCSvv/O7nZM88i34Q
        2XAm8mZfLSWt1o0fQxok3R+H5bCDsQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXfO2TlKq9O0fDEoW33IwOm8voaJBMWJgqSii5lz6GmKzunO
        JtkXNVNrXdSQsHmL5XVa5pz3NBpm5GVTKyUvXdAK06SylKBGmyPw2+95/s+PhwceChO2EJ5U
        YoqaVaXIkkV8V3zQ9vytD0REtJ8xexd62uqNmkuaCNTevEKgiZ+fCVTZZyFQzv0mPhq6rkAF
        swsYslofkWj48iKJdMU9PGScHSfQy64yPlq+2QdQibWXhx70zZCoemKUh6ay6/hoZuCZ3R8c
        I1BuTx+J8hq+EWhx5C0e4cG0dbcRTGNFI2BKs0ZxprDgB2DuP57nMUbDNT7zpLyRZFqqMhlb
        P8mYXufjzC2TATB1Dasks2zcHimIEoeplBo165Wg5NT7ReckyF8sCUVi/8BQsSQg5Pw+/yCR
        b3hYPJucmM6qfMNjxQnfTa+w1Hrviy90JfwsMOmlBS4UpAOh9d1XXAtcKSFdDaBFX4Q5g63w
        dm876WQ3+Gdcy3cOLQC4+v4O4Qjc6FNQe+Mv6Qjc6UEAi60DPEeB0bkYnP+qB06lA4NvJhfs
        SyiKT4thhyHNYQvoQ/BWby/PwTi9G3Z1Tq6t20KfgcPzD4FzZjN8cXcOd7AL7Q2XqrrX+hgd
        DCtaPmBO9oCTc5U8J++AOa2lWCEQ6tbpunWKbp2iW6fcA7gBuLMaTiFXcP5iTqbgNClycZxS
        YQT2h2nr/23qANqlE2ZAU0C0QRAhxaOFhCydy1CYAaQwkbsgNc3eEsTLMi6xKqVUpUlmOTMI
        sh9XhHluiVPa3y9FLZUESUJQqCQkICQgGIk8BFa/jCghLZep2SSWTWVV/z0e5eKZBTbFH6/x
        01QpRhRHzaba7Uxn/cbOhj3DJqkc1E/XvLu0UNg/EfxRH5F/weZ5BNR1dedXZflMmYtO2k4f
        CzqYViaNia88XLuUYxvOMazmjnkV0eUrv5IiLWExQ2flv6t9GvK+WLSxmcT0rPsBdcunbVcS
        9dlXd1q8TtQLlm+GW+dEOJcgk+zFVJzsH13OnWxGAwAA
X-CMS-MailID: 20181203140512eucas1p19d36dff812fd391107d679e180f230cf
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
        <734d0941-c885-4d36-274b-23843d6626c1@partner.samsung.com>
        <5BFB3C17.40502@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo Choi,

On 11/26/18 1:19 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> I add the one more comment for devfreq_resume_device()
> 
> On 2018년 11월 23일 19:01, Lukasz Luba wrote:
>> Hi Chanwoo Choi,
>>
>> On 11/23/18 12:54 AM, Chanwoo Choi wrote:
>>> Hi Lukasz,
>>>
>>> I add one more comment about devfreq_resume_device().
>>>
>>> On 2018년 11월 22일 20:00, Lukasz Luba wrote:
>>>>
>>>>
>>>> On 11/22/18 3:58 AM, Chanwoo Choi wrote:
>>>>> On 2018년 11월 22일 03:01, Lukasz Luba wrote:
>>>>>> The patch adds support for handling suspend/resume process.
>>>>>> It uses atomic variables to make sure no race condition
>>>>>> affects the process.
>>>>>>
>>>>>> The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
>>>>>> solve issue with devfreq device's frequency during suspend/resume.
>>>>>> During the discussion on LKML some corner cases and comments appeared
>>>>>> related to the design. This patch address them keeping in mind suggestions
>>>>>> from Chanwoo Choi.
>>>>>
>>>>> Please remove the duplicate information about patch history.
>>>>>
>>>>>>
>>>>>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>>>>>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>>>>> ---
>>>>>>     drivers/devfreq/devfreq.c | 45 +++++++++++++++++++++++++++++++++++++++------
>>>>>>     1 file changed, 39 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>>> index cf9c643..7e09de8 100644
>>>>>> --- a/drivers/devfreq/devfreq.c
>>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>>> @@ -872,14 +872,33 @@ EXPORT_SYMBOL(devm_devfreq_remove_device);
>>>>>>      */
>>>>>>     int devfreq_suspend_device(struct devfreq *devfreq)
>>>>>>     {
>>>>>> -	if (!devfreq)
>>>>>> -		return -EINVAL;
>>>>>> +        int ret;
>>>>>
>>>>> Move 'ret' definition under 'if (devfreq->suspend_freq) {'
>>>>> because 'ret' is used if suspend_freq isn't zero.
>>>> Not only there, 6 lines above 'ret' is used for
>>>> devfreq->governor->event_handler().
>>>
>>> OK.
>>>
>>>>>
>>>>>> +        unsigned long prev_freq;
>>>>>> +        u32 flags = 0;
>>>>>> +
>>>>>> +        if (!devfreq)
>>>>>> +                return -EINVAL;
>>>>>> +
>>>>>> +        if (devfreq->governor) {
>>>>>> +		ret = devfreq->governor->event_handler(devfreq,
>>>>>> +					DEVFREQ_GOV_SUSPEND, NULL);
>>>>>> +		if (ret)
>>>>>> +			return ret;
>>>>>> +	}
>>>>>>     
>>>>>> -	if (!devfreq->governor)
>>>>>> -		return 0;
>>>>>> +	if (devfreq->suspend_freq) {
>>>>>> +		if (atomic_inc_return(&devfreq->suspend_count) > 1)
>>>>>> +			return 0;
>>>>>>     
>>>>>> -	return devfreq->governor->event_handler(devfreq,
>>>>>> -				DEVFREQ_GOV_SUSPEND, NULL);
>>>>>> +		ret = devfreq_set_target(devfreq, devfreq->suspend_freq,
>>>>>> +					 &prev_freq, flags);
>>>>>
>>>>> Remove the 'prev_freq' parameter.
>>>> OK
>>>>>
>>>>>> +		if (ret)
>>>>>> +			return ret;
>>>>>> +
>>>>>> +		devfreq->resume_freq = prev_freq;
>>>>>
>>>>> As I commented on patch2, if devfreq_set_taget save the current frequency
>>>>> to 'devfreq->resume_freq', this line is not needed.
>>>> OK
>>>>>
>>>>>
>>>>>> +	}
>>>>>> +
>>>>>> +        return 0;
>>>>>>     }
>>>>>>     EXPORT_SYMBOL(devfreq_suspend_device);
>>>>>>     
>>>>>> @@ -893,9 +912,23 @@ EXPORT_SYMBOL(devfreq_suspend_device);
>>>>>>      */
>>>>>>     int devfreq_resume_device(struct devfreq *devfreq)
>>>>>>     {
>>>>>> +        int ret;
>>>>>
>>>>> Move 'ret' definition under 'if (devfreq->suspend_freq) {'
>>>>> because 'ret' is used if suspend_freq isn't zero.
>>>> OK
>>>
>>> If you change the devfreq_resume_device() according to my new comment,
>>> please ignore it.
>>>
>>>>>
>>>>>> +        unsigned long prev_freq;
>>>>>
>>>>> Remove prev_freq variable which is not used on this function.
>>>>> After calling devfreq_set_target, prev_freq is not used.
>>>> OK
>>>>>
>>>>>> +        u32 flags = 0;
>>>>>> +
>>>>>>     	if (!devfreq)
>>>>>>     		return -EINVAL;
>>>>>>     
>>>>>> +	if (devfreq->suspend_freq) {
> 
> In devfreq_resume_device(), it should check the 'devfreq->resume_freq'
> instead of 'devfreq->suspend_freq'.
OK, I will fix it.

Regards,
Lukasz

> 
> 
>>>>>> +		if (atomic_dec_return(&devfreq->suspend_count) >= 1)
>>>>>> +			return 0;
>>>>>> +
>>>>>> +		ret = devfreq_set_target(devfreq, devfreq->resume_freq,
>>>>>> +					 &prev_freq, flags);
>>>>>
>>>>> Remove the 'prev_freq' parameter.
>>>> OK
>>>>>
>>>>>> +		if (ret)
>>>>>> +			return ret;
>>>>>> +	}
>>>>>> +
>>>>>>     	if (!devfreq->governor)
>>>>>>     		return 0;
>>>
>>> Please change the code as following because you uses the following type
>>> in the devfreq_suspend_device(). If there is any special issue, please
>>> keep the same format in order to improve the readability.
>>>
>>> 	if (devfreq->governor) {
>>> 		ret = devfreq->governor->event_handler(devfreq,
>>> 				DEVFREQ_GOV_RESUME, NULL);
>>> 		if (ret)
>>> 			return ret;
>>> 	}
>>>
>>>
>> OK, I will change the code to keep the same format.
>> Thank you for the review.
>>
>> Regards,
>> Lukasz
>>
>>
>>
> 
> 
