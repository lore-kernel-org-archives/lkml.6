Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4501AC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F239A2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mv8iAvDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F239A2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbeLEIHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:07:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:42110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbeLEIHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:07:24 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C3A920850;
        Wed,  5 Dec 2018 08:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543997243;
        bh=NKoIq89E2JFrsQnF2th3jXg990piVoQtxWG5nHU4ey0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Mv8iAvDWMiVKdVLIIjSS08PBgGCvd+Tya1CbtSC8ITAEUufCZIUMgtd7cEcqmbro8
         DntFOzK+tGfBzv/1kTZc230U0qHW2PZNN5n0CkBE3651NuKgvnj+Wnn9VSRUFShs4V
         0esCDZUZtRoCDis98le8CppREekOHQAf+9+8tAVk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Taniya Das <tdas@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <49139ae4-4373-9e70-02ad-80f7bbc4494c@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        evgreen@google.com
References: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
 <1543722903-10989-3-git-send-email-tdas@codeaurora.org>
 <20181204051231.mm5ixli7ckpfzvd4@vireshk-i7>
 <154396249199.88331.1800559141437859959@swboyd.mtv.corp.google.com>
 <154396472692.88331.13742924031474269133@swboyd.mtv.corp.google.com>
 <49139ae4-4373-9e70-02ad-80f7bbc4494c@codeaurora.org>
Message-ID: <154399724253.88331.15449997536107541794@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v11 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date:   Wed, 05 Dec 2018 00:07:22 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-12-04 19:37:00)
> Hello Stephen, Viresh
> =

> Thanks for the code and suggestions.
> =

> Having a NR_DOMAINS '2' makes the driver not scalable for re-use.
> This assumption is only true for the current version of the HW and do =

> not intend to update/clean-up this logic again. So want to stick keeping =

> current logic of having the *qcom_freq_domain_map[NR_CPUS].

Ok, so let's just count the number of reg properties there are in the
node and use that to know how many frequency domains exist. That already
maps exactly to how many frequency domains this driver needs to worry
about. Alternatively, we could count the number of named register
regions like 'freq_domain0', 'freq_domain1', etc. are listed in
reg-names so that other register regions in this device could be exposed
in DT when/if they are added. Here's the reg counting patch.

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufr=
eq-hw.c
index 8dc6b73c2f22..c0f6a07eb3c5 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -29,8 +29,6 @@ struct cpufreq_qcom {
 	cpumask_t related_cpus;
 };
 =

-static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
-
 static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
 					unsigned int index)
 {
@@ -76,9 +74,26 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct c=
pufreq_policy *policy,
 =

 static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 {
-	struct cpufreq_qcom *c;
+	struct cpufreq_qcom *freq_domains, *c;
+	struct device_node *cpu_np;
+	struct of_phandle_args args;
+	int ret;
+
+	freq_domains =3D cpufreq_get_driver_data();
+	if (!freq_domains)
+		return -ENODEV;
+
+	cpu_np =3D of_cpu_device_node_get(policy->cpu);
+	if (!cpu_np)
+		return -ENODEV;
+
+	ret =3D of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
+					 "#freq-domain-cells", 0, &args);
+	of_node_put(cpu_np);
+	if (ret)
+		return ret;
 =

-	c =3D qcom_freq_domain_map[policy->cpu];
+	c =3D &freq_domains[args.args[0]];
 	if (!c) {
 		pr_err("No scaling support for CPU%d\n", policy->cpu);
 		return -ENODEV;
@@ -171,43 +186,15 @@ static int qcom_cpufreq_hw_read_lut(struct device *de=
v, struct cpufreq_qcom *c,
 	return 0;
 }
 =

-static void qcom_get_related_cpus(int index, struct cpumask *m)
-{
-	struct device_node *cpu_np;
-	struct of_phandle_args args;
-	int cpu, ret;
-
-	for_each_possible_cpu(cpu) {
-		cpu_np =3D of_cpu_device_node_get(cpu);
-		if (!cpu_np)
-			continue;
-
-		ret =3D of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
-						 "#freq-domain-cells", 0,
-						  &args);
-		of_node_put(cpu_np);
-		if (ret < 0)
-			continue;
-
-		if (index =3D=3D args.args[0])
-			cpumask_set_cpu(cpu, m);
-	}
-}
-
 static int qcom_cpu_resources_init(struct platform_device *pdev,
-				   unsigned int cpu, int index,
-				   unsigned long xo_rate,
-				   unsigned long cpu_hw_rate)
+				   int index, unsigned long xo_rate,
+				   unsigned long cpu_hw_rate,
+				   struct cpufreq_qcom *c)
 {
-	struct cpufreq_qcom *c;
 	struct resource *res;
 	struct device *dev =3D &pdev->dev;
 	void __iomem *base;
-	int ret, cpu_r;
-
-	c =3D devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
-	if (!c)
-		return -ENOMEM;
+	int ret;
 =

 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, index);
 	base =3D devm_ioremap_resource(dev, res);
@@ -220,12 +207,6 @@ static int qcom_cpu_resources_init(struct platform_dev=
ice *pdev,
 		return -ENODEV;
 	}
 =

-	qcom_get_related_cpus(index, &c->related_cpus);
-	if (!cpumask_weight(&c->related_cpus)) {
-		dev_err(dev, "Domain-%d failed to get related CPUs\n", index);
-		return -ENOENT;
-	}
-
 	c->perf_state_reg =3D base + REG_PERF_STATE;
 =

 	ret =3D qcom_cpufreq_hw_read_lut(dev, c, base, xo_rate, cpu_hw_rate);
@@ -234,9 +215,6 @@ static int qcom_cpu_resources_init(struct platform_devi=
ce *pdev,
 		return ret;
 	}
 =

-	for_each_cpu(cpu_r, &c->related_cpus)
-		qcom_freq_domain_map[cpu_r] =3D c;
-
 	return 0;
 }
 =

@@ -245,9 +223,20 @@ static int qcom_cpufreq_hw_driver_probe(struct platfor=
m_device *pdev)
 	struct device_node *cpu_np;
 	struct of_phandle_args args;
 	struct clk *clk;
-	unsigned int cpu;
+	unsigned int cpu, domain, max_domains;
 	unsigned long xo_rate, cpu_hw_rate;
 	int ret;
+	struct cpufreq_qcom *freq_domains, *freq_domain;
+
+	max_domains =3D 0;
+	while (platform_get_resource(pdev, IORESOURCE_MEM, max_domains))
+		max_domains++;
+
+	freq_domains =3D devm_kcalloc(&pdev->dev, max_domains,
+				    sizeof(*freq_domains), GFP_KERNEL);
+	cpufreq_qcom_hw_driver.driver_data =3D freq_domains;
+	if (!freq_domains)
+		return -ENOMEM;
 =

 	clk =3D clk_get(&pdev->dev, "xo");
 	if (IS_ERR(clk))
@@ -273,16 +262,26 @@ static int qcom_cpufreq_hw_driver_probe(struct platfo=
rm_device *pdev)
 =

 		ret =3D of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
 						 "#freq-domain-cells", 0,
-						  &args);
+						 &args);
 		of_node_put(cpu_np);
 		if (ret)
 			return ret;
 =

-		if (qcom_freq_domain_map[cpu])
+		domain =3D args.args[0];
+		if (WARN_ON(domain >=3D max_domains))
+			continue;
+
+		freq_domain =3D &freq_domains[domain];
+		cpumask_set_cpu(cpu, &freq_domain->related_cpus);
+		/*
+		 * If we've already populated the frequency table for this domain
+		 * just mark it related and get out of here
+		 */
+		if (cpumask_weight(&freq_domain->related_cpus) > 1)
 			continue;
 =

-		ret =3D qcom_cpu_resources_init(pdev, cpu, args.args[0],
-					      xo_rate, cpu_hw_rate);
+		ret =3D qcom_cpu_resources_init(pdev, domain, xo_rate,
+					      cpu_hw_rate, freq_domain);
 		if (ret)
 			return ret;
 	}
