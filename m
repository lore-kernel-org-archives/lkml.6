Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA19C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D023222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="q7dohMPP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403854AbfBMOwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:52:54 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46213 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfBMOwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:52:53 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190213145251euoutp027f4d6ce62aecf33590ef24a092c8a260~C9A-_v1PC0078700787euoutp02P
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 14:52:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190213145251euoutp027f4d6ce62aecf33590ef24a092c8a260~C9A-_v1PC0078700787euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550069571;
        bh=pVrUwqnUPjrxJQiTr6JOTk6QnHXkFvCrW4hd6oReHvA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=q7dohMPPisqQCwLeqa8iLRDrpAPphAS1msizo8AfSL+iMyqh8tkhJ5ds0WuYly977
         D+ddZFOFG6nkmv44HJoI0z3H6Y/VXtgo0Y4sxJEc+R8uWwTpQzTEeXfcttcphTFtiG
         ojErCsGXc0URfkkSaqosLqmjL66hWuVtuNeHwlyY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190213145250eucas1p21fc4767693427b830a49db86e21c433f~C9A-SOkM22279922799eucas1p2n;
        Wed, 13 Feb 2019 14:52:50 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E5.F2.04441.24F246C5; Wed, 13
        Feb 2019 14:52:50 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190213145249eucas1p25320b36cd88b950ee5d89ac40f5a4072~C9A_kPdwO3244332443eucas1p2Q;
        Wed, 13 Feb 2019 14:52:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190213145249eusmtrp2f008ca137f3a731c4fe0d6e5ec42fa7a~C9A_VUCHU0821308213eusmtrp2c;
        Wed, 13 Feb 2019 14:52:49 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-23-5c642f4299c7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id ED.C6.04284.14F246C5; Wed, 13
        Feb 2019 14:52:49 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190213145248eusmtip1d6c99f37afcad212d46ad9330b7e7c0f~C9A9iWdT83107631076eusmtip1d;
        Wed, 13 Feb 2019 14:52:48 +0000 (GMT)
Subject: Re: [PATCH v3 0/7] drivers: devfreq: fix and optimize workqueue
 mechanism
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, joel@joelfernandes.org,
        chris.diamand@arm.com, mka@chromium.org, rostedt@goodmis.org,
        mingo@redhat.com
Message-ID: <3ad228a9-71af-2604-a8b4-8c49f1ca1038@partner.samsung.com>
Date:   Wed, 13 Feb 2019 15:52:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <80cd346e-a0a3-ff66-40a6-c15fd23ba904@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7djP87pO+ikxBhdOCFhsnLGe1WLap8ss
        Fte/PGe1WNaganG26Q27xeVdc9gsPvceYbRYe+Quu8WlAwuYLD5veMxocbtxBZvFvo4HTBaH
        37SzOvB6rJm3htFjdsNFFo+WfbfYPRZ++srq8X7fVTaPvi2rGD0+b5ILYI/isklJzcksSy3S
        t0vgyjg63bTgmG5Fw8brbA2MC1W7GDk4JARMJHZsLeti5OIQEljBKPFm3n5mCOcLo8S2hu+M
        EM5nRonzB7ezdTFygnX82/uGHSKxnFFi9o53TBDOW0aJfU+3M4FUCQuESMz8tYkFZAebgJ7E
        jlWFIKaIQJLEjP82IOXMAh8ZJTYeaGcBKecVcJP4+ukKmM0ioCrx+/NrsDGiAhESh3vfMULU
        CEqcnPkErIZTwF3iXvctVhCbWUBc4taT+UwQtrxE89bZYC9ICLxll2jc9grqaheJ6XO/M0PY
        whKvjm9hh7BlJP7vhGiWECiWONuxCqq+RqL95A6oGmuJw8cvsoI8wCygKbF+lz5E2FHi7fLb
        LJBg5JO48VYQ4gQ+iUnbpjNDhHklOtqEIKo1JLb0XIBaJCaxfM009gmMSrOQPDYLyTOzkDwz
        C2HvAkaWVYziqaXFuempxYZ5qeV6xYm5xaV56XrJ+bmbGIGp7PS/4592MH69lHSIUYCDUYmH
        t0IoJUaINbGsuDL3EKMEB7OSCG+hDlCINyWxsiq1KD++qDQntfgQozQHi5I4bzXDg2ghgfTE
        ktTs1NSC1CKYLBMHp1QD49xkfxNWtROF+wqzubhvnjuVKKGZsDhBnfMa096ZF6qPKS+JaZRI
        bZTpXm/VsuQ5f91MLU4ZIa1kr/X6RvPjvlkHG9k9ZToYdEWK/c2EX6c2JIV8/e5Y6FSR6Nd+
        +W703/1NG7kTDQoqD5Rc2P7H6aBArrtylmCf3bRT9xdxn+GPiDfSf6upxFKckWioxVxUnAgA
        AZiRUWEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xu7qO+ikxBssPCVpsnLGe1WLap8ss
        Fte/PGe1WNaganG26Q27xeVdc9gsPvceYbRYe+Quu8WlAwuYLD5veMxocbtxBZvFvo4HTBaH
        37SzOvB6rJm3htFjdsNFFo+WfbfYPRZ++srq8X7fVTaPvi2rGD0+b5ILYI/SsynKLy1JVcjI
        Ly6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQyzg63bTgmG5Fw8brbA2M
        C1W7GDk5JARMJP7tfcPexcjFISSwlFHiyMdjrBAJMYlJ+7azQ9jCEn+udbFBFL1mlJj9ZyoT
        SEJYIERi5q9NLF2MHBxsAnoSO1YVgoRFBJIkphx/AFbPLPCRUeLQswNQGyYwSVz8/4MNpIpX
        wE3i66crLCA2i4CqxO/Pr8GGigpESHx8uo8JokZQ4uTMJ2A1nALuEve6b4FdxyxgJjFv80Nm
        CFtc4taT+UwQtrxE89bZzBMYhWYhaZ+FpGUWkpZZSFoWMLKsYhRJLS3OTc8tNtQrTswtLs1L
        10vOz93ECIzhbcd+bt7BeGlj8CFGAQ5GJR7eCqGUGCHWxLLiytxDjBIczEoivIU6QCHelMTK
        qtSi/Pii0pzU4kOMpkDPTWSWEk3OB6aXvJJ4Q1NDcwtLQ3Njc2MzCyVx3vMGlVFCAumJJanZ
        qakFqUUwfUwcnFINjPYLWhtL7KbW/XuQahvF7PT2a5wgQ+HhFw+0lrPw1LF4rraIdtl/6uob
        HdYjE/k+iN/P/B1bdpPfti30isjU6GebfY2mHfFYkn06uiuN++LLwpbjog2TJL+161jaRKfP
        b1roa/F2x83At/Z8+pN2XMpy2/Plrmd9VVOib0b4PWcjLV++bmYBJZbijERDLeai4kQAz6iV
        evcCAAA=
X-CMS-MailID: 20190213145249eucas1p25320b36cd88b950ee5d89ac40f5a4072
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190212222422eucas1p1624203db4db3e495035820dea542e23a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190212222422eucas1p1624203db4db3e495035820dea542e23a
References: <CGME20190212222422eucas1p1624203db4db3e495035820dea542e23a@eucas1p1.samsung.com>
        <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <d9245497-ec63-4a5d-6c00-0ec2954af735@samsung.com>
        <80cd346e-a0a3-ff66-40a6-c15fd23ba904@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias, Chanwoo,

Regarding some measurements data for our approximations.

I have found a comprehensive power consumption measurements
for i.MX6 dual/quad (Cortex-A9) boards.
https://cache.freescale.com/files/32bit/doc/app_note/AN4509.pdf

The boards have DDR3 memories not LPDDR3 PoP but it is also measured
and mentioned explicitly.
There are many use case scenarios covered, which use different devices
in the SoC.

Regards,
Lukasz


On 2/13/19 12:14 PM, Lukasz Luba wrote:
> Hi Chanwoo,
> 
> On 2/13/19 1:18 AM, Chanwoo Choi wrote:
>> On 19. 2. 13. 오전 7:23, Lukasz Luba wrote:
>>> This patch set changes workqueue related features in devfreq framework.
>>> First patch switches to delayed work instead of deferred.
>>> The second switches to regular system work and deletes custom 'devfreq'.
>>>
>>> Using deferred work in this context might harm the system performance.
>>> When the CPU enters idle, deferred work is not fired. The devfreq 
>>> device's
>>> utilization does not have to be connected with a particular CPU.
>>> The drivers for GPUs, Network on Chip, cache L3 rely on devfreq 
>>> governor.
>>> They all are missing opportunity to check the HW state and react when
>>> the deferred work is not fired.
>>> A corner test case, when Dynamic Memory Controller is utilized by 
>>> CPUs running
>>> on full speed, might show x5 worse performance if the crucial CPU is 
>>> in idle.
>>>
>>> There was a discussion regarding v2 that the power usage because of 
>>> waking up
>>
>> We have not yet finished the any discussion. We only just had a few reply
>> and you didn't wait for any reply from other. As I already commented
>> on exynos5422-dmc series, please don't send the next patch
>> without any final agreement.
>>
>> In this series, patch1/patch2 are same at version 2 patchset.
>> Even if we need to discuss more them, you just send same patches
>> without any agreement among reviewers. At least, you have to wait the 
>> reply
>> instead of just sending the new patchset. It is basic review rule on 
>> mailing list.
> I think you are blocking the fixes.
> Matthias is currently fixing devfreq governors which lack 'case SUSPEND'
> and he is interested in these v3. I have fixed a month ago issue with
> system suspend and OPP state of devfreq devices, which Tobias was rising
> and sending patches a few years ago, but you have blocked them.
> 
> These version is ready for comments regarding 'battery powered devices'.
> The v3 has introduced approach for 2 polling intervals similar to
> thermal framework.
> It also has trace events. The trace events are *really* important in
> this discussion because we need some measurements.
> 
> You said:
> 'When release the real mobile product like galaxy phone,
> it is very important issue to remove the unneeded wakeup on idle state.'
> Was it a real reason for profiling the devfreq framework and core
> workqueue mechanism? There are embedded devices which are not using
> battery and probably developers were not aware because there was no
> traces which could give any information about devfreq behavior.
> Power is important, performance is important but relaying on randomness
> is not the best solution. As I said earlier, your driver can stuck on
> highest OPP waiting for next callback which will not come...
> 
> Regards,
> Lukasz
>>
>>
>>> an idle CPU would be too high. In my opinion it won't and fixing bug 
>>> is more
>>> important than < 1% more power used [1].
>>> I have addressed also this issue. In this patch set there is a mechanism
>>> which prevents from to frequent checks when there is no need.
>>> When the device enters its lowest state (OPP) the framework sets polling
>>> interval to 'polling_idle_ms'. In default Kconfig it is 500ms, so 2 
>>> times per
>>> second.
>>> It is tunable from the sysfs interface per device, thus driver 
>>> developer can
>>> experiment and choose best intervals for the system.
>>>
>>> Changes:
>>> v3:
>>> - reordered first two patches
>>> - added functionality to lower power consumption when the device is 
>>> less busy;
>>>    there is a new polling interval enabled when device enters lowest 
>>> frequency;
>>> - added trace events to capture the behaviour of the system
>>> v2:
>>> - single patch split into two
>>> - added cover letter
>>>
>>> link for the previous version and discussion:
>>> https://marc.info/?l=linux-pm&m=154989907416072&w=2
>>> https://marc.info/?l=linux-pm&m=154904631226997&w=2
>>>
>>> Regards,
>>> Lukasz Luba
>>>
>>> [1] https://marc.info/?l=linux-kernel&m=155000641622443&w=2
>>>
>>> Lukasz Luba (7):
>>>    drivers: devfreq: change deferred work into delayed
>>>    drivers: devfreq: change devfreq workqueue mechanism
>>>    Kconfig: drivers: devfreq: add default idle polling
>>>    include: devfreq: add polling_idle_ms to 'profile'
>>>    drivers: devfreq: add longer polling interval in idle
>>>    trace: events: add devfreq trace event file
>>>    drivers: devfreq: add tracing for scheduling work
>>>
>>>   MAINTAINERS                               |   1 +
>>>   drivers/devfreq/Kconfig                   |  13 +++
>>>   drivers/devfreq/devfreq.c                 | 184 
>>> ++++++++++++++++++++++++------
>>>   drivers/devfreq/governor.h                |   3 +-
>>>   drivers/devfreq/governor_simpleondemand.c |   6 +-
>>>   include/linux/devfreq.h                   |   6 +
>>>   include/trace/events/devfreq.h            |  39 +++++++
>>>   7 files changed, 218 insertions(+), 34 deletions(-)
>>>   create mode 100644 include/trace/events/devfreq.h
>>>
>>
>>
