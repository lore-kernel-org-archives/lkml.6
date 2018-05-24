Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965341AbeEXIB6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:01:58 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:40122 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964870AbeEXIB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:01:56 -0400
X-Google-Smtp-Source: AB8JxZoHOg36NPozrXDjqGn9TzGkjNs5EO5sUPEw/yllI/nYLxK4MffAb+feq5tDJ8Oy1jh2NYV0n12TZvEOWmP9Kv0=
MIME-Version: 1.0
In-Reply-To: <56552c53-8868-af50-232e-b12e3c247ecd@gmail.com>
References: <20180523160020.15291-1-digetx@gmail.com> <20180523160020.15291-2-digetx@gmail.com>
 <20180524043040.25pld3ezs4lpabro@vireshk-i7> <56552c53-8868-af50-232e-b12e3c247ecd@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 May 2018 10:01:54 +0200
X-Google-Sender-Auth: tnyy5YvU5Rx-rPtTi0Ma7rTBVT4
Message-ID: <CAJZ5v0iXibwwnAyjBXc+zO5YQ0=WwaoUqq1K3OWqojh8xX+Wjw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] cpufreq: tegra20: Use PLL_C as intermediate clock source
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 7:37 AM, Dmitry Osipenko <digetx@gmail.com> wrote:
> On 24.05.2018 07:30, Viresh Kumar wrote:
>> On 23-05-18, 19:00, Dmitry Osipenko wrote:
>>> PLL_C is running at 600MHz which is significantly higher than the 216MHz
>>> of the PLL_P and it is known that PLL_C is always-ON because AHB BUS is
>>> running on that PLL. Let's use PLL_C as intermediate clock source, making
>>> CPU snappier a tad during of the frequency transition.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/cpufreq/tegra20-cpufreq.c | 25 +++++++++++++++++++++----
>>>  1 file changed, 21 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
>>> index 3ad6bded6efc..4bf5ba7da40b 100644
>>> --- a/drivers/cpufreq/tegra20-cpufreq.c
>>> +++ b/drivers/cpufreq/tegra20-cpufreq.c
>>> @@ -25,12 +25,13 @@
>>>  #include <linux/types.h>
>>>
>>>  #define PLL_P_FREQ  216000
>>> +#define PLL_C_FREQ  600000
>>>
>>>  static struct cpufreq_frequency_table freq_table[] = {
>>>      { .frequency = 216000 },
>>>      { .frequency = 312000 },
>>>      { .frequency = 456000 },
>>> -    { .frequency = 608000 },
>>> +    { .frequency = 600000 },
>>>      { .frequency = 760000 },
>>>      { .frequency = 816000 },
>>>      { .frequency = 912000 },
>>> @@ -44,6 +45,7 @@ struct tegra20_cpufreq {
>>>      struct clk *cpu_clk;
>>>      struct clk *pll_x_clk;
>>>      struct clk *pll_p_clk;
>>> +    struct clk *pll_c_clk;
>>>      bool pll_x_prepared;
>>>  };
>>>
>>> @@ -58,7 +60,10 @@ static unsigned int tegra_get_intermediate(struct cpufreq_policy *policy,
>>>      if (index == 0 || policy->cur == PLL_P_FREQ)
>>>              return 0;
>>>
>>> -    return PLL_P_FREQ;
>>> +    if (index == 3 || policy->cur == PLL_C_FREQ)
>>> +            return 0;
>>
>> So we can choose between two different intermediate frequencies ? And
>> I didn't like the way magic number 3 is used here. Its prone to errors
>> and we better use a macro or something else here.
>>
>> Like instead of doing index == 3, what about freq_table[index].freq ==
>> PLL_C_FREQ ? Same for the previous patch as well.
>
> The frequency is determined by the parent clock of CCLK (CPU clock), we can
> choose between different parents for the CCLK. PLL_C as PLL_P and PLL_X are
> among the available parents for the CCLK to choose from and there some others.
>
> I don't mind to use freq_table[index].freq, though I'd like to keep compiled
> assembly minimal where possible. Hence the freq_table should be made constant to
> tell compiler that it doesn't need to emit data fetches for the table values and
> could embed the constants into the code where appropriate.
>
> Could we constify the "struct cpufreq_frequency_table" within the cpufreq core?
> Seems nothing prevents this (I already tried to constify - there are no
> obstacles), unless some cpufreq driver would try to modify
> policy->freq_table->... within the cpufreq callback implementation.

Some drivers generate frequency tables out of external data
unavailable at compile time, like ACPI tables.

But if you know it for the fact that the core doesn't modify the
frequency table, you could pass a constant table from the driver to
it, can't you?
