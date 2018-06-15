Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3E820C5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8350208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XbgAMjdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8350208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965487AbeFOCpc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:45:32 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37777 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965174AbeFOCpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:45:30 -0400
Received: by mail-pg0-f65.google.com with SMTP id r21-v6so3780254pgv.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 19:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DTk/s8fzsUu66K9r3XiCb0g0cZz33jEHzEOMnHieuLY=;
        b=XbgAMjdo2mfdEcv/vlbTL8TA1EqlO7p+cNMU4zr+ZW4URp2C0TqktuRGpgy+mNDXrb
         OPh9TvAPX6eVXt4iyIHlPu+gE314i5dK2z61TUw6Jx6sYZ6XZxUP+VyUDfqeaJGjeDHd
         X6brG4oN9mF8AqOU6uhLHngQtQQGsuv4puTzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DTk/s8fzsUu66K9r3XiCb0g0cZz33jEHzEOMnHieuLY=;
        b=ZaEQxShd78u4B9OwUA0MJBoRCTaW9IasLcryeo5m+10mh27oI75gZhSmEUbT76GO7e
         jHKasmppU1n9I8TvOrQPtLFWU0yH+Ny8OV6AAOyuw/X5p4mr6uACw4ciSjzBiA9r1dPD
         z5nQiW4Hf9t352kkjUSjbLZI3Ghu47HMO6PrljNp4D+KqpypS+UfHNF5qN2DqV+X61kM
         Qn9NDeQbTEILm3dHOoDWZWlDS6FE8HkQQODYmXyD3GFAVYiqonYGYvraOJF/4NeE3oL5
         1n3o8FPqoc7b3YLofqSxb3JFXKuT87ZTwS49WEnn0Gu0v6xESktLLHBfz6Dp4WDJaDU+
         YZ/A==
X-Gm-Message-State: APt69E38tk4fxxaIaZNxu5mNILUvCDldPWMzlPd7QeWCqr3cB/yykT4r
        iqMkRmXpg52YGV9B1C9BTRGSUw==
X-Google-Smtp-Source: ADUXVKIa3z+gBsLH0vHQjUX7JfcEWQlFgRmItgXYtz4rgha5/JWFHrdh9Yy3OTXQC+8dkP6nq9PuDA==
X-Received: by 2002:a65:6008:: with SMTP id m8-v6mr4537316pgu.134.1529030729975;
        Thu, 14 Jun 2018 19:45:29 -0700 (PDT)
Received: from localhost ([122.167.141.115])
        by smtp.gmail.com with ESMTPSA id n25-v6sm9849184pff.119.2018.06.14.19.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 19:45:28 -0700 (PDT)
Date:   Fri, 15 Jun 2018 08:15:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ilia.lin@gmail.com
Cc:     Ilia Lin <ilialin@codeaurora.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: kryo: Add module remove and exit
Message-ID: <20180615024524.5ecazjeufuiqmast@vireshk-i7>
References: <20180607205827.1588-1-ilia.lin@gmail.com>
 <20180614204212.2028-1-ilia.lin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614204212.2028-1-ilia.lin@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-06-18, 22:42, ilia.lin@gmail.com wrote:
> From: Ilia Lin <ilia.lin@gmail.com>
> 
> Add device remove and module exit code to make the driver
> functioning as a loadable module.
> 
> Fixes: ac28927659be (cpufreq: kryo: allow building as a loadable module)
> Signed-off-by: Ilia Lin <ilia.lin@gmail.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-kryo.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> index 5e9511223ce9..01bddacf5c3b 100644
> --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> @@ -42,6 +42,8 @@ enum _msm8996_version {
>  	NUM_OF_MSM8996_VERSIONS,
>  };
>  
> +struct platform_device *cpufreq_dt_pdev, *kryo_cpufreq_pdev;
> +
>  static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
>  {
>  	size_t len;
> @@ -74,7 +76,6 @@ static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
>  static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  {
>  	struct opp_table *opp_tables[NR_CPUS] = {0};
> -	struct platform_device *cpufreq_dt_pdev;
>  	enum _msm8996_version msm8996_version;
>  	struct nvmem_cell *speedbin_nvmem;
>  	struct device_node *np;
> @@ -129,6 +130,7 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  		BUG();
>  		break;
>  	}
> +	kfree(speedbin);

Again, stuff like this can't go in this patch itself. It is a separate
bug fix and you should send it with a matching fixes tag separately.

>  
>  	for_each_possible_cpu(cpu) {
>  		cpu_dev = get_cpu_device(cpu);
> @@ -164,8 +166,15 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int qcom_cpufreq_kryo_remove(struct platform_device *pdev)
> +{
> +	platform_device_unregister(cpufreq_dt_pdev);
> +	return 0;
> +}
> +
>  static struct platform_driver qcom_cpufreq_kryo_driver = {
>  	.probe = qcom_cpufreq_kryo_probe,
> +	.remove = qcom_cpufreq_kryo_remove,
>  	.driver = {
>  		.name = "qcom-cpufreq-kryo",
>  	},
> @@ -200,8 +209,9 @@ static int __init qcom_cpufreq_kryo_init(void)
>  	if (unlikely(ret < 0))
>  		return ret;
>  
> -	ret = PTR_ERR_OR_ZERO(platform_device_register_simple(
> -		"qcom-cpufreq-kryo", -1, NULL, 0));
> +	kryo_cpufreq_pdev = platform_device_register_simple(
> +		"qcom-cpufreq-kryo", -1, NULL, 0);
> +	ret = PTR_ERR_OR_ZERO(kryo_cpufreq_pdev);
>  	if (0 == ret)
>  		return 0;
>  
> @@ -210,5 +220,12 @@ static int __init qcom_cpufreq_kryo_init(void)
>  }
>  module_init(qcom_cpufreq_kryo_init);
>  
> +static void __init qcom_cpufreq_kryo_exit(void)
> +{
> +	platform_device_unregister(kryo_cpufreq_pdev);
> +	platform_driver_unregister(&qcom_cpufreq_kryo_driver);
> +}
> +module_exit(qcom_cpufreq_kryo_exit);
> +
>  MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Kryo CPUfreq driver");
>  MODULE_LICENSE("GPL v2");
> -- 
> 2.11.0

-- 
viresh
