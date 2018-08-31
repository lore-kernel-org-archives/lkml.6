Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56EBC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC9C2083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZgDBkcR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC9C2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeIADDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:03:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35739 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbeIADDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:03:06 -0400
Received: by mail-pl1-f194.google.com with SMTP id d9-v6so6086313plr.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 15:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JWravq+t0iWKBP7yOtilwFWvbxreMAwW6S9fE2u+f6g=;
        b=ZgDBkcR/VjdcudwwwJ6CfSW+6dyq500I3VqPlXfU1Xo6S0bRAY8pvxy8/Sw2e36lv2
         7xykDWIBHgdv4KY1tIuL0geE4Q8m/dI5CmKYKJzEgP7MdTV7X/Z9/3qmrMFUo8fPc9zy
         1/Giw/GZWazUltZkx68S8EBgoPGpe28LcWGhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JWravq+t0iWKBP7yOtilwFWvbxreMAwW6S9fE2u+f6g=;
        b=c/ddDSPMrPntU1tBe/2lFXNlil6VlTepFhNwNT0Ax1uR+4zydV6diwq4QDceWDxBS6
         4dR9zFZexPxBQ70tHPGi1NFBW6/h1JCdqOcQr5zRXjCP+WbsaubAkU73W5jOvEnAm+vx
         RMbcNF99+LQQuNPfFOKeMbNVS6D6jnYF412EDSEaefY0jTsFt2teDubcRUxVdbKMoevw
         JtkTW8pSfpOoxNg1H/dnS+lZ8ZvdE4pl1oSbfyySJjaNzxXxCGnWlb/4kABImcjr6+qs
         +U2jx2Ri384qYK+SqdjyOVJXrJ0ysNL7c9Yqln7TJiUuAEAyTRv9MNTu4N1Wnvp5v0e7
         32vA==
X-Gm-Message-State: APzg51CKCRRXDmNIqcX+lSfHa4GJfFO5kJrDVTBPSEQjeAA76LS283UW
        FvYM72QXUfYCQ3TklAxwo9sBVXjnbVM=
X-Google-Smtp-Source: ANB0VdYRg/+1GQz2M8pMUs/LZjzw3EZ/Iny2KUFoLAK0rQE9YtLN+3d08v6dOaueHiQBPCFY1jE1vA==
X-Received: by 2002:a17:902:46a4:: with SMTP id p33-v6mr17749933pld.205.1535756007693;
        Fri, 31 Aug 2018 15:53:27 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a19-v6sm26522056pfj.38.2018.08.31.15.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 15:53:27 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: qcom: Fix error handling in pm_runtime support
Date:   Fri, 31 Aug 2018 15:55:10 -0700
Message-Id: <20180831225510.32230-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver does not cope with the fact that probe can fail in a number
of cases after enabling pm_runtime on the device, this results in
warnings about "Unbalanced pm_runtime_enable". Further more if probe
fails after invoking host_init the power-domain will be left referenced.

As it's not possible for the error handling in qcom_pcie_host_init() to
handle errors happening after returning from that function the
pm_runtime_get_sync() is moved to probe() as well.

Fixes: 854b69efbdd2 ("PCI: qcom: add runtime pm support to pcie_port")
Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Dropped remove function, as this can't be called
- Handle pm_runtime_get_sync() errors
- Add "Fixes" tag

 drivers/pci/controller/dwc/pcie-qcom.c | 56 ++++++++++++++++++--------
 1 file changed, 39 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index d2373e4d141c..3bfaad052736 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1117,7 +1117,6 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 	int ret;
 
-	pm_runtime_get_sync(pci->dev);
 	qcom_ep_reset_assert(pcie);
 
 	ret = pcie->ops->init(pcie);
@@ -1154,7 +1153,6 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 	phy_power_off(pcie->phy);
 err_deinit:
 	pcie->ops->deinit(pcie);
-	pm_runtime_put(pci->dev);
 
 	return ret;
 }
@@ -1244,6 +1242,12 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		pm_runtime_disable(dev);
+		return ret;
+	}
+
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 	pp = &pci->pp;
@@ -1253,44 +1257,56 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	pcie->ops = of_device_get_match_data(dev);
 
 	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_LOW);
-	if (IS_ERR(pcie->reset))
-		return PTR_ERR(pcie->reset);
+	if (IS_ERR(pcie->reset)) {
+		ret = PTR_ERR(pcie->reset);
+		goto err_pm_runtime_put;
+	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "parf");
 	pcie->parf = devm_ioremap_resource(dev, res);
-	if (IS_ERR(pcie->parf))
-		return PTR_ERR(pcie->parf);
+	if (IS_ERR(pcie->parf)) {
+		ret = PTR_ERR(pcie->parf);
+		goto err_pm_runtime_put;
+	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
 	pci->dbi_base = devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(pci->dbi_base))
-		return PTR_ERR(pci->dbi_base);
+	if (IS_ERR(pci->dbi_base)) {
+		ret = PTR_ERR(pci->dbi_base);
+		goto err_pm_runtime_put;
+	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi");
 	pcie->elbi = devm_ioremap_resource(dev, res);
-	if (IS_ERR(pcie->elbi))
-		return PTR_ERR(pcie->elbi);
+	if (IS_ERR(pcie->elbi)) {
+		ret = PTR_ERR(pcie->elbi);
+		goto err_pm_runtime_put;
+	}
 
 	pcie->phy = devm_phy_optional_get(dev, "pciephy");
-	if (IS_ERR(pcie->phy))
-		return PTR_ERR(pcie->phy);
+	if (IS_ERR(pcie->phy)) {
+		ret = PTR_ERR(pcie->phy);
+		goto err_pm_runtime_put;
+	}
 
 	ret = pcie->ops->get_resources(pcie);
 	if (ret)
-		return ret;
+		goto err_pm_runtime_put;
 
 	pp->ops = &qcom_pcie_dw_ops;
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
-		if (pp->msi_irq < 0)
-			return pp->msi_irq;
+		if (pp->msi_irq < 0) {
+			ret = pp->msi_irq;
+			goto err_pm_runtime_put;
+		}
 	}
 
 	ret = phy_init(pcie->phy);
 	if (ret) {
 		pm_runtime_disable(&pdev->dev);
-		return ret;
+		goto err_pm_runtime_put;
 	}
 
 	platform_set_drvdata(pdev, pcie);
@@ -1299,10 +1315,16 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(dev, "cannot initialize host\n");
 		pm_runtime_disable(&pdev->dev);
-		return ret;
+		goto err_pm_runtime_put;
 	}
 
 	return 0;
+
+err_pm_runtime_put:
+	pm_runtime_put(dev);
+	pm_runtime_disable(dev);
+
+	return ret;
 }
 
 static const struct of_device_id qcom_pcie_match[] = {
-- 
2.18.0

