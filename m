Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4D5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92D12086A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RGo5ePis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92D12086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeGRGW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 02:22:58 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33878 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbeGRGW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 02:22:57 -0400
Received: by mail-pf0-f195.google.com with SMTP id k19-v6so1664432pfi.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 22:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lJSWeSe5/uZ21LHlgl/bkpSWtEe0H3Tsjj9hXdn8+8k=;
        b=RGo5ePisWQG7LkVFyYZcICq8eRtMXFarrddIb+z5/JqEMSu1K2KNpmSYjSxCVStJuU
         7DZF5HWmqdacmEajRKc3/YLsJVTh4Hz+cHMc8b/pftwqPHgAOf7l/gtMCGvuiUOPpEW/
         2GyEQHiWpxD9/wxQR6LX/guY/9oGoetOpRd2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lJSWeSe5/uZ21LHlgl/bkpSWtEe0H3Tsjj9hXdn8+8k=;
        b=nvkqHiP264liSY1Ecm3djSk84NSAyTHcEb/9gvwctrODmOPMxJKjCSoY6Z92LL01kE
         D9qhy1m5+Y5BLipxnzEK3TBxBkio+SYra8d5OGg6Qk/V5kLLRiI7wsKUNrQhF25HHYWI
         T5L462Fl7ScgFu+ofCSWOzjBe0r756TEMcUYTzGw7h6MYUNqFg+kdg6L7pkdplx4paVz
         PQab2s6THT27RXm7vLf5b8an9ZVfhzXSUueskP7KUab5erjEyPCxTExi2ZabV00JbqOG
         piS2qP7iaAubHig/Gn6HfqqBsJL03eRDYgvoN7SCTnA4cY5o8686sx361SaxoPyK281u
         QSMg==
X-Gm-Message-State: AOUpUlGlAjPpTT+dUVsEIP+i0l8W27QaJSLO5HFK0k2YX3/2WF2sp0+J
        7V6cRkcmPTdhXJHO4OJKBtmt8g==
X-Google-Smtp-Source: AAOMgpeHch4jlKydkjBSuWw4bbAUmUznM6L/Qa7yae8tfRafBYc/cyYWiD1IZz9YxNdb7WsE+JwxbQ==
X-Received: by 2002:a63:1015:: with SMTP id f21-v6mr4490766pgl.354.1531892810132;
        Tue, 17 Jul 2018 22:46:50 -0700 (PDT)
Received: from localhost ([122.171.235.75])
        by smtp.gmail.com with ESMTPSA id k128-v6sm3834545pgk.4.2018.07.17.22.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 22:46:49 -0700 (PDT)
Date:   Wed, 18 Jul 2018 11:16:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, amit.kucheria@linaro.org,
        evgreen@google.com
Subject: Re: [PATCH v6 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
Message-ID: <20180718054647.ysomgxiwzbuuptoc@vireshk-i7>
References: <1531892220-2046-1-git-send-email-tdas@codeaurora.org>
 <1531892220-2046-3-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531892220-2046-3-git-send-email-tdas@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-07-18, 11:07, Taniya Das wrote:
> +static int qcom_cpu_resources_init(struct platform_device *pdev,
> +				   struct device_node *np, unsigned int cpu,
> +				   unsigned long xo_rate)
> +{
> +	struct cpufreq_qcom *c;
> +	struct resource res;
> +	struct device *dev = &pdev->dev;
> +	const u16 *offsets;
> +	cpumask_t cpus_related;
> +	int ret, i, cpu_r;
> +	void __iomem *base;
> +
> +	cpumask_clear(&cpus_related);
> +
> +	ret = qcom_get_related_cpus(np, &cpus_related);
> +	if (ret) {
> +		dev_err(dev, "%s failed to get related CPUs\n", np->name);
> +		return ret;
> +	}
> +
> +	/* Related CPUs */
> +	cpu_r = cpumask_first(&cpus_related);
> +	if (cpu != cpu_r) {
> +		qcom_freq_domain_map[cpu] = qcom_freq_domain_map[cpu_r];
> +		return 0;
> +	}
> +
> +	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
> +	if (!c)
> +		return -ENOMEM;
> +
> +	offsets = of_device_get_match_data(&pdev->dev);
> +	if (!offsets)
> +		return -EINVAL;
> +
> +	if (of_address_to_resource(np, 0, &res))
> +		return -ENOMEM;
> +
> +	base = devm_ioremap_resource(dev, &res);
> +	if (!base)
> +		return -ENOMEM;
> +
> +	for (i = REG_ENABLE; i < REG_ARRAY_SIZE; i++)
> +		c->reg_bases[i] = base + offsets[i];
> +
> +	/* HW should be in enabled state to proceed */
> +	if (!(readl_relaxed(c->reg_bases[REG_ENABLE]) & 0x1)) {
> +		dev_err(dev, "%s cpufreq hardware not enabled\n", np->name);
> +		return -ENODEV;
> +	}
> +
> +	cpumask_copy(&c->related_cpus, &cpus_related);
> +
> +	c->max_cores = cpumask_weight(&c->related_cpus);
> +	if (!c->max_cores)
> +		return -ENOENT;
> +
> +	c->xo_rate = xo_rate;
> +
> +	ret = qcom_cpufreq_hw_read_lut(pdev, c);
> +	if (ret) {
> +		dev_err(dev, "%s failed to read LUT\n", np->name);
> +		return ret;
> +	}
> +
> +	qcom_freq_domain_map[cpu] = c;

Set this for all related CPUs here and then the check at the top of
this routine will be simply:

if (qcom_freq_domain_map[cpu])
        return 0;

> +
> +	return 0;
> +}
> +
-- 
viresh
