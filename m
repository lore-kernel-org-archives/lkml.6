Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2674DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33D9218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HOWeEFZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391534AbfBMKsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:48:01 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35375 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbfBMKsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:48:01 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190213104758euoutp0134566e7d3fa5235cfa9e0440eb15a080~C5rLzrzHh2991829918euoutp01U
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 10:47:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190213104758euoutp0134566e7d3fa5235cfa9e0440eb15a080~C5rLzrzHh2991829918euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550054878;
        bh=nrrI1tC6qItzOsgPTtNwv6lZfcRq0a/Mp5Bt3wss15A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HOWeEFZG5PwQrFbVe0KhjEpGNa8L4tStpqK+6cZfccV3eFqwHdE+DoPGZKrGeM2mh
         c6/HVQBb90lZeGu7JrA9QfvSj7VODEv+8etk0Tfh9SJoWIdqD/1UoWvFjiX5MGoVSH
         pzr7sjrgAXjF1yWYxBPgL6V45/cadBbUIJLKSNfk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190213104757eucas1p17281a4f7d8fd88fd29cecce38ce5d7aa~C5rLSjHwn1636916369eucas1p13;
        Wed, 13 Feb 2019 10:47:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 2C.0C.04806.DD5F36C5; Wed, 13
        Feb 2019 10:47:57 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190213104756eucas1p2837f43bd184051babbb1380f8e6927dc~C5rKf3QmM1410214102eucas1p2D;
        Wed, 13 Feb 2019 10:47:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190213104756eusmtrp15dba3357a0c6f1aeb0abb70c9106c899~C5rKQ4Zmb3048830488eusmtrp1d;
        Wed, 13 Feb 2019 10:47:56 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-0b-5c63f5dd43ce
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A2.F4.04284.CD5F36C5; Wed, 13
        Feb 2019 10:47:56 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190213104755eusmtip27593b31083fe13e4170531229c5128a0~C5rJyI3bB2154221542eusmtip2M;
        Wed, 13 Feb 2019 10:47:55 +0000 (GMT)
Subject: Re: [PATCH v2 0/2] drivers: devfreq: fix and optimize workqueue
 mechanism
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, joel@joelfernandes.org,
        chris.diamand@arm.com, mka@chromium.org
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <376d00b9-0635-539a-3106-f83baa2e15ea@partner.samsung.com>
Date:   Wed, 13 Feb 2019 11:47:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <815961f8-f9c3-6d26-8811-880e4cd76cb9@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7djPc7p3vybHGJxbz2mxccZ6Votpny6z
        WFz/8pzVYlmDqsXZpjfsFpd3zWGz+Nx7hNFi7ZG77BafNzxmtLjduILN4vCbdlYHbo8189Yw
        esxuuMjisfDTV1aPvi2rGD0+b5ILYI3isklJzcksSy3St0vgylhw+iFLwWb7ik8XLzA1MPYZ
        dzFyckgImEh86ehg62Lk4hASWMEocebgcSYI5wujxPUp/9khnM+MEhsbnrHBtCz9dJ8ZxBYS
        WM4oseyqE0TRW0aJT3cXghUJC4RIrOk7AFTEwSEikCQx478NSJhZ4ASjRM9EK5Awm4CexI5V
        hSBhXgE3iY5jT9lAwiwCqhJnmnRAwqICERKHe98xQpQISpyc+YQFxOYUsJdY9mEdI8REcYlb
        T+YzQdjyEs1bZzODXCMhcIld4vydyUwgMyUEXCQ65ytDXC8s8er4FnYIW0bi9OQeFgi7WOJs
        xyqoD2sk2k/ugKqxljh8/CIryBhmAU2J9bv0IcKOEu97vkNN55O48VYQ4gI+iUnbpjNDhHkl
        OtqEIKo1JLb0XGCCsMUklq+Zxj6BUWkWkr9mIfllFpJfZiHsXcDIsopRPLW0ODc9tdg4L7Vc
        rzgxt7g0L10vOT93EyMwPZ3+d/zrDsZ9f5IOMQpwMCrx8K44mhQjxJpYVlyZe4hRgoNZSYT3
        xqfkGCHelMTKqtSi/Pii0pzU4kOM0hwsSuK81QwPooUE0hNLUrNTUwtSi2CyTBycUg2MSapN
        J3bN6brBs8Bhf7JQWcJ89kO2EqURWel3e7t6bGZ5/Z5uvGjFzrmu64TjCpzfujAdPZjGZhbZ
        9++9pWex2FXB28em3p76fYnVokfLZhhPzb01WXphYg7D9h+5E1KadR95faqsVFNzVme86Oo8
        nXfhmrcWjR3MstIn8xoM87IKX2bcWndLiaU4I9FQi7moOBEA3S17CEsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xe7p3vibHGNydImqxccZ6Votpny6z
        WFz/8pzVYlmDqsXZpjfsFpd3zWGz+Nx7hNFi7ZG77BafNzxmtLjduILN4vCbdlYHbo8189Yw
        esxuuMjisfDTV1aPvi2rGD0+b5ILYI3SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaP
        tTIyVdK3s0lJzcksSy3St0vQy1hw+iFLwWb7ik8XLzA1MPYZdzFyckgImEgs/XSfuYuRi0NI
        YCmjxLftrewQCTGJSfu2Q9nCEn+udbFBFL1mlJh/6w0LSEJYIERiTd8BZhBbRCBJYsrxB2BF
        zAInGCW2HT/FBNFxhEni4u1TQFUcHGwCehI7VhWCNPAKuEl0HHvKBhJmEVCVONOkAxIWFYiQ
        +Ph0HxNEiaDEyZlPwHZxCthLLPuwjhHEZhYwk5i3+SEzhC0ucevJfCYIW16ieets5gmMQrOQ
        tM9C0jILScssJC0LGFlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBMbmtmM/N+9gvLQx+BCj
        AAejEg/viqNJMUKsiWXFlbmHGCU4mJVEeG98So4R4k1JrKxKLcqPLyrNSS0+xGgK9NtEZinR
        5Hxg2sgriTc0NTS3sDQ0NzY3NrNQEuc9b1AZJSSQnliSmp2aWpBaBNPHxMEp1cAYysY17eiW
        1tzdSlXlXxxEToWkOfOJ7t3xfrPUWc57j0X4lfxPMtac0k7O8ig0Pil/75TfqioV5i73V96G
        vg+vXfv08rbl5hVFbb6PdZ41eK3YI7w3gWOnGefMoG6OMhn7+69nfTw1NfbLJuX6M9+Trljw
        zPzo/2zRn0Z28+Vr7736Vevu2vVBiaU4I9FQi7moOBEAtt+Ch+MCAAA=
X-CMS-MailID: 20190213104756eucas1p2837f43bd184051babbb1380f8e6927dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190211153030eucas1p19bd9a7eca565ca066ab00dc2243cfb46
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190211153030eucas1p19bd9a7eca565ca066ab00dc2243cfb46
References: <CGME20190211153030eucas1p19bd9a7eca565ca066ab00dc2243cfb46@eucas1p1.samsung.com>
        <1549899005-7760-1-git-send-email-l.luba@partner.samsung.com>
        <26e38213-630f-94bc-ff80-1cad708c7f83@samsung.com>
        <f60efa88-cf43-faed-55be-f90ce8f44f9e@partner.samsung.com>
        <815961f8-f9c3-6d26-8811-880e4cd76cb9@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 2/13/19 2:09 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 19. 2. 12. 오후 9:05, Lukasz Luba wrote:
>> Hi Chanwoo
>>
>> On 2/12/19 6:46 AM, Chanwoo Choi wrote:
>>> Hi Lukasz,
>>>
>>> On 19. 2. 12. 오전 12:30, Lukasz Luba wrote:
>>>> This patch set changes workqueue related features in devfreq framework.
>>>> First patch switches to delayed work instead of deferred.
>>>> The second switches to regular system work and deletes custom 'devfreq'.
>>>>
>>>> Using deferred work in this context might harm the system performance.
>>>> When the CPU enters idle, deferred work is not fired. The devfreq device's
>>>> utilization does not have to be connected with a particular CPU.
>>>> The drivers for GPUs, Network on Chip, cache L3 rely on devfreq governor.
>>>> They all are missing opportunity to check the HW state and react when
>>>> the deferred work is not fired.
>>>> A corner test case, when Dynamic Memory Controller is utilized by CPUs running
>>>> on full speed, might show x5 worse performance if the crucial CPU is in idle.
>>>
>>> The devfreq framework keeps the balancing between performance
>>> and power-consumption. It is wrong to focus on only either
>>> performance or power.
>> IMO it just does not work, please see my explanation below.
>>>
>>> This cover-letter focus on the only performance without any power-consumption
>>> disadvantages. It is easy to raise the performance with short sampling rate
>>> with polling modes. To get the performance, it is good as short as possible
>>> of period.
>> The cover-letter mentioned about missing functionality. The interface
>> has 'polling_ms' field, which driver developer would assume works.
>> I have test cases where it would not be called for seconds or even
>> never.
>> In your driver drivers/devfreq/exynos-bus.c polling_ms = 50
>> The driver is controlling many devices including Network-on-Chip (NOC).
>> It is using 'simple_ondemand' governor. When it is missing opportunity
>> to change the frequency, it can either harm the performance or power
>> consumption, depending of the frequency the device stuck on.
> 
> Almost everyone knew that DVFS governor is never perfect in the linux kernel.
> I don't want to discuss it with this too generic opinion which doesn't
> include the real measured data.
> 
>>
>>>
>>> Sometimes, when cpu is idle, the device might require the busy state.
>>> It is very difficult to catch the always right timing between them.
>> I will try to address them in the next patch set.
>>>
>>> Also, this patch cannot prevent the unneeded wakeup from idle state.
> 
> Please answer this question.
> 
> When release the real mobile product like galaxy phone,
> it is very important issue to remove the unneeded wakeup on idle state.
I would say that these devfreq wake-ups are important and people thought
that they are periodic and rely on it. Since the devfreq does not have
trace events no one knew what is actually happening inside.
Profiling the whole devfreq framework just for one product is not fair.
The devfreq clients are not only mobiles, there are other type of
embedded devices. There are embedded devices (based on TI, iMX, etc)
which are not powered from battery and are used i.e. for streaming video
from camera or image recognition.
> 
> 
>>> Apparently, it only focuses on performance without considering
>>> the power-consumption disadvantage. In the embedded device,
>>> the power-consumption is very important point. We can not ignore
>>> the side effect.
>> Power consumption is important, but we cannot rely on randomness
>> when we develop core features in a framework.
> 
> Sure, I agree that as I commented, the devfreq framework keep
> the balancing between performance and power-consumption.
> 
> Instead, this patch only focus on the performance without considering
> the power-consumption side-effect.
Please refer to patch set v3 which tries to address battery power
devices.

> 
>>>
>>> Always, I hope to improve the devfreq framwork more that older.
>>> But, frankly, it is difficult to agree because it only consider
>>> the performance without considering the side-effect.
>>>
>>> The power management framework always have to consider
>>> the power-consumption issue. This point is always true.
>> I do agree that the power vs. performance trade-off must be considered
>> in the devfreq framework. I have developed 2 additional patches and
> 
> You should only mention the posted patches on mailing list.
The patches are now posted on LKLM as v3 (after ~7h).
Frankly, I do not understand your behavior.
You were explicitly added on the review on Tizen kernel
on these patches (from 21 Jan) before even discussion on LKLM
happen. There was a few iteration and good review.
I just wanted to say that it was verified and questions about
power usage also appeared.

Secondly, people are referring to different patches in Android
kernel, ARM EAS kernel or like Matthias to LineageOS.
They are even referring to some research papers or trace analyses.
I have mentioned these patches and said that the same day they will
be posted on LKLM (which actually happen) because they were ready.
> 
>> I am going to post them today (you can now check them on Tizen gerrit,
>> change 198160).
> 
> It is not good to mention the some specific gerrit. I just only review
> the patches on mailing list. First of all, please answer the question
> on above
I have already replayed: devfreq is broken, drivers for GPUs, buses
cannot rely on it. Cost of a fix is in corner case: waking up CPU
a few times per second. Result: reliable periodic callback for drivers.
The way how it is implemented in v3 provides a tunable for driver
developer which saves some power when the device is less utilized:
'polling_idle_ms'.
Thermal framework also has two polling intervals: longer when the
temperature is lower than threshold (i.e. 1s) and shorter when the
temperature crosses threshold (i.e. 100ms).
Suggestion from Matthias that we could use power efficient wq
would have to involve changes in configs and verifications on
probably a lot of ARM platforms.
> 
>>
>> We cannot simply pin the *device* load with *CPU* load or idle state.
>> It is not an implication.
>> The device like GPU, NoC or Dynamic Memory Controller can have
>> completely different utilization (i.e in Exynos the GPU is connected
>> to DDR memory through NoC and DMC).
> 
> In order to get the high performance, the performance of GPU depends on CPU.
> h/w have depended on them tightly coupled. So, it is not easy to show
> the just relationship between them. We need the comprehensive measured data
> for both performance and power-consumption on all cases without the corner cases.
Are you sure that the fully loaded GPU implies that all CPUs are not in
idle? What about tasks pinned to CPU cgroups?
I will try create some small OpenCL kernel for Odroid XU4 and verify it.

The current devfreq implementation is missing trace events.
I have posted in v3 basic support. It would be a good starting point
for measurements and analysis.

Regards,
Lukasz
> 
>> Some developers who use OpenCL on GPU might be interested in this
>> improvement.>
>> Thank you for participating in the discussion on this issue.
>> It will need more development and iterations.
>> In my opinion currently there is one bug in the devfreq and one missing
>> feature to solve.
>>
>> Regards,
>> Lukasz
>>
>>>
>>>>
>>>> Changes:
>>>> v2:
>>>> - single patch split into two
>>>> - added cover letter
>>>>
>>>> link for the previous version and discussion:
>>>> https://marc.info/?l=linux-pm&m=154904631226997&w=2
>>>>
>>>> Regards,
>>>> Lukasz Luba
>>>>
>>>> Lukasz Luba (2):
>>>>     drivers: devfreq: change devfreq workqueue mechanism
>>>>     drivers: devfreq: change deferred work into delayed
>>>>
>>>>    drivers/devfreq/devfreq.c | 27 +++++++--------------------
>>>>    1 file changed, 7 insertions(+), 20 deletions(-)
>>>>
>>>
>>>
>>
>>
> 
> 
