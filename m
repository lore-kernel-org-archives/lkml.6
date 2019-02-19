Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3892DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067382075A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MK//UaIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfBSGEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 01:04:30 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39865 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfBSGD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 01:03:57 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so9869777pld.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 22:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DS4uNOBDo1WB9KnSrcyr/O/ij9VFYUJ1ooQOz6eplho=;
        b=MK//UaIe9fvR4Oi7QbwiXf6DH4NUISyH6nuVMXk8obRig92DIgm1Jt5B1XNfT7+++I
         oUnSCJpYA1mDIkOFbEHgGlT51LF5ZJYpzMznxEjqRLmUOG0HVtGSP1aOSZ1W0WEr/2ab
         rkjmcObQTWnUeAny72o5PCGK2NlQhEdxoVVYlcr5BQ5ktJfgVIul78OpgzRGeVe0qB4B
         uRCh7RfWwRG+yTQVB4TKiM4z0awNUQMk0RGvDcFDA1h2T5o+TGLWSWmtcKZ+jiFhY/Iq
         yP7a1p/rGtFszHO9E5Lk1qTrLpSuHBd/fSHIUd/bCl4Fm9/bxkqbaYpSwzJuuQVAeWXf
         oKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DS4uNOBDo1WB9KnSrcyr/O/ij9VFYUJ1ooQOz6eplho=;
        b=B6KwgDljjwvx7PT8OVyyGOEShvd+2YDBYRXBSB2FofhXv1fUpmwL/MVYGcbxxiAQUn
         JCon5n6X7KbfU3XomE0+AFfbmRUez5fghmqdlhtJ0Gg7lMicOjPnikhv+evTCd/RpjS+
         NjODXnoaDoEYfUqtSnVBzueH/wYjaWCu13dJrjM4IQLJqtirBV3mNX1qmkrWvOALQeDV
         Qo4rd0HM1i9AqbVSQNjBnKVz4f+1A86l1/NSpRBdHbjxCgaYf1CpAKiQQWqDJT5p20dS
         J/tGD3fX7TYYPpuOHxdBZebAbISjzst949Vcnju2H/tkKZWzrtBvYr6ZBf+3IeJ9ceum
         lh0g==
X-Gm-Message-State: AHQUAuYVsnBjUArOqqOA2zYA8Pe8sxcSiyP/DmxHzNs9ACuixwvrSOPC
        EWIxXVnfnmo2d++pth6tlmDMkQ==
X-Google-Smtp-Source: AHgI3IZPJjl3Bc6qKv5xONL3tYOXtG9gF2gr4rH6Yg/k7qsN7r/DMCcPVC7hopEjbqjVIJGPX48VGg==
X-Received: by 2002:a17:902:20e2:: with SMTP id v31mr29499375plg.307.1550556236482;
        Mon, 18 Feb 2019 22:03:56 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 86sm31914838pfk.157.2019.02.18.22.03.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 22:03:55 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 4/7] PCI: qcom: Use clk_bulk API for 2.4.0 controllers
Date:   Mon, 18 Feb 2019 22:04:04 -0800
Message-Id: <20190219060407.15263-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190219060407.15263-1-bjorn.andersson@linaro.org>
References: <20190219060407.15263-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before introducing the QCS404 platform, which uses the same PCIe
controller as IPQ4019, migrate this to use the bulk clock API, in order
to make the error paths slighly cleaner.

Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 48 +++++++-------------------
 1 file changed, 13 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index d185ea5fe996..b4d8bcf6eb77 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -113,9 +113,8 @@ struct qcom_pcie_resources_2_3_2 {
 };
 
 struct qcom_pcie_resources_2_4_0 {
-	struct clk *aux_clk;
-	struct clk *master_clk;
-	struct clk *slave_clk;
+	struct clk_bulk_data clks[3];
+	int num_clks;
 	struct reset_control *axi_m_reset;
 	struct reset_control *axi_s_reset;
 	struct reset_control *pipe_reset;
@@ -638,18 +637,17 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
+	int ret;
 
-	res->aux_clk = devm_clk_get(dev, "aux");
-	if (IS_ERR(res->aux_clk))
-		return PTR_ERR(res->aux_clk);
+	res->clks[0].id = "aux";
+	res->clks[1].id = "master_bus";
+	res->clks[2].id = "slave_bus";
 
-	res->master_clk = devm_clk_get(dev, "master_bus");
-	if (IS_ERR(res->master_clk))
-		return PTR_ERR(res->master_clk);
+	res->num_clks = 3;
 
-	res->slave_clk = devm_clk_get(dev, "slave_bus");
-	if (IS_ERR(res->slave_clk))
-		return PTR_ERR(res->slave_clk);
+	ret = devm_clk_bulk_get(dev, res->num_clks, res->clks);
+	if (ret < 0)
+		return ret;
 
 	res->axi_m_reset = devm_reset_control_get_exclusive(dev, "axi_m");
 	if (IS_ERR(res->axi_m_reset))
@@ -719,9 +717,7 @@ static void qcom_pcie_deinit_2_4_0(struct qcom_pcie *pcie)
 	reset_control_assert(res->axi_m_sticky_reset);
 	reset_control_assert(res->pwr_reset);
 	reset_control_assert(res->ahb_reset);
-	clk_disable_unprepare(res->aux_clk);
-	clk_disable_unprepare(res->master_clk);
-	clk_disable_unprepare(res->slave_clk);
+	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 }
 
 static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
@@ -850,23 +846,9 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
 
 	usleep_range(10000, 12000);
 
-	ret = clk_prepare_enable(res->aux_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable iface clock\n");
+	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
+	if (ret)
 		goto err_clk_aux;
-	}
-
-	ret = clk_prepare_enable(res->master_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable core clock\n");
-		goto err_clk_axi_m;
-	}
-
-	ret = clk_prepare_enable(res->slave_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable phy clock\n");
-		goto err_clk_axi_s;
-	}
 
 	/* enable PCIe clocks and resets */
 	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
@@ -891,10 +873,6 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
 
 	return 0;
 
-err_clk_axi_s:
-	clk_disable_unprepare(res->master_clk);
-err_clk_axi_m:
-	clk_disable_unprepare(res->aux_clk);
 err_clk_aux:
 	reset_control_assert(res->ahb_reset);
 err_rst_ahb:
-- 
2.18.0

