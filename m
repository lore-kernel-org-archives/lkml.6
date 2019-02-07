Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A80C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE98E21904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfBGL1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:27:12 -0500
Received: from foss.arm.com ([217.140.101.70]:35486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfBGL1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:27:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 505A9A78;
        Thu,  7 Feb 2019 03:27:11 -0800 (PST)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B09423F675;
        Thu,  7 Feb 2019 03:27:10 -0800 (PST)
Subject: Re: Kernel 4.9: strange behavior with fifo scheduler
To:     =?UTF-8?B?RnLDqWTDqXJpYyBNYXRoaWV1?= <frederic.mathieu@dualis.com>,
        linux-kernel@vger.kernel.org
References: <016801d4bd40$35c226e0$a14674a0$@dualis.com>
 <0c3a5c51-9694-fc3e-3cbb-abdbe398a09f@arm.com>
 <001c01d4be1f$67f74930$37e5db90$@dualis.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <6538f4ff-2ee9-42f0-eff2-19c2bc883281@arm.com>
Date:   Thu, 7 Feb 2019 12:27:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <001c01d4be1f$67f74930$37e5db90$@dualis.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/19 2:25 PM, Frédéric Mathieu wrote:
> Hi Dietmar,
> 
> Attention !, these tests were executed on a kernel with the patch RT and the option CONFIG_PREEMPT_RT_FULL = y. I confirm the truth of my priority settings
> On a vanilla kernel, I get the same results as you.
> 
> After talking with mike Galbraith, I turned my attention to the priority of kernel threads. The following link explains in the behavior of the scheduler :
> https://wiki.linuxfoundation.org/realtime/documentation/technical_details/hr_timers
> 
> Contrary to what I thought, there is no dynamic adjustment of the priority according to the priority of the calling task.
> 
> -----Message d'origine-----
> De : linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] De la part de Dietmar Eggemann
> Envoyé : mercredi 6 février 2019 11:55
> À : Frédéric Mathieu <frederic.mathieu@dualis.com>; linux-kernel@vger.kernel.org
> Objet : Re: Kernel 4.9: strange behavior with fifo scheduler
> 
> Hi Frédéric,
> 
> On 2/5/19 11:47 AM, Frédéric Mathieu wrote:
>> Hi,
>>
>> on an X86_64 architecture (Intel(R) Core(TM) i3-6100U CPU @ 2.30GHz),
>> I use the linux kernel 4.9.146 with patch rt 125.
>> uname -a: Linux 4.9.146-rt125 #1 SMP PREEMPT RT Tue Jan 29 14:17:55
>> CET 2019
>> x86_64 GNU/Linux

Ah, OK, I should have read it more carefully! So you're talking about 
the ktimersoftd/0 thread in this case which makes cyclictest show the 
latency of ~6ms every 5th time.

v4.9 + rt 125 on ARM64 Juno: (test prio (49) > cyclictest prio (50)

    ...
    ktimersoftd/0-4     [000]    54.948862: sched_pi_setprio:
comm=ktimersoftd/0 pid=4 oldprio=49 newprio=98
    ktimersoftd/0-4     [000]    54.948867: sched_waking: 
comm=cyclictest pid=2730 prio=49 target_cpu=000
    ktimersoftd/0-4     [000]    54.948870: sched_wakeup: 
cyclictest:2730 [49] success=1 CPU:000
    ktimersoftd/0-4     [000]    54.948874: sched_switch: 
ktimersoftd/0:4 [98] R ==> cyclictest:2730 [49]
       cyclictest-2730  [000]    54.948890: sched_switch: 
cyclictest:2730 [49] S ==> ktimersoftd/0:4 [98]
    ktimersoftd/0-4     [000]    54.948906: sched_switch: 
ktimersoftd/0:4 [98] S ==> swapper/0:0 [120]
           <idle>-0     [000]    54.949087: sched_waking: 
comm=test pid=2723 prio=50 target_cpu=000
           <idle>-0     [000]    54.949090: sched_wakeup: 
test:2723 [50] success=1 CPU:000
           <idle>-0     [000]    54.949098: sched_switch: 
swapper/0:0 [120] R ==> test:2723 [50]
             test-2723  [000]    54.949784: sched_waking: 
comm=ktimersoftd/0 pid=4 prio=98 target_cpu=000
             test-2723  [000]    54.949787: sched_wakeup: 
ktimersoftd/0:4 [98] success=1 CPU:000
             test-2723  [000]    54.951979: sched_waking: 
comm=ksoftirqd/0 pid=3 prio=120 target_cpu=000
             test-2723  [000]    54.951983: sched_wakeup: 
ksoftirqd/0:3 [120] success=1 CPU:000
             test-2723  [000]    54.955111: sched_switch: 
test:2723 [50] S ==> ktimersoftd/0:4 [98]
    ktimersoftd/0-4     [000]    54.955125: sched_waking: 
comm=cyclictest pid=2730 prio=49 target_cpu=000
    ktimersoftd/0-4     [000]    54.955128: sched_wakeup: 
cyclictest:2730 [49] success=1 CPU:000
    ktimersoftd/0-4     [000]    54.955132: sched_switch: 
ktimersoftd/0:4 [98] R ==> cyclictest:2730 [49]
       cyclictest-2730  [000]    54.955138: sched_pi_setprio: 
comm=ktimersoftd/0 pid=4 oldprio=98 newprio=49
       cyclictest-2730  [000]    54.955145: sched_switch: 
cyclictest:2730 [49] D ==> ktimersoftd/0:4 [49]
    ktimersoftd/0-4     [000]    54.955149: sched_pi_setprio: 
comm=ktimersoftd/0 pid=4 oldprio=49 newprio=98
    ktimersoftd/0-4     [000]    54.955154: sched_waking: 
comm=cyclictest pid=2730 prio=49 target_cpu=000
    ktimersoftd/0-4     [000]    54.955157: sched_wakeup: 
cyclictest:2730 [49] success=1 CPU:000
    ...

[...]
