Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DFBC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7A5208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vGACvYTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7A5208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeJRQA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:00:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40172 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeJRQA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:00:28 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181018080039euoutp020b3ebf78ac8e13a7e52200dfb694372b~epRaoEUQL0126501265euoutp02V
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 08:00:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181018080039euoutp020b3ebf78ac8e13a7e52200dfb694372b~epRaoEUQL0126501265euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539849639;
        bh=WkpcmVOCyvok1uZkgnTJIvW7omX6r/pAnmFbGtqS/FA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=vGACvYTafoNKfj4OPIN8ViYpNU/JZQkPBRjq3Sd5RpxRemBf5YJuRxSGvhFI7+GNH
         nJSEG80OL2/oOMhbkAU6xC1VJB+MKojINn4/z4/GqFATzq5d5we7hF3TMgR/2h9qIH
         jJyOacgjSXnUXCYjbxoS8a17/tblsjct7AkEh04o=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181018080038eucas1p14fa687b8bf9edcab3f74af953c7d8756~epRZfwwnL1936819368eucas1p12;
        Thu, 18 Oct 2018 08:00:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id CD.0F.04294.5AD38CB5; Thu, 18
        Oct 2018 09:00:37 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181018080037eucas1p2dcf7d2aaba718a5bb42e5da97a3bd06e~epRYnuXf71974219742eucas1p2D;
        Thu, 18 Oct 2018 08:00:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181018080037eusmtrp131e403c4d586c16c5498bf7011e3b188~epRYi-Zv80959709597eusmtrp1b;
        Thu, 18 Oct 2018 08:00:37 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-da-5bc83da5dc86
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2F.B0.04284.4AD38CB5; Thu, 18
        Oct 2018 09:00:36 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181018080036eusmtip1139ceed0c7e81b4d5676e534d4ee12c1~epRX1DQoO1077010770eusmtip1c;
        Thu, 18 Oct 2018 08:00:36 +0000 (GMT)
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        b.zolnierkie@samsung.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Date:   Thu, 18 Oct 2018 10:00:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5BC7622E.6000201@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjuO7cdh5PjzHzRMhklJqTZRT/oQpHQ6U/0oygUqlUHjdRsJ5ea
        0sXKec0szc2pXShtDcRLtmyULWmWRWllEYorrFDToq2LkZLHk+S/533e53mf74GPJdVf6UB2
        X8ohQZeiTdIwSqrl4dizxVdXd8Qv6S5fhn+PGhW4oaKextXuebjmZQ+Nc67UM7jsfhGBJyxV
        DH7Ramawu6gd4e62iwR2FrUR+ENjPYWrPGUkHnhXzODnZUYSG9p/kLjhO7/Wl7dWWxF/29Sn
        4Jvqwvkr9kGCb7TkMXxvj53h71VZFfyXu68YvrjZgnh3Y/BmZZxy1V4haZ9e0EWu2aVMHHXn
        06nng9LtXS50DL33z0deLHDLoXf0hCIfKVk1V4dg4P3vf4MHga0sh5IHN4LL52rRtKXp8mdC
        XtQiuDl2g5aHkUlL/zgjqfy4GHjcVzHpYNnZ3A4osARKGpLzUPDL5WAknuEiwGY5KMkpbiGc
        fDahkLA/tx3aXZemwlScLzwyDlAS9uLCwXDy/BRPcgHwdqCGkPF8uDViJqX7wBlZqMg9rpDN
        enA4iikpC7hY8LwJkQv4wZCzWSHjudB5rpCSsQhPDRZGxlmQ+8j2T7MSHji7aOkMyS2C+tZI
        mV4Hw8ZKWr7uA29GfOXX+EBpywVSplVgOK2W1WHQXPickPEcqLWWK0qQxjSjo2lGL9OMXqb/
        uRcRZUEBQpqYnCCIS1OEwxGiNllMS0mI2HMguRFN/sPOCafHhlr/7HYgjkUab5VLcMaraa1e
        zEh2IGBJzWzVkeiOeLVqrzYjU9Ad2KlLSxJEBwpiKU2A6lp1Q7yaS9AeEvYLQqqgm94SrFfg
        MWQlnBsizu4QfvKlka9D63JtTPbPTbej9adWBL0eclNnXLOCO8w11xao1vcwWzJK7E9ajRvH
        GuJi+r1XDv8wxD7eaV4Ste3oihe9oXm13ff5cXtiZsCdU/0hg9cL2rr0Cf2Vqz7uzxoPWb3R
        /9NDemtny3d/IseUfcfbESaYQ7/FpWsoMVEbFU7qRO1fI/eGwIMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42I5/e/4Xd0ltieiDfa9trb49W4mu8XGGetZ
        LeZ9lrWYf+Uaq0Xz4vVsFlMP9jJZ/Fs1l83i8q45bBafe48wWlw6sIDJ4njvASaLp5vWs1jM
        /TKV2eLJwz42iwtTZzJbdBz5xmyx8auHg6DHmnlrGD12zrrL7rF5hZbH4j0vmTw2repk87hz
        bQ+bx/65a9g93u+7yubRt2UVo8fnTXIBXFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqG
        xuaxVkamSvp2NimpOZllqUX6dgl6Ge8+d7EWTJGu2HPxAWMD4yPRLkZODgkBE4nNi94wdTFy
        cQgJLGWU+DX5EiNEQkxi0r7t7BC2sMSfa11sEEWvGSWWn+wFKxIWMJc4dXcGmC0iECdxZitE
        EbPADxaJyztvQ439yyzRdOY10CgODjYBPYkdqwpBGngF3CS2XDzIAmKzCKhKtJz/B7ZNVCBC
        YvXyF6wQNYISJ2c+AavhFNCS6GiZAraMWcBMYt7mh8wQtrjErSfzmSBseYntb+cwT2AUmoWk
        fRaSlllIWmYhaVnAyLKKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMA1sO/Zz8w7GSxuDDzEK
        cDAq8fA+SD0eLcSaWFZcmXuIUYKDWUmEt9rsRLQQb0piZVVqUX58UWlOavEhRlOg5yYyS4km
        5wNTVF5JvKGpobmFpaG5sbmxmYWSOO95g8ooIYH0xJLU7NTUgtQimD4mDk6pBkarKYJB/fYr
        u3vKF147L7B9sVUnY0nONkle6f1LnEtdarluP5QOZpE8rfKx7NydxcJJhzJOXfB81dhh32Ja
        nXSl8/j1nvVvHDfsWxUvfiW+bKv8tB9CWWxFWyxdmFMtVcT+55UVyTM9OPAyfLt8vwnLH92+
        DPmnIvP7nIUW2TyUvdd/M1TrqBJLcUaioRZzUXEiAJRNRT8ZAwAA
Message-Id: <20181018080037eucas1p2dcf7d2aaba718a5bb42e5da97a3bd06e~epRYnuXf71974219742eucas1p2D@eucas1p2.samsung.com>
X-CMS-MailID: 20181018080037eucas1p2dcf7d2aaba718a5bb42e5da97a3bd06e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181009162509epcas1p4fdd2e23039caa24586a4a52c6d2e7336
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181009162509epcas1p4fdd2e23039caa24586a4a52c6d2e7336
References: <CGME20181009162509epcas1p4fdd2e23039caa24586a4a52c6d2e7336@epcas1p4.samsung.com>
        <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
        <20181010153553eucas1p1b8f74f4aa45751ef029805fd118affc1~cSUmU58-F2963929639eucas1p1L@eucas1p1.samsung.com>
        <5BBE3751.7000908@linaro.org>
        <20181011111025eucas1p2125db99d798a60a8e38da97c2a1c7436~ciWHHd0YW0102601026eucas1p2b@eucas1p2.samsung.com>
        <CAKfTPtBZam-+3sbKa+XffhoxkPX_ndTLoxioVwU-iz0qTnnPAw@mail.gmail.com>
        <5BC7622E.6000201@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/17/2018 06:24 PM, Thara Gopinath wrote:
> On 10/16/2018 01:11 PM, Vincent Guittot wrote:
>> Hi Lukasz,
>>
>> On Thu, 11 Oct 2018 at 13:10, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>>
>>>
>>>
>>> On 10/10/2018 07:30 PM, Thara Gopinath wrote:
>>>> Hello Lukasz,
>>>>
>>>> On 10/10/2018 11:35 AM, Lukasz Luba wrote:
>>>>> Hi Thara,
>>>>>
>>>>> I have run it on Exynos5433 mainline.
>>>>> When it is enabled with step_wise thermal governor,
>>>>> some of my tests are showing ~30-50% regression (i.e. hackbench),
>>>>> dhrystone ~10%.
>>>>
>>>> That is interesting. If I understand correctly, dhrystone spawns 16
>>>> threads or so and floods the system. In "theory", such a test should not
>>>> see any performance improvement and degradation. What is the thermal
>>>> activity like in your system? I will try running one of these tests on
>>>> hikey960.
>>> I use this dhrystone implementation:
>>> https://github.com/Keith-S-Thompson/dhrystone/blob/master/v2.2/dry.c
>>> It does not span new threads/processes and I pinned it to a single cpu.
>>>
>>> My thermal setup is probably different than yours.
>>> You have (on hikey960) probably 1 sensor for whole SoC and one thermal
>>> zone (if it is this mainline file:
>>> arch/arm64/boot/dts/hisilicon/hi3660.dtsi).
>>> This thermal zone has two cooling devices - two clusters with dvfs.
>>> Your temperature signal read out from that sensor is probably much
>>> smoother. When you have sensor inside cluster, the rising factor
>>> can be even 20deg/s (for big cores).
>>> In my case, there are 4 thermal zones, each cluster has it's private
>>> sensor and thermal zone. There is no 'SoC sensor' or 'PCB sensor',
>>> which is recommended for IPA.
>>>>>
>>>>> Could you tell me which thermal governor was used in your case?
>>>>> Please also share the name of that benchmark, i will give it a try.
>>>>> Is it single threaded compute-intensive?
>>>>
>>>> Step-wise governor.
>>>> I use aobench which is part of phoronix-test-suite.
>>>>
>>>> Regards
>>>> Thara
>>>>
>>> I have built this aobench and run it pinned to single big cpu:
>>> time taskset -c 4 ./aobench
>>
>> Why have you pinned the test only on CPU4 ?
>> Goal of thermal pressure is to inform the scheduler of reduced compute
>> capacity and help the scheduler to take better decision in tasks
>> placement.
> 
> Hi Lukasz,
> 
> I agree with Vincent's observation. I had not seen this earlier. Pinning
> a task to a cpu will obviously prevent migration. The performance
> regression could be due to as Vincent mentioned below other tasks in the
> system. On another note, which cpufreq governor are you using? Is the
> core being bumped up to highest possible OPP during the test?
The governor is ondemand. No, it is not at highest OPP.
Could you send me the needed test configuration and condition?
We would then align in this area.

Regards,
Lukasz
> 
> Regards
> Thara
>> So I would not expect perf impact on your test as the bench will stay
>> pinned on the cpu4
>> That being said you obviously have perf impact as shown below in your results
>> And other tasks on the system are not pinned and might come and
>> disturb your bench
>>
>>> The results:
>>> 3min-5:30min [mainline]
>>> 5:15min-5:50min [+patchset]
>>>
>>> The idea is definitely worth to investigate further.
>>
>> Yes I agree
>>
>> Vincent
>>>
>>> Regards,
>>> Lukasz
>>>
>>>
>>>
> 
> 
