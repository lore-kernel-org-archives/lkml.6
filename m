Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755899AbeE2BE2 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 21:04:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755808AbeE2BE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 21:04:26 -0400
Subject: Re: [PATCH v8 6/6] cpuset: Allow reporting of sched domain generation
 info
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>
References: <1526590545-3350-1-git-send-email-longman@redhat.com>
 <1526590545-3350-7-git-send-email-longman@redhat.com>
 <20180522135349.GB31040@localhost.localdomain>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <9c1c3698-4eca-55ea-2796-7842ce5afeaf@redhat.com>
Date: Mon, 28 May 2018 21:04:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180522135349.GB31040@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/2018 09:53 AM, Juri Lelli wrote:
> Hi,
>
> On 17/05/18 16:55, Waiman Long wrote:
>> This patch enables us to report sched domain generation information.
>>
>> If DYNAMIC_DEBUG is enabled, issuing the following command
>>
>>   echo "file cpuset.c +p" > /sys/kernel/debug/dynamic_debug/control
>>
>> and setting loglevel to 8 will allow the kernel to show what scheduling
>> domain changes are being made.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  kernel/cgroup/cpuset.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index fb8aa82b..8f586e8 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -820,6 +820,12 @@ static int generate_sched_domains(cpumask_var_t **domains,
>>  	}
>>  	BUG_ON(nslot != ndoms);
>>  
>> +#ifdef CONFIG_DEBUG_KERNEL
>> +	for (i = 0; i < ndoms; i++)
>> +		pr_debug("generate_sched_domains dom %d: %*pbl\n", i,
>> +			 cpumask_pr_args(doms[i]));
>> +#endif
>> +
> While I'm always in favor of adding debug output, in this case I'm not
> sure it's adding much to what we already print when booting with
> sched_debug kernel command-line param, e.g.
>
> --->8---
>  Kernel command line: BOOT_IMAGE=/vmlinuz-4.17.0-rc5+ ... sched_debug
>
> [...]
>
>  smp: Bringing up secondary CPUs ...
>  x86: Booting SMP configuration:
>  .... node  #0, CPUs:        #1  #2  #3  #4  #5
>  .... node  #1, CPUs:    #6  #7  #8  #9 #10 #11
>  smp: Brought up 2 nodes, 12 CPUs
>  smpboot: Max logical packages: 2
>  smpboot: Total of 12 processors activated (45636.50 BogoMIPS)
>  CPU0 attaching sched-domain(s):
>   domain-0: span=0-5 level=MC
>    groups: 0:{ span=0 cap=1016 }, 1:{ span=1 cap=1011 }, 2:{ span=2 }, 3:{ span=3 cap=1023 }, 4:{ span=4 }, 5:{ span=5 }
>    domain-1: span=0-11 level=NUMA
>     groups: 0:{ span=0-5 cap=6122 }, 6:{ span=6-11 cap=6141 }
>  CPU1 attaching sched-domain(s):
>   domain-0: span=0-5 level=MC
>    groups: 1:{ span=1 cap=1011 }, 2:{ span=2 }, 3:{ span=3 cap=1023 }, 4:{ span=4 }, 5:{ span=5 }, 0:{ span=0 cap=1016 }
>    domain-1: span=0-11 level=NUMA
>     groups: 0:{ span=0-5 cap=6122 }, 6:{ span=6-11 cap=6141 }
>  CPU2 attaching sched-domain(s):
>   domain-0: span=0-5 level=MC
>    groups: 2:{ span=2 }, 3:{ span=3 cap=1023 }, 4:{ span=4 }, 5:{ span=5 }, 0:{ span=0 cap=1016 }, 1:{ span=1 cap=1011 }
>    domain-1: span=0-11 level=NUMA
>     groups: 0:{ span=0-5 cap=6122 }, 6:{ span=6-11 cap=6141 }
>  CPU3 attaching sched-domain(s):
>   domain-0: span=0-5 level=MC
>    groups: 3:{ span=3 cap=1023 }, 4:{ span=4 }, 5:{ span=5 }, 0:{ span=0 cap=1016 }, 1:{ span=1 cap=1011 }, 2:{ span=2 }
>    domain-1: span=0-11 level=NUMA
>     groups: 0:{ span=0-5 cap=6122 }, 6:{ span=6-11 cap=6141 }
>  CPU4 attaching sched-domain(s):
>   domain-0: span=0-5 level=MC
>    groups: 4:{ span=4 }, 5:{ span=5 }, 0:{ span=0 cap=1016 }, 1:{ span=1 cap=1011 }, 2:{ span=2 }, 3:{ span=3 cap=1023 }
>    domain-1: span=0-11 level=NUMA
>     groups: 0:{ span=0-5 cap=6122 }, 6:{ span=6-11 cap=6141 }
>  CPU5 attaching sched-domain(s):
>   domain-0: span=0-5 level=MC
>    groups: 5:{ span=5 }, 0:{ span=0 cap=1016 }, 1:{ span=1 cap=1011 }, 2:{ span=2 }, 3:{ span=3 cap=1023 }, 4:{ span=4 }
>    domain-1: span=0-11 level=NUMA
>     groups: 0:{ span=0-5 cap=6122 }, 6:{ span=6-11 cap=6141 }
>  CPU6 attaching sched-domain(s):
>   domain-0: span=6-11 level=MC
>    groups: 6:{ span=6 }, 7:{ span=7 }, 8:{ span=8 cap=1021 }, 9:{ span=9 }, 10:{ span=10 }, 11:{ span=11 }
>    domain-1: span=0-11 level=NUMA
>     groups: 6:{ span=6-11 cap=6141 }, 0:{ span=0-5 cap=6122 }
>  CPU7 attaching sched-domain(s):
>   domain-0: span=6-11 level=MC
>    groups: 7:{ span=7 }, 8:{ span=8 cap=1021 }, 9:{ span=9 }, 10:{ span=10 }, 11:{ span=11 }, 6:{ span=6 }
>    domain-1: span=0-11 level=NUMA
>     groups: 6:{ span=6-11 cap=6141 }, 0:{ span=0-5 cap=6122 }
>  CPU8 attaching sched-domain(s):
>   domain-0: span=6-11 level=MC
>    groups: 8:{ span=8 cap=1021 }, 9:{ span=9 }, 10:{ span=10 }, 11:{ span=11 }, 6:{ span=6 }, 7:{ span=7 }
>    domain-1: span=0-11 level=NUMA
>     groups: 6:{ span=6-11 cap=6141 }, 0:{ span=0-5 cap=6122 }
>  CPU9 attaching sched-domain(s):
>   domain-0: span=6-11 level=MC
>    groups: 9:{ span=9 }, 10:{ span=10 }, 11:{ span=11 }, 6:{ span=6 }, 7:{ span=7 }, 8:{ span=8 cap=1021 }
>    domain-1: span=0-11 level=NUMA
>     groups: 6:{ span=6-11 cap=6141 }, 0:{ span=0-5 cap=6122 }
>  CPU10 attaching sched-domain(s):
>   domain-0: span=6-11 level=MC
>    groups: 10:{ span=10 }, 11:{ span=11 }, 6:{ span=6 }, 7:{ span=7 }, 8:{ span=8 cap=1021 }, 9:{ span=9 }
>    domain-1: span=0-11 level=NUMA
>     groups: 6:{ span=6-11 cap=6141 }, 0:{ span=0-5 cap=6122 }
>  CPU11 attaching sched-domain(s):
>   domain-0: span=6-11 level=MC
>    groups: 11:{ span=11 }, 6:{ span=6 }, 7:{ span=7 }, 8:{ span=8 cap=1021 }, 9:{ span=9 }, 10:{ span=10 }
>    domain-1: span=0-11 level=NUMA
>     groups: 6:{ span=6-11 cap=6141 }, 0:{ span=0-5 cap=6122 }
>  span: 0-11 (max cpu_capacity = 1024)
>
> [...]
>
>  generate_sched_domains dom 0: 6-11 <-- this and the one below is what
>  generate_sched_domains dom 1: 0-5      you are adding
>  CPU0 attaching NULL sched-domain.
>  CPU1 attaching NULL sched-domain.
>  CPU2 attaching NULL sched-domain.
>  CPU3 attaching NULL sched-domain.
>  CPU4 attaching NULL sched-domain.
>  CPU5 attaching NULL sched-domain.
>  CPU6 attaching NULL sched-domain.
>  CPU7 attaching NULL sched-domain.
>  CPU8 attaching NULL sched-domain.
>  CPU9 attaching NULL sched-domain.
>  CPU10 attaching NULL sched-domain.
>  CPU11 attaching NULL sched-domain.
>  CPU6 attaching sched-domain(s):
>   domain-0: span=6-11 level=MC
>    groups: 6:{ span=6 }, 7:{ span=7 }, 8:{ span=8 }, 9:{ span=9 }, 10:{ span=10 }, 11:{ span=11 }
>  CPU7 attaching sched-domain(s):
>   domain-0: span=6-11 level=MC
>    groups: 7:{ span=7 }, 8:{ span=8 }, 9:{ span=9 }, 10:{ span=10 }, 11:{ span=11 }, 6:{ span=6 }
>  CPU8 attaching sched-domain(s):
>   domain-0: span=6-11 level=MC
>    groups: 8:{ span=8 }, 9:{ span=9 }, 10:{ span=10 }, 11:{ span=11 }, 6:{ span=6 }, 7:{ span=7 }
>  CPU9 attaching sched-domain(s):
>   domain-0: span=6-11 level=MC
>    groups: 9:{ span=9 }, 10:{ span=10 }, 11:{ span=11 }, 6:{ span=6 }, 7:{ span=7 }, 8:{ span=8 }
>  CPU10 attaching sched-domain(s):
>   domain-0: span=6-11 level=MC
>    groups: 10:{ span=10 }, 11:{ span=11 }, 6:{ span=6 }, 7:{ span=7 }, 8:{ span=8 }, 9:{ span=9 }
>  CPU11 attaching sched-domain(s):
>   domain-0: span=6-11 level=MC
>    groups: 11:{ span=11 }, 6:{ span=6 }, 7:{ span=7 }, 8:{ span=8 }, 9:{ span=9 }, 10:{ span=10 }
>  span: 6-11 (max cpu_capacity = 1024)
>  CPU0 attaching sched-domain(s):
>   domain-0: span=0-5 level=MC
>    groups: 0:{ span=0 }, 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }
>  CPU1 attaching sched-domain(s):
>   domain-0: span=0-5 level=MC
>    groups: 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }, 0:{ span=0 }
>  CPU2 attaching sched-domain(s):
>   domain-0: span=0-5 level=MC
>    groups: 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }, 0:{ span=0 }, 1:{ span=1 }
>  CPU3 attaching sched-domain(s):
>   domain-0: span=0-5 level=MC
>    groups: 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }, 0:{ span=0 }, 1:{ span=1 }, 2:{ span=2 }
>  CPU4 attaching sched-domain(s):
>   domain-0: span=0-5 level=MC
>    groups: 4:{ span=4 }, 5:{ span=5 }, 0:{ span=0 }, 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }
>  CPU5 attaching sched-domain(s):
>   domain-0: span=0-5 level=MC
>    groups: 5:{ span=5 }, 0:{ span=0 }, 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }
>  span: 0-5 (max cpu_capacity = 1024)
>  --->8---
>
>  Do you think there is still a benefit in printing out what
>  generate_sched_domains does?

For testing purpose the debug messages from generate_sched_domains() is
more concise. The sched_debug message is too verbose from my point of
view. So I think it is still useful.

Cheers,
Longman
