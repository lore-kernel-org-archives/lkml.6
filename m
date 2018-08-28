Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D2EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32CF208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A32CF208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbeH1Fo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:44:28 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35770 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbeH1Fo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:44:28 -0400
Received: by mail-oi0-f68.google.com with SMTP id m11-v6so40464oic.2;
        Mon, 27 Aug 2018 18:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u9bJdMmrGH9rRJqPJ81Gw7NB31ekfOx9SOa8t7KchgQ=;
        b=tvpfB+FAdxGIbmfvNluwj2pSRtzN3/UArDz2DKeSYItzuR9xWca8FCe3BAlG8s7JUA
         R4jF6D9XWrJ0AeKjDtjrXhmQB8qcLZXjkjokKgvnNTS5Hf0pNK6hiJT+Ka7v6TuzFTEi
         YatrVORv8h7P+0pJ5K2i0rGq1Yxh/APZx60hJCAB7Ks/cC6l8fMVtYKWFAoOpq8+t1Dj
         QkAuCE5wmZLxVQhpJwB3U/z1uY21AxGmmE4svW+Tfp2UaAySnc1TzWS6OfK/XJXdRTH7
         v9POz+XNEa3+ID07nU2Ut4/HLhl+INUqzqQyFZV5Ym6RacunvkKMqOoVlCCT63CYCRJC
         NISg==
X-Gm-Message-State: APzg51A1LnS7Xxo9gkdre1/sNjO/uc84oYKwnvrle/dUqCtt2uCWOFkb
        wLEaODb3gqJI0zieGDeUvHJUs34=
X-Google-Smtp-Source: ANB0VdaCbSs0VDaX6ftl/VSTtIGwm8T+Vo2Be1E+902w0zYLTvtiW+Wm06MTgY4uaIn+P4nXCMO0cA==
X-Received: by 2002:aca:2111:: with SMTP id 17-v6mr970890oiz.241.1535421311849;
        Mon, 27 Aug 2018 18:55:11 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.55.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:55:11 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org
Subject: [PATCH] soc: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:44 -0500
Message-Id: <20180828015252.28511-43-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Qiang Zhao <qiang.zhao@nxp.com>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-soc@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/soc/dove/pmu.c            |  8 +++---
 drivers/soc/fsl/qe/qe_tdm.c       |  4 +--
 drivers/soc/qcom/apr.c            |  2 +-
 drivers/soc/rockchip/pm_domains.c | 44 +++++++++++++++----------------
 drivers/soc/tegra/pmc.c           | 12 ++++-----
 drivers/soc/ti/knav_dma.c         |  8 +++---
 drivers/soc/ti/knav_qmss_queue.c  |  8 +++---
 7 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/soc/dove/pmu.c b/drivers/soc/dove/pmu.c
index 5abb08ffb74d..ffc5311c0ed8 100644
--- a/drivers/soc/dove/pmu.c
+++ b/drivers/soc/dove/pmu.c
@@ -383,7 +383,7 @@ int __init dove_init_pmu(void)
 
 	domains_node = of_get_child_by_name(np_pmu, "domains");
 	if (!domains_node) {
-		pr_err("%s: failed to find domains sub-node\n", np_pmu->name);
+		pr_err("%pOFn: failed to find domains sub-node\n", np_pmu);
 		return 0;
 	}
 
@@ -396,7 +396,7 @@ int __init dove_init_pmu(void)
 	pmu->pmc_base = of_iomap(pmu->of_node, 0);
 	pmu->pmu_base = of_iomap(pmu->of_node, 1);
 	if (!pmu->pmc_base || !pmu->pmu_base) {
-		pr_err("%s: failed to map PMU\n", np_pmu->name);
+		pr_err("%pOFn: failed to map PMU\n", np_pmu);
 		iounmap(pmu->pmu_base);
 		iounmap(pmu->pmc_base);
 		kfree(pmu);
@@ -414,7 +414,7 @@ int __init dove_init_pmu(void)
 			break;
 
 		domain->pmu = pmu;
-		domain->base.name = kstrdup(np->name, GFP_KERNEL);
+		domain->base.name = kasprintf(GFP_KERNEL, "%pOFn", np);
 		if (!domain->base.name) {
 			kfree(domain);
 			break;
@@ -444,7 +444,7 @@ int __init dove_init_pmu(void)
 	/* Loss of the interrupt controller is not a fatal error. */
 	parent_irq = irq_of_parse_and_map(pmu->of_node, 0);
 	if (!parent_irq) {
-		pr_err("%s: no interrupt specified\n", np_pmu->name);
+		pr_err("%pOFn: no interrupt specified\n", np_pmu);
 	} else {
 		ret = dove_init_pmu_irq(pmu, parent_irq);
 		if (ret)
diff --git a/drivers/soc/fsl/qe/qe_tdm.c b/drivers/soc/fsl/qe/qe_tdm.c
index f744c214f680..f78c34647ca2 100644
--- a/drivers/soc/fsl/qe/qe_tdm.c
+++ b/drivers/soc/fsl/qe/qe_tdm.c
@@ -131,7 +131,7 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 
 	pdev = of_find_device_by_node(np2);
 	if (!pdev) {
-		pr_err("%s: failed to lookup pdev\n", np2->name);
+		pr_err("%pOFn: failed to lookup pdev\n", np2);
 		of_node_put(np2);
 		return -EINVAL;
 	}
@@ -153,7 +153,7 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 	pdev = of_find_device_by_node(np2);
 	if (!pdev) {
 		ret = -EINVAL;
-		pr_err("%s: failed to lookup pdev\n", np2->name);
+		pr_err("%pOFn: failed to lookup pdev\n", np2);
 		of_node_put(np2);
 		goto err_miss_siram_property;
 	}
diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
index 57af8a537332..4bda793ba6ae 100644
--- a/drivers/soc/qcom/apr.c
+++ b/drivers/soc/qcom/apr.c
@@ -219,7 +219,7 @@ static int apr_add_device(struct device *dev, struct device_node *np,
 	adev->domain_id = id->domain_id;
 	adev->version = id->svc_version;
 	if (np)
-		strncpy(adev->name, np->name, APR_NAME_SIZE);
+		snprintf(adev->name, APR_NAME_SIZE, "%pOFn", np);
 	else
 		strncpy(adev->name, id->name, APR_NAME_SIZE);
 
diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 6dff8682155f..6f86a726bb45 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -392,21 +392,21 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	error = of_property_read_u32(node, "reg", &id);
 	if (error) {
 		dev_err(pmu->dev,
-			"%s: failed to retrieve domain id (reg): %d\n",
-			node->name, error);
+			"%pOFn: failed to retrieve domain id (reg): %d\n",
+			node, error);
 		return -EINVAL;
 	}
 
 	if (id >= pmu->info->num_domains) {
-		dev_err(pmu->dev, "%s: invalid domain id %d\n",
-			node->name, id);
+		dev_err(pmu->dev, "%pOFn: invalid domain id %d\n",
+			node, id);
 		return -EINVAL;
 	}
 
 	pd_info = &pmu->info->domain_info[id];
 	if (!pd_info) {
-		dev_err(pmu->dev, "%s: undefined domain id %d\n",
-			node->name, id);
+		dev_err(pmu->dev, "%pOFn: undefined domain id %d\n",
+			node, id);
 		return -EINVAL;
 	}
 
@@ -424,8 +424,8 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 		if (!pd->clks)
 			return -ENOMEM;
 	} else {
-		dev_dbg(pmu->dev, "%s: doesn't have clocks: %d\n",
-			node->name, pd->num_clks);
+		dev_dbg(pmu->dev, "%pOFn: doesn't have clocks: %d\n",
+			node, pd->num_clks);
 		pd->num_clks = 0;
 	}
 
@@ -434,8 +434,8 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 		if (IS_ERR(pd->clks[i].clk)) {
 			error = PTR_ERR(pd->clks[i].clk);
 			dev_err(pmu->dev,
-				"%s: failed to get clk at index %d: %d\n",
-				node->name, i, error);
+				"%pOFn: failed to get clk at index %d: %d\n",
+				node, i, error);
 			return error;
 		}
 	}
@@ -486,8 +486,8 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	error = rockchip_pd_power(pd, true);
 	if (error) {
 		dev_err(pmu->dev,
-			"failed to power on domain '%s': %d\n",
-			node->name, error);
+			"failed to power on domain '%pOFn': %d\n",
+			node, error);
 		goto err_unprepare_clocks;
 	}
 
@@ -575,24 +575,24 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
 		error = of_property_read_u32(parent, "reg", &idx);
 		if (error) {
 			dev_err(pmu->dev,
-				"%s: failed to retrieve domain id (reg): %d\n",
-				parent->name, error);
+				"%pOFn: failed to retrieve domain id (reg): %d\n",
+				parent, error);
 			goto err_out;
 		}
 		parent_domain = pmu->genpd_data.domains[idx];
 
 		error = rockchip_pm_add_one_domain(pmu, np);
 		if (error) {
-			dev_err(pmu->dev, "failed to handle node %s: %d\n",
-				np->name, error);
+			dev_err(pmu->dev, "failed to handle node %pOFn: %d\n",
+				np, error);
 			goto err_out;
 		}
 
 		error = of_property_read_u32(np, "reg", &idx);
 		if (error) {
 			dev_err(pmu->dev,
-				"%s: failed to retrieve domain id (reg): %d\n",
-				np->name, error);
+				"%pOFn: failed to retrieve domain id (reg): %d\n",
+				np, error);
 			goto err_out;
 		}
 		child_domain = pmu->genpd_data.domains[idx];
@@ -683,16 +683,16 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 	for_each_available_child_of_node(np, node) {
 		error = rockchip_pm_add_one_domain(pmu, node);
 		if (error) {
-			dev_err(dev, "failed to handle node %s: %d\n",
-				node->name, error);
+			dev_err(dev, "failed to handle node %pOFn: %d\n",
+				node, error);
 			of_node_put(node);
 			goto err_out;
 		}
 
 		error = rockchip_pm_add_subdomain(pmu, node);
 		if (error < 0) {
-			dev_err(dev, "failed to handle subdomain node %s: %d\n",
-				node->name, error);
+			dev_err(dev, "failed to handle subdomain node %pOFn: %d\n",
+				node, error);
 			of_node_put(node);
 			goto err_out;
 		}
diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 2d6f3fcf3211..acbe63e925d5 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -796,7 +796,7 @@ static void tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
 
 	id = tegra_powergate_lookup(pmc, np->name);
 	if (id < 0) {
-		pr_err("powergate lookup failed for %s: %d\n", np->name, id);
+		pr_err("powergate lookup failed for %pOFn: %d\n", np, id);
 		goto free_mem;
 	}
 
@@ -816,13 +816,13 @@ static void tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
 
 	err = tegra_powergate_of_get_clks(pg, np);
 	if (err < 0) {
-		pr_err("failed to get clocks for %s: %d\n", np->name, err);
+		pr_err("failed to get clocks for %pOFn: %d\n", np, err);
 		goto set_available;
 	}
 
 	err = tegra_powergate_of_get_resets(pg, np, off);
 	if (err < 0) {
-		pr_err("failed to get resets for %s: %d\n", np->name, err);
+		pr_err("failed to get resets for %pOFn: %d\n", np, err);
 		goto remove_clks;
 	}
 
@@ -851,15 +851,15 @@ static void tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
 
 	err = pm_genpd_init(&pg->genpd, NULL, off);
 	if (err < 0) {
-		pr_err("failed to initialise PM domain %s: %d\n", np->name,
+		pr_err("failed to initialise PM domain %pOFn: %d\n", np,
 		       err);
 		goto remove_resets;
 	}
 
 	err = of_genpd_add_provider_simple(np, &pg->genpd);
 	if (err < 0) {
-		pr_err("failed to add PM domain provider for %s: %d\n",
-		       np->name, err);
+		pr_err("failed to add PM domain provider for %pOFn: %d\n",
+		       np, err);
 		goto remove_genpd;
 	}
 
diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index 224d7ddeeb76..bbd4e5bc8707 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -544,15 +544,15 @@ static void __iomem *pktdma_get_regs(struct knav_dma_device *dma,
 
 	ret = of_address_to_resource(node, index, &res);
 	if (ret) {
-		dev_err(dev, "Can't translate of node(%s) address for index(%d)\n",
-			node->name, index);
+		dev_err(dev, "Can't translate of node(%pOFn) address for index(%d)\n",
+			node, index);
 		return ERR_PTR(ret);
 	}
 
 	regs = devm_ioremap_resource(kdev->dev, &res);
 	if (IS_ERR(regs))
-		dev_err(dev, "Failed to map register base for index(%d) node(%s)\n",
-			index, node->name);
+		dev_err(dev, "Failed to map register base for index(%d) node(%pOFn)\n",
+			index, node);
 	if (_size)
 		*_size = resource_size(&res);
 
diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 6755f2af5619..b5d5673c255c 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1382,15 +1382,15 @@ static void __iomem *knav_queue_map_reg(struct knav_device *kdev,
 
 	ret = of_address_to_resource(node, index, &res);
 	if (ret) {
-		dev_err(kdev->dev, "Can't translate of node(%s) address for index(%d)\n",
-			node->name, index);
+		dev_err(kdev->dev, "Can't translate of node(%pOFn) address for index(%d)\n",
+			node, index);
 		return ERR_PTR(ret);
 	}
 
 	regs = devm_ioremap_resource(kdev->dev, &res);
 	if (IS_ERR(regs))
-		dev_err(kdev->dev, "Failed to map register base for index(%d) node(%s)\n",
-			index, node->name);
+		dev_err(kdev->dev, "Failed to map register base for index(%d) node(%pOFn)\n",
+			index, node);
 	return regs;
 }
 
-- 
2.17.1

