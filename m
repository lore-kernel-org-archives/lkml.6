Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD87BC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B28A208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hS6XToPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B28A208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeLCRqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:46:47 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36866 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbeLCRqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:46:46 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so6747440pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 09:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NXecUgyMFmNOiSvhFg/wJjIcNHBR9Or9P0oEn/I4pFI=;
        b=hS6XToPLlgoaH+JTfUZXk/6Dx5FGerwQVzVbCsJMpiJ7BrXgBMkb8HGe7ELMmqe8e6
         xciGrRDxDDfuJnVK4CMk9jbA3aHHI/4qLsjE1G7G8FrAbXu59+bY/toOApYOT9QpuB58
         QL5cEa3KEgCOQLdl7baKSHurkVe6Sg7YKPweU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NXecUgyMFmNOiSvhFg/wJjIcNHBR9Or9P0oEn/I4pFI=;
        b=I07JVOnjwB+GBvjT18FGDvpml4eLzhTBcvtMzZQ/QG3QW8YuZJpquVznWgyfO5WOZf
         SA/biTXGWIuT+Xzm9rxt670X7sNTEhukKcPmt/qRTp+hPD2dIHNT/efUSj8JD70K101t
         LO7j6bgqImrn/bcfgNzjQ/eM6mJDOEV0E0VIn8x+H0RSytPyDNpq6ByOqQJ0CXhdvZM+
         0QP/Xz07o169kiJXzzWOalqJ02P++Scit14OjeSrj+T9uxZJBIGkY3+CLWk4G56G8v91
         gAkM1WdGWRBQ8mIQb4v9YNC9QamQjA+5XxrWpuRIOumKWDWYCjJBvBsmTm+ETghn5oIf
         qpiA==
X-Gm-Message-State: AA+aEWZJEHxE2uAs9P1FInlC8x7OUuKWfo7dikswE9PnaslMS2CLRJHp
        p6tqf2Zy6slRE9FtBGGNGe2C3g==
X-Google-Smtp-Source: AFSGD/UydYE4spiJwLIHJoFC4TzJBNmJIm1CqLYXoDoGc1wOxpsSYlIVW3BDt4sLnWDjNWOt+r5VXg==
X-Received: by 2002:a62:9fd9:: with SMTP id v86mr16675173pfk.191.1543859203626;
        Mon, 03 Dec 2018 09:46:43 -0800 (PST)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id c67sm21041992pfg.170.2018.12.03.09.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 09:46:42 -0800 (PST)
Date:   Mon, 3 Dec 2018 09:46:42 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        evgreen@google.com, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v11 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq
 HW driver
Message-ID: <20181203174642.GE22824@google.com>
References: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
 <1543722903-10989-3-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1543722903-10989-3-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 09:25:03AM +0530, Taniya Das wrote:
> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
> for changing the frequency of CPUs. The driver implements the cpufreq
> driver interface for this hardware engine.
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/cpufreq/Kconfig.arm       |  11 ++
>  drivers/cpufreq/Makefile          |   1 +
>  drivers/cpufreq/qcom-cpufreq-hw.c | 334 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 346 insertions(+)
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-hw.c
> 
> ...
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> new file mode 100644
> index 0000000..8dc6b73
> --- /dev/null
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> 
> ...
> 
> +static int qcom_cpufreq_hw_read_lut(struct device *dev, struct cpufreq_qcom *c,
> +				    void __iomem *base, unsigned long xo_rate,
> +				    unsigned long cpu_hw_rate)
> +{
> +	u32 data, src, lval, i, core_count, prev_cc = 0, prev_freq = 0, freq;
> +	unsigned int max_cores = cpumask_weight(&c->related_cpus);
> +
> +	c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
> +				sizeof(*c->table), GFP_KERNEL);
> +	if (!c->table)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> +		data = readl_relaxed(base + REG_LUT_TABLE + i * LUT_ROW_SIZE);
> +		src = FIELD_GET(LUT_SRC, data);
> +		lval = FIELD_GET(LUT_L_VAL, data);
> +		core_count = FIELD_GET(LUT_CORE_COUNT, data);
> +
> +		if (src)
> +			freq = xo_rate * lval / 1000;
> +		else
> +			freq = cpu_hw_rate / 1000;
> +
> +		/* Ignore boosts in the middle of the table */
> +		if (core_count != max_cores) {
> +			c->table[i].frequency = CPUFREQ_ENTRY_INVALID;
> +		} else {
> +			c->table[i].frequency = freq;
> +			dev_dbg(dev, "index=%d freq=%d, core_count %d\n", i,
> +				freq, core_count);
> +		}

nit: IMO it would be better to put the normal case ("core_count !=
max_cores") first and the exception in the else branch.

> +MODULE_DESCRIPTION("QCOM CPUFREQ HW Driver");

nit: my suggestion was 'QCOM CPUFreq HW driver', which is what's used
elsewhere in the driver.

Anyway, no need to respin just for the nits, we can address them (or
not) with follow-up patches.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
