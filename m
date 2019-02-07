Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771E0C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EAF21907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AaogncLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfBGMXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:23:01 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55632 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfBGMW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:22:59 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190207122257euoutp02cbfebf6b5bd20ea9d4ed0f3cc5f3c4f1~BFGZ5fANu2881428814euoutp02H;
        Thu,  7 Feb 2019 12:22:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190207122257euoutp02cbfebf6b5bd20ea9d4ed0f3cc5f3c4f1~BFGZ5fANu2881428814euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549542177;
        bh=kUWpkcVUcFwPK5XCeCJZ6CkDivsKpEZ5CoD7EVd/0M0=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=AaogncLy2WC6gEpHaOVPS3Fxjx6jYCPDBAr9Uy2WvjELI+f1T/HYTGx0B8VCWvJDO
         /ObSFbk+L3p/sGrSKB1w77swcpIvK1PhCnJPVWgFZac+56enaprgB+JXc1AkYh7AAc
         ReDhfDvaTPAXVhDn8wptcjBm1i+62HFjMc08WLqg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190207122256eucas1p28a198b56a9a4a7925cf73a42ff389cab~BFGZcFbnL3266632666eucas1p2H;
        Thu,  7 Feb 2019 12:22:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 79.11.04441.0232C5C5; Thu,  7
        Feb 2019 12:22:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190207122255eucas1p1444023f01217a43cfb958fe0bd48ef4d~BFGYwQHup0912409124eucas1p1Y;
        Thu,  7 Feb 2019 12:22:55 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-3b-5c5c23209155
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 91.26.04128.F132C5C5; Thu,  7
        Feb 2019 12:22:55 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PMK00LA22DUXV40@eusync1.samsung.com>;
        Thu, 07 Feb 2019 12:22:55 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/2] cpufreq: dt/ti/opp: move regulators initialization to
 the drivers
Date:   Thu, 07 Feb 2019 13:22:26 +0100
Message-id: <20190207122227.19873-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190207122227.19873-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsWy7djP87oKyjExBvseiVhsnLGe1eLm1w5W
        i8u75rBZfO49wmgx4/w+Jou1R+6yW7z5cZbJ4szpS6wW/65tZLHY+NXDYuWJWcwO3B6bVnWy
        edy5tofNY8vVdhaPvi2rGD1OnnrC4nH8xnYmj8+b5ALYo7hsUlJzMstSi/TtErgyHt07y17Q
        7VEx8eUVpgbGpdZdjJwcEgImEpcPvWXvYuTiEBJYwSjRN/E2lPOZUeLQtjPsMFWLN95ihUgs
        Y5S4eX8hVFUDk8Sb+beZQKrYBAwlut52sYHYIgJWEi/aX4EVMQs8YZLYeeMn2ChhgQiJbd8n
        g9ksAqoSN6ZdA7I5OHgFbCX6jwZCbJOXWL3hADOIzSlgJ9F0+jLYZgmBDWwSF//eZoMocpFY
        8HIuI4QtI3F5cjcLRFEzo0T7jFnsEE4Po8TWOTugOqwlDh+/yApiMwvwSUzaNp0ZZLOEAK9E
        R5sQRImHxKS+21B/TmSU2PT6KtsERokFjAyrGMVTS4tz01OLDfNSy/WKE3OLS/PS9ZLzczcx
        AuP09L/jn3Ywfr2UdIhRgINRiYc34FZUjBBrYllxZe4hRgkOZiURXjG5mBgh3pTEyqrUovz4
        otKc1OJDjNIcLErivNUMD6KFBNITS1KzU1MLUotgskwcnFINjKm/vqzZ/Wjur92P/I5JlHxV
        n6y5qMc330XP/fzZLeqP2QVl/UOn6mZvsViSNbnfTVwyf0l6zZxpj/uPcFdekjwtejdiyvQG
        fbU5/ooTvhT897ItsNlXva6Qy3jrl89tWkwON3t27+nv4DaawFc3PWuz7uQZ14tDj+qu8Fve
        90hK2mbz3+SPZUosxRmJhlrMRcWJAIFsLqvPAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsVy+t/xy7ryyjExBtuPmllsnLGe1eLm1w5W
        i8u75rBZfO49wmgx4/w+Jou1R+6yW7z5cZbJ4szpS6wW/65tZLHY+NXDYuWJWcwO3B6bVnWy
        edy5tofNY8vVdhaPvi2rGD1OnnrC4nH8xnYmj8+b5ALYo7hsUlJzMstSi/TtErgyHt07y17Q
        7VEx8eUVpgbGpdZdjJwcEgImEos33mLtYuTiEBJYwihx59ApZginiUli4q87bCBVbAKGEl1v
        u8BsEQEriRftr9hBipgFnjBJPHiwlgkkISwQIdG16SM7iM0ioCpxY9o1IJuDg1fAVqL/aCDE
        NnmJ1RsOMIPYnAJ2Ek2nL7OC2EJAJXv+dLFMYORZwMiwilEktbQ4Nz232EivODG3uDQvXS85
        P3cTIzDsth37uWUHY9e74EOMAhyMSjy8P65HxQixJpYVV+YeYpTgYFYS4RWTi4kR4k1JrKxK
        LcqPLyrNSS0+xCjNwaIkznveoDJKSCA9sSQ1OzW1ILUIJsvEwSnVwOg0Kd98nnZSaMNM1T9/
        6+Muztsfs3yGn3Igs6bz75rFnp+/7dRpzX7lvijnd2m65sy9t2b23RVukgxN3SuxK21erXlV
        o5hyPFNsy/9DAhXX1x+Q3JvkVNfUvqgk53LPKua1Cps7j0nmvWfyqHHrygp5eOVES2fRlcUc
        QSaNmf873DWWTPxWp8RSnJFoqMVcVJwIAC+PtUQ3AgAA
X-CMS-MailID: 20190207122255eucas1p1444023f01217a43cfb958fe0bd48ef4d
CMS-TYPE: 201P
X-CMS-RootMailID: 20190207122255eucas1p1444023f01217a43cfb958fe0bd48ef4d
References: <20190207122227.19873-1-m.szyprowski@samsung.com>
        <CGME20190207122255eucas1p1444023f01217a43cfb958fe0bd48ef4d@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_pm_opp_set_regulators() helper is used to assign the regulators to
the used operation points. This helper however only got the names of the
passed regulators and performs their initialization on its own.

Change this by requiring proper regulator objects and move regulator
gathering to the client drivers. This will be later needed to avoid
regulator initialization in forbidden context (i.e. during early system
resume, when no irqs are available yet). Both clients of the
dev_pm_opp_set_regulators() function are adapted to the new signature.

ti-cpufreq driver is also marked with 'suppress_bind_attrs', as it really
doesn't properly support driver removal.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/cpufreq/cpufreq-dt.c | 39 ++++++++++++++++++++++-----------
 drivers/cpufreq/ti-cpufreq.c | 42 ++++++++++++++++++++++++++++++------
 drivers/opp/core.c           | 40 ++++------------------------------
 include/linux/pm_opp.h       |  2 +-
 4 files changed, 67 insertions(+), 56 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 36a011ea0039..02a344e9d818 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -30,6 +30,7 @@ struct private_data {
 	struct opp_table *opp_table;
 	struct device *cpu_dev;
 	const char *reg_name;
+	struct regulator *reg;
 	bool have_static_opps;
 };
 
@@ -153,6 +154,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	struct cpufreq_frequency_table *freq_table;
 	struct opp_table *opp_table = NULL;
 	struct private_data *priv;
+	struct regulator *reg;
 	struct device *cpu_dev;
 	struct clk *cpu_clk;
 	unsigned int transition_latency;
@@ -188,27 +190,34 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 			fallback = true;
 	}
 
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto out_put_clk;
+	}
+
 	/*
-	 * OPP layer will be taking care of regulators now, but it needs to know
-	 * the name of the regulator first.
+	 * OPP layer will be taking care of regulators.
 	 */
 	name = find_supply_name(cpu_dev);
 	if (name) {
-		opp_table = dev_pm_opp_set_regulators(cpu_dev, &name, 1);
+		reg = regulator_get_optional(cpu_dev, name);
+		ret = PTR_ERR_OR_ZERO(reg);
+		if (ret) {
+			dev_err(cpu_dev, "Failed to get regulator for cpu%d: %d\n",
+				policy->cpu, ret);
+			goto out_free_priv;
+		}
+		priv->reg = reg;
+		opp_table = dev_pm_opp_set_regulators(cpu_dev, &priv->reg, 1);
 		if (IS_ERR(opp_table)) {
 			ret = PTR_ERR(opp_table);
 			dev_err(cpu_dev, "Failed to set regulator for cpu%d: %d\n",
 				policy->cpu, ret);
-			goto out_put_clk;
+			goto out_put_regulator;
 		}
 	}
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		ret = -ENOMEM;
-		goto out_put_regulator;
-	}
-
 	priv->reg_name = name;
 	priv->opp_table = opp_table;
 
@@ -287,10 +296,14 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 out_free_opp:
 	if (priv->have_static_opps)
 		dev_pm_opp_of_cpumask_remove_table(policy->cpus);
-	kfree(priv);
-out_put_regulator:
+out_put_opp_regulator:
 	if (name)
 		dev_pm_opp_put_regulators(opp_table);
+out_put_regulator:
+	if (priv->reg)
+		regulator_put(priv->reg);
+out_free_priv:
+	kfree(priv);
 out_put_clk:
 	clk_put(cpu_clk);
 
@@ -306,6 +319,8 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 		dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
 	if (priv->reg_name)
 		dev_pm_opp_put_regulators(priv->opp_table);
+	if (priv->reg)
+		regulator_put(priv->reg);
 
 	clk_put(policy->clk);
 	kfree(priv);
diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 22b53bf26817..623ae7fa34f9 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -23,6 +23,7 @@
 #include <linux/of_platform.h>
 #include <linux/pm_opp.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
 #define REVISION_MASK				0xF
@@ -213,13 +214,43 @@ static const struct of_device_id *ti_cpufreq_match_node(void)
 	return match;
 }
 
+#define TI_MULTIREGULATOR_COUNT 2
+static struct regulator *multi_regulators[TI_MULTIREGULATOR_COUNT];
+
+static int ti_setup_multi_regulators(struct device *cpu_dev)
+{
+	struct opp_table *ti_opp_table;
+	int ret = 0;
+
+	multi_regulators[0] = regulator_get(cpu_dev, "vdd");
+	if (IS_ERR(multi_regulators[0]))
+		return PTR_ERR(multi_regulators[0]);
+	multi_regulators[1] = regulator_get(cpu_dev, "vbb");
+	if (IS_ERR(multi_regulators[1])) {
+		ret = PTR_ERR(multi_regulators[1]);
+		goto free0;
+	}
+
+	ti_opp_table = dev_pm_opp_set_regulators(cpu_dev, multi_regulators,
+						 TI_MULTIREGULATOR_COUNT);
+	if (IS_ERR(ti_opp_table)) {
+		ret = PTR_ERR(ti_opp_table);
+		goto free1;
+	}
+	return 0;
+free1:
+	regulator_put(multi_regulators[1]);
+free0:
+	regulator_put(multi_regulators[0]);
+	return ret;
+}
+
 static int ti_cpufreq_probe(struct platform_device *pdev)
 {
 	u32 version[VERSION_COUNT];
 	const struct of_device_id *match;
 	struct opp_table *ti_opp_table;
 	struct ti_cpufreq_data *opp_data;
-	const char * const reg_names[] = {"vdd", "vbb"};
 	int ret;
 
 	match = dev_get_platdata(&pdev->dev);
@@ -273,14 +304,10 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 	}
 
 	opp_data->opp_table = ti_opp_table;
-
 	if (opp_data->soc_data->multi_regulator) {
-		ti_opp_table = dev_pm_opp_set_regulators(opp_data->cpu_dev,
-							 reg_names,
-							 ARRAY_SIZE(reg_names));
-		if (IS_ERR(ti_opp_table)) {
+		ret = ti_setup_multi_regulators(opp_data->cpu_dev);
+		if (ret) {
 			dev_pm_opp_put_supported_hw(opp_data->opp_table);
-			ret =  PTR_ERR(ti_opp_table);
 			goto fail_put_node;
 		}
 	}
@@ -316,6 +343,7 @@ static struct platform_driver ti_cpufreq_driver = {
 	.driver = {
 		.name = "ti-cpufreq",
 	},
+	.suppress_bind_attrs = true,
 };
 builtin_platform_driver(ti_cpufreq_driver);
 
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index d7f97167cac3..fc143a38fe8d 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1477,11 +1477,10 @@ static void _free_set_opp_data(struct opp_table *opp_table)
  * This must be called before any OPPs are initialized for the device.
  */
 struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
-					    const char * const names[],
+					    struct regulator **regulators,
 					    unsigned int count)
 {
 	struct opp_table *opp_table;
-	struct regulator *reg;
 	int ret, i;
 
 	opp_table = dev_pm_opp_get_opp_table(dev);
@@ -1498,41 +1497,14 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 	if (opp_table->regulators)
 		return opp_table;
 
-	opp_table->regulators = kmalloc_array(count,
-					      sizeof(*opp_table->regulators),
-					      GFP_KERNEL);
-	if (!opp_table->regulators) {
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	for (i = 0; i < count; i++) {
-		reg = regulator_get_optional(dev, names[i]);
-		if (IS_ERR(reg)) {
-			ret = PTR_ERR(reg);
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "%s: no regulator (%s) found: %d\n",
-					__func__, names[i], ret);
-			goto free_regulators;
-		}
-
-		opp_table->regulators[i] = reg;
-	}
-
+	opp_table->regulators = regulators;
 	opp_table->regulator_count = count;
 
 	/* Allocate block only once to pass to set_opp() routines */
 	ret = _allocate_set_opp_data(opp_table);
-	if (ret)
-		goto free_regulators;
-
-	return opp_table;
-
-free_regulators:
-	while (i != 0)
-		regulator_put(opp_table->regulators[--i]);
+	if (ret == 0)
+		return opp_table;
 
-	kfree(opp_table->regulators);
 	opp_table->regulators = NULL;
 	opp_table->regulator_count = -1;
 err:
@@ -1556,12 +1528,8 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
 	/* Make sure there are no concurrent readers while updating opp_table */
 	WARN_ON(!list_empty(&opp_table->opp_list));
 
-	for (i = opp_table->regulator_count - 1; i >= 0; i--)
-		regulator_put(opp_table->regulators[i]);
-
 	_free_set_opp_data(opp_table);
 
-	kfree(opp_table->regulators);
 	opp_table->regulators = NULL;
 	opp_table->regulator_count = -1;
 
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 24c757a32a7b..3cf24c2c4969 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -123,7 +123,7 @@ struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev, const u32 *ver
 void dev_pm_opp_put_supported_hw(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name);
 void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
-struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count);
+struct opp_table *dev_pm_opp_set_regulators(struct device *dev, struct regulator **regulators, unsigned int count);
 void dev_pm_opp_put_regulators(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
 void dev_pm_opp_put_clkname(struct opp_table *opp_table);
-- 
2.17.1

