Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752304AbeDON2J (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 09:28:09 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52308 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751190AbeDON2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 09:28:08 -0400
Subject: Re: [PATCH 1/4 v4] sched/pelt: Move pelt related code in a dedicated
 file
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        Juri Lelli <juri.lelli@redhat.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>
References: <1521199541-15308-1-git-send-email-vincent.guittot@linaro.org>
 <1521199541-15308-2-git-send-email-vincent.guittot@linaro.org>
 <95f22502-16e6-555c-fb61-e1a9e88f1163@arm.com>
 <CAKfTPtCp2Qy7pZoTQH-550pJ2DZqwR2aAzk0+2B5b8DOenU4uA@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <3dfcbb67-746f-87b5-6167-6e5e220c4a69@arm.com>
Date: Sun, 15 Apr 2018 15:27:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCp2Qy7pZoTQH-550pJ2DZqwR2aAzk0+2B5b8DOenU4uA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/15/2018 02:16 PM, Vincent Guittot wrote:
> On 15 April 2018 at 13:58, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>> On 03/16/2018 12:25 PM, Vincent Guittot wrote:
>>>
>>> We want to track rt_rq's utilization as a part of the estimation of the
>>> whole rq's utilization. This is necessary because rt tasks can steal
>>> utilization to cfs tasks and make them lighter than they are.
>>> As we want to use the same load tracking mecanism for both and prevent
>>> useless dependency between cfs and rt code, pelt code is moved in a
>>> dedicated file.
>>
>>
>> This would mean that we introduce function calls into the cfs scheduler
>> fast-path, something we avoided so far (e.g. the cpu and frequency
>> invariance hooks). Are we OK with that?
>>
>> Quentin mentioned this already during v3 review back in December.
> 
> Yes and I hadn't seen any differences in the code size with the patch
> which should have been the case if inline function where replaced by
> function call

I see a diff (e.g. for arm64 defconfig):

6d626e0aaf91 - (HEAD -> tip/sched/core_rt_rq_util_tracking) sched/nohz: 
monitor rt utilization (2018-04-15 Vincent Guittot)
3111c6206f0c - cpufreq/schedutil: add rt utilization tracking 
(2018-04-15 Vincent Guittot)
62e103d266ed - sched/rt: add rt_rq utilization tracking (2018-04-15 
Vincent Guittot)
8f78fef6b1a2 - sched/pelt: Move pelt related code in a dedicated file 
(2018-04-15 Vincent Guittot)
31e77c93e432 - (tip/sched/core_rt_rq_util_tracking_base) sched/fair: 
Update blocked load when newly idle (2018-03-09 Vincent Guittot)

deggeman-mac:/opt/git/kernel_org:tip/sched/core_rt_rq_util_tracking$ 
size vmlinux
    text    data     bss     dec     hex filename
11286856        6154896  410296 17852048        1106690 vmlinux

versus:

31e77c93e432 - (HEAD -> tip/sched/core_rt_rq_util_tracking_base) 
sched/fair: Update blocked load when ne$
ly idle (2018-03-09 Vincent Guittot)

deggeman-mac:/opt/git/kernel_org:tip/sched/core_rt_rq_util_tracking_base$ 
size vmlinux
    text    data     bss     dec     hex filename 

11295048        6154896  410296 17860240        1108690 vmlinux

So I assume that in kernel/sched/fair.o:

U __update_load_avg_blocked_se
U __update_load_avg_cfs_rq
U __update_load_avg_se

are function calls now.
