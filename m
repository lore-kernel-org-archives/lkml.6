Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F44C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFCC208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+aSVRaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFCC208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754651AbeGIGU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:20:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754627AbeGIGUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:20:21 -0400
Received: from localhost.localdomain (unknown [106.201.46.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2761E208E1;
        Mon,  9 Jul 2018 06:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531117221;
        bh=9F2j0qU4EuKw6U0ANvByv1DweXfo29Cp44sdPkaPidg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r+aSVRafL1foLthjb68y309NmYBjuAPT4pKvHbyapCkJZc5W3em8lJ4//eCuOlKn9
         IU2kU8NkPHNLnTMqh5AcFGGufiec3+zDCsnGmzmGy8Qxds+GXmND8RyPLLFLEuw6ed
         5tF5ZiWIFJ0ofhNLsSQzNCnXJXalsedssQX7Iyp4=
From:   Vinod Koul <vkoul@kernel.org>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Timur Tabi <timur@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v5 5/6] crypto: qcom: Add support for prng-ee
Date:   Mon,  9 Jul 2018 11:49:24 +0530
Message-Id: <20180709061925.20276-6-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180709061925.20276-1-vkoul@kernel.org>
References: <20180709061925.20276-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qcom 8996 and later chips features multiple Execution Environments
(EE) and secure world is typically responsible for configuring the
prng.

Add driver data for qcom,prng as 0 and qcom,prng-ee as 1 and use
that to skip initialization routine.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/crypto/qcom-rng.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
index 53e1d276e05e..f1bd86acaf9d 100644
--- a/drivers/crypto/qcom-rng.c
+++ b/drivers/crypto/qcom-rng.c
@@ -28,6 +28,7 @@ struct qcom_rng {
 	struct mutex lock;
 	void __iomem *base;
 	struct clk *clk;
+	unsigned int skip_init;
 };
 
 struct qcom_rng_ctx {
@@ -128,7 +129,10 @@ static int qcom_rng_init(struct crypto_tfm *tfm)
 
 	ctx->rng = qcom_rng_dev;
 
-	return qcom_rng_enable(ctx->rng);
+	if (!ctx->rng->skip_init)
+		return qcom_rng_enable(ctx->rng);
+
+	return 0;
 }
 
 static struct rng_alg qcom_rng_alg = {
@@ -168,6 +172,8 @@ static int qcom_rng_probe(struct platform_device *pdev)
 	if (IS_ERR(rng->clk))
 		return PTR_ERR(rng->clk);
 
+	rng->skip_init = (unsigned long)of_device_get_match_data(&pdev->dev);
+
 	qcom_rng_dev = rng;
 	ret = crypto_register_rng(&qcom_rng_alg);
 	if (ret) {
@@ -188,7 +194,8 @@ static int qcom_rng_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id qcom_rng_of_match[] = {
-	{ .compatible = "qcom,prng" },
+	{ .compatible = "qcom,prng", .data = (void *)0},
+	{ .compatible = "qcom,prng-ee", .data = (void *)1},
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_rng_of_match);
-- 
2.14.4

