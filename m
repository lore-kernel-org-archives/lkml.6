Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933930AbeEWRm1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 13:42:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53772 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933884AbeEWRmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 13:42:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 28912601E8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilialin@codeaurora.org
From: <ilialin@codeaurora.org>
To: "'Sudeep Holla'" <sudeep.holla@arm.com>, <vireshk@kernel.org>,
        <nm@ti.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <mark.rutland@arm.com>, <rjw@rjwysocki.net>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1527079139-3558-1-git-send-email-ilialin@codeaurora.org> <1527079139-3558-2-git-send-email-ilialin@codeaurora.org> <1ec7645d-72b6-5a1a-48c3-831a3c484a0e@arm.com>
In-Reply-To: <1ec7645d-72b6-5a1a-48c3-831a3c484a0e@arm.com>
Subject: RE: [PATCH v11 1/2] cpufreq: Add Kryo CPU scaling driver
Date: Wed, 23 May 2018 20:42:15 +0300
Message-ID: <004301d3f2bd$66cf03a0$346d0ae0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLuzorm6MUHRcprQ6BNjG7R6Sz68AJAPGpWAZZZsIGh6SitkA==
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Sudeep Holla <sudeep.holla@arm.com>
> Sent: Wednesday, May 23, 2018 16:25
> To: Ilia Lin <ilialin@codeaurora.org>; vireshk@kernel.org; nm@ti.com;
> sboyd@kernel.org; robh@kernel.org; mark.rutland@arm.com;
> rjw@rjwysocki.net; linux-pm@vger.kernel.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Subject: Re: [PATCH v11 1/2] cpufreq: Add Kryo CPU scaling driver
> 
> 
> 
> On 23/05/18 13:38, Ilia Lin wrote:
> > In Certain QCOM SoCs like apq8096 and msm8996 that have KRYO
> > processors, the CPU frequency subset and voltage value of each OPP
> > varies based on the silicon variant in use. Qualcomm Process Voltage
> > Scaling Tables defines the voltage and frequency value based on the
> > msm-id in SMEM and speedbin blown in the efuse combination.
> > The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the
> > SoC to provide the OPP framework with required information.
> > This is used to determine the voltage and frequency value for each OPP
> > of
> > operating-points-v2 table when it is parsed by the OPP framework.
> >
> > Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> > ---
> >  drivers/cpufreq/Kconfig.arm          |  10 ++
> >  drivers/cpufreq/Makefile             |   1 +
> >  drivers/cpufreq/cpufreq-dt-platdev.c |   3 +
> >  drivers/cpufreq/qcom-cpufreq-kryo.c  | 181
> > +++++++++++++++++++++++++++++++++++
> >  4 files changed, 195 insertions(+)
> >  create mode 100644 drivers/cpufreq/qcom-cpufreq-kryo.c
> >
> > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> > index de55c7d..0bfd40e 100644
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
> > @@ -124,6 +124,16 @@ config ARM_OMAP2PLUS_CPUFREQ
> >  	depends on ARCH_OMAP2PLUS
> >  	default ARCH_OMAP2PLUS
> >
> > +config ARM_QCOM_CPUFREQ_KRYO
> > +	bool "Qualcomm Kryo based CPUFreq"
> > +	depends on QCOM_QFPROM
> > +	depends on QCOM_SMEM
> > +	select PM_OPP
> > +	help
> > +	  This adds the CPUFreq driver for Qualcomm Kryo SoC based boards.
> > +
> > +	  If in doubt, say N.
> > +
> 
> Sorry but just noticed now, any reason why this can't be module. I can't
> imagine any.

I was asked previously to change this from tristate to bool.

> 
> [..]
> 
> > +static int qcom_cpufreq_kryo_probe(struct platform_device *pdev) {
> > +	struct opp_table *opp_tables[NR_CPUS] = {0};
> > +	struct platform_device *cpufreq_dt_pdev;
> > +	enum _msm8996_version msm8996_version;
> > +	struct nvmem_cell *speedbin_nvmem;
> > +	struct device_node *np;
> > +	struct device *cpu_dev;
> 
> [..]
> 
> > +
> > +	cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -
> 1, NULL, 0);
> > +	if (!IS_ERR(cpufreq_dt_pdev))
> > +		return 0;
> > +
> > +	ret = PTR_ERR(cpufreq_dt_pdev);
> > +	dev_err(cpu_dev, "Failed to register platform device\n");
> > +
> > +free_opp:
> > +	for_each_possible_cpu(cpu) {
> > +		if (IS_ERR_OR_NULL(opp_tables[cpu]))
> > +			break;
> > +		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int __init qcom_cpufreq_kryo_init(void) {
> > +	/*
> > +	 * Since the driver depends on smem and nvmem drivers, which may
> > +	 * return EPROBE_DEFER, all the real activity is done in the probe,
> > +	 * which may be defered as well. The init here is only registering
> > +	 * a platform device.
> > +	 */
> > +	platform_device_register_simple("qcom-cpufreq-kryo", -1, NULL, 0);
> > +	return 0;
> > +}
> > +module_init(qcom_cpufreq_kryo_init);
> 
> Do you need this at all ? See below on how to eliminate the need for this.
> 
> > +
> > +static struct platform_driver qcom_cpufreq_kryo_driver = {
> > +	.probe = qcom_cpufreq_kryo_probe,
> > +	.driver = {
> > +		.name = "qcom-cpufreq-kryo",
> > +	},
> > +};
> > +builtin_platform_driver(qcom_cpufreq_kryo_driver);
> 
> Use builtin_platform_driver_probe and remove qcom_cpufreq_kryo_init or
> use module_platform_driver_probe if it can be module.
> 
> --
> Regards,
> Sudeep
