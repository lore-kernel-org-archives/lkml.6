Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC0FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5808420657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZW+BPhPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbfAQH1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:27:20 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43767 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730600AbfAQH1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:27:20 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so4383196pfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 23:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eD0lyzSRvpefDvYLI8Sl2SUZlTAol1MPWr5Dcjzo728=;
        b=ZW+BPhPoZYy9gCzbmQCddF+lqZmwJpsHdYlx1NmE7TpJpljS8/S+ioiAXJ4qXc+z8P
         VqSyM8eQNn2Sg53mum3U6isuPrVg3qW5Ly5998p+00lUAWyt5gKqtTxqjIk0l/YaKw50
         bk0ePoKW079guSVBen8E2MV5r0oMjc9KzQA7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eD0lyzSRvpefDvYLI8Sl2SUZlTAol1MPWr5Dcjzo728=;
        b=fyDY43OA5iJZLlzKHsm0AkRgR2Y+Kx9FXm3B42HxfRsVR8wybXN9XLhhV9nUTR4AH5
         /ZRFFKFh1SvvqooqUI7w18/QOz0JjyN6F3WIDvAYmbT8iXNkxVl10LAM70s7kx8qnhDH
         yN2/pORkWBH6a1ts/quUbjrdU6uU3GZG5vK2Azse4HEVOEShs8gmkHZ0Em++7VGETDff
         7WWtR+6/dKSdiDEuo/NLyfSHgO7Ux9/cLzTSbW6A6Idt7h/l9tr/S1dHCJOEQ1mcaEh0
         KqyfTJYFc6oTIYw9h0u7VRZErxzsAa7sQQqsJTDK88kBYRnZmqLNIoN/pb9Fi+BPbO2Y
         X89Q==
X-Gm-Message-State: AJcUukdkvLVDhAqSY0Qc5QDXUjLJfihf0mstA11nTImlVNXmyDHQH9eQ
        I4x3fkM0CsSZM45QCZovv+On4A==
X-Google-Smtp-Source: ALg8bN5q48A45qHJSr9lM+0lUWcZWeQq7fJj6KJDTv4/nmaM7Bqr90xsWHpkRSS48C9RpTp5IanUWA==
X-Received: by 2002:a63:cf48:: with SMTP id b8mr12682108pgj.17.1547710039388;
        Wed, 16 Jan 2019 23:27:19 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id h19sm1145853pfn.114.2019.01.16.23.27.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 23:27:18 -0800 (PST)
Date:   Thu, 17 Jan 2019 12:57:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        Matthias Kaehlcke <mka@chromium.org>, evgreen@google.com
Subject: Re: [PATCH v3] cpufreq: qcom: Read voltage LUT and populate OPP
Message-ID: <20190117072716.iy3glrtdpobsh5u2@vireshk-i7>
References: <1547708936-25661-1-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547708936-25661-1-git-send-email-tdas@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-01-19, 12:38, Taniya Das wrote:
> @@ -159,10 +170,18 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  	struct device *dev = &global_pdev->dev;
>  	struct of_phandle_args args;
>  	struct device_node *cpu_np;
> +	struct device *cpu_dev;
>  	struct resource *res;
>  	void __iomem *base;
>  	int ret, index;
> 
> +	cpu_dev = get_cpu_device(policy->cpu);
> +	if (!cpu_dev) {
> +		pr_err("%s: failed to get cpu%d device\n", __func__,
> +		       policy->cpu);
> +		return -ENODEV;
> +	}
> +
>  	cpu_np = of_cpu_device_node_get(policy->cpu);
>  	if (!cpu_np)
>  		return -EINVAL;
> @@ -199,12 +218,18 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> 
>  	policy->driver_data = base + REG_PERF_STATE;
> 
> -	ret = qcom_cpufreq_hw_read_lut(dev, policy, base);
> +	ret = qcom_cpufreq_hw_read_lut(policy, base);

I asked you to pass cpu_dev here instead of dev and you said okay in
the previous version of the patch. Didn't like it ?

-- 
viresh
