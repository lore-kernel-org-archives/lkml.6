Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C305EC7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F90520663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mFksgUnE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E7QH/VQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfAULWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:22:13 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33032 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbfAULWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:22:11 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DFDFD608BA; Mon, 21 Jan 2019 11:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548069730;
        bh=0Hi91cQ/hjCVhDdogwQ5vT80/tQYis8QOW0Gl5mbSwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mFksgUnEyGQHnkIpROzIWp97cweXyO7bPGtJzKZ8yi3dDPGTeeuXAg1Lj+EPOtm40
         /kbXe9RW/CMj0w1LXHVJ6sc2NLRj/zyK8fWNAzLCaItct71p6XhUzS29y4Krub5Cjb
         olL6OrjNdaSBCJYWyhU08fnlxMU3YA6kBoBJhXZM=
Received: from alokc-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokc@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6A1B36013C;
        Mon, 21 Jan 2019 11:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548069729;
        bh=0Hi91cQ/hjCVhDdogwQ5vT80/tQYis8QOW0Gl5mbSwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E7QH/VQdmkBEJi1ngtaeYwvqs2jqiZuZzVtS+hZNCmGk/hmWjZSKmhLMEGbzuvyrp
         Umu26/Qby9BZJKMeEeqPovUsL0GdUYtiQuWZr5TVGVwM9AO9ElqJZYR5RDKGxjmDqM
         V6kRzk4xUmMqVZ82uiIgXY5vzURaBhq4hg+3A8ik=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A1B36013C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=alokc@codeaurora.org
From:   Alok Chauhan <alokc@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Alok Chauhan <alokc@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        georgi.djakov@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org
Subject: [PATCH 3/6] i2c: i2c-qcom-geni: Add interconnect support
Date:   Mon, 21 Jan 2019 16:51:40 +0530
Message-Id: <1548069703-26595-4-git-send-email-alokc@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548069703-26595-1-git-send-email-alokc@codeaurora.org>
References: <1548069703-26595-1-git-send-email-alokc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get the interconnect paths for I2C based Serial Engine device
and vote accordingly based on maximum supported I2C frequency.

Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index db075bc..e8fe63a 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -14,6 +14,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/qcom-geni-se.h>
 #include <linux/spinlock.h>
+#include <linux/interconnect.h>
 
 #define SE_I2C_TX_TRANS_LEN		0x26c
 #define SE_I2C_RX_TRANS_LEN		0x270
@@ -508,6 +509,15 @@ static int geni_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Set the bus quota to a reasonable value */
+	gi2c->se.avg_bw = Bps_to_icc(1000);
+	gi2c->se.peak_bw = Bps_to_icc(76800000);
+	ret = geni_interconnect_init(&gi2c->se);
+	if (ret) {
+		dev_err(&pdev->dev, "interconnect_init failed %d\n", ret);
+		return ret;
+	}
+
 	ret = device_property_read_u32(&pdev->dev, "clock-frequency",
 							&gi2c->clk_freq_out);
 	if (ret) {
@@ -611,6 +621,8 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
 		gi2c->suspended = 1;
 	}
 
+	geni_icc_update_bw(&gi2c->se, false);
+
 	return 0;
 }
 
@@ -619,6 +631,7 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
 	int ret;
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
 
+	geni_icc_update_bw(&gi2c->se, true);
 	ret = geni_se_resources_on(&gi2c->se);
 	if (ret)
 		return ret;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

