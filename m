Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754044AbeEWFoN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 01:44:13 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42094 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753852AbeEWFoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 01:44:09 -0400
X-Google-Smtp-Source: AB8JxZrWjTy8nouJbHRYsxQ+8zonqZ+wyvUimHwsxfujtwpRUVK9ZC/4xUr42ql/CntvP94kgrgxzA==
Date: Wed, 23 May 2018 11:14:05 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Ilia Lin <ilialin@codeaurora.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] cpufreq: Add Kryo CPU scaling driver
Message-ID: <20180523054405.edj4svjdf5picno2@vireshk-i7>
References: <1526729701-8589-1-git-send-email-ilialin@codeaurora.org>
 <1526988585-21678-1-git-send-email-ilialin@codeaurora.org>
 <20180522130704.GA31065@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522130704.GA31065@e107155-lin>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-05-18, 14:07, Sudeep Holla wrote:
> On Tue, May 22, 2018 at 02:29:45PM +0300, Ilia Lin wrote:
> > In Certain QCOM SoCs like apq8096 and msm8996 that have KRYO processors,
> > the CPU frequency subset and voltage value of each OPP varies
> > based on the silicon variant in use. Qualcomm Process Voltage Scaling Tables
> > defines the voltage and frequency value based on the msm-id in SMEM
> > and speedbin blown in the efuse combination.
> > The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
> > to provide the OPP framework with required information.
> > This is used to determine the voltage and frequency value for each OPP of
> > operating-points-v2 table when it is parsed by the OPP framework.
> > 
> > Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> [...]
> 
> > +
> > +	switch (msm8996_version) {
> > +	case MSM8996_V3:
> > +		versions = 1 << (unsigned int)(*speedbin);
> > +		break;
> > +	case MSM8996_SG:
> > +		versions = 1 << ((unsigned int)(*speedbin) + 4);
> > +		break;
> > +	default:
> > +		BUG();
> > +		break;
> > +	}
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		cpu_dev = get_cpu_device(cpu);
> > +		if (NULL == cpu_dev) {
> > +			ret = -ENODEV;
> > +			goto free_opp;
> > +		}
> > +
> > +		opp_tables[cpu] = dev_pm_opp_set_supported_hw(cpu_dev,
> > +							      &versions, 1);
> 
> Will be not get NULL for all CPUs except 0 ?

With my patches, we will get the OPP table again with refcount
incremented. And on failures, we need to call put-supported-hw helper
only for the CPUs for which it passed previously.

-- 
viresh
