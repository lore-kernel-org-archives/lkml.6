Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55997ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BFB20870
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mA8ApO7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19BFB20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbeJYWsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:48:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728494AbeJYWsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:02 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D631420834;
        Thu, 25 Oct 2018 14:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476905;
        bh=juvJHMYGCf+DRwLatpEas47J3TbuSjhLEDzXc1dFIJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mA8ApO7g0nbckId1/559PbSfawrmBYuy23C5QNo/K270C+4haQwBrZxk74wYQXxTs
         RKTZTvQVRF4CBEQQr86IVockfX0T65+/VxlbtDaK96P53Uz79fEIF2FiNE/ru/FPSl
         XlDjGy+K8s1OjsPGkXfXlKlaQmflJmCUFc469n4o=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 27/98] ata: sata_rcar: Handle return value of clk_prepare_enable
Date:   Thu, 25 Oct 2018 10:13:12 -0400
Message-Id: <20181025141423.213774-27-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arvind Yadav <arvind.yadav.cs@gmail.com>

[ Upstream commit 5dc63fdcc09f47fb226b8bc7d83a61feb787d817 ]

Here, Clock enable can failed. So adding an error check for
clk_prepare_enable.

tj: minor style updates

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/sata_rcar.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index f72d601e300a..e83a3d3421b9 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -890,7 +890,10 @@ static int sata_rcar_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to get access to sata clock\n");
 		return PTR_ERR(priv->clk);
 	}
-	clk_prepare_enable(priv->clk);
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
 
 	host = ata_host_alloc(&pdev->dev, 1);
 	if (!host) {
@@ -970,8 +973,11 @@ static int sata_rcar_resume(struct device *dev)
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct sata_rcar_priv *priv = host->private_data;
 	void __iomem *base = priv->base;
+	int ret;
 
-	clk_prepare_enable(priv->clk);
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
 
 	/* ack and mask */
 	iowrite32(0, base + SATAINTSTAT_REG);
@@ -988,8 +994,11 @@ static int sata_rcar_restore(struct device *dev)
 {
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct sata_rcar_priv *priv = host->private_data;
+	int ret;
 
-	clk_prepare_enable(priv->clk);
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
 
 	sata_rcar_setup_port(host);
 
-- 
2.17.1

