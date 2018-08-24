Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D464C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1624321529
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PtRnfzI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1624321529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbeHXS5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:57:04 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39829 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbeHXS5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:57:04 -0400
Received: by mail-lf1-f67.google.com with SMTP id j201-v6so6974034lfg.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 08:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VOTlw0jbFzeVYfn2nvtN837cqf7mbmCbkdOjrsuQfJI=;
        b=PtRnfzI+dkg9eE0EG9HOuGeM255u//4F4/tBULMJPeVw2wAcy2GekZVbFLsYC+txWf
         qwUQa6NFL6zYG44njCIlkphCKe6iVN9QIEVuWGNwzEVj/Odw89qk/JN5v7Xb69A4irlH
         MzHu34Mee1yuUMkuhSsniYleuM/QILaDzpOjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VOTlw0jbFzeVYfn2nvtN837cqf7mbmCbkdOjrsuQfJI=;
        b=Hc/gP8FwPDNs7XMPOD7WL1c3LkxUPFKgEtBpTojuCvaxNNjJUFBtg9hSyB0OlbiOVq
         R5b6EHOzy8RKLbReTXC/Fot63hwoU2tkny+Os8oL1MkytGUFKN0neoEsObQgH9oyQ5jR
         toBL0CG8mQ75Jd96JipeZ8GQd2QaSjdOnN6frvCdJH1V9QBkJNkBuftu/QpB2Qi+i0GT
         t0qKlBRtsSobRfejyOCfcrjyBErxDifuySYm9dHgOn3POJwYU4G14dt6gSuCR+f4WJg2
         z7H0P0EKj9/HTlCptYxOq9bLShPDKpEal/rMEC4NCDl7FXGMUmOYzeBU5zNn5Nokyuvb
         nkAA==
X-Gm-Message-State: APzg51AsMubzeOHFp++k9Zu7O8unsc48krwOBpznKTqI/HarixlQ7ne/
        rjqKo4dSBTC+5x8u75V5jXZ5fA==
X-Google-Smtp-Source: ANB0VdaI6BluqUTXsBgWPAWPnP1CRDmlKO7Avux+5f3rOXvaqh1KhIbhQOzHKegmxGxpf/jMSiGLuQ==
X-Received: by 2002:a19:5410:: with SMTP id i16-v6mr1634454lfb.122.1535124115390;
        Fri, 24 Aug 2018 08:21:55 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id r138-v6sm1378413lfr.50.2018.08.24.08.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 08:21:54 -0700 (PDT)
Date:   Fri, 24 Aug 2018 17:21:52 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Sricharan R <sricharan@codeaurora.org>
Cc:     mark.rutland@arm.com, robh@kernel.org, sudeep.holla@arm.com,
        linux@arm.linux.org.uk, ctatlor97@gmail.com, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, sboyd@codeaurora.org,
        linux@armlinux.org.uk, thierry.escande@linaro.org,
        linux-kernel@vger.kernel.org, david.brown@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        andy.gross@linaro.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v12 14/14] cpufreq: qcom: Add support for krait based socs
Message-ID: <20180824152152.GA24008@centauri.lan>
References: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
 <1534248753-2440-15-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534248753-2440-15-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 05:42:33PM +0530, Sricharan R wrote:
> In Certain QCOM SoCs like ipq8064, apq8064, msm8960, msm8974
> that has KRAIT processors the voltage/current value of each OPP
> varies based on the silicon variant in use.
> 
> The required OPP related data is determined based on
> the efuse value. This is similar to the existing code for
> kryo cores. So adding support for krait cores here.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  .../devicetree/bindings/opp/qcom-nvmem-cpufreq.txt |   3 +-
>  drivers/cpufreq/Kconfig.arm                        |   2 +-
>  drivers/cpufreq/cpufreq-dt-platdev.c               |   5 +
>  drivers/cpufreq/qcom-cpufreq-nvmem.c               | 151 +++++++++++++++++++--
>  4 files changed, 149 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> index 6dcdfcd..7bc0f1a 100644
> --- a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> +++ b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> @@ -19,7 +19,8 @@ In 'cpus' nodes:
>  
>  In 'operating-points-v2' table:
>  - compatible: Should be
> -	- 'operating-points-v2-qcom-cpu' for apq8096 and msm8996.
> +	- 'operating-points-v2-qcom-cpu' for apq8096, msm8996, msm8974,
> +					     apq8064, msm8960 and ipq8074.
>  - nvmem-cells: A phandle pointing to a nvmem-cells node representing the
>  		efuse registers that has information about the
>  		speedbin that is used to select the right frequency/voltage

Hello Sricharan,

I see several references to kryo in this file that should probably be removed
or renamed.

Also, the documentation for opp-supported-hw lists how the different
bitmap values maps to the different compatible HW. It might be good to add a
note that the table is only for msm8996, and for orther SoCs, there is a 1:1
speedbin to opp-supported-hw mapping.


Kind regards,
Niklas


> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 13fbd97..497ae89 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -126,7 +126,7 @@ config ARM_OMAP2PLUS_CPUFREQ
>  
>  config ARM_QCOM_CPUFREQ_NVMEM
>  	tristate "Qualcomm nvmem based CPUFreq"
> -	depends on ARM64
> +	depends on ARCH_QCOM
>  	depends on QCOM_QFPROM
>  	depends on QCOM_SMEM
>  	select PM_OPP
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index fe14c57..917cdc2 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -128,6 +128,11 @@
>  	{ .compatible = "ti,am43", },
>  	{ .compatible = "ti,dra7", },
>  
> +	{ .compatible = "qcom,ipq8064", },
> +	{ .compatible = "qcom,apq8064", },
> +	{ .compatible = "qcom,msm8974", },
> +	{ .compatible = "qcom,msm8960", },
> +
>  	{ }
>  };
>  
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index 0ad8e5b..5f2add0 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -45,6 +45,82 @@ enum _msm8996_version {
>  
>  static struct platform_device *cpufreq_dt_pdev, *cpufreq_pdev;
>  
> +static void __init get_krait_bin_format_a(int *speed, int *pvs, int *pvs_ver,
> +					  struct nvmem_cell *pvs_nvmem, u8 *buf)
> +{
> +	u32 pte_efuse;
> +
> +	pte_efuse = *((u32 *)buf);
> +
> +	*speed = pte_efuse & 0xf;
> +	if (*speed == 0xf)
> +		*speed = (pte_efuse >> 4) & 0xf;
> +
> +	if (*speed == 0xf) {
> +		*speed = 0;
> +		pr_warn("Speed bin: Defaulting to %d\n", *speed);
> +	} else {
> +		pr_info("Speed bin: %d\n", *speed);
> +	}
> +
> +	*pvs = (pte_efuse >> 10) & 0x7;
> +	if (*pvs == 0x7)
> +		*pvs = (pte_efuse >> 13) & 0x7;
> +
> +	if (*pvs == 0x7) {
> +		*pvs = 0;
> +		pr_warn("PVS bin: Defaulting to %d\n", *pvs);
> +	} else {
> +		pr_info("PVS bin: %d\n", *pvs);
> +	}
> +
> +	kfree(buf);
> +}
> +
> +static void __init get_krait_bin_format_b(int *speed, int *pvs, int *pvs_ver,
> +					  struct nvmem_cell *pvs_nvmem, u8 *buf)
> +{
> +	u32 pte_efuse, redundant_sel;
> +
> +	pte_efuse = *((u32 *)buf);
> +	redundant_sel = (pte_efuse >> 24) & 0x7;
> +	*speed = pte_efuse & 0x7;
> +
> +	/* 4 bits of PVS are in efuse register bits 31, 8-6. */
> +	*pvs = ((pte_efuse >> 28) & 0x8) | ((pte_efuse >> 6) & 0x7);
> +	*pvs_ver = (pte_efuse >> 4) & 0x3;
> +
> +	switch (redundant_sel) {
> +	case 1:
> +		*speed = (pte_efuse >> 27) & 0xf;
> +		break;
> +	case 2:
> +		*pvs = (pte_efuse >> 27) & 0xf;
> +		break;
> +	}
> +
> +	/* Check SPEED_BIN_BLOW_STATUS */
> +	if (pte_efuse & BIT(3)) {
> +		pr_info("Speed bin: %d\n", *speed);
> +	} else {
> +		pr_warn("Speed bin not set. Defaulting to 0!\n");
> +		*speed = 0;
> +	}
> +
> +	/* Check PVS_BLOW_STATUS */
> +	pte_efuse = *(((u32 *)buf) + 4);
> +	pte_efuse &= BIT(21);
> +	if (pte_efuse) {
> +		pr_info("PVS bin: %d\n", *pvs);
> +	} else {
> +		pr_warn("PVS bin not set. Defaulting to 0!\n");
> +		*pvs = 0;
> +	}
> +
> +	pr_info("PVS version: %d\n", *pvs_ver);
> +	kfree(buf);
> +}
> +
>  static enum _msm8996_version __init qcom_cpufreq_get_msm_id(void)
>  {
>  	size_t len;
> @@ -74,6 +150,35 @@ static enum _msm8996_version __init qcom_cpufreq_get_msm_id(void)
>  	return version;
>  }
>  
> +static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
> +					   struct nvmem_cell *speedbin_nvmem,
> +					   char **name,
> +					   u32 *versions)
> +{
> +	int speed = 0, pvs = 0, pvs_ver = 0;
> +	u8 *buf;
> +	size_t len;
> +
> +	buf = nvmem_cell_read(speedbin_nvmem, &len);
> +	if (len == 4) {
> +		get_krait_bin_format_a(&speed, &pvs, &pvs_ver,
> +				       speedbin_nvmem, buf);
> +	} else if (len == 8) {
> +		get_krait_bin_format_b(&speed, &pvs, &pvs_ver,
> +				       speedbin_nvmem, buf);
> +	} else {
> +		dev_err(cpu_dev, "Unable to read nvmem data. Defaulting to 0!\n");
> +		return -ENODEV;
> +	}
> +
> +	snprintf(*name, sizeof("speedXX-pvsXX-vXX"), "speed%d-pvs%d-v%d",
> +		 speed, pvs, pvs_ver);
> +
> +	*versions = (1 << speed);
> +
> +	return 0;
> +}
> +
>  static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
>  					  struct nvmem_cell *speedbin_nvmem,
>  					  char **pvs_name,
> @@ -83,6 +188,7 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
>  	u8 *speedbin;
>  	enum _msm8996_version msm8996_version;
>  
> +	*pvs_name = NULL;
>  	msm8996_version = qcom_cpufreq_get_msm_id();
>  	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
>  		dev_err(cpu_dev, "Not Snapdragon 820/821!");
> @@ -111,7 +217,7 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
>  
>  static int qcom_cpufreq_probe(struct platform_device *pdev)
>  {
> -	struct opp_table *opp_tables[NR_CPUS] = { NULL };
> +	struct opp_table *tbl1[NR_CPUS] = { NULL }, *tbl2[NR_CPUS] = { NULL };
>  	int (*get_version)(struct device *cpu_dev,
>  			   struct nvmem_cell *speedbin_nvmem,
>  			   char **name, int *versions);
> @@ -120,8 +226,8 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>  	struct device *cpu_dev;
>  	unsigned cpu;
>  	u32 versions;
> -	char *pvs_name = NULL;
>  	const struct of_device_id *match;
> +	char *pvs_name = "speedXX-pvsXX-vXX";
>  	int ret;
>  
>  	cpu_dev = get_cpu_device(0);
> @@ -163,10 +269,19 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>  			goto free_opp;
>  		}
>  
> -		opp_tables[cpu] = dev_pm_opp_set_supported_hw(cpu_dev,
> -							      &versions, 1);
> -		if (IS_ERR(opp_tables[cpu])) {
> -			ret = PTR_ERR(opp_tables[cpu]);
> +		if (pvs_name) {
> +			tbl1[cpu] = dev_pm_opp_set_prop_name(cpu_dev, pvs_name);
> +			if (IS_ERR(tbl1[cpu])) {
> +				ret = PTR_ERR(tbl1[cpu]);
> +				dev_err(cpu_dev, "Failed to add OPP name %s\n",
> +					pvs_name);
> +				goto free_opp;
> +			}
> +		}
> +
> +		tbl2[cpu] = dev_pm_opp_set_supported_hw(cpu_dev, &versions, 1);
> +		if (IS_ERR(tbl2[cpu])) {
> +			ret = PTR_ERR(tbl2[cpu]);
>  			dev_err(cpu_dev, "Failed to set supported hardware\n");
>  			goto free_opp;
>  		}
> @@ -182,9 +297,15 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
>  
>  free_opp:
>  	for_each_possible_cpu(cpu) {
> -		if (IS_ERR_OR_NULL(opp_tables[cpu]))
> +		if (IS_ERR_OR_NULL(tbl1[cpu]))
> +			break;
> +		dev_pm_opp_put_prop_name(tbl1[cpu]);
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		if (IS_ERR_OR_NULL(tbl2[cpu]))
>  			break;
> -		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
> +		dev_pm_opp_put_supported_hw(tbl2[cpu]);
>  	}
>  
>  	return ret;
> @@ -205,8 +326,18 @@ static int qcom_cpufreq_remove(struct platform_device *pdev)
>  };
>  
>  static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
> -	{ .compatible = "qcom,apq8096", .data = qcom_cpufreq_kryo_name_version},
> -	{ .compatible = "qcom,msm8996", .data = qcom_cpufreq_kryo_name_version},
> +	{ .compatible = "qcom,apq8096",
> +	  .data = qcom_cpufreq_kryo_name_version},
> +	{ .compatible = "qcom,msm8996",
> +	  .data = qcom_cpufreq_kryo_name_version},
> +	{ .compatible = "qcom,ipq8064",
> +	  .data = qcom_cpufreq_krait_name_version },
> +	{ .compatible = "qcom,apq8064",
> +	  .data = qcom_cpufreq_krait_name_version },
> +	{ .compatible = "qcom,msm8974",
> +	  .data = qcom_cpufreq_krait_name_version },
> +	{ .compatible = "qcom,msm8960",
> +	  .data = qcom_cpufreq_krait_name_version },
>  	{},
>  };
>  
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> 
