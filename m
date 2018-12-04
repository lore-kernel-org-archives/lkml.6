Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03A6C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99FD2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7BmqpHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99FD2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbeLDW2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:28:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:54832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeLDW2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:28:14 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE9D02081C;
        Tue,  4 Dec 2018 22:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543962492;
        bh=HqAZkScs+ZcMVzztqkHJGsxIZM9HgQ5Y1Eao1f5INAY=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=P7BmqpHdG/XX+wu2IFL6Xgx5XxkEkz95/xorIrOqvpL5tNKvMtmAe0cH9/YgCosH0
         8eQYcoXaG6GuqE5k4xC4fZxFV+LqxygQuaAKyZoK9Gw93G/rCiyDVKqL0dAOQ5/ust
         EJhXdeKvEVqEXJpKtjQV3qdepsHaeR9Z/zhmymyw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Taniya Das <tdas@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181204051231.mm5ixli7ckpfzvd4@vireshk-i7>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        evgreen@google.com
References: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
 <1543722903-10989-3-git-send-email-tdas@codeaurora.org>
 <20181204051231.mm5ixli7ckpfzvd4@vireshk-i7>
Message-ID: <154396249199.88331.1800559141437859959@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v11 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date:   Tue, 04 Dec 2018 14:28:11 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Viresh Kumar (2018-12-03 21:12:31)
> Hi Taniya,
> =

> Sorry that I haven't been reviewing it much from last few iterations as I=
 was
> letting others get this into a better shape. Thanks for your efforts..
> =

> On 02-12-18, 09:25, Taniya Das wrote:
> > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> =

> > +struct cpufreq_qcom {
> > +     struct cpufreq_frequency_table *table;
> > +     void __iomem *perf_state_reg;
> > +     cpumask_t related_cpus;
> > +};
> > +
> > +static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
> =

> Now that the code is much more simplified, I am not sure if you need this
> per-cpu structure at all. The only place where you are using it is in
> qcom_cpufreq_hw_cpu_init() and probe(). Why not merge qcom_cpu_resources_=
init()
> completely into qcom_cpufreq_hw_cpu_init() and get rid of this structure
> entirely ?
> =


Good point. Here's an untested patch to handle that. It removes the
related functionality and makes an array of pointers to the domains that
are created each time qcom_cpu_resources_init() is called.

---8<----

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufr=
eq-hw.c
index 8dc6b73c2f22..04e7cfd70316 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -23,14 +23,14 @@
 #define REG_LUT_TABLE			0x110
 #define REG_PERF_STATE			0x920
 =

+#define MAX_FREQ_DOMAINS		2
+
 struct cpufreq_qcom {
 	struct cpufreq_frequency_table *table;
 	void __iomem *perf_state_reg;
 	cpumask_t related_cpus;
 };
 =

-static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
-
 static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
 					unsigned int index)
 {
@@ -76,9 +76,14 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct c=
pufreq_policy *policy,
 =

 static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 {
+	struct cpufreq_qcom **freq_domain_map;
 	struct cpufreq_qcom *c;
 =

-	c =3D qcom_freq_domain_map[policy->cpu];
+	freq_domain_map =3D cpufreq_get_driver_data();
+	if (!freq_domain_map)
+		return -ENODEV;
+
+	c =3D freq_domain_map[policy->cpu];
 	if (!c) {
 		pr_err("No scaling support for CPU%d\n", policy->cpu);
 		return -ENODEV;
@@ -171,39 +176,17 @@ static int qcom_cpufreq_hw_read_lut(struct device *de=
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
 				   unsigned int cpu, int index,
 				   unsigned long xo_rate,
-				   unsigned long cpu_hw_rate)
+				   unsigned long cpu_hw_rate,
+				   struct cpufreq_qcom **freq_domain_map)
 {
 	struct cpufreq_qcom *c;
 	struct resource *res;
 	struct device *dev =3D &pdev->dev;
 	void __iomem *base;
-	int ret, cpu_r;
+	int ret;
 =

 	c =3D devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
 	if (!c)
@@ -220,12 +203,6 @@ static int qcom_cpu_resources_init(struct platform_dev=
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
@@ -234,8 +211,7 @@ static int qcom_cpu_resources_init(struct platform_devi=
ce *pdev,
 		return ret;
 	}
 =

-	for_each_cpu(cpu_r, &c->related_cpus)
-		qcom_freq_domain_map[cpu_r] =3D c;
+	freq_domain_map[index] =3D c;
 =

 	return 0;
 }
@@ -245,9 +221,16 @@ static int qcom_cpufreq_hw_driver_probe(struct platfor=
m_device *pdev)
 	struct device_node *cpu_np;
 	struct of_phandle_args args;
 	struct clk *clk;
-	unsigned int cpu;
+	unsigned int cpu, domain;
 	unsigned long xo_rate, cpu_hw_rate;
 	int ret;
+	struct cpufreq_qcom **freq_domain_map, *freq_domain;
+
+	freq_domain_map =3D devm_kcalloc(&pdev->dev, MAX_FREQ_DOMAINS,
+				       sizeof(*freq_domain_map), GFP_KERNEL);
+	cpufreq_qcom_hw_driver.driver_data =3D freq_domain_map;
+	if (!freq_domain_map)
+		return -ENOMEM;
 =

 	clk =3D clk_get(&pdev->dev, "xo");
 	if (IS_ERR(clk))
@@ -273,16 +256,28 @@ static int qcom_cpufreq_hw_driver_probe(struct platfo=
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
+		if (domain >=3D MAX_FREQ_DOMAINS)
 			continue;
 =

-		ret =3D qcom_cpu_resources_init(pdev, cpu, args.args[0],
-					      xo_rate, cpu_hw_rate);
+		/*
+		 * If we've already populated the frequency table for this domain
+		 * just mark it related and get out of here
+		 */
+		freq_domain =3D freq_domain_map[domain];
+		if (freq_domain) {
+			cpumask_set_cpu(cpu, &freq_domain->related_cpus);
+			continue;
+		}
+
+		ret =3D qcom_cpu_resources_init(pdev, cpu, domain,
+					      xo_rate, cpu_hw_rate,
+					      freq_domain_map);
 		if (ret)
 			return ret;
 	}
