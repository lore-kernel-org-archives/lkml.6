Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031205AbeEZGvJ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 02:51:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8149 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031142AbeEZGvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 02:51:07 -0400
Subject: Re: [PATCH] cpufreq: reinitialize new policy min/max when writing
 scaling_(max|min)_freq
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <gengyanping@hisilicon.com>, <sunzhaosheng@hisilicon.com>
References: <1527144234-96396-1-git-send-email-kevin.wangtao@hisilicon.com>
 <CAJZ5v0ih6s9WviSpg9D+kSt2h8T5Vnx-MziOmYuk1H4yZOYLNg@mail.gmail.com>
From: "Wangtao (Kevin, Kirin)" <kevin.wangtao@hisilicon.com>
Message-ID: <c6d1e102-bfdb-572c-2045-bf669ee9d674@hisilicon.com>
Date: Sat, 26 May 2018 14:50:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0ih6s9WviSpg9D+kSt2h8T5Vnx-MziOmYuk1H4yZOYLNg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.121.90.40]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2018/5/24 15:45, Rafael J. Wysocki 写道:
> On Thu, May 24, 2018 at 8:43 AM, Kevin Wangtao
> <kevin.wangtao@hisilicon.com> wrote:
>> consider such situation, current user_policy.min is 1000000,
>> current user_policy.max is 1200000, in cpufreq_set_policy,
>> other driver may update policy.min to 1200000, policy.max to
>> 1300000. After that, If we input "echo 1300000 > scaling_min_freq",
>> then user_policy.min will be 1300000, and user_policy.max is
>> still 1200000, because the input value is checked with policy.max
>> not user_policy.max. if we get all related cpus offline and
>> online again, it will cause cpufreq_init_policy fail because
>> user_policy.min is higher than user_policy.max.
> 
> How do you reproduce this, exactly?
I can also reproduce this issue with upstream code, write max frequency to scaling_max_freq
and scaling_min_freq, run benchmark to let cpu cooling take effect to clip freq, then write
the cliped freq to scaling_max_freq, thus user_policy.min is still max frequency but user_policy.max
is cliped freq which is lower than max frequency.
> 
>> The solution is when user space tries to write scaling_(max|min)_freq,
>> the min/max of new_policy should be reinitialized with min/max
>> of user_policy, like what cpufreq_update_policy does.
>>
>> Signed-off-by: Kevin Wangtao <kevin.wangtao@hisilicon.com>
>> ---
>>   drivers/cpufreq/cpufreq.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index b79c532..8b33e08 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -697,6 +697,8 @@ static ssize_t store_##file_name                                    \
>>          struct cpufreq_policy new_policy;                               \
>>                                                                          \
>>          memcpy(&new_policy, policy, sizeof(*policy));                   \
>> +       new_policy->min = policy->user_policy.min;                      \
>> +       new_policy->max = policy->user_policy.max;                      \
> 
> It looks like you haven't even tried to build this, have you?
> 
>>                                                                          \
>>          ret = sscanf(buf, "%u", &new_policy.object);                    \
>>          if (ret != 1)                                                   \
>> --
>> 2.8.1
>>
> 
> .
> 
