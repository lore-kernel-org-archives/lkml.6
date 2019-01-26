Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D9FC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03095214C6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfAZJpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 04:45:05 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2779 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726165AbfAZJpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 04:45:05 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BFD479EEDAAC648224E9;
        Sat, 26 Jan 2019 17:45:02 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Sat, 26 Jan 2019
 17:44:54 +0800
Subject: Re: [RFC PATCH] cpufreq / cppc: Work around for Hisilicon CPPC
 cpufreq
To:     George Cherian <gcherianv@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     George Cherian <george.cherian@cavium.com>,
        Prashanth Prakash <pprakash@codeaurora.org>,
        <robert.moore@intel.com>, <lenb@kernel.org>, <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <guohanjun@huawei.com>
References: <1547722811-18052-1-git-send-email-wangxiongfeng2@huawei.com>
 <20190124065614.gnnwd6lhbyjiph2e@vireshk-i7>
 <CABYS093CQdhNBb8KqfV+3FfNCGcgW7DE+KsQ=DAJnRFQq74Piw@mail.gmail.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <930bc3a8-2076-0923-7968-81001c90db8a@huawei.com>
Date:   Sat, 26 Jan 2019 17:44:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CABYS093CQdhNBb8KqfV+3FfNCGcgW7DE+KsQ=DAJnRFQq74Piw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

Thanks for your reply !

On 2019/1/25 15:07, George Cherian wrote:
> Hi Wang,
> 
> On Thu, Jan 24, 2019 at 12:27 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>
>> +George/Prashanth.
>>
>> Guys please see if you have any objections to this patch. I am not
>> very familiar with this stuff and it would be good to get some
>> feedback from you guys.
>>
>> @Rafael: Do you have any comments on this ?
>>
>> On 17-01-19, 19:00, Xiongfeng Wang wrote:
>>> Hisilicon chips do not support delivered performance counter register
>>> and reference performance counter register. But the platform can
>>> calculate the real performance using its own method. This patch provide
>>> a workaround for this problem, and other platforms can also use this
>>> workaround framework. We reuse the desired performance register to
>>> store the real performance calculated by the platform. After the
>>> platform finished the frequency adjust, it gets the real performance and
>>> writes it into desired performance register. OS can use it to calculate
>>> the real frequency.
> Does your platform support Autonomous Selection mode?
> This register is not valid when autonomous mode is enabled. In such case
> how are you calculating the frequency?

Our platform does not support Autonomous Selection mode.
When it's enabled, this method won't work. But I think the current doesn't support
Autonomous Selection mode. I only found a defition 'AUTO_SEL_ENABLE' in enum cppc_regs
and there is no one using it.

>>>
>>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>>> ---
>>>  drivers/acpi/cppc_acpi.c       | 29 ++++++++++++++++++++
>>>  drivers/cpufreq/Kconfig.arm    |  7 +++++
>>>  drivers/cpufreq/cppc_cpufreq.c | 62 ++++++++++++++++++++++++++++++++++++++++++
>>>  include/acpi/cppc_acpi.h       |  4 +++
>>>  4 files changed, 102 insertions(+)
>>>
>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>> index 217a782..0cdaf7e 100644
>>> --- a/drivers/acpi/cppc_acpi.c
>>> +++ b/drivers/acpi/cppc_acpi.c
>>> @@ -1050,6 +1050,35 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>>>       return ret_val;
>>>  }
>>>
>>> +#ifdef CONFIG_HISILICON_CPPC_CPUFREQ_WORKAROUND
>>> +/*
>>> + * We reuse the desired performance register to store the real performance
>>> + * calculated by the platform.
>>> + */
>>> +u64 hisi_cppc_get_real_perf(unsigned int cpunum)
>>> +{
>>> +     int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
>>> +     struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>>> +     struct cpc_register_resource *desired_reg;
>>> +     u64 desired_perf;
>>> +     int ret;
>>> +
>>> +     /*
>>> +      * Make sure the platform has finished the frequency adjust
>>> +      * and wrote the real performance in desired performance register
>>> +      */
>>> +     ret = check_pcc_chan(pcc_ss_id, false);
>>> +     if (ret)
>>> +             return 0;
> If there is a pending command in the channel then returning zero
> will give bogus frequency value. You may return the previous written value.

How about returning a error code here ?
In current kernel, when 'cppc_cpufreq_get_rate' returns -EFAULT, 'cpuinfo_cur_freq'
shows a very big value. I was thinking about writing a patch to fix it.

>>> +
>>> +     desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
>>> +     cpc_read(cpunum, desired_reg, &desired_perf);
>>> +
>>> +     return desired_perf;
>>> +}
>>> +EXPORT_SYMBOL_GPL(hisi_cppc_get_real_perf);
>>> +#endif
>>> +
>>>  /**
>>>   * cppc_get_perf_caps - Get a CPUs performance capabilities.
>>>   * @cpunum: CPU from which to get capabilities info.
>>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>>> index 688f102..236bd07 100644
>>> --- a/drivers/cpufreq/Kconfig.arm
>>> +++ b/drivers/cpufreq/Kconfig.arm
>>> @@ -18,6 +18,13 @@ config ACPI_CPPC_CPUFREQ
>>>
>>>         If in doubt, say N.
>>>
>>> +config HISILICON_CPPC_CPUFREQ_WORKAROUND
>>> +     bool "Workaround for Hisilicon CPPC Cpufreq"
>>> +     default y
>>> +     depends on ACPI_CPPC_CPUFREQ && ARM64
> Do you really want this to be applied to all ARM64? or just only
> for affected HISI platforms?

I was thinking about applying the framwork to all ARM64.
CONF_HISILICON_CPPC_CPUFREQ_WORKAROUND adds the OEM ID for HISI.

>>> +     help
>>> +       This option enables a workaround for Hisilicon CPPC Cpufreq.
>>> +
>>>  config ARM_ARMADA_37XX_CPUFREQ
>>>       tristate "Armada 37xx CPUFreq support"
>>>       depends on ARCH_MVEBU && CPUFREQ_DT
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>> index fd25c21c..b910e84 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -33,6 +33,13 @@
>>>  /* Offest in the DMI processor structure for the max frequency */
>>>  #define DMI_PROCESSOR_MAX_SPEED  0x14
>>>
>>> +struct cppc_get_rate_workaround_info {
> If your intention is to make a generic framework for future extensions
> then you might need to name it differently. Something like
> struct cppc_workaround_info, so that you can extend the same for any
> future workarounds.

Thanks for your advice. I will change it in the next version.

>>> +     char oem_id[ACPI_OEM_ID_SIZE +1];
>>> +     char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
>>> +     u32 oem_revision;
>>> +     unsigned int (*get)(unsigned int cpu);
> This can be  unsigned int (*get_rate)(unsigned int cpu);
>>> +};
>>> +
>>>  /*
>>>   * These structs contain information parsed from per CPU
>>>   * ACPI _CPC structures.
>>> @@ -357,6 +364,59 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
>>>       .name = "cppc_cpufreq",
>>>  };
>>>
>>> +#ifdef CONFIG_HISILICON_CPPC_CPUFREQ_WORKAROUND
>>> +/*
>>> + * When the platform does not support delivered performance counter or
>>> + * reference performance counter, it can calculate the performance using the
>>> + * platform specific mechanism. We reuse the desired performance register to
>>> + * store the real performance calculated by the platform.
>>> + */
>>> +static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpunum)
>>> +{
>>> +     struct cppc_cpudata *cpu = all_cpu_data[cpunum];
>>> +     u64 desired_perf = hisi_cppc_get_real_perf(cpunum);
>>> +
>>> +     return cppc_cpufreq_perf_to_khz(cpu, desired_perf);
>>> +}
>>> +#endif
>>> +
>>> +static struct cppc_get_rate_workaround_info wa_info[] = {
>>> +#ifdef CONFIG_HISILICON_CPPC_CPUFREQ_WORKAROUND
>>> +     {
>>> +             .oem_id         = "HISI  ",
>>> +             .oem_table_id   = "HIP07   ",
>>> +             .oem_revision   = 0,
>>> +             .get = hisi_cppc_cpufreq_get_rate,
>>> +     },
>>> +     {
>>
>> This should be:
>>
>>         }, {
>>
>>> +             .oem_id         = "HISI  ",
>>> +             .oem_table_id   = "HIP08   ",
>>> +             .oem_revision   = 0,
>>> +             .get = hisi_cppc_cpufreq_get_rate,
>>> +     },
>>> +#endif
>>> +     {},
>>> +};
>>> +
>>> +static void cppc_check_get_rate_workaround(struct cpufreq_driver *cppc_cpufreq_driver)
> This function can be renamed to cppc_check_workaround to make it
> generic also can have a
> proper return value so that the caller can validate.

Thanks, I will change it and all above.
If I want to apply it to ARM64, I think I will need a CONFIG_ARM64 here.

>>> +{
>>> +     struct acpi_table_header *tbl;
>>> +     acpi_status status = AE_OK;
>>> +     int i;
>>> +
>>> +     status = acpi_get_table(ACPI_SIG_PCCT, 0, &tbl);
>>> +     if (ACPI_FAILURE(status) || !tbl)
>>> +             return;
>>> +
>>> +     for (i = 0; i < ARRAY_SIZE(wa_info) - 1; i++) {
>>> +             if (!memcmp(wa_info[i].oem_id, tbl->oem_id, ACPI_OEM_ID_SIZE) &&
>>> +                 !memcmp(wa_info[i].oem_table_id, tbl->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
>>> +                 wa_info[i].oem_revision == tbl->oem_revision) {
>>> +                     cppc_cpufreq_driver->get = wa_info[i].get;
>>> +                     return;
>>> +             }
>>> +     }
>>> +}
>>>  static int __init cppc_cpufreq_init(void)
>>>  {
>>>       int i, ret = 0;
>>> @@ -386,6 +446,8 @@ static int __init cppc_cpufreq_init(void)
>>>               goto out;
>>>       }
>>>
>>> +     cppc_check_get_rate_workaround(&cppc_cpufreq_driver);
>>> +
>>>       ret = cpufreq_register_driver(&cppc_cpufreq_driver);
>>>       if (ret)
>>>               goto out;
>>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>>> index 4f34734..be7400b 100644
>>> --- a/include/acpi/cppc_acpi.h
>>> +++ b/include/acpi/cppc_acpi.h
>>> @@ -146,4 +146,8 @@ struct cppc_cpudata {
>>>  extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
>>>  extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
>>>
>>> +#ifdef CONFIG_HISILICON_CPPC_CPUFREQ_WORKAROUND
>>> +u64 hisi_cppc_get_real_perf(unsigned int cpunum);
>>> +#endif
>>> +
>>>  #endif /* _CPPC_ACPI_H*/
>>> --
>>> 1.7.12.4
>>
>> --
>> viresh
> -George
> 
> .
> 
Thanks,
Xiongfeng


