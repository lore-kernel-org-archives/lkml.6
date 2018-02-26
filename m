Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752499AbeBZKQP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 05:16:15 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49748 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752045AbeBZKQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 05:16:12 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B6A26095F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH v7 14/15] cpufreq: Add module to register cpufreq on Krait
 CPUs
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@codeaurora.org, linux@armlinux.org.uk, andy.gross@linaro.org,
        david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, robh@kernel.org
References: <1519638811-17269-1-git-send-email-sricharan@codeaurora.org>
 <1519638811-17269-15-git-send-email-sricharan@codeaurora.org>
 <20180226100425.GO26947@vireshk-i7>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <ab5ad9c2-2016-47ca-b748-833ff6e75f70@codeaurora.org>
Date: Mon, 26 Feb 2018 15:45:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226100425.GO26947@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 2/26/2018 3:34 PM, Viresh Kumar wrote:
> On 26-02-18, 15:23, Sricharan R wrote:
>> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> Is this email id still valid ?
> 

 Yes. codeaurora id should exist.

>> +static int __init qcom_cpufreq_populate_opps(struct nvmem_cell *pvs_nvmem,
>> +					     struct opp_table **tbl)
>> +{
>> +	int speed = 0, pvs = 0, pvs_ver = 0, cpu;
>> +	struct device *cpu_dev;
>> +	u8 *buf;
>> +	size_t len;
>> +	char pvs_name[] = "speedXX-pvsXX-vXX";
>> +
>> +	buf = nvmem_cell_read(pvs_nvmem, &len);
>> +	if (len == 4)
>> +		get_krait_bin_format_a(&speed, &pvs, &pvs_ver, pvs_nvmem, buf);
>> +	else if (len == 8)
>> +		get_krait_bin_format_b(&speed, &pvs, &pvs_ver, pvs_nvmem, buf);
>> +	else
>> +		pr_warn("Unable to read nvmem data. Defaulting to 0!\n");
>> +
>> +	snprintf(pvs_name, sizeof(pvs_name), "speed%d-pvs%d-v%d",
>> +		 speed, pvs, pvs_ver);
>> +
>> +	for (cpu = 0; cpu < num_possible_cpus(); cpu++) {
>> +		cpu_dev = get_cpu_device(cpu);
>> +		if (!cpu_dev)
>> +			return -ENODEV;
>> +
>> +		tbl[cpu] = dev_pm_opp_set_prop_name(cpu_dev, pvs_name);
>> +
>> +		if (IS_ERR(tbl[cpu])) {
>> +			tbl[cpu] = 0;
>> +			pr_warn("failed to add OPP name %s\n", pvs_name);
>> +			return PTR_ERR(tbl[cpu]);
> 
> You just set tbl[cpu] to 0 :)
> 

 my bad. will fix it.

>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int __init qcom_cpufreq_driver_init(void)
>> +{
>> +	struct platform_device *pdev;
>> +	struct device *cpu_dev;
>> +	struct device_node *np;
>> +	struct nvmem_cell *pvs_nvmem;
>> +	struct opp_table *tbl[NR_CPUS] = { NULL };
>> +	int ret, cpu = 0;
>> +
>> +	cpu_dev = get_cpu_device(0);
>> +	if (!cpu_dev)
>> +		return -ENODEV;
>> +
>> +	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
>> +	if (!np)
>> +		return -ENOENT;
>> +
>> +	if (!of_device_is_compatible(np, "operating-points-v2-krait-cpu")) {
>> +		ret = -ENOENT;
>> +		goto free_np;
>> +	}
>> +
>> +	pvs_nvmem = of_nvmem_cell_get(np, NULL);
>> +	if (IS_ERR(pvs_nvmem)) {
>> +		dev_err(cpu_dev, "Could not get nvmem cell\n");
>> +		ret = PTR_ERR(pvs_nvmem);
>> +		goto free_np;
>> +	}
>> +
>> +	ret = qcom_cpufreq_populate_opps(pvs_nvmem, tbl);
>> +	if (ret)
>> +		goto free_opp_name;
>> +
>> +	pdev = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
>> +	if (IS_ERR(pdev)) {
>> +		ret = PTR_ERR(pdev);
>> +		goto free_opp_name;
>> +	}
>> +
>> +	of_node_put(np);
>> +
>> +	return 0;
>> +
>> +free_opp_name:
>> +	while (tbl[cpu]) {
>> +		dev_pm_opp_put_prop_name(tbl[cpu]);
>> +		cpu++;
>> +	}
>> +
>> +free_np:
>> +	of_node_put(np);
>> +
>> +	return ret;
>> +}
>> +late_initcall(qcom_cpufreq_driver_init);
>> +
>> +MODULE_DESCRIPTION("Qualcomm CPUfreq driver");
>> +MODULE_AUTHOR("Stephen Boyd <sboyd@codeaurora.org>");
>> +MODULE_LICENSE("GPL v2");
> 
> Everything else is fine. Fix above issue and you can add
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

 Thanks. Will fix and repost.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
