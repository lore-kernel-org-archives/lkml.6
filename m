Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD45C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F5F2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cq30fiW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F5F2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937490AbeFSJa7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:30:59 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42320 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937215AbeFSJa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:30:56 -0400
Received: by mail-pg0-f67.google.com with SMTP id c10-v6so8899128pgu.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 02:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DZp8i1ERX48yktDo0QZ9NY2NKGqgrT3a0gQz5yEKMs8=;
        b=cq30fiW596t2cgCJBzwocgGnxsnNOU7O7wT3DoUiSPxPCWhF3DKi+NkMt5yxMRoRqH
         z1svclkp11OzlljMzL9uIxNZMlBIEc2XTYOJ3V+sBODTOgOTmsObB7lVsWcCIXaDo0sz
         OaUgC8REX/TlfF49ATe28UpSGkE/xeN/NMLkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DZp8i1ERX48yktDo0QZ9NY2NKGqgrT3a0gQz5yEKMs8=;
        b=luYFx0IF23ktu6Cj82XEaXsdzx6l+bnkHzfKYe0rdo89KNtRtZAnQYmG1FlgnPScSs
         LKRGTtkvobeBEWL+kJq9fZbwJb/+cjyOVOg2GzQsRslzoD4PtSnTksXv43R0gEcP3D4g
         9NcrqxTWsgDw2RQVHC7Iq4DI++QYOnlu4qgTP8KE3gwRrvVhgJJQb08H9pq3x3y1zkZi
         t2H70BU0tNFuUJAZ/2q3SfyK5Tnh2Tnz+E2DxGse9mcU96NhfrMeUIqm25382F7EvmCK
         XdxjkrAz2P/AsHq9aYcLalJ47SNPJKavyxk9Gc9ImC3ORKg4XqdsEyRHFPa6rCXYduWI
         64XQ==
X-Gm-Message-State: APt69E132DQPXZswTjqyAKWi05ingCSoMDm9Wodw9+ItnWpSMdxl0atT
        g8BGuLoCJhTPWlvOOeAtKsRoXvHcu1s=
X-Google-Smtp-Source: ADUXVKIG+U5Go0TwV6bfpKGEIgTDh8hmFy7eqLC3I+uJhonqhoRmnseotE1Hq7hyeJz+MsgbE0DsOA==
X-Received: by 2002:a65:6517:: with SMTP id x23-v6mr14348702pgv.268.1529400656423;
        Tue, 19 Jun 2018 02:30:56 -0700 (PDT)
Received: from localhost ([122.171.103.96])
        by smtp.gmail.com with ESMTPSA id l11-v6sm22692943pff.50.2018.06.19.02.30.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 02:30:55 -0700 (PDT)
Date:   Tue, 19 Jun 2018 15:00:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org
Subject: Re: [PATCH v4 2/2] cpufreq: qcom-fw: Add support for QCOM cpufreq FW
 driver
Message-ID: <20180619093053.6q624k54bffrcqu6@vireshk-i7>
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
 <1528801355-18719-3-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528801355-18719-3-git-send-email-tdas@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-06-18, 16:32, Taniya Das wrote:
> +static int qcom_get_related_cpus(struct device_node *np, struct cpumask *m)
> +{
> +	struct device_node *cpu_np, *freq_np;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_np = of_cpu_device_node_get(cpu);
> +		if (!cpu_np)
> +			continue;
> +		freq_np = of_parse_phandle(cpu_np, "qcom,freq-domain", 0);
> +		if (!freq_np)
> +			continue;
> +		if (freq_np == np)
> +			cpumask_set_cpu(cpu, m);
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_cpu_resources_init(struct platform_device *pdev,
> +				   struct device_node *np, unsigned int cpu)
> +{
> +	struct cpufreq_qcom *c;
> +	struct resource res;
> +	struct device *dev = &pdev->dev;
> +	void __iomem *en_base;
> +	int index, ret;
> +
> +	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
> +	if (!c)
> +		return -ENOMEM;
> +
> +	index = of_property_match_string(np, "reg-names", "enable");
> +	if (index < 0)
> +		return index;
> +
> +	if (of_address_to_resource(np, index, &res))
> +		return -ENOMEM;
> +
> +	en_base = devm_ioremap(dev, res.start, resource_size(&res));
> +	if (!en_base) {
> +		dev_err(dev, "Unable to map %s enable-base\n", np->name);
> +		return -ENOMEM;
> +	}
> +
> +	/* FW should be in enabled state to proceed */
> +	if (!(readl_relaxed(en_base) & 0x1)) {
> +		dev_err(dev, "%s firmware not enabled\n", np->name);
> +		return -ENODEV;
> +	}
> +	devm_iounmap(&pdev->dev, en_base);
> +
> +	index = of_property_match_string(np, "reg-names", "perf");
> +	if (index < 0)
> +		return index;
> +
> +	if (of_address_to_resource(np, index, &res))
> +		return -ENOMEM;
> +
> +	c->perf_base = devm_ioremap(dev, res.start, resource_size(&res));
> +	if (!c->perf_base) {
> +		dev_err(dev, "Unable to map %s perf-base\n", np->name);
> +		return -ENOMEM;
> +	}
> +
> +	index = of_property_match_string(np, "reg-names", "lut");
> +	if (index < 0)
> +		return index;
> +
> +	if (of_address_to_resource(np, index, &res))
> +		return -ENOMEM;
> +
> +	c->lut_base = devm_ioremap(dev, res.start, resource_size(&res));
> +	if (!c->lut_base) {
> +		dev_err(dev, "Unable to map %s lut-base\n", np->name);
> +		return -ENOMEM;
> +	}
> +
> +	ret = qcom_get_related_cpus(np, &c->related_cpus);
> +	if (ret) {
> +		dev_err(dev, "%s failed to get related CPUs\n", np->name);
> +		return ret;
> +	}
> +
> +	c->max_cores = cpumask_weight(&c->related_cpus);
> +	if (!c->max_cores)
> +		return -ENOENT;
> +
> +	ret = qcom_read_lut(pdev, c);
> +	if (ret) {
> +		dev_err(dev, "%s failed to read LUT\n", np->name);
> +		return ret;
> +	}
> +
> +	qcom_freq_domain_map[cpu] = c;

This still looks wrong. You have removed the for-each-cpu loop here, so what
will happen now is that you will allocate a different "struct cpufreq_qcom" for
every CPU, even if they are related. Is that what you should be doing ? I think
there should still be a single copy of that structure which must be used by all
related CPUs.

> +
> +	return 0;
> +}
> +
> +static int qcom_resources_init(struct platform_device *pdev)
> +{
> +	struct device_node *np, *cpu_np;
> +	unsigned int cpu;
> +	int ret;
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_np = of_cpu_device_node_get(cpu);
> +		if (!cpu_np) {
> +			dev_err(&pdev->dev, "Failed to get cpu %d device\n",
> +				cpu);
> +			continue;
> +		}
> +
> +		np = of_parse_phandle(cpu_np, "qcom,freq-domain", 0);
> +		if (!np) {
> +			dev_err(&pdev->dev, "Failed to get freq-domain device\n");
> +			return -EINVAL;
> +		}
> +
> +		of_node_put(cpu_np);
> +
> +		ret = qcom_cpu_resources_init(pdev, np, cpu);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

-- 
viresh
