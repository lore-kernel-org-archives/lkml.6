Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932760AbeEHJKE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 05:10:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54662 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932308AbeEHJKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 05:10:02 -0400
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
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <8cf21b1a-ca6e-fed7-43c5-94c66ff5986b@arm.com>
Date: Tue, 8 May 2018 11:09:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508082242.bre6sjfvefhz6xc3@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2018 10:22 AM, Viresh Kumar wrote:
> On 08-05-18, 08:33, Dietmar Eggemann wrote:
>> This reverts commit e2cabe48c20efb174ce0c01190f8b9c5f3ea1d13.
>>
>> Lifting the restriction that the sugov kthread is bound to the
>> policy->related_cpus for a system with a slow switching cpufreq driver,
>> which is able to perform DVFS from any cpu (e.g. cpufreq-dt), is not
>> only not beneficial it also harms Enery-Aware Scheduling (EAS) on
>> systems with asymmetric cpu capacities (e.g. Arm big.LITTLE).
>>
>> The sugov kthread which does the update for the little cpus could
>> potentially run on a big cpu. It could prevent that the big cluster goes
>> into deeper idle states although all the tasks are running on the little
>> cluster.
> 
> I think the original patch did the right thing, but that doesn't suit
> everybody as you explained.
> 
> I wouldn't really revert the patch but fix my platform's cpufreq
> driver to set dvfs_possible_from_any_cpu = false, so that other
> platforms can still benefit from the original commit.

This would make sure that the kthreads are bound to the correct set of 
cpus for platforms with those cpufreq drivers (cpufreq-dt (h960), 
scmi-cpufreq, scpi-cpufreq) but it will also change the logic (e.g. 
sugov_should_update_freq() -> cpufreq_can_do_remote_dvfs()).

I'm still struggling to understand when a driver/platform should set 
dvfs_possible_from_any_cpu to true and what the actual benefit would be.
