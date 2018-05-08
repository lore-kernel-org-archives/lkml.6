Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754830AbeEHKhE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 06:37:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55804 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754476AbeEHKhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 06:37:03 -0400
Subject: Re: [PATCH] Revert "cpufreq: schedutil: Don't restrict kthread to
 related_cpus unnecessarily"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
References: <20180508073340.13114-1-dietmar.eggemann@arm.com>
 <20180508082242.bre6sjfvefhz6xc3@vireshk-i7>
 <8cf21b1a-ca6e-fed7-43c5-94c66ff5986b@arm.com>
 <20180508094526.ajyjrwytguhv4xpe@vireshk-i7>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <7922d081-0bfb-0e55-7caf-ec9fb5d7bab0@arm.com>
Date: Tue, 8 May 2018 12:36:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508094526.ajyjrwytguhv4xpe@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2018 11:45 AM, Viresh Kumar wrote:
> On 08-05-18, 11:09, Dietmar Eggemann wrote:
>> This would make sure that the kthreads are bound to the correct set of cpus
>> for platforms with those cpufreq drivers (cpufreq-dt (h960), scmi-cpufreq,
>> scpi-cpufreq) but it will also change the logic (e.g.
>> sugov_should_update_freq() -> cpufreq_can_do_remote_dvfs()).
> 
> Yeah, I misunderstood your patch a bit. So you are not disabling
> remote updates but only limiting the CPUs where the kthread runs.

Yes, remote updates are possible even if the sugov kthread is bound to 
the cpus of the policy.

cross policy (cluster) remote callback example:
...
migration/1-14 [001] enqueue_task_fair: this_cpu=1 cpu_of(rq)=7
migration/1-14 [001] sugov_update_shared: this_cpu=1 sg_cpu->cpu=7
                      sg_cpu->sg_policy->policy->related_cpus=4-7
   sugov:4-1492 [004] sugov_work: this_cpu=4
                      sg_cpu->sg_policy->policy->related_cpus=4-7
...

cpu=1 updates cpu=7 remotely. This is independent from where the actual 
sugov kthread is running.

> That still looks to be a big little specific problem to me right now
> and I am not sure why should we specially handle these kthreads ?
> Isn't the same true for any other threads/tasks in the kernel which
> may end up running on big CPUs ? And this problem still occurs with
> the EAS patches applied ? As I thought we may end up keeping such
> small tasks on little cores then.

Binding it to the cpus of the policy makes sense since if the OPP should 
be changed for these cpus it should be done on one of these cpus, making 
sure we don't disturb the others. EAS and big.LITTLE will profit from 
this, but potentially every system with multiple frequency domains.

Binding them on to little cpus is an overhead to me which will gain us 
very little. Keeping the sugov threads to the cpus of the policy doesn't 
cost much and helps a lot.

>> I'm still struggling to understand when a driver/platform should set
>> dvfs_possible_from_any_cpu to true and what the actual benefit would be.
> 
> Ideally it should be set by default for all ARM platforms at least
> which have more than one cpufreq policy, as there is no hardware
> limitation for changing frequency from other CPUs. If you look at the
> commit logs of patches which added remote updates, you will see
> interesting cases where this can be very useful.

That's true but where is the benefit by doing so? (Multiple) per-cluster 
or per-cpu frequency domains, why should the sugov kthread run on a 
foreign cpu?

> commit 674e75411fc2 ("sched: cpufreq: Allow remote cpufreq callbacks")

IMHO, this describes the remote cpufreq callback functionality itself 
which works perfectly fine even if we leave the sugov ktrhead bound to 
the cpus of the policy.
