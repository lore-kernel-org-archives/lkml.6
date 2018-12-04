Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F06C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F13920834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WKuZQvtb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F13920834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbeLDFMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 00:12:37 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44159 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeLDFMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 00:12:36 -0500
Received: by mail-pl1-f194.google.com with SMTP id k8so7665475pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 21:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w4Gmfd0KRBypvFjigH8/XeIjz2O9uKu0KD6RLo72Hes=;
        b=WKuZQvtbkoO62hbvxXSgofFF4pGprcwOQQKKY3opg1hglASakdd0ESNm9QbMTLIZi2
         p0jrn7ho3NojLODWYw5SRgt2bN6wfcc6ckowcicqv+MuclITiKbCVvPVOZYWbrd3CW5m
         jlEaFrDc0hgGQl1Spd7ecIwvndIhe2fNhpq6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w4Gmfd0KRBypvFjigH8/XeIjz2O9uKu0KD6RLo72Hes=;
        b=cVsDcq9SguEsXAfGe+gAjM3wcpFbd7K2jVLGgNahx1756fzYap2k5iPVvZgWI4QG8w
         BfXDZTm/ifoU+IznkW8a4YfJsYQjYA3tCYV0vrBQGKqoQgtI3JgBGv2lXzC7J+kIWp4R
         j5NYD4E35twz4Xyu3Bh//priS/DWuctUlmpha+DI08VyVKucpodvq7xdEoRUinwY1/o2
         9crSyIIV/Bm1PuRR3nOwrd74mPolLragXlh8TOgWgN1aLdHe6ayO7/oQW1hcfvnBxLU2
         M6qqL1M9HJJi8M3bB+ZQ8P1b607BpdjjSLkJL7J4hQX6QAqsIzuucnbvNg0j8ecZtORA
         XrQg==
X-Gm-Message-State: AA+aEWbQuA/IAk4Y15NIbHf+C0t+Jb0iotmoaPvfQ6iMoEnrEreLw2n7
        8UswiXzkEQkRT8e3dbj88++Qzg==
X-Google-Smtp-Source: AFSGD/UQfFUPVCOOYAJ2mbirVdtnbK1GZoHKygZMwCgHOn4HLSkHo1M8l+7skrjYvVpReInbkNwJvw==
X-Received: by 2002:a17:902:50e:: with SMTP id 14mr18521751plf.141.1543900355193;
        Mon, 03 Dec 2018 21:12:35 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id g3sm39577243pfe.37.2018.12.03.21.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 21:12:33 -0800 (PST)
Date:   Tue, 4 Dec 2018 10:42:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        evgreen@google.com, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v11 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq
 HW driver
Message-ID: <20181204051231.mm5ixli7ckpfzvd4@vireshk-i7>
References: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
 <1543722903-10989-3-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543722903-10989-3-git-send-email-tdas@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Taniya,

Sorry that I haven't been reviewing it much from last few iterations as I was
letting others get this into a better shape. Thanks for your efforts..

On 02-12-18, 09:25, Taniya Das wrote:
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c

> +struct cpufreq_qcom {
> +	struct cpufreq_frequency_table *table;
> +	void __iomem *perf_state_reg;
> +	cpumask_t related_cpus;
> +};
> +
> +static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];

Now that the code is much more simplified, I am not sure if you need this
per-cpu structure at all. The only place where you are using it is in
qcom_cpufreq_hw_cpu_init() and probe(). Why not merge qcom_cpu_resources_init()
completely into qcom_cpufreq_hw_cpu_init() and get rid of this structure
entirely ?

-- 
viresh
