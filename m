Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbeEQT0D (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 15:26:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37500 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751640AbeEQT0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 15:26:01 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 087E46021A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skannan@codeaurora.org
Message-ID: <5AFDD747.7020509@codeaurora.org>
Date: Thu, 17 May 2018 12:25:59 -0700
From: Saravana Kannan <skannan@codeaurora.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
MIME-Version: 1.0
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: Taniya Das <tdas@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org,
        amit.kucheria@linaro.org
Subject: Re: [v0 2/2] cpufreq: qcom-fw: Add support for QCOM cpufreq FW driver
References: <1526549401-25666-1-git-send-email-tdas@codeaurora.org> <1526549401-25666-3-git-send-email-tdas@codeaurora.org> <20180517101405.23oxyqpmpjhauflx@vireshk-i7>
In-Reply-To: <20180517101405.23oxyqpmpjhauflx@vireshk-i7>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17/2018 03:14 AM, Viresh Kumar wrote:
> On 17-05-18, 15:00, Taniya Das wrote:
>> The CPUfreq FW present in some QCOM chipsets offloads the steps necessary
>> for hanging the frequency of CPUs. The driver implements the cpufreq driver
>> interface for this firmware.
>>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>
>>   ##################################################################################
>> diff --git a/drivers/cpufreq/qcom-cpufreq-fw.c b/drivers/cpufreq/qcom-cpufreq-fw.c

>> +
>> +static int qcom_read_lut(struct platform_device *pdev,
>> +			struct cpufreq_qcom *c)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	u32 data, src, lval, i, core_count, prev_cc = 0;
>> +
>> +	c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
>> +				sizeof(*c->table), GFP_KERNEL);
>> +	if (!c->table)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
>> +		data = readl_relaxed(c->lut_base + i * LUT_ROW_SIZE);
>> +		src = ((data & GENMASK(31, 30)) >> 30);
>> +		lval = (data & GENMASK(7, 0));
>> +		core_count = CORE_COUNT_VAL(data);
>
> Why do you need this here ? And why do below in case this doesn't
> match max-cores count ?

This is how we detect boost frequencies.

>> +
>> +		if (!src)
>> +			c->table[i].frequency = INIT_RATE / 1000;
>> +		else
>> +			c->table[i].frequency = XO_RATE * lval / 1000;
>> +
>> +		c->table[i].driver_data = c->table[i].frequency;
>> +
>> +		dev_dbg(dev, "index=%d freq=%d, core_count %d\n",
>> +				i, c->table[i].frequency, core_count);
>> +
>> +		if (core_count != c->max_cores)
>> +			c->table[i].frequency = CPUFREQ_ENTRY_INVALID;

The FW might has some frequencies marked as "boost frequencies" when 
there are higher non-boost frequencies. So, we mark them as invalid.

>> +
>> +		/*
>> +		 * Two of the same frequencies with the same core counts means
>> +		 * end of table.
>> +		 */
>> +		if (i > 0 && c->table[i - 1].driver_data ==
>> +					c->table[i].driver_data
>> +					&& prev_cc == core_count) {
>> +			struct cpufreq_frequency_table *prev = &c->table[i - 1];
>> +
>> +			if (prev->frequency == CPUFREQ_ENTRY_INVALID) {
>> +				prev->flags = CPUFREQ_BOOST_FREQ;
>> +				prev->frequency = prev->driver_data;
>> +			}
>> +
>> +			break;
>> +		}
>> +		prev_cc = core_count;
>> +	}
>> +	c->table[i].frequency = CPUFREQ_TABLE_END;
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_get_related_cpus(struct device_node *np, struct cpumask *m)
>> +{
>> +	struct device_node *dev_phandle;
>> +	struct device *cpu_dev;
>> +	int cpu, i = 0, ret = -ENOENT;
>> +
>> +	dev_phandle = of_parse_phandle(np, "qcom,cpulist", i++);
>
> TBH, I am not a great fan of the CPU phandle list you have created
> here. Lets see what Rob has to say on this.
>

Neither do we, but this is the only real way of mapping the logical CPU 
numbers to the real CPUs in HW that belong to the same freq domain. 
Because boot CPU is always going to be CPU0 if I'm not mistaken.

>> +	while (dev_phandle) {
>> +		for_each_possible_cpu(cpu) {
>> +			cpu_dev = get_cpu_device(cpu);
>> +			if (cpu_dev && cpu_dev->of_node == dev_phandle) {
>> +				cpumask_set_cpu(cpu, m);
>> +				ret = 0;
>
> Maybe just remove this line ...
>
>> +				break;
>> +			}
>> +		}
>> +		dev_phandle = of_parse_phandle(np, "qcom,cpulist", i++);
>> +	}
>> +
>> +	return ret;


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
