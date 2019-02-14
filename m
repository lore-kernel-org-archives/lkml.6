Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12E7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7253721900
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbfBNMQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:16:42 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3727 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727772AbfBNMQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 07:16:42 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 04A2EE93DC15A1E39201;
        Thu, 14 Feb 2019 20:16:40 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Thu, 14 Feb 2019
 20:16:29 +0800
Subject: Re: [PATCH v2 2/2] cpufreq / cppc: Work around for Hisilicon CPPC
 cpufreq
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <gcherianv@gmail.com>, <pprakash@codeaurora.org>,
        <george.cherian@cavium.com>, <robert.moore@intel.com>
References: <1550130368-60513-1-git-send-email-wangxiongfeng2@huawei.com>
 <1550130368-60513-3-git-send-email-wangxiongfeng2@huawei.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <guohanjun@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d083bdd3-ead8-b6db-0a4e-2631bdc104a9@huawei.com>
Date:   Thu, 14 Feb 2019 12:16:23 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1550130368-60513-3-git-send-email-wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2019 07:46, Xiongfeng Wang wrote:
> Hisilicon chips do not support delivered performance counter register
> and reference performance counter register. But the platform can
> calculate the real performance using its own method. This patch provide
> a workaround for this problem, and other platforms can also use this
> workaround framework. We reuse the desired performance register to
> store the real performance calculated by the platform. After the
> platform finished the frequency adjust, it gets the real performance and
> writes it into desired performance register. OS can use it to calculate
> the real frequency.
>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 70 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index fd25c21c..da96fec 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -33,6 +33,16 @@
>  /* Offest in the DMI processor structure for the max frequency */
>  #define DMI_PROCESSOR_MAX_SPEED  0x14
>
> +struct cppc_workaround_info {
> +	char oem_id[ACPI_OEM_ID_SIZE +1];
> +	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
> +	u32 oem_revision;
> +	unsigned int (*get_rate)(unsigned int cpu);
> +};
> +
> +/* CPPC workaround for get_rate callback */
> +unsigned int (*cppc_wa_get_rate)(unsigned int cpu);
> +
>  /*
>   * These structs contain information parsed from per CPU
>   * ACPI _CPC structures.
> @@ -334,6 +344,9 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
>  	struct cppc_cpudata *cpu = all_cpu_data[cpunum];
>  	int ret;
>
> +	if (cppc_wa_get_rate)
> +		return cppc_wa_get_rate(cpunum);
> +
>  	ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t0);
>  	if (ret)
>  		return ret;
> @@ -357,6 +370,61 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
>  	.name = "cppc_cpufreq",
>  };
>
> +/*
> + * HISI platform does not support delivered performance counter and
> + * reference performance counter. It can calculate the performance using the
> + * platform specific mechanism. We reuse the desired performance register to
> + * store the real performance calculated by the platform.
> + */
> +static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpunum)
> +{
> +	struct cppc_cpudata *cpudata = all_cpu_data[cpunum];
> +	u64 desired_perf;
> +	int ret;
> +
> +	ret = cppc_get_desired_perf(cpunum, &desired_perf);
> +	if (ret < 0)
> +		return -EIO;
> +
> +	return cppc_cpufreq_perf_to_khz(cpudata, desired_perf);
> +}
> +
> +static struct cppc_workaround_info wa_info[] = {
> +	{
> +		.oem_id		= "HISI  ",
> +		.oem_table_id	= "HIP07   ",
> +		.oem_revision	= 0,
> +		.get_rate = hisi_cppc_cpufreq_get_rate,
> +	}, {
> +		.oem_id		= "HISI  ",
> +		.oem_table_id	= "HIP08   ",
> +		.oem_revision	= 0,
> +		.get_rate = hisi_cppc_cpufreq_get_rate,
> +	}
> +};
> +
> +static int cppc_check_workaround(void)
> +{
> +	struct acpi_table_header *tbl;
> +	acpi_status status = AE_OK;
> +	int i;
> +
> +	status = acpi_get_table(ACPI_SIG_PCCT, 0, &tbl);
> +	if (ACPI_FAILURE(status) || !tbl)
> +		return -EINVAL;
> +
> +	for (i = 0; i < ARRAY_SIZE(wa_info); i++) {
> +		if (!memcmp(wa_info[i].oem_id, tbl->oem_id, ACPI_OEM_ID_SIZE) &&
> +		    !memcmp(wa_info[i].oem_table_id, tbl->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
> +		    wa_info[i].oem_revision == tbl->oem_revision) {

It would be nice to factor this out into a common helper at some stage, 
as it is almost same as this:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clocksource/arm_arch_timer.c?h=v5.0-rc6#n449

> +			cppc_wa_get_rate = wa_info[i].get_rate;
> +			return 0;
> +		}
> +	}
> +
> +	return -ENODEV;
> +}
> +
>  static int __init cppc_cpufreq_init(void)
>  {
>  	int i, ret = 0;
> @@ -386,6 +454,8 @@ static int __init cppc_cpufreq_init(void)
>  		goto out;
>  	}
>
> +	cppc_check_workaround();
> +
>  	ret = cpufreq_register_driver(&cppc_cpufreq_driver);
>  	if (ret)
>  		goto out;
>


