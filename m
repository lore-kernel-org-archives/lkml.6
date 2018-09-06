Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88671C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 23:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3520B20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 23:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3520B20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbeIGEC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 00:02:59 -0400
Received: from foss.arm.com ([217.140.101.70]:52244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725745AbeIGEC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 00:02:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 216197A9;
        Thu,  6 Sep 2018 16:25:09 -0700 (PDT)
Received: from [10.103.100.29] (unknown [10.103.100.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDD6B3F557;
        Thu,  6 Sep 2018 16:25:08 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: vruntime should normalize when switching from
 fair
To:     Juri Lelli <juri.lelli@gmail.com>
Cc:     Miguel de Dios <migueldedios@google.com>,
        Steve Muckle <smuckle@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Todd Kjos <tkjos@google.com>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        John Dias <joaodias@google.com>
References: <20180817182728.76129-1-smuckle@google.com>
 <dcd2fa21-7fef-d648-017d-9d42d11793e0@google.com>
 <b27b2354-cbfe-7c16-bdc1-d88ed3be90bd@arm.com>
 <20180824065419.GB24860@localhost.localdomain>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <5fa77995-428e-077e-e236-7cc4a2e82577@arm.com>
Date:   Thu, 6 Sep 2018 16:25:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824065419.GB24860@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juri,

On 08/23/2018 11:54 PM, Juri Lelli wrote:
> On 23/08/18 18:52, Dietmar Eggemann wrote:
>> Hi,
>>
>> On 08/21/2018 01:54 AM, Miguel de Dios wrote:
>>> On 08/17/2018 11:27 AM, Steve Muckle wrote:
>>>> From: John Dias <joaodias@google.com>

[...]

>>
>> I tried to catch this issue on my Arm64 Juno board using pi_test (and a
>> slightly adapted pip_test (usleep_val = 1500 and keep low as cfs)) from
>> rt-tests but wasn't able to do so.
>>
>> # pi_stress --inversions=1 --duration=1 --groups=1 --sched id=low,policy=cfs
>>
>> Starting PI Stress Test
>> Number of thread groups: 1
>> Duration of test run: 1 seconds
>> Number of inversions per group: 1
>>       Admin thread SCHED_FIFO priority 4
>> 1 groups of 3 threads will be created
>>        High thread SCHED_FIFO priority 3
>>         Med thread SCHED_FIFO priority 2
>>         Low thread SCHED_OTHER nice 0
>>
>> # ./pip_stress
>>
>> In both cases, the cfs task entering  rt_mutex_setprio() is queued, so
>> dequeue_task_fair()->dequeue_entity(), which subtracts cfs_rq->min_vruntime
>> from se->vruntime, is called on it before it gets the rt prio.
>>
>> Maybe it requires a very specific use of the pthread library to provoke this
>> issue by making sure that the cfs tasks really blocks/sleeps?
> 
> Maybe one could play with rt-app to recreate such specific use case?
> 
> https://github.com/scheduler-tools/rt-app/blob/master/doc/tutorial.txt#L459

I played a little bit with rt-app on hikey960 to re-create Steve's test 
program.
Since there is no semaphore support (sem_wait(), sem_post()) I used 
condition variables (wait: pthread_cond_wait() , signal: 
pthread_cond_signal()). It's not really the same since this is stateless 
but sleeps before the signals help to maintain the state in this easy 
example.

This provokes the vruntime issue e.g. for cpus 0,4 and it doesn't for 0,1:


     "global": {
         "calibration" : 130,
	"pi_enabled" : true
     },
     "tasks": {
         "rt_task": {
	    "loop" : 100,
	    "policy" : "SCHED_FIFO",
	    "cpus" : [0],

	    "lock" : "b_mutex",
	    "wait" : { "ref" : "b_cond", "mutex" : "b_mutex" },
	    "unlock" : "b_mutex",
	    "sleep" : 3000,
	    "lock1" : "a_mutex",
	    "signal" : "a_cond",
	    "unlock1" : "a_mutex",
	    "lock2" : "pi-mutex",
	    "unlock2" : "pi-mutex"
         },
	"cfs_task": {
	    "loop" : 100,
	    "policy" : "SCHED_OTHER",
	    "cpus" : [4],

	    "lock" : "pi-mutex",
	    "sleep" : 3000,
	    "lock1" : "b_mutex",
	    "signal" : "b_cond",
	    "unlock" : "b_mutex",
	    "lock2" : "a_mutex",
	    "wait" : { "ref" : "a_cond", "mutex" : "a_mutex" },
	    "unlock1" : "a_mutex",
	    "unlock2" : "pi-mutex"
	}
     }
}

Adding semaphores is possible but rt-app has no easy way to initialize 
individual objects, e.g. sem_init(..., value). The only way I see is via 
the global section, like "pi_enabled". But then, this is true for all 
objects of this kind (in this case mutexes)?

So the following couple of lines extension to rt-app works because both 
semaphores can be initialized to 0:

  {
     "global": {
         "calibration" : 130,
	"pi_enabled" : true
     },
     "tasks": {
         "rt_task": {
	    "loop" : 100,
	    "policy" : "SCHED_FIFO",
	    "cpus" : [0],

	    "sem_wait" : "b_sem",
	    "sleep" : 1000,
	    "sem_post" : "a_sem",

	    "lock" : "pi-mutex",
	    "unlock" : "pi-mutex"
         },
	"cfs_task": {
	    "loop" : 100,
	    "policy" : "SCHED_OTHER",
	    "cpus" : [4],

	    "lock" : "pi-mutex",
	    "sleep" : 1000,
	    "sem_post" : "b_sem",
	    "sem_wait" : "a_sem",
	    "unlock" : "pi-mutex"
	}
     }
}

Any thoughts on that? I can see something like this as infrastructure to 
create a regression test case based on rt-app and standard ftrace.

[...]
