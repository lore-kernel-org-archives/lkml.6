Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752537AbeBZJsZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:48:25 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39159 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752451AbeBZJsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:48:20 -0500
X-Google-Smtp-Source: AG47ELsitpOahy362ZK3ffwzUTO8aSn/fIr0qWOvQslC6VqdEOWcmiaJi8Gud+F0Dg+nPEvpALc6/v1jutvUs4N/sF4=
MIME-Version: 1.0
In-Reply-To: <14e2fe70-7628-4377-664d-3c4b0071e08d@linux.vnet.ibm.com>
References: <1518430876-24464-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20180212102900.GU28462@vireshk-i7> <14e2fe70-7628-4377-664d-3c4b0071e08d@linux.vnet.ibm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Feb 2018 10:48:19 +0100
X-Google-Sender-Auth: L-fNLenWZ4pCGGwFxiEb_ET-FiY
Message-ID: <CAJZ5v0gw1_xDRW+QuxXC4GO93A4v+Hw6T7NObd45qK6J+n6hMg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: powernv: Check negative value returned by cpufreq_table_find_index_dl()
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 11:33 AM, Shilpasri G Bhat
<shilpa.bhat@linux.vnet.ibm.com> wrote:
> Hi,
>
> On 02/12/2018 03:59 PM, Viresh Kumar wrote:
>> On 12-02-18, 15:51, Shilpasri G Bhat wrote:
>>> This patch fixes the below Coverity warning:
>>>
>>> *** CID 182816:  Memory - illegal accesses  (NEGATIVE_RETURNS)
>>> /drivers/cpufreq/powernv-cpufreq.c: 1008 in powernv_fast_switch()
>>> 1002                                         unsigned int target_freq)
>>> 1003     {
>>> 1004         int index;
>>> 1005         struct powernv_smp_call_data freq_data;
>>> 1006
>>> 1007         index = cpufreq_table_find_index_dl(policy, target_freq);
>>>>>>     CID 182816:  Memory - illegal accesses  (NEGATIVE_RETURNS)
>>>>>>     Using variable "index" as an index to array "powernv_freqs".
>>> 1008         freq_data.pstate_id = powernv_freqs[index].driver_data;
>>> 1009         freq_data.gpstate_id = powernv_freqs[index].driver_data;
>>> 1010         set_pstate(&freq_data);
>>> 1011
>>> 1012         return powernv_freqs[index].frequency;
>>> 1013     }
>>>
>>> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>>> ---
>>>  drivers/cpufreq/powernv-cpufreq.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
>>> index 29cdec1..69edfe9 100644
>>> --- a/drivers/cpufreq/powernv-cpufreq.c
>>> +++ b/drivers/cpufreq/powernv-cpufreq.c
>>> @@ -1005,6 +1005,9 @@ static unsigned int powernv_fast_switch(struct cpufreq_policy *policy,
>>>      struct powernv_smp_call_data freq_data;
>>>
>>>      index = cpufreq_table_find_index_dl(policy, target_freq);
>>> +    if (unlikely(index < 0))
>>> +            index = get_nominal_index();
>>> +
>>
>> AFAICT, you will get -1 here only if the freq table had no valid
>> frequencies (or the freq table is empty). Why would that happen ?
>
> I agree too. There is no way we can get -1 with initialized cpu frequency table.
> We don't initialize powernv-cpufreq if we don't have valid CPU frequency
> entries. Is there any other way to suppress the Coverity tool warning apart from
> ignoring it?

In principle you could use BUG_ON(something_impossible) to annotate
that kind of thing to the static analysis tools, but that would
generate extra code.
