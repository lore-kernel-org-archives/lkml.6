Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EF2C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF2A2084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcYkMB+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF2A2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388963AbeKLJUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:20:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:44954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388693AbeKLIU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:26 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C950F216FD;
        Sun, 11 Nov 2018 22:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975429;
        bh=9e+9YsawFXHuytbwV94ZCfexbyDVtXYtsMaCx6C7FPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UcYkMB+ECNKK4uFl/TWcn7Uwz+mPt7XzfPwjcngmEyqqxGarFCdYPgqCb7+itot0Y
         ILRWv88d0Qeq3xB+H2LqSlMdqVZQssp7KEJdB8uGUuQpMAChF2o+/VZkORJNvnXs+I
         ccjmU8fI5p04SkuEhE93LvKrGuspBV6XkJVCPsmk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chris Welch <Chris.Welch@viavisolutions.com>,
        Vignesh R <vigneshr@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 170/350] PCI: dwc: pci-dra7xx: Enable errata i870 for both EP and RC mode
Date:   Sun, 11 Nov 2018 14:20:34 -0800
Message-Id: <20181111221715.148580091@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vignesh R <vigneshr@ti.com>

[ Upstream commit 726d75a6d243bf6730da3216f3592503f6f0f588 ]

Errata i870 is applicable in both EP and RC mode. Therefore rename
function dra7xx_pcie_ep_unaligned_memaccess(), that implements errata
workaround, to dra7xx_pcie_unaligned_memaccess() and call it for both RC
and EP. Make sure driver probe does not fail in case the workaround is not
applied for RC mode in order to maintain DT backward compatibility.

Reported-by: Chris Welch <Chris.Welch@viavisolutions.com>
Signed-off-by: Vignesh R <vigneshr@ti.com>
[lorenzo.pieralisi@arm.com: reworded the log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/dwc/pci-dra7xx.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -542,7 +542,7 @@ static const struct of_device_id of_dra7
 };
 
 /*
- * dra7xx_pcie_ep_unaligned_memaccess: workaround for AM572x/AM571x Errata i870
+ * dra7xx_pcie_unaligned_memaccess: workaround for AM572x/AM571x Errata i870
  * @dra7xx: the dra7xx device where the workaround should be applied
  *
  * Access to the PCIe slave port that are not 32-bit aligned will result
@@ -552,7 +552,7 @@ static const struct of_device_id of_dra7
  *
  * To avoid this issue set PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE to 1.
  */
-static int dra7xx_pcie_ep_unaligned_memaccess(struct device *dev)
+static int dra7xx_pcie_unaligned_memaccess(struct device *dev)
 {
 	int ret;
 	struct device_node *np = dev->of_node;
@@ -704,6 +704,11 @@ static int __init dra7xx_pcie_probe(stru
 
 		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
 				   DEVICE_TYPE_RC);
+
+		ret = dra7xx_pcie_unaligned_memaccess(dev);
+		if (ret)
+			dev_err(dev, "WA for Errata i870 not applied\n");
+
 		ret = dra7xx_add_pcie_port(dra7xx, pdev);
 		if (ret < 0)
 			goto err_gpio;
@@ -717,7 +722,7 @@ static int __init dra7xx_pcie_probe(stru
 		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
 				   DEVICE_TYPE_EP);
 
-		ret = dra7xx_pcie_ep_unaligned_memaccess(dev);
+		ret = dra7xx_pcie_unaligned_memaccess(dev);
 		if (ret)
 			goto err_gpio;
 


