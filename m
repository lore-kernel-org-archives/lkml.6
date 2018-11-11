Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CE2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED9120866
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zEOZBvl+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED9120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732244AbeKLJzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:55:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:34452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732026AbeKLIRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:47 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 926C2223AE;
        Sun, 11 Nov 2018 22:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975271;
        bh=JtvBFFKQHuUZHyJSfntn2GFYpmDrPDJAx/5EZNZv7R0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zEOZBvl+55eDc2ofGPAc1rjIXhHYhueIQ0CG2rI20hKgs1Epsz9IValtAy8z1LSS2
         QaAU9lHpu5zf3Ug/ZyqjJZ0SvIxX3di+pIrS8725huzOmKIK8kKZwtBZc4EKoV0j8s
         IHc7gaiCj8+NeITxEKmTgVC9vMjOBqKSwk76eLl0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chris Welch <Chris.Welch@viavisolutions.com>,
        Vignesh R <vigneshr@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 171/361] PCI: dwc: pci-dra7xx: Enable errata i870 for both EP and RC mode
Date:   Sun, 11 Nov 2018 14:18:38 -0800
Message-Id: <20181111221644.285271199@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

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
 


