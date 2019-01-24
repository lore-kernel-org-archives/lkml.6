Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19542C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7F621855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTy4ncyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfAXG4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 01:56:18 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46919 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbfAXG4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 01:56:18 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so2439670ply.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 22:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+RFbdHFgEH9SLSSrBYPvGf832hxvm9jHcDGhBdjy9HY=;
        b=kTy4ncyAktWp80Ar13m0aoynhcSkfPRvCQk+TtLNgFZty4NK71vzNMBRHRTDyGHfW7
         bGFJeBbN7DZE6EWIHIazlIErUPH4xx9ipp69s/fJ9ddMuHLSWl4aNa4JGjHsaCIZqeSa
         6xYb63OvgP+DUyGMwUE43ch7z5ZJS7eHB4PHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+RFbdHFgEH9SLSSrBYPvGf832hxvm9jHcDGhBdjy9HY=;
        b=cA9C1j8NCJlTF9JrUQuGqIg+cmRzhQXoT85UXlQ/EjsCE+khUMLLGNPyZyYRDHgdFo
         3WTX1TdVBcqerEAXXLeuN72JiIjm+hcuZvjccyebqO4FT/+LL2AVv8sgefMRFq+nvRcz
         b2Tl4vDlR2KGw8iRq89SulTsp5nhm9esve7/tBt00qiSZR3x5nEI/qsIR38gYkiP+O5V
         awh/4ZrYOAgnGllGPGovMwyclXJQ9kYHN0czipe3KVkV7rBf4YkxbI/WV1vEe+ZCg3T3
         D2VEPpFI+9mD1L9CYzfgXFEDnMuUuzb3nXS6jiFD5xjjP4XCXksSAQTRhcBNCPWOZmr8
         Awog==
X-Gm-Message-State: AJcUukcdFagvIx0AsPHDzZ8jf7CLYZF742wPfc62y1xc2DFHk7j1e8Ws
        uh3D7mDRcAEnZQ6TCGsN4+GlEg==
X-Google-Smtp-Source: ALg8bN5gsvhWPP4njhp5pLoBixnddvRVT9RaaToJhkOaGeSDbMfwlP8MBPV2O1PbsYVIOV5pRuvLMQ==
X-Received: by 2002:a17:902:8641:: with SMTP id y1mr5389626plt.159.1548312977564;
        Wed, 23 Jan 2019 22:56:17 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id f64sm67588884pfh.0.2019.01.23.22.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 22:56:16 -0800 (PST)
Date:   Thu, 24 Jan 2019 12:26:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        George Cherian <george.cherian@cavium.com>,
        Prashanth Prakash <pprakash@codeaurora.org>
Cc:     robert.moore@intel.com, lenb@kernel.org, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, guohanjun@huawei.com
Subject: Re: [RFC PATCH] cpufreq / cppc: Work around for Hisilicon CPPC
 cpufreq
Message-ID: <20190124065614.gnnwd6lhbyjiph2e@vireshk-i7>
References: <1547722811-18052-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547722811-18052-1-git-send-email-wangxiongfeng2@huawei.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+George/Prashanth.

Guys please see if you have any objections to this patch. I am not
very familiar with this stuff and it would be good to get some
feedback from you guys.

@Rafael: Do you have any comments on this ?

On 17-01-19, 19:00, Xiongfeng Wang wrote:
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
>  drivers/acpi/cppc_acpi.c       | 29 ++++++++++++++++++++
>  drivers/cpufreq/Kconfig.arm    |  7 +++++
>  drivers/cpufreq/cppc_cpufreq.c | 62 ++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/cppc_acpi.h       |  4 +++
>  4 files changed, 102 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 217a782..0cdaf7e 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1050,6 +1050,35 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>  	return ret_val;
>  }
>  
> +#ifdef CONFIG_HISILICON_CPPC_CPUFREQ_WORKAROUND
> +/*
> + * We reuse the desired performance register to store the real performance
> + * calculated by the platform.
> + */
> +u64 hisi_cppc_get_real_perf(unsigned int cpunum)
> +{
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
> +	struct cpc_register_resource *desired_reg;
> +	u64 desired_perf;
> +	int ret;
> +
> +	/*
> +	 * Make sure the platform has finished the frequency adjust
> +	 * and wrote the real performance in desired performance register
> +	 */
> +	ret = check_pcc_chan(pcc_ss_id, false);
> +	if (ret)
> +		return 0;
> +
> +	desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
> +	cpc_read(cpunum, desired_reg, &desired_perf);
> +
> +	return desired_perf;
> +}
> +EXPORT_SYMBOL_GPL(hisi_cppc_get_real_perf);
> +#endif
> +
>  /**
>   * cppc_get_perf_caps - Get a CPUs performance capabilities.
>   * @cpunum: CPU from which to get capabilities info.
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 688f102..236bd07 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -18,6 +18,13 @@ config ACPI_CPPC_CPUFREQ
>  
>  	  If in doubt, say N.
>  
> +config HISILICON_CPPC_CPUFREQ_WORKAROUND
> +	bool "Workaround for Hisilicon CPPC Cpufreq"
> +	default y
> +	depends on ACPI_CPPC_CPUFREQ && ARM64
> +	help
> +	  This option enables a workaround for Hisilicon CPPC Cpufreq.
> +
>  config ARM_ARMADA_37XX_CPUFREQ
>  	tristate "Armada 37xx CPUFreq support"
>  	depends on ARCH_MVEBU && CPUFREQ_DT
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index fd25c21c..b910e84 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -33,6 +33,13 @@
>  /* Offest in the DMI processor structure for the max frequency */
>  #define DMI_PROCESSOR_MAX_SPEED  0x14
>  
> +struct cppc_get_rate_workaround_info {
> +	char oem_id[ACPI_OEM_ID_SIZE +1];
> +	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
> +	u32 oem_revision;
> +	unsigned int (*get)(unsigned int cpu);
> +};
> +
>  /*
>   * These structs contain information parsed from per CPU
>   * ACPI _CPC structures.
> @@ -357,6 +364,59 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
>  	.name = "cppc_cpufreq",
>  };
>  
> +#ifdef CONFIG_HISILICON_CPPC_CPUFREQ_WORKAROUND
> +/*
> + * When the platform does not support delivered performance counter or
> + * reference performance counter, it can calculate the performance using the
> + * platform specific mechanism. We reuse the desired performance register to
> + * store the real performance calculated by the platform.
> + */
> +static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpunum)
> +{
> +	struct cppc_cpudata *cpu = all_cpu_data[cpunum];
> +	u64 desired_perf = hisi_cppc_get_real_perf(cpunum);
> +
> +	return cppc_cpufreq_perf_to_khz(cpu, desired_perf);
> +}
> +#endif
> +
> +static struct cppc_get_rate_workaround_info wa_info[] = {
> +#ifdef CONFIG_HISILICON_CPPC_CPUFREQ_WORKAROUND
> +	{
> +		.oem_id		= "HISI  ",
> +		.oem_table_id	= "HIP07   ",
> +		.oem_revision	= 0,
> +		.get = hisi_cppc_cpufreq_get_rate,
> +	},
> +	{

This should be:

        }, {

> +		.oem_id		= "HISI  ",
> +		.oem_table_id	= "HIP08   ",
> +		.oem_revision	= 0,
> +		.get = hisi_cppc_cpufreq_get_rate,
> +	},
> +#endif
> +	{},
> +};
> +
> +static void cppc_check_get_rate_workaround(struct cpufreq_driver *cppc_cpufreq_driver)
> +{
> +	struct acpi_table_header *tbl;
> +	acpi_status status = AE_OK;
> +	int i;
> +
> +	status = acpi_get_table(ACPI_SIG_PCCT, 0, &tbl);
> +	if (ACPI_FAILURE(status) || !tbl)
> +		return;
> +
> +	for (i = 0; i < ARRAY_SIZE(wa_info) - 1; i++) {
> +		if (!memcmp(wa_info[i].oem_id, tbl->oem_id, ACPI_OEM_ID_SIZE) &&
> +		    !memcmp(wa_info[i].oem_table_id, tbl->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
> +		    wa_info[i].oem_revision == tbl->oem_revision) {
> +			cppc_cpufreq_driver->get = wa_info[i].get;
> +			return;
> +		}
> +	}
> +}
>  static int __init cppc_cpufreq_init(void)
>  {
>  	int i, ret = 0;
> @@ -386,6 +446,8 @@ static int __init cppc_cpufreq_init(void)
>  		goto out;
>  	}
>  
> +	cppc_check_get_rate_workaround(&cppc_cpufreq_driver);
> +
>  	ret = cpufreq_register_driver(&cppc_cpufreq_driver);
>  	if (ret)
>  		goto out;
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 4f34734..be7400b 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -146,4 +146,8 @@ struct cppc_cpudata {
>  extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
>  extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
>  
> +#ifdef CONFIG_HISILICON_CPPC_CPUFREQ_WORKAROUND
> +u64 hisi_cppc_get_real_perf(unsigned int cpunum);
> +#endif
> +
>  #endif /* _CPPC_ACPI_H*/
> -- 
> 1.7.12.4

-- 
viresh
