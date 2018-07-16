Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FCDECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 05:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C3420854
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 05:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LM3k4IiQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C3420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbeGPFh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 01:37:56 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45673 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeGPFhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 01:37:55 -0400
Received: by mail-pf0-f195.google.com with SMTP id i26-v6so14293046pfo.12
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 22:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QgkMnEFIxJGAje2UsBQPMQ+CWvoYqiNzv1pFlMeT8HQ=;
        b=LM3k4IiQLn9/Z83NtCuYPKzdH/6S7TBi+yQW04HtoYVGe+dqTxS/fEw3tdB8sZTSZL
         bKUizRlWWy/kQn5UGtRKaip035f7wsNmHP8HXdvpkwxsIXSI+EG2AZhL8JisLa28eofI
         SDCFSyvgjzqGr5KnDYBGTJawKnOJmdXwNuV2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QgkMnEFIxJGAje2UsBQPMQ+CWvoYqiNzv1pFlMeT8HQ=;
        b=iuX7GyG7blkr6Dmy/k2jPha07lRb7ZBNrjHJhp1l2uzU0yHYUNQxm9CEX9a8FkV0iY
         6AK96IUWZN6dCmXpWuXcSNClbJo3YObSDw2zRJmSa8GxOHsce8p942QvYUfaVLO6fGgW
         2yJ2DUf8XiZbcPmvxACM2ZW5OzlLhjU6edo55CSIjtJXrL3JQTkJL5P6+acEo9/WwRyh
         7FIJplryJDUw0DJ/MI8HFIIl3P5RmeuUXwrwx8blidhyDF7SclY6aaPRfrx5o2X0Z6cb
         gGc4gGy8woDCZZJUkGZXv8TxhZd/BEcuL49zq/MF+kFdCJFDltA+ZAmcE9Hn6+c5fGbw
         QzZg==
X-Gm-Message-State: AOUpUlFFV/jPEbnhwgpfLNBSZVzcrUAUPnia/66pIpT+vq/aaio2/7A7
        u9RC/YDHJDBucNML1Tm32PyJmw==
X-Google-Smtp-Source: AAOMgpcM24mn5U99twXWRphZ4pNFIDGj7SWuKCqNwNXExmeZvjB5VrOV0VMUKOWCh2EzXJnR+JxI0w==
X-Received: by 2002:a65:62d8:: with SMTP id m24-v6mr13252094pgv.307.1531717941736;
        Sun, 15 Jul 2018 22:12:21 -0700 (PDT)
Received: from localhost ([122.171.235.75])
        by smtp.gmail.com with ESMTPSA id s90-v6sm36204890pfa.178.2018.07.15.22.12.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 22:12:21 -0700 (PDT)
Date:   Mon, 16 Jul 2018 10:42:19 +0530
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
Subject: Re: [PATCH v5 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
Message-ID: <20180716051219.36rdvxux3lz3rjed@vireshk-i7>
References: <1531418745-19742-1-git-send-email-tdas@codeaurora.org>
 <1531418745-19742-3-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531418745-19742-3-git-send-email-tdas@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-07-18, 23:35, Taniya Das wrote:
> +static int qcom_cpu_resources_init(struct platform_device *pdev,
> +				   struct device_node *np, unsigned int cpu)
> +{
> +	struct cpufreq_qcom *c;
> +	struct resource res;
> +	struct device *dev = &pdev->dev;
> +	unsigned int offset, cpu_r;
> +	int ret;
> +
> +	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
> +	if (!c)
> +		return -ENOMEM;
> +
> +	c->reg_offset = of_device_get_match_data(&pdev->dev);
> +	if (!c->reg_offset)
> +		return -EINVAL;
> +
> +	if (of_address_to_resource(np, 0, &res))
> +		return -ENOMEM;
> +
> +	c->base = devm_ioremap(dev, res.start, resource_size(&res));
> +	if (!c->base) {
> +		dev_err(dev, "Unable to map %s base\n", np->name);
> +		return -ENOMEM;
> +	}
> +
> +	offset = c->reg_offset[REG_ENABLE];
> +
> +	/* HW should be in enabled state to proceed */
> +	if (!(readl_relaxed(c->base + offset) & 0x1)) {
> +		dev_err(dev, "%s cpufreq hardware not enabled\n", np->name);
> +		return -ENODEV;
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
> +
> +	/* Related CPUs to keep a single copy */
> +	cpu_r = cpumask_first(&c->related_cpus);
> +	if (cpu != cpu_r) {
> +		qcom_freq_domain_map[cpu] = qcom_freq_domain_map[cpu_r];
> +		devm_kfree(dev, c);
> +	}

Sorry about missing this, you have actually worked on my comments.

But I think this isn't the clever way of doing it. You allocate the
structures, fill everything and then finally free them because we were
related. Why can't we have similar check at the top of this routine
and skip everything then ?

-- 
viresh
