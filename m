Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B25C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F42D2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="behf821E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F42D2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeLEGQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:16:06 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34502 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeLEGQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:16:05 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so9499474pfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 22:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RxnxLeE/nMZYJF4tiJIgBKKQRgUgdiQvy6Z7yAmFPBU=;
        b=behf821EfgII1wjMHZuLg734CsI7ssoqlH4uWjM8Bz+yzMncvj1qOJxSHCqAWCjDAn
         xblSYSKcSlGWG/uSybQapCO6wpEokvuUs4qTWlJ2tvteyTBF73aLmplhuU+dw57LL81n
         RSkLQXFPZyCTcR3Bdw1bo+OVeL9dduoZ8JRlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RxnxLeE/nMZYJF4tiJIgBKKQRgUgdiQvy6Z7yAmFPBU=;
        b=WV4X1TbVGM8D0u7aMGX2oOwlUluUwR9TQpvxcDx2ISXrwV8ARGYUjqFt/x3gZlXh/f
         KWKloIUDx9RYvs9WLknYxOPfk8AKyv3OIwHPNqYMJElIH7BaCoLgJzu4PcBoS5O4tesp
         CuOKM5aYTESqpAZ5bWyvmTg0pre1JHRdywDW56nAanUUU2hN+SkbNyZjr+D+Bw3BoPCx
         KHC/BTOzlgmJwom6Csg/cGg4pSMicpkru26E09lRaWDdM2AgR8jJo7rGbHVbYxY3Oh4q
         RoJptvn5/zQhWQweaf1TT3ArKMyP04G4+9YpP8KfvInVX0WgXb9q5Z3KplKi63dtZh2R
         695w==
X-Gm-Message-State: AA+aEWYb5d27dNaoJO/EVX0ZmhRNHhxKQz4aPEEuGXaJAhakBbV/YUvQ
        yMT83rKPZ51enSrr64zyZ753aOX8eXQ=
X-Google-Smtp-Source: AFSGD/UiG1j5iuZi/ZclCTmXQjn5TsVDfH6c65ckcqeMjSp0OzzXGZ0za6Ds9Ij2MBC9M8n4Y3ioFQ==
X-Received: by 2002:a63:b17:: with SMTP id 23mr19550595pgl.423.1543990564559;
        Tue, 04 Dec 2018 22:16:04 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id q199sm53092737pfc.97.2018.12.04.22.16.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 22:16:03 -0800 (PST)
Date:   Wed, 5 Dec 2018 11:46:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        evgreen@google.com
Subject: Re: [PATCH v11 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq
 HW driver
Message-ID: <20181205061600.7zglbpkgbktn27am@vireshk-i7>
References: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
 <1543722903-10989-3-git-send-email-tdas@codeaurora.org>
 <20181204051231.mm5ixli7ckpfzvd4@vireshk-i7>
 <154396249199.88331.1800559141437859959@swboyd.mtv.corp.google.com>
 <154396472692.88331.13742924031474269133@swboyd.mtv.corp.google.com>
 <49139ae4-4373-9e70-02ad-80f7bbc4494c@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49139ae4-4373-9e70-02ad-80f7bbc4494c@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-12-18, 09:07, Taniya Das wrote:
> Hello Stephen, Viresh
> 
> Thanks for the code and suggestions.
> 
> Having a NR_DOMAINS '2' makes the driver not scalable for re-use.

Sure, I didn't like it either and that wasn't really what I was suggesting in
the first place. I didn't wanted to write the code myself and pass it on, but I
have it now anyway :)

It may have a bug or two in there, but compiles just fine and is rebased over
your patch Taniya.

-- 
viresh

-------------------------8<-------------------------

 drivers/cpufreq/qcom-cpufreq-hw.c | 156 +++++++++++-------------------
 1 file changed, 57 insertions(+), 99 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 8dc6b73c2f22..bcf9bb37298a 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -23,13 +23,8 @@
 #define REG_LUT_TABLE			0x110
 #define REG_PERF_STATE			0x920
 
-struct cpufreq_qcom {
-	struct cpufreq_frequency_table *table;
-	void __iomem *perf_state_reg;
-	cpumask_t related_cpus;
-};
-
-static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
+static unsigned long cpu_hw_rate, xo_rate;
+static struct platform_device *global_pdev;
 
 static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
 					unsigned int index)
@@ -74,53 +69,17 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
 	return policy->freq_table[index].frequency;
 }
 
-static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
-{
-	struct cpufreq_qcom *c;
-
-	c = qcom_freq_domain_map[policy->cpu];
-	if (!c) {
-		pr_err("No scaling support for CPU%d\n", policy->cpu);
-		return -ENODEV;
-	}
-
-	cpumask_copy(policy->cpus, &c->related_cpus);
-
-	policy->fast_switch_possible = true;
-	policy->freq_table = c->table;
-	policy->driver_data = c->perf_state_reg;
-
-	return 0;
-}
-
-static struct freq_attr *qcom_cpufreq_hw_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	&cpufreq_freq_attr_scaling_boost_freqs,
-	NULL
-};
-
-static struct cpufreq_driver cpufreq_qcom_hw_driver = {
-	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
-			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
-	.verify		= cpufreq_generic_frequency_table_verify,
-	.target_index	= qcom_cpufreq_hw_target_index,
-	.get		= qcom_cpufreq_hw_get,
-	.init		= qcom_cpufreq_hw_cpu_init,
-	.fast_switch    = qcom_cpufreq_hw_fast_switch,
-	.name		= "qcom-cpufreq-hw",
-	.attr		= qcom_cpufreq_hw_attr,
-};
-
-static int qcom_cpufreq_hw_read_lut(struct device *dev, struct cpufreq_qcom *c,
-				    void __iomem *base, unsigned long xo_rate,
-				    unsigned long cpu_hw_rate)
+static int qcom_cpufreq_hw_read_lut(struct device *dev,
+				    struct cpufreq_policy *policy,
+				    void __iomem *base)
 {
 	u32 data, src, lval, i, core_count, prev_cc = 0, prev_freq = 0, freq;
-	unsigned int max_cores = cpumask_weight(&c->related_cpus);
+	unsigned int max_cores = cpumask_weight(policy->cpus);
+	struct cpufreq_frequency_table	*table;
 
-	c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
-				sizeof(*c->table), GFP_KERNEL);
-	if (!c->table)
+	table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
+				sizeof(*table), GFP_KERNEL);
+	if (!table)
 		return -ENOMEM;
 
 	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
@@ -136,9 +95,9 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev, struct cpufreq_qcom *c,
 
 		/* Ignore boosts in the middle of the table */
 		if (core_count != max_cores) {
-			c->table[i].frequency = CPUFREQ_ENTRY_INVALID;
+			table[i].frequency = CPUFREQ_ENTRY_INVALID;
 		} else {
-			c->table[i].frequency = freq;
+			table[i].frequency = freq;
 			dev_dbg(dev, "index=%d freq=%d, core_count %d\n", i,
 				freq, core_count);
 		}
@@ -148,7 +107,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev, struct cpufreq_qcom *c,
 		 * end of table
 		 */
 		if (i > 0 && prev_freq == freq && prev_cc == core_count) {
-			struct cpufreq_frequency_table *prev = &c->table[i - 1];
+			struct cpufreq_frequency_table *prev = &table[i - 1];
 
 			/*
 			 * Only treat the last frequency that might be a boost
@@ -166,7 +125,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev, struct cpufreq_qcom *c,
 		prev_freq = freq;
 	}
 
-	c->table[i].frequency = CPUFREQ_TABLE_END;
+	table[i].frequency = CPUFREQ_TABLE_END;
+	policy->freq_table = table;
 
 	return 0;
 }
@@ -194,22 +154,29 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
 	}
 }
 
-static int qcom_cpu_resources_init(struct platform_device *pdev,
-				   unsigned int cpu, int index,
-				   unsigned long xo_rate,
-				   unsigned long cpu_hw_rate)
+static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 {
-	struct cpufreq_qcom *c;
+	struct device *dev = &global_pdev->dev;
+	struct of_phandle_args args;
+	struct device_node *cpu_np;
 	struct resource *res;
-	struct device *dev = &pdev->dev;
 	void __iomem *base;
-	int ret, cpu_r;
+	int ret, index;
 
-	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
-	if (!c)
-		return -ENOMEM;
+	cpu_np = of_cpu_device_node_get(policy->cpu);
+	if (!cpu_np)
+		return -EINVAL;
+
+	ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
+			"#freq-domain-cells", 0, &args);
+	of_node_put(cpu_np);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
+	if (ret)
+		return ret;
+
+	index = args.args[0];
+
+	res = platform_get_resource(global_pdev, IORESOURCE_MEM, index);
 	base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
@@ -220,33 +187,46 @@ static int qcom_cpu_resources_init(struct platform_device *pdev,
 		return -ENODEV;
 	}
 
-	qcom_get_related_cpus(index, &c->related_cpus);
-	if (!cpumask_weight(&c->related_cpus)) {
+	qcom_get_related_cpus(index, policy->cpus);
+	if (!cpumask_weight(policy->cpus)) {
 		dev_err(dev, "Domain-%d failed to get related CPUs\n", index);
 		return -ENOENT;
 	}
 
-	c->perf_state_reg = base + REG_PERF_STATE;
+	policy->driver_data = base + REG_PERF_STATE;
 
-	ret = qcom_cpufreq_hw_read_lut(dev, c, base, xo_rate, cpu_hw_rate);
+	ret = qcom_cpufreq_hw_read_lut(dev, policy, base);
 	if (ret) {
 		dev_err(dev, "Domain-%d failed to read LUT\n", index);
 		return ret;
 	}
 
-	for_each_cpu(cpu_r, &c->related_cpus)
-		qcom_freq_domain_map[cpu_r] = c;
+	policy->fast_switch_possible = true;
 
 	return 0;
 }
 
+static struct freq_attr *qcom_cpufreq_hw_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	&cpufreq_freq_attr_scaling_boost_freqs,
+	NULL
+};
+
+static struct cpufreq_driver cpufreq_qcom_hw_driver = {
+	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
+	.verify		= cpufreq_generic_frequency_table_verify,
+	.target_index	= qcom_cpufreq_hw_target_index,
+	.get		= qcom_cpufreq_hw_get,
+	.init		= qcom_cpufreq_hw_cpu_init,
+	.fast_switch    = qcom_cpufreq_hw_fast_switch,
+	.name		= "qcom-cpufreq-hw",
+	.attr		= qcom_cpufreq_hw_attr,
+};
+
 static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 {
-	struct device_node *cpu_np;
-	struct of_phandle_args args;
 	struct clk *clk;
-	unsigned int cpu;
-	unsigned long xo_rate, cpu_hw_rate;
 	int ret;
 
 	clk = clk_get(&pdev->dev, "xo");
@@ -263,29 +243,7 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 	cpu_hw_rate = clk_get_rate(clk) / CLK_HW_DIV;
 	clk_put(clk);
 
-	for_each_possible_cpu(cpu) {
-		cpu_np = of_cpu_device_node_get(cpu);
-		if (!cpu_np) {
-			dev_dbg(&pdev->dev, "Failed to get cpu %d device\n",
-				cpu);
-			continue;
-		}
-
-		ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
-						 "#freq-domain-cells", 0,
-						  &args);
-		of_node_put(cpu_np);
-		if (ret)
-			return ret;
-
-		if (qcom_freq_domain_map[cpu])
-			continue;
-
-		ret = qcom_cpu_resources_init(pdev, cpu, args.args[0],
-					      xo_rate, cpu_hw_rate);
-		if (ret)
-			return ret;
-	}
+	global_pdev = pdev;
 
 	ret = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
 	if (ret) {
