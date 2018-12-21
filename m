Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265A2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AEF218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Nm4cLdgN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbeLUIcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:32:50 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34797 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730462AbeLUIcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:32:50 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181221083247euoutp01e4e488e040b14f600c175dd758ba18f0~yS-wA5Q6s1764617646euoutp01Q;
        Fri, 21 Dec 2018 08:32:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181221083247euoutp01e4e488e040b14f600c175dd758ba18f0~yS-wA5Q6s1764617646euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545381167;
        bh=tLC3+04L43oul86HuxKWApsTwBv8jVtRRdaFe6Bs3Wk=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=Nm4cLdgNnBjrqBL/uzwMMVOb0EUaU5sqR04g9VYvIH1v4dTMU+txR7idiHJVeN/9F
         /46ZOaqXzpN1yRefQiPco2LmzodDvivqf7ecB8V7gB+OcC1pX2S4nkBKkiSsj8Ii5A
         yQFensTeSqFw40uIVyYDe5hcdqjpkkE59NDcy5do=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181221083247eucas1p271308b4950ef226b4bc65f955060eb00~yS-vc-4hu0581305813eucas1p2A;
        Fri, 21 Dec 2018 08:32:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id FD.1A.04294.E25AC1C5; Fri, 21
        Dec 2018 08:32:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181221083246eucas1p22cade911a455344d351db6060d39ddce~yS-u0XXPk3030030300eucas1p2a;
        Fri, 21 Dec 2018 08:32:46 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-f0-5c1ca52ebd78
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 33.F0.04128.E25AC1C5; Fri, 21
        Dec 2018 08:32:46 +0000 (GMT)
Received: from AMDC3748.DIGITAL.local ([106.120.43.17]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PK2007EFVQLXY60@eusync1.samsung.com>;
        Fri, 21 Dec 2018 08:32:46 +0000 (GMT)
From:   Andrzej Hajda <a.hajda@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm-kernel@lists.infradead.org, andy.shevchenko@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: [PATCH] PCI: pcie-rockchip: use probe_err helpers instead of open
 coding
Date:   Fri, 21 Dec 2018 09:32:38 +0100
Message-id: <20181221083238.10020-1-a.hajda@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181220111434.GC10978@kroah.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUhTcRTG/Xvv7u5mk9sU/KdSMRJRcmpGXLAsYemV+iAEfSgjp96c6aZs
        ztQ+aCqhFrU11DZTKl+Z5myb04x8meIySRraTEnIJqSzKF+IynQ5b377PTzPcw4HDo7wl9FA
        PEuWT8tl4hwBxkUtY78nI4QtwSlRan0sOdc1ySKXVSOAfP7QwCJrFhYxsrzJgJHuzyss8klt
        GyCNTgeLnOp/hJHWmleA/Lq5xCafjc6zyYaNGoT8uGhgnfGlOhs7ATXlsCPUC908mzLqqzBq
        sKGTTZmaS6jvA+8xaks3iFL3zHpA9ToaEWrdeDDZ5xL3ZAadk1VAyyPjUrmS7tpRLM8dXThR
        28MuBU/DqgEHh8Rx2Ka1s6sBF+cT7QD+mhlgMWIdwLo1DdhLmX5uezNGK4ALdbdQRrgBHH+p
        ZXtSGBEGt0yzmIf9iRh4/61udy5CaFHo3KhHPYYfcQHOVOi9PYwSIdA1O71b4BEkVH8xspl1
        h2BH9xDiYQ4RCV2W0d1tkFjBoKZxdaeM7wgRHNEVM3k/6LKZ/3eD4ZTmDspwCSzTTiNMtxLA
        101tGGPEwhGbneVhhPCFDyx1CDOTBytv8xmk4NpaDHNkGYBb9k1EBQ48Bl56EEArFdJMWnFM
        Rt8QKsRShVKWKUzPlRrBzgNMbNs2+kD/3zQrIHAg2Md71xuUwmeJCxRFUiuAOCLw51WeCk7h
        8zLERcW0PPeqXJlDK6wgCEcFAbybXp8u84lMcT6dTdN5tHzP9cY5gaVA1Ld/7nzCCZ/SnjcR
        V5qiLp7+YUNUR+OD6guNPaHEcJIhTLcklLQnfhAlX6/K1rb6uwuU4RUrf+y25vzh2kWTb268
        xNwhOjvUYoFD6Q6OKo1f/k0dMlYiTz8yvWrRCKzr5rjQxLsD+nNxXRl4qlrVkuy8phQnOV0J
        4+rDSgGqkIijwxG5QvwPWKANUvwCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsVy+t/xy7p6S2ViDL79k7a4te4cq8XLCYcZ
        LTbOWM9qMfXhEzaL5sXr2Sz+P3rNarFw2nJGi02Pr7FaXN41h83i0NS9jBZvfr9gt1h75C67
        xdwvU5kt7jxZz+rA57Fm3hpGj8vXLjJ77Jx1l91j06pONo/9c9ewe2xeUu/xft9VNo+/s/az
        ePRtWcXosf3aPGaPz5vkArijuGxSUnMyy1KL9O0SuDI2TDvCVvDfsOL0tK3sDYyLNLsYOTkk
        BEwkNn/7x9TFyMUhJLCEUWLOytWMEE4jk0T/40eMIFVsApoSfzffZAOxRQSMJfrPzmIHKWIW
        mMsicez4DLCEsECwxPWWVUwgNouAqsSrm1fA4rwCFhITn29ih1gnL7F6wwFmEJtTQF/i1bYj
        LCC2kICexNXmZ4wTGHkWMDKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECAzfbcd+btnB2PUu
        +BCjAAejEg+vxi7pGCHWxLLiytxDjBIczEoivB22MjFCvCmJlVWpRfnxRaU5qcWHGKU5WJTE
        ec8bVEYJCaQnlqRmp6YWpBbBZJk4OKUaGCcontKYEdkzdc6js4Y9N0qDEv5GKa5JWGX6wo1n
        sXtY4fprpgL6pybO7FCzNo/8/yy+MX718pcG3y4Fzrx6YWqz/NpIRs7wLdcm7GcICLitpRbM
        c6BfqTXRbPrq2rtrvpZHc/iwObz02r0gc3rbvgfbJ7OsCP5v8mOR+oZn91oWpb2e+GKa4W0l
        luKMREMt5qLiRAD44L/AWwIAAA==
X-CMS-MailID: 20181221083246eucas1p22cade911a455344d351db6060d39ddce
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181221083246eucas1p22cade911a455344d351db6060d39ddce
References: <20181220111434.GC10978@kroah.com>
        <CGME20181221083246eucas1p22cade911a455344d351db6060d39ddce@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

probe_err helpers makes probe error handling easier and less error prone.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
Hi all,

This is sample conversion of one of drivers to proposed probe_err* helpers.
It was created to convince Greg that these helpers are useful.
With this helper we gain:
- corect error handling (deferral does not spam dmesg, other errors are logged),
- uniform error logging,
- simplified code,
- possibilty to check why some devices are deferred,
- shorter code.
Here are links to patchsets adding helpers v1[1], v4[2], in v1 I have added
big patch doing conversion to probe_err to show scale of the 'issue'.
If the helpers will be accepted I plan to send patches converting other drivers
as well.

[1]: https://lkml.org/lkml/2018/10/16/601
[2]: https://lkml.org/lkml/2018/12/20/438

Regards
Andrzej
---

 drivers/pci/controller/pcie-rockchip.c | 100 ++++++++++---------------
 1 file changed, 39 insertions(+), 61 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index c53d1322a3d6..0d4f012c02ba 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -69,86 +69,67 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 		rockchip->link_gen = 2;
 
 	rockchip->core_rst = devm_reset_control_get_exclusive(dev, "core");
-	if (IS_ERR(rockchip->core_rst)) {
-		if (PTR_ERR(rockchip->core_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing core reset property in node\n");
-		return PTR_ERR(rockchip->core_rst);
-	}
+	if (IS_ERR(rockchip->core_rst))
+		return probe_err_ptr(dev, rockchip->core_rst,
+				     "missing core reset property in node\n");
 
 	rockchip->mgmt_rst = devm_reset_control_get_exclusive(dev, "mgmt");
-	if (IS_ERR(rockchip->mgmt_rst)) {
-		if (PTR_ERR(rockchip->mgmt_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing mgmt reset property in node\n");
-		return PTR_ERR(rockchip->mgmt_rst);
-	}
+	if (IS_ERR(rockchip->mgmt_rst))
+		return probe_err_ptr(dev, rockchip->mgmt_rst,
+				     "missing mgmt reset property in node\n");
 
 	rockchip->mgmt_sticky_rst = devm_reset_control_get_exclusive(dev,
 								     "mgmt-sticky");
-	if (IS_ERR(rockchip->mgmt_sticky_rst)) {
-		if (PTR_ERR(rockchip->mgmt_sticky_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing mgmt-sticky reset property in node\n");
-		return PTR_ERR(rockchip->mgmt_sticky_rst);
-	}
+	if (IS_ERR(rockchip->mgmt_sticky_rst))
+		return probe_err_ptr(dev, rockchip->mgmt_sticky_rst,
+				     "missing mgmt-sticky reset property in node\n");
 
 	rockchip->pipe_rst = devm_reset_control_get_exclusive(dev, "pipe");
-	if (IS_ERR(rockchip->pipe_rst)) {
-		if (PTR_ERR(rockchip->pipe_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing pipe reset property in node\n");
-		return PTR_ERR(rockchip->pipe_rst);
-	}
+	if (IS_ERR(rockchip->pipe_rst))
+		return probe_err_ptr(dev, rockchip->pipe_rst,
+				     "missing pipe reset property in node\n");
 
 	rockchip->pm_rst = devm_reset_control_get_exclusive(dev, "pm");
-	if (IS_ERR(rockchip->pm_rst)) {
-		if (PTR_ERR(rockchip->pm_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing pm reset property in node\n");
-		return PTR_ERR(rockchip->pm_rst);
-	}
+	if (IS_ERR(rockchip->pm_rst))
+		return probe_err_ptr(dev, rockchip->pm_rst,
+				     "missing pm reset property in node\n");
 
 	rockchip->pclk_rst = devm_reset_control_get_exclusive(dev, "pclk");
-	if (IS_ERR(rockchip->pclk_rst)) {
-		if (PTR_ERR(rockchip->pclk_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing pclk reset property in node\n");
-		return PTR_ERR(rockchip->pclk_rst);
-	}
+	if (IS_ERR(rockchip->pclk_rst))
+		return probe_err_ptr(dev, rockchip->pclk_rst,
+				     "missing pclk reset property in node\n");
 
 	rockchip->aclk_rst = devm_reset_control_get_exclusive(dev, "aclk");
-	if (IS_ERR(rockchip->aclk_rst)) {
-		if (PTR_ERR(rockchip->aclk_rst) != -EPROBE_DEFER)
-			dev_err(dev, "missing aclk reset property in node\n");
-		return PTR_ERR(rockchip->aclk_rst);
-	}
+	if (IS_ERR(rockchip->aclk_rst))
+		return probe_err_ptr(dev, rockchip->aclk_rst,
+				     "missing aclk reset property in node\n");
 
 	if (rockchip->is_rc) {
 		rockchip->ep_gpio = devm_gpiod_get(dev, "ep", GPIOD_OUT_HIGH);
-		if (IS_ERR(rockchip->ep_gpio)) {
-			dev_err(dev, "missing ep-gpios property in node\n");
-			return PTR_ERR(rockchip->ep_gpio);
-		}
+		if (IS_ERR(rockchip->ep_gpio))
+			return probe_err_ptr(dev, rockchip->ep_gpio,
+					     "missing ep-gpios property in node\n");
 	}
 
 	rockchip->aclk_pcie = devm_clk_get(dev, "aclk");
-	if (IS_ERR(rockchip->aclk_pcie)) {
-		dev_err(dev, "aclk clock not found\n");
-		return PTR_ERR(rockchip->aclk_pcie);
-	}
+	if (IS_ERR(rockchip->aclk_pcie))
+		return probe_err_ptr(dev, rockchip->aclk_pcie,
+				     "aclk clock not found\n");
 
 	rockchip->aclk_perf_pcie = devm_clk_get(dev, "aclk-perf");
-	if (IS_ERR(rockchip->aclk_perf_pcie)) {
-		dev_err(dev, "aclk_perf clock not found\n");
-		return PTR_ERR(rockchip->aclk_perf_pcie);
-	}
+	if (IS_ERR(rockchip->aclk_perf_pcie))
+		return probe_err_ptr(dev, rockchip->aclk_perf_pcie,
+				     "aclk_perf clock not found\n");
 
 	rockchip->hclk_pcie = devm_clk_get(dev, "hclk");
-	if (IS_ERR(rockchip->hclk_pcie)) {
-		dev_err(dev, "hclk clock not found\n");
-		return PTR_ERR(rockchip->hclk_pcie);
-	}
+	if (IS_ERR(rockchip->hclk_pcie))
+		return probe_err_ptr(dev, rockchip->hclk_pcie,
+				     "hclk clock not found\n");
 
 	rockchip->clk_pcie_pm = devm_clk_get(dev, "pm");
-	if (IS_ERR(rockchip->clk_pcie_pm)) {
-		dev_err(dev, "pm clock not found\n");
-		return PTR_ERR(rockchip->clk_pcie_pm);
-	}
+	if (IS_ERR(rockchip->clk_pcie_pm))
+		return probe_err_ptr(dev, rockchip->clk_pcie_pm,
+				     "pm clock not found\n");
 
 	return 0;
 }
@@ -323,12 +304,9 @@ int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip)
 		phy = devm_of_phy_get(dev, dev->of_node, name);
 		kfree(name);
 
-		if (IS_ERR(phy)) {
-			if (PTR_ERR(phy) != -EPROBE_DEFER)
-				dev_err(dev, "missing phy for lane %d: %ld\n",
-					i, PTR_ERR(phy));
-			return PTR_ERR(phy);
-		}
+		if (IS_ERR(phy))
+			return probe_err_ptr(dev, phy,
+					     "missing phy for lane %d\n", i);
 
 		rockchip->phys[i] = phy;
 	}
-- 
2.17.1

