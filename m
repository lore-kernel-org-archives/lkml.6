Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751214AbeEUJAp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:00:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59238 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbeEUJAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:00:41 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6DC8B601D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilialin@codeaurora.org
From: <ilialin@codeaurora.org>
To: "'Viresh Kumar'" <viresh.kumar@linaro.org>
Cc: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <mark.rutland@arm.com>, <nm@ti.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <andy.gross@linaro.org>,
        <david.brown@linaro.org>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <rjw@rjwysocki.net>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <rnayak@codeaurora.org>,
        <amit.kucheria@linaro.org>, <nicolas.dechesne@linaro.org>,
        <celster@codeaurora.org>, <tfinkel@codeaurora.org>
References: <1526555955-29960-1-git-send-email-ilialin@codeaurora.org> <1526555955-29960-11-git-send-email-ilialin@codeaurora.org> <20180518014538.duphof6enscpm5vp@vireshk-i7> <019201d3ef66$db97aed0$92c70c70$@codeaurora.org> <20180521044938.bnr2sdkmvdorfxqm@vireshk-i7>
In-Reply-To: <20180521044938.bnr2sdkmvdorfxqm@vireshk-i7>
Subject: RE: [PATCH v8 10/15] cpufreq: Add Kryo CPU scaling driver
Date: Mon, 21 May 2018 12:00:09 +0300
Message-ID: <000501d3f0e2$23500c00$69f02400$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ4436NnLWh81Iiw1zG4GLOsqluSgF4oTaoAirQgjkBovTfXAF8juezornlK7A=
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Final version (addressing Russel's comment as well):




// SPDX-License-Identifier: GPL-2.0
/*
 * Copyright (c) 2018, The Linux Foundation. All rights reserved.
 */

/*
 * In Certain QCOM SoCs like apq8096 and msm8996 that have KRYO processors,
 * the CPU frequency subset and voltage value of each OPP varies
 * based on the silicon variant in use. Qualcomm Process Voltage Scaling
Tables
 * defines the voltage and frequency value based on the msm-id in SMEM
 * and speedbin blown in the efuse combination.
 * The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the
SoC
 * to provide the OPP framework with required information.
 * This is used to determine the voltage and frequency value for each OPP of
 * operating-points-v2 table when it is parsed by the OPP framework.
 */

#include <linux/cpu.h>
#include <linux/err.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/nvmem-consumer.h>
#include <linux/of.h>
#include <linux/platform_device.h>
#include <linux/pm_opp.h>
#include <linux/slab.h>
#include <linux/soc/qcom/smem.h>

#define MSM_ID_SMEM	137
#define SILVER_LEAD	0
#define GOLD_LEAD	2

enum _msm_id {
	MSM8996V3 = 0xF6ul,
	APQ8096V3 = 0x123ul,
	MSM8996SG = 0x131ul,
	APQ8096SG = 0x138ul,
};

enum _msm8996_version {
	MSM8996_V3,
	MSM8996_SG,
	NUM_OF_MSM8996_VERSIONS,
};

static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
{
	size_t len;
	u32 *msm_id;
	enum _msm8996_version version;

	msm_id = qcom_smem_get(QCOM_SMEM_HOST_ANY, MSM_ID_SMEM, &len);
	/* The first 4 bytes are format, next to them is the actual msm-id
*/
	msm_id++;

	switch ((enum _msm_id)*msm_id) {
	case MSM8996V3:
	case APQ8096V3:
		version = MSM8996_V3;
		break;
	case MSM8996SG:
	case APQ8096SG:
		version = MSM8996_SG;
		break;
	default:
		version = NUM_OF_MSM8996_VERSIONS;
	}

	return version;
}

static int __init qcom_cpufreq_kryo_driver_init(void)
{
	struct device *cpu_dev_silver, *cpu_dev_gold;
	struct opp_table *opp_silver, *opp_gold;
	enum _msm8996_version msm8996_version;
	struct nvmem_cell *speedbin_nvmem;
	struct platform_device *pdev;
	struct device_node *np;
	u8 *speedbin;
	u32 versions;
	size_t len;
	int ret;

	cpu_dev_silver = get_cpu_device(SILVER_LEAD);
	if (NULL == cpu_dev_silver)
		return -ENODEV;

	cpu_dev_gold = get_cpu_device(SILVER_LEAD);
	if (NULL == cpu_dev_gold)
		return -ENODEV;

	msm8996_version = qcom_cpufreq_kryo_get_msm_id();
	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
		dev_err(cpu_dev_silver, "Not Snapdragon 820/821!");
		return -ENODEV;
	}

	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev_silver);
	if (IS_ERR(np))
		return PTR_ERR(np);

	if (!of_device_is_compatible(np, "operating-points-v2-kryo-cpu")) {
		ret = -ENOENT;
		goto free_np;
	}

	speedbin_nvmem = of_nvmem_cell_get(np, NULL);
	if (IS_ERR(speedbin_nvmem)) {
		ret = PTR_ERR(speedbin_nvmem);
		dev_err(cpu_dev_silver, "Could not get nvmem cell: %d\n",
ret);
		goto free_np;
	}

	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
	nvmem_cell_put(speedbin_nvmem);

	switch (msm8996_version) {
	case MSM8996_V3:
		versions = 1 << (unsigned int)(*speedbin);
		break;
	case MSM8996_SG:
		versions = 1 << ((unsigned int)(*speedbin) + 4);
		break;
	default:
		BUG();
		break;
	}

	opp_silver =
dev_pm_opp_set_supported_hw(cpu_dev_silver,&versions,1);
	if (IS_ERR(opp_silver)) {
		dev_err(cpu_dev_silver, "Failed to set supported
hardware\n");
		ret = PTR_ERR(opp_silver);
		goto free_np;
	}

	opp_gold = dev_pm_opp_set_supported_hw(cpu_dev_gold,&versions,1);
	if (IS_ERR(opp_gold)) {
		dev_err(cpu_dev_gold, "Failed to set supported hardware\n");
		ret = PTR_ERR(opp_gold);
		goto free_opp_silver;
	}

	pdev = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
	if (!IS_ERR(pdev))
		return 0;

	ret = PTR_ERR(pdev);
	dev_err(cpu_dev_silver, "Failed to register platform device\n");
	dev_pm_opp_put_supported_hw(opp_gold);

free_opp_silver:
	dev_pm_opp_put_supported_hw(opp_silver);

free_np:
	of_node_put(np);

	return ret;
}
late_initcall(qcom_cpufreq_kryo_driver_init);

MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Kryo CPUfreq driver");
MODULE_LICENSE("GPL v2");






> -----Original Message-----
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Sent: Monday, May 21, 2018 07:50
> To: ilialin@codeaurora.org
> Cc: mturquette@baylibre.com; sboyd@kernel.org; robh@kernel.org;
> mark.rutland@arm.com; nm@ti.com; lgirdwood@gmail.com;
> broonie@kernel.org; andy.gross@linaro.org; david.brown@linaro.org;
> catalin.marinas@arm.com; will.deacon@arm.com; rjw@rjwysocki.net; linux-
> clk@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-pm@vger.kernel.org; linux-arm-
> msm@vger.kernel.org; linux-soc@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; rnayak@codeaurora.org;
> amit.kucheria@linaro.org; nicolas.dechesne@linaro.org;
> celster@codeaurora.org; tfinkel@codeaurora.org
> Subject: Re: [PATCH v8 10/15] cpufreq: Add Kryo CPU scaling driver
> 
> On 19-05-18, 14:45, ilialin@codeaurora.org wrote:
> > Hi Viresh,
> >
> > If I send patches in reply, it will produce new patches, instead of
> > answers in the thread. Please find below the file dump.
> 
> There is one email from you which appears to be just fine and appears to
be
> in reply to this thread only. Maybe its your email client that screwed it
up for
> you ? Things look good in mutt.
> 
> --
> viresh
