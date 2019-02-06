Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34931C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09EE5217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfBFKzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:55:23 -0500
Received: from foss.arm.com ([217.140.101.70]:51388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726914AbfBFKzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:55:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F481A78;
        Wed,  6 Feb 2019 02:55:22 -0800 (PST)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D02743F719;
        Wed,  6 Feb 2019 02:55:21 -0800 (PST)
Subject: Re: Kernel 4.9: strange behavior with fifo scheduler
To:     =?UTF-8?B?RnLDqWTDqXJpYyBNYXRoaWV1?= <frederic.mathieu@dualis.com>,
        linux-kernel@vger.kernel.org
References: <016801d4bd40$35c226e0$a14674a0$@dualis.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <0c3a5c51-9694-fc3e-3cbb-abdbe398a09f@arm.com>
Date:   Wed, 6 Feb 2019 11:55:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <016801d4bd40$35c226e0$a14674a0$@dualis.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frédéric,

On 2/5/19 11:47 AM, Frédéric Mathieu wrote:
> Hi,
> 
> on an X86_64 architecture (Intel(R) Core(TM) i3-6100U CPU @ 2.30GHz), I use
> the linux kernel 4.9.146 with patch rt 125.
> uname -a: Linux 4.9.146-rt125 #1 SMP PREEMPT RT Tue Jan 29 14:17:55 CET 2019
> x86_64 GNU/Linux
> 
> I observed a strange behavior of the scheduler when several tasks are
> executed in FIFO mode on a CPU core and a significant CPU activity.
> 
> first test (reference: cpu load=0%):
> cyclictest -m -D 5 -i 1000 -p 50 -a 0
>        	# / dev / cpu_dma_latency set to 0us
>        	policy: fifo: loadavg: 1.95 1.06 0.43 1/159 14305
>        	T: 0 (14145) P: 50 I: 1000 C: 4997 Min: 7 Act: 7 Avg: 7 Max: 18
> work fine
> 
> now, i'm loading the system on the cpu core 0 with a homemade process:
>        cpu load 60%, sched FIFO prio 1, cpu 0

Are you sure that your test app runs with prio 1? Is this in the range 
of the SCHED_FIFO (userspace) priorities shown by chrt -m?

...
SCHED_FIFO min/max priority	: 1/99
...

If I run your setup (test and cyclictest affine to CPU0) on 4.15.0-43 
(i7-4750HQ) with:

(1) test prio > cyclictest prio

# chrt -p $PID_TEST

pid 28489's current scheduling policy: SCHED_FIFO
pid 28489's current scheduling priority: 51

# cat /proc/$PID_TEST/stat

28489 (test) R 28488 28487 8664 34828 28487 4194304 86 0 0 0 0 0 0 0 -52

I get your behaviour:

# /dev/cpu_dma_latency set to 0us
Thread 0 Interval: 1500
        0:       0:       6
        0:       1:       5
        0:       2:       2
        0:       3:    5419
        0:       4:       3
        0:       5:       2
        0:       6:       2
        0:       7:       2
        0:       8:    5422
        0:       9:       3
...

whereas with:

(2) test prio < cyclictest prio

# chrt -p $PID_TEST

pid 28811's current scheduling policy: SCHED_FIFO
pid 28811's current scheduling priority: 49

# cat /proc/$PID_TEST/stat

28811 (test) S 28810 28809 8664 34828 28809 1077936128 90 0 0 0 0 0 0 0 -50

I get:

# /dev/cpu_dma_latency set to 0us
Thread 0 Interval: 1500
        0:       0:       7
        0:       1:       4
        0:       2:       3
        0:       3:       5
        0:       4:       4
        0:       5:       2
        0:       6:       2
        0:       7:       2
        0:       8:       2
        0:       9:       3
...

[...]

> In this case cyclictest detects very long latencies
>        cyclictest -m -D 5 -i 1000 -p 50 -a 0 -v
> 
> Max CPUs = 2
> # /dev/cpu_dma_latency set to 0us
> Thread 0 Interval: 1500
>         0:       0:      13
>         0:       1:       8
>         0:       2:       7
>         0:       3:    5648
>         0:       4:       8
>         0:       5:       7
>         0:       6:       7
>         0:       7:       7
>         0:       8:    5649

[...]

> After verification, although no other process is running with real time
> scheduler, I see a latency of about 5.6 ms at regular intervals.
> 
> it seems that the priority task 1 (fifo) is not pre-empted by the cyclictest
> process with a priority of 50 (fifo) when the low priority task is active.
> This  corresponds to the cycle recorded in the file: 6 ms of latency
> followed by 4 "normal" latencies of 7 us.
> 
> Does anyone have any idea of this problem?
> 
> Best regards
> Frederic MATHIEU
