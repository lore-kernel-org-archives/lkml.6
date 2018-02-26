Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752169AbeBZHtQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 02:49:16 -0500
Received: from foss.arm.com ([217.140.101.70]:44838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750882AbeBZHtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 02:49:14 -0500
Subject: Re: [PATCH] cpufreq: scpi: invoke frequency-invariance setter
 function
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20180220111057.14756-1-dietmar.eggemann@arm.com>
 <CAJZ5v0hB+Uk8SNVqUH3fr1y0SXbY1Rd26b84P-8PPV8FiPbnWw@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <23dba70b-aa83-4a21-a33d-733bec215264@arm.com>
Date: Mon, 26 Feb 2018 08:49:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hB+Uk8SNVqUH3fr1y0SXbY1Rd26b84P-8PPV8FiPbnWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2018 11:27 PM, Rafael J. Wysocki wrote:
> On Tue, Feb 20, 2018 at 12:10 PM, Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:

[...]

>> Fixes: 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> This is really minor, but I would reorder this slightly.

Tried to figure out what would be the better order. Not sure since I saw
different examples. Can you tell what would be the best tag order?

[...]

>> diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
>> index c32a833e1b00..3101d4e9c2de 100644
>> --- a/drivers/cpufreq/scpi-cpufreq.c
>> +++ b/drivers/cpufreq/scpi-cpufreq.c
>> @@ -51,13 +51,19 @@ static unsigned int scpi_cpufreq_get_rate(unsigned int cpu)
>>   static int
>>   scpi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
>>   {
>> +       unsigned long freq = policy->freq_table[index].frequency;
>>          struct scpi_data *priv = policy->driver_data;
>> -       u64 rate = policy->freq_table[index].frequency * 1000;
>> +       u64 rate = freq * 1000;
>>          int ret;
>>
>>          ret = clk_set_rate(priv->clk, rate);
>> -       if (!ret && (clk_get_rate(priv->clk) != rate))
>> -               ret = -EIO;
>> +       if (!ret) {
> 
> I would do:
> 
> if (ret)
>          return ret;
> 
> arch_set_freq_scale(policy->related_cpus, freq, policy->cpuinfo.max_freq);
> 
> if (clk_get_rate(priv->clk) != rate)
>          return -EIO;
> 
> return 0;
> 
> That's somewhat easier to follow for me.

Yes I can change this.

> 
>> +               if (clk_get_rate(priv->clk) != rate)
>> +                       ret = -EIO;
>> +
>> +               arch_set_freq_scale(policy->related_cpus, freq,
>> +                                   policy->cpuinfo.max_freq);
>> +       }
>>
>>          return ret;
>>   }
>> --
> 
> I also am not sure why you want to call arch_set_freq_scale() even if
> the new clock rate didn't stick.

Right, this is much better.

 static int
 scpi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
 {
+       unsigned long freq = policy->freq_table[index].frequency;
        struct scpi_data *priv = policy->driver_data;
-       u64 rate = policy->freq_table[index].frequency * 1000;
+       u64 rate = freq * 1000;
        int ret;
 
        ret = clk_set_rate(priv->clk, rate);
-       if (!ret && (clk_get_rate(priv->clk) != rate))
-               ret = -EIO;
 
-       return ret;
+       if (ret)
+               return ret;
+
+       if (clk_get_rate(priv->clk) != rate)
+               return -EIO;
+
+       arch_set_freq_scale(policy->related_cpus, freq,
+                           policy->cpuinfo.max_freq);
+
+       return 0;

Will send out a v2 as soon as I know the preferred tag order.
