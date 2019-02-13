Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7F0C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D9E20643
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DdkOrrrv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388178AbfBMNAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:00:32 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:32947 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730451AbfBMNAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:00:31 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190213130030euoutp02cf99455f8ccdf189dbee330a1a809757~C7e55DpEU0188801888euoutp02N
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:00:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190213130030euoutp02cf99455f8ccdf189dbee330a1a809757~C7e55DpEU0188801888euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550062830;
        bh=bpPKzwesBV6HdybY3gutnR/+vzN1yzK8UODNlpERpxU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=DdkOrrrvrMdkCYnsvg+1+N/19ThVAFaSNy+mOCyJuHvOPibrH5fNjeFqZgK7LRRqw
         6zgvY6q74vffkFvvoAZ3to84qqCR6Dy4R9V6/aZbE+zUPWhT2eI4i6+jr9Z6QJ1uuS
         47YchJ5+9VtzCqrenUWErzMdL4nLVEmVtziq/yak=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190213130029eucas1p2895b800a765a2bf64fa764cd85a3d577~C7e5F42El2946929469eucas1p2b;
        Wed, 13 Feb 2019 13:00:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6A.DE.04806.CE4146C5; Wed, 13
        Feb 2019 13:00:29 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190213130028eucas1p2c91c56e8b8672b479417b5b3e6312233~C7e4S1h490426404264eucas1p2R;
        Wed, 13 Feb 2019 13:00:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190213130028eusmtrp24e1af0d8f05cdd2bca6c94e2bf183d48~C7e4D9VQC0937809378eusmtrp29;
        Wed, 13 Feb 2019 13:00:28 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-e2-5c6414ec7b4f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D6.27.04284.CE4146C5; Wed, 13
        Feb 2019 13:00:28 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190213130027eusmtip1e5e198082688fdc003e82eef2bae39a0~C7e3iQgKZ0208302083eusmtip1z;
        Wed, 13 Feb 2019 13:00:27 +0000 (GMT)
Subject: Re: [PATCH v2 0/2] drivers: devfreq: fix and optimize workqueue
 mechanism
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        joel@joelfernandes.org, chris.diamand@arm.com,
        Viresh Kumar <viresh.kumar@linaro.org>
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <90bbff25-1c9c-127c-13a7-91a5f4fe666e@partner.samsung.com>
Date:   Wed, 13 Feb 2019 14:00:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213003044.GV117604@google.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsWy7djPc7pvRVJiDN71s1psnLGe1WLap8ss
        Fte/PGe1WNaganG26Q27xeVdc9gsPvceYbRYe+Quu8XnDY8ZLW43rmCzOPymHajrq4cDj8ea
        eWsYPWY3XGTxWPjpK6vHnWt72Dz6tqxi9Pi8SS6ALYrLJiU1J7MstUjfLoErY/PEmoI5LhVn
        P/9gaWCcYdbFyMEhIWAisX5/TBcjF4eQwApGiabpvWwQzhdGifvtW1ghnM+MEiu7VjJ1MXKC
        dTQe2wVVtZxRYs/8rVDOW0aJidNfs4JUCQuESKzpO8AMYosIaEg8+X2eEaSIWeAAk8SzpSvY
        QJazCehJ7FhVCFLDK+AmsaD/FQuIzSKgKnGg5yUbiC0qECFxuPcdI0SNoMTJmU/AajgFDCXu
        NN0Bm88sIC5x68l8JghbXqJ562xmkF0SAtfYJTa+XM0OcbaLxIv+dywQtrDEq+NboOIyEv93
        zod6rVjibMcqNgi7RqL95A6oGmuJw8cvsoLczCygKbF+lz5E2FHifc93Jkg48knceCsIcQKf
        xKRt05khwrwSHW1CENUaElt6LkAtEpNYvmYa+wRGpVlIHpuF5JlZSJ6ZhbB3ASPLKkbx1NLi
        3PTUYuO81HK94sTc4tK8dL3k/NxNjMC0dfrf8a87GPf9STrEKMDBqMTDWyGUEiPEmlhWXJl7
        iFGCg1lJhPcLH1CINyWxsiq1KD++qDQntfgQozQHi5I4bzXDg2ghgfTEktTs1NSC1CKYLBMH
        p1QDo8PMsz6zDG0nrgiNUlbiKlnsuzVuze2lUzUVGy0N/tob+0q83+Wu45Ys63Co317HPezx
        +QsrWWKrT2+L82N3uyZ5Qe+CN0OGmWJj5YPHbwQjnvUtFFy07eWrCI1tQekK6TW5V0rNPNjL
        T1xscmyr3mWzju/J5OrrPKdvzuo4Z8JuXcl98YatEktxRqKhFnNRcSIA5AjwY1cDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsVy+t/xu7pvRFJiDG5N5bfYOGM9q8W0T5dZ
        LK5/ec5qsaxB1eJs0xt2i8u75rBZfO49wmix9shddovPGx4zWtxuXMFmcfhNO6vFxq8eDjwe
        a+atYfSY3XCRxWPhp6+sHneu7WHz6NuyitHj8ya5ALYoPZui/NKSVIWM/OISW6VoQwsjPUNL
        Cz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYzNE2sK5rhUnP38g6WBcYZZFyMnh4SAiUTj
        sV1sXYxcHEICSxklJh28zAaREJOYtG87O4QtLPHnWhdU0WtGiT3rG8ESwgIhEmv6DjCD2CIC
        GhJPfp9nBCliFjjAJHGz7zMTRMddJomJP5YCORwcbAJ6EjtWFYI08Aq4SSzof8UCYrMIqEoc
        6HkJtllUIELi49N9TBA1ghInZz4Bq+EUMJS403QHbBmzgJnEvM0PoWxxiVtP5jNB2PISzVtn
        M09gFJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzBatx37uXkH
        46WNwYcYBTgYlXh4K4RSYoRYE8uKK3MPMUpwMCuJ8H7hAwrxpiRWVqUW5ccXleakFh9iNAV6
        biKzlGhyPjCR5JXEG5oamltYGpobmxubWSiJ8543qIwSEkhPLEnNTk0tSC2C6WPi4JRqYAxh
        Ts2azhfwRiDW1tntnfzTuMeOq9Jmu3h7Cl/VEVA78yrCSrbD16r/RyVr2qO8p1djZr//uubr
        2yxnVaGctF4/PuYNd1bGGUr91hM4FPrsgWVN+KrKlS87r4RmnN69cYbfvodFBROW1ZTs39RT
        Ii+mpf5L99zF1KL/pluzFvXsSn/ZnMOrp8RSnJFoqMVcVJwIADo1fansAgAA
X-CMS-MailID: 20190213130028eucas1p2c91c56e8b8672b479417b5b3e6312233
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190211153030eucas1p19bd9a7eca565ca066ab00dc2243cfb46
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190211153030eucas1p19bd9a7eca565ca066ab00dc2243cfb46
References: <CGME20190211153030eucas1p19bd9a7eca565ca066ab00dc2243cfb46@eucas1p1.samsung.com>
        <1549899005-7760-1-git-send-email-l.luba@partner.samsung.com>
        <26e38213-630f-94bc-ff80-1cad708c7f83@samsung.com>
        <20190212193229.GT117604@google.com>
        <1356584e-1812-6768-72af-931c07d925a8@partner.samsung.com>
        <20190213003044.GV117604@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2/13/19 1:30 AM, Matthias Kaehlcke wrote:
> Hi Lukasz,
> 
> On Tue, Feb 12, 2019 at 10:20:07PM +0100, Lukasz Luba wrote:
>> Hi Matthias,
>>
>> On 2/12/19 8:32 PM, Matthias Kaehlcke wrote:
>>> Hi,
>>>
>>> On Tue, Feb 12, 2019 at 02:46:24PM +0900, Chanwoo Choi wrote:
>>>> Hi Lukasz,
>>>>
>>>> On 19. 2. 12. 오전 12:30, Lukasz Luba wrote:
>>>>> This patch set changes workqueue related features in devfreq framework.
>>>>> First patch switches to delayed work instead of deferred.
>>>>> The second switches to regular system work and deletes custom 'devfreq'.
>>>>>
>>>>> Using deferred work in this context might harm the system performance.
>>>>> When the CPU enters idle, deferred work is not fired. The devfreq device's
>>>>> utilization does not have to be connected with a particular CPU.
>>>>> The drivers for GPUs, Network on Chip, cache L3 rely on devfreq governor.
>>>>> They all are missing opportunity to check the HW state and react when
>>>>> the deferred work is not fired.
>>>>> A corner test case, when Dynamic Memory Controller is utilized by CPUs running
>>>>> on full speed, might show x5 worse performance if the crucial CPU is in idle.
>>>>
>>>> The devfreq framework keeps the balancing between performance
>>>> and power-consumption. It is wrong to focus on only either
>>>> performance or power.
>>>>
>>>> This cover-letter focus on the only performance without any power-consumption
>>>> disadvantages. It is easy to raise the performance with short sampling rate
>>>> with polling modes. To get the performance, it is good as short as possible
>>>> of period.
>>>>
>>>> Sometimes, when cpu is idle, the device might require the busy state.
>>>> It is very difficult to catch the always right timing between them.
>>>>
>>>> Also, this patch cannot prevent the unneeded wakeup from idle state.
>>>> Apparently, it only focuses on performance without considering
>>>> the power-consumption disadvantage. In the embedded device,
>>>> the power-consumption is very important point. We can not ignore
>>>> the side effect.
>>>>
>>>> Always, I hope to improve the devfreq framwork more that older.
>>>> But, frankly, it is difficult to agree because it only consider
>>>> the performance without considering the side-effect.
>>>>
>>>> The power management framework always have to consider
>>>> the power-consumption issue. This point is always true.
>>>
>>> I missed the impact of forcing a CPU out of an idle state and/or not
>>> allowing it to enter a more power efficient state. I agree that this
>>> should be avoided.
>> It would be good to have some real world scenarios for comparison:
>> w/ and w/o this change, i.e. it is 5% or 50% more power used.
> 
> If you have data please share :)
I will try to measure it. I have some data which refer to CPU hotplug
and generic data regarding ARM big.LITTLE.
It is a mobile on my desk.
When one CPU of ARM big is sent offline power drops ~12mW comparing
to WFI idle which was previous state. The same for LITTLE ~12mW.
When the last CPU in the cluster is sent offline, whole culster
is switched off and power drops ~50mW.
The LITTLE core can consume ~250mW at max speed.
Energy Aware Scheduler is now merged IIRC, so if it has to choose
which core wake up for idle, it will take LITTLE not big.
For older platforms which has Cortex-A9 500mW is also better estimation.

> 
> Though I also imagine there will be quite some variation between
> different systems/platforms.
True.
> 
>> I have patches that tries to mitigate wake-ups when there is small
>> utilization. Let's make it tunable and involve driver developers.
>> They will decide how much impact on the system power usage they
>> introduce.
> 
> Great!
> 
>>> I wonder if using a power-efficient workqueue could help here:
>>>
>>>     Instead of running work on the local CPU, the workqueue core asks the
>>>     scheduler to provide the target CPU for the work queued on unbound
>>>     workqueues (which includes those marked as power-efficient). So they
>>>     will not get pinned on a single CPU as can happen with regular
>>>     workqueues.
>>>
>>>     https://lwn.net/Articles/731052/
>>>
>>>
>>> Since this series also changes from a custom to system workqueue it
>>> seems worth to mention that there are power-efficient system workqueues:
>>>
>>> system_power_efficient_wq
>>> system_freezable_power_efficient_wq
>>>
>>>
>>> In case a power-efficient workqueue is suitable in principle there
>>> would still be a problem though: the feature is currently disabled by
>>> default, hence devfreq couldn't really rely on it. It is enabled in
>>> the arm64 defconfig though, so at least devices on this architecture
>>> would benefit from it. Also power-efficient workqueues might be
>>> enabled by default in the future as the scheduler becomes more energy
>>> aware.
>> Regarding this CPU idle cost worries.
>> IIRC the new energy model does not even consider idle costs of the CPU.
>> It would be good to know the measurements, i.e. worst case scenario:
>> waking up 1 (of 4 or 8) CPU from idle 30 times per second for let's
>> say 100 us. It is 3 ms / 1000 ms * running energy cost i.e. 250mW.
>> Thus, 0.75mW.
> 
> I'm not an expert in this area, but your example seems too optimistic
> You are just accounting for the pure runtime, not for the cost of
> entering and exiting an idle state. Let's take a SDM845 idle state as
> example:
> 
> C0_CPU_PD: c0-power-down {
>    ...
>    entry-latency-us = <350>;
>    exit-latency-us = <461>;
>    min-residency-us = <1890>;
>    ...
> };
> 
> https://patchwork.kernel.org/patch/10661319/
> 
> That's 811us for entering and exiting the idle state. At an
> intermediate OPP (1.8 GHz) the power consumption is 505mW, according
> to the Energy Model. I'm ignoring the actual execution time, since I
> tend to agree with you that the monitoring should be done, unless it
> has a really unreasonable cost. That leaves us with 30 * 811us =
> 24.3ms and 24.3ms / 1000 ms * 505mW = 12.3mW.
You are probably taking ARM 'big' core wake-up from deeper that WFI 
idle. I was referring to ARM LITTLE 250mW.
It is also not 100% that the schedule work will wake up CPU which
is currently in deepest idle.

A short array would create a better picture of the use cases.
The question is also probability of occurrence for each of these cases.
For first two CPU state it would be a power cost lost during additional
rescheduling to/from workqueue task, which takes i.e. 2*5 us * 30 times.

CPU state ->|  running | idle    | idle clock | idle, pwr  |
------------|   (C0)   | WFI (C1)|  gated (C2)| gated (C3) |
architecture|          |         |            |            |
------V-----------------------------------------------------
ARM big     |    <1mW  | <1mW    |   ~12mW    |  ~12mW     |
ARM LITTLE  |    <1mW  | <1mW    |   ~6mW     |  ~6mW      |
MIPS
PowerPC


> 
>> In my opinion it is not a big cost. In most cases the system is still
>> doing some other work. It is worth to mention here that on mobiles
>> when the power button is hit the full suspend is called which freezes
>> all tasks, devices and power consumption is ~15mW. Thus, the system
>> suspend is out of scope here.
> 
> I agree that system suspend is out of scope.
> 
>> As I replayed to Chanwoon for the same email: in my opinion current
>> devfreq is broken.
>> It was probably developed in times where there was 1 CPU (maybe 2)
>> and idle state of CPU would be a good hint to not to check devfreq
>> devices.
> 
> IIUC the use of a power-efficient workqueues would address the problem
> of waking up a CPU in idle state, however as mentioned earlier by
> default this feature is disabled (except for arm64). How about
> switching to system_power_efficient_wq and use INIT_DELAYED_WORK if
> CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y (or check if the workqueue in
> question has WQ_UNBOUND set?) and INIT_DEFERRABLE_WORK otherwise? It's
> not ideal, but a possible improvement.
I think it would be to complicated to maintain because different
platforms might use different mechanisms.
I would suggests that we could just follow mechanism in thermal
framework. I have never faced any issue with delayed work there,
while working on IPA.
They use 'system_freezable_power_efficient_wq' and INIT_DELAYED_WORK().
https://elixir.bootlin.com/linux/v5.0-rc6/source/drivers/thermal/thermal_core.c#L293
https://elixir.bootlin.com/linux/v5.0-rc6/source/drivers/thermal/thermal_core.c#L1281
They have these two polling intervals, though.

Regards,
Lukasz

> 
> Cheers
> 
> Matthias
> 
> 
