Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7623C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7657320C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pP80PnJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbfB0NK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:10:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40899 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbfB0NKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:10:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id g20so4779721wmh.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 05:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sja5VFo1EQDHP6qZ43IkInaQbb/huVQfu1jUcq5Lg7A=;
        b=pP80PnJmhleIBb1SHRTyGc5mwo8ODxhnElEjD78hXEc62DLGRV6bDoNRN1jwbL+Lf9
         U5Uz2iSlSZxVWnfiITUFugdd/lJO6oSR2wbf4LJCs+Y34mfEj+JcubimF9clpHw725Ap
         tnsHCHt9KPiTy9+rU6xd35NhT8KB4HSEbVxL4Q4aNIwmx05Wysz8ZFv1aq53c4GjyFyd
         7K9KtHVAamgkJAyxbHQlpSPV3vqoWzxNmADHPyh9zd152kOvYO339fDBhymzeuU6lAan
         SL79S2CfE3lkZObL8p2Qo3dObFULH43v93GxapCvrftw06j9LmL78t4kTzmPIRk0AMQ4
         r64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sja5VFo1EQDHP6qZ43IkInaQbb/huVQfu1jUcq5Lg7A=;
        b=G7JKY5lEoHcRix8RHaWYmJgxL/AS8C57hZZBdAOnaJbxhTs+VDFHymWGwO9+ZKg71T
         4J7u+5SNfXyW4xoXuiCxSoqP9JjhxnQkd2pmq6FiikrCeUJ+nBfZtgYlnmckZGPmBqvY
         7AHUH/Vv5p8hfWYYUrqIW/4Ajh+zi4OHzwx67i2TvAJ2TMiSpJTpBpIOJgH5bASutw3b
         3JC8UZUZ8nWwkeZWEhZfAlZKo+2/Y/SqPCAgsFv8ZlxegubGJbN0xubo+7m2KTnYErE3
         dkIdQ4YvU8nfsdrWo6S1JlV6sakexvCJ6/TJrE5ZQ/t1nnNO381YZHkUNyy41JEz+P4B
         Jzbw==
X-Gm-Message-State: AHQUAuY05o4VXVmeLSQBerIStFYoad1oMDYbofCNR2EcnG+rvdQSL0Og
        27a2lIEU73zAya/6vHnvv7l16oSznpo=
X-Google-Smtp-Source: AHgI3IYQmtFDf41TaJjnSt5dZhQTv30sWKV4aIOa459TjrbyCL8Hzs+Os9+wbdPuIaILWl82mR8HWQ==
X-Received: by 2002:a1c:39d5:: with SMTP id g204mr2361578wma.17.1551273022185;
        Wed, 27 Feb 2019 05:10:22 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y20sm2278968wmi.34.2019.02.27.05.10.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 05:10:21 -0800 (PST)
Subject: Re: [PATCH V2] cpufreq: kyro: Release OPP tables on module removal
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, Ilia Lin <ilia.lin@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, amit.kucheria@linaro.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <78f96969448b17e95b0b21cb78194bb9f709a897.1551261748.git.viresh.kumar@linaro.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <23ab0431-de19-4f5d-219f-dbfa890b7946@linaro.org>
Date:   Wed, 27 Feb 2019 15:10:18 +0200
MIME-Version: 1.0
In-Reply-To: <78f96969448b17e95b0b21cb78194bb9f709a897.1551261748.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/19 12:04, Viresh Kumar wrote:
> Commit 5ad7346b4ae2 ("cpufreq: kryo: Add module remove and exit") made
> it possible to build the kyro cpufreq driver as a module, but it failed

Nit: s/kyro/kryo/ above and in the subject

> to release all the resources, i.e. OPP tables, when the module is
> unloaded.
> 
> This patch fixes it by releasing the OPP tables, by calling
> dev_pm_opp_put_supported_hw() for them, from the
> qcom_cpufreq_kryo_remove() routine. The array of pointers to the OPP
> tables is also allocated dynamically now in qcom_cpufreq_kryo_probe(),
> as the pointers will be required while releasing the resources.
> 
> Compile tested only.
> 
> Cc: 4.18+ <stable@vger.kernel.org> # v4.18+
> Fixes: 5ad7346b4ae2 ("cpufreq: kryo: Add module remove and exit")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V1->V2:
> - The previous version targeted a compile time issue of frame size but
>   this fixes a bug in the driver and needs to get applied to 4.18+
>   kernels.
> - This may go in 5.0 release.
> - Haven't included any Reviewed-by tags as there were many changes in
>   this version.
> 
>  drivers/cpufreq/qcom-cpufreq-kryo.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> index 2a3675c24032..65edbfd4d4a5 100644
> --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> @@ -75,7 +75,7 @@ static enum _msm8996_version qcom_cpufreq_kryo_get_msm_id(void)
>  
>  static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  {
> -	struct opp_table *opp_tables[NR_CPUS] = {0};
> +	struct opp_table **opp_tables;
>  	enum _msm8996_version msm8996_version;
>  	struct nvmem_cell *speedbin_nvmem;
>  	struct device_node *np;
> @@ -133,6 +133,10 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  	}
>  	kfree(speedbin);
>  
> +	opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables), GFP_KERNEL);
> +	if (!opp_tables)
> +		return -ENOMEM;
> +
>  	for_each_possible_cpu(cpu) {
>  		cpu_dev = get_cpu_device(cpu);
>  		if (NULL == cpu_dev) {
> @@ -151,8 +155,10 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  
>  	cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
>  							  NULL, 0);
> -	if (!IS_ERR(cpufreq_dt_pdev))
> +	if (!IS_ERR(cpufreq_dt_pdev)) {
> +		platform_set_drvdata(pdev, opp_tables);
>  		return 0;
> +	}
>  
>  	ret = PTR_ERR(cpufreq_dt_pdev);
>  	dev_err(cpu_dev, "Failed to register platform device\n");
> @@ -163,13 +169,23 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  			break;
>  		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
>  	}
> +	kfree(opp_tables);
>  
>  	return ret;
>  }
>  
>  static int qcom_cpufreq_kryo_remove(struct platform_device *pdev)
>  {
> +	struct opp_table **opp_tables = platform_get_drvdata(pdev);
> +	unsigned cpu;

Nit: unsigned int

> +
>  	platform_device_unregister(cpufreq_dt_pdev);
> +
> +	for_each_possible_cpu(cpu)
> +		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
> +
> +	kfree(opp_tables);
> +
>  	return 0;
>  }
>  

Reviewed-by: Georgi Djakov <georgi.djakov@linaro.org>

Thanks,
Georgi
