Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAB1C7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4F720663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i1C9FTzE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YUjJIC90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfAULWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:22:20 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33190 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbfAULWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:22:18 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2072B608CD; Mon, 21 Jan 2019 11:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548069737;
        bh=vD5MTXyLS/qkTnSNYHFn5UkX/UYasOxBeZwiEyrO4hM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i1C9FTzE3IWmWs1kivPPDE3tcdNuMhj+iR5wAh82umzdKLOMYAvOLpfd5Db6mCDT6
         HMTmk5tyvjnCmRZwFmxlqrOlRH3o5BAtKjtWCPX1mbtR+RNv+GiDqoqMOaH4csMUf4
         y4Ovwg0oJKrFfzdNvqVxMcQmJMKoIU3815IK9Fys=
Received: from alokc-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokc@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2F44A608CB;
        Mon, 21 Jan 2019 11:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548069734;
        bh=vD5MTXyLS/qkTnSNYHFn5UkX/UYasOxBeZwiEyrO4hM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YUjJIC90BwZzYqFJzmuwiRHdv1Bt7bBDHqlWqSU0ZAU+7ebQpQwsg9u0oaiL7mSEU
         jd2KfQnsyiCNYllABmTOxyEUKlbIcDAgvRVLZmHIFXMQQp2OuLQYLlaJWIdJDcnSUA
         6W9IXJCOPcSpZHcQjgDgNSbIIyA98fR8GH9+2qWM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F44A608CB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=alokc@codeaurora.org
From:   Alok Chauhan <alokc@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        georgi.djakov@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org,
        Alok Chauhan <alokc@codeaurora.org>
Subject: [PATCH 4/6] spi: spi-geni-qcom: Add interconnect support
Date:   Mon, 21 Jan 2019 16:51:41 +0530
Message-Id: <1548069703-26595-5-git-send-email-alokc@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548069703-26595-1-git-send-email-alokc@codeaurora.org>
References: <1548069703-26595-1-git-send-email-alokc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get the interconnect paths for SPI based Serial Engine device
and vote accordingly based on maximum supported SPI frequency.

Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
---
 drivers/spi/spi-geni-qcom.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index fdb7cb88..7bbbe9d 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -12,6 +12,7 @@
 #include <linux/qcom-geni-se.h>
 #include <linux/spi/spi.h>
 #include <linux/spinlock.h>
+#include <linux/interconnect.h>
 
 /* SPI SE specific registers and respective register fields */
 #define SE_SPI_CPHA		0x224
@@ -589,6 +590,15 @@ static int spi_geni_probe(struct platform_device *pdev)
 	spin_lock_init(&mas->lock);
 	pm_runtime_enable(&pdev->dev);
 
+	/* Set the bus quota to a reasonable value */
+	mas->se.avg_bw = Bps_to_icc(2500);
+	mas->se.peak_bw = Bps_to_icc(200000000);
+	ret = geni_interconnect_init(&mas->se);
+	if (ret) {
+		dev_err(&pdev->dev, "interconnect_init failed %d\n", ret);
+		return ret;
+	}
+
 	ret = spi_geni_init(mas);
 	if (ret)
 		goto spi_geni_probe_runtime_disable;
@@ -628,8 +638,15 @@ static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
 {
 	struct spi_master *spi = dev_get_drvdata(dev);
 	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+	int ret;
 
-	return geni_se_resources_off(&mas->se);
+	ret = geni_se_resources_off(&mas->se);
+	if (ret)
+		return ret;
+
+	geni_icc_update_bw(&mas->se, false);
+
+	return 0;
 }
 
 static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
@@ -637,6 +654,7 @@ static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
 	struct spi_master *spi = dev_get_drvdata(dev);
 	struct spi_geni_master *mas = spi_master_get_devdata(spi);
 
+	geni_icc_update_bw(&mas->se, true);
 	return geni_se_resources_on(&mas->se);
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

