Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05724ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FB12086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ffEcIkRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FB12086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390218AbeIUT3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:29:42 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39563 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390137AbeIUT3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:29:41 -0400
Received: by mail-it1-f195.google.com with SMTP id h1-v6so1929818itj.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ttqe+UCwyMe7WVvDlGEx6hIjqgfZCL2tUPGredWpOM4=;
        b=ffEcIkRcUe9fys/MpcTBH8yQPBg4Izfl+n8OSAAqxW5vHX/Bu/0FtnyKqjib7rq5jg
         WnqW2hv5VfppEtoxEs9ofQxvqLra8BN4JvDQhfnq/0fQ1GTzQ5FOWCoMexuJFwOSx2nH
         rBMC2pDFoKjSyYMNhctQKjgw3pTwsd+zIBz+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ttqe+UCwyMe7WVvDlGEx6hIjqgfZCL2tUPGredWpOM4=;
        b=pUCnemx3XvBqhXro55MYYHRC8X5h3pdFMNwofLYwMm1FQKJKEchCHrY/Bp+3k02vgK
         jIp4Wy2YEo8dIXrOKWldnJfeVkihsyKjazNXzhu3Fe746aKDSX3RUboXO4mJRArYSt5h
         wUpy7hZ0ZKDT2npWlyxx8zwVtC/m8eocxiiv/hziruWttkuvgNGcPw12Axv/iNJsqH6N
         wxOcouaLplyy7LBEq6FH+z6B8shSoEFs683ZXa6Qrygt7+qWcQws/DQtX3ViuRO8dMr9
         278RzCMAnguyrOdqkZmDCVOM5BC1/88JyKjNtBmQWXGFnorWjYE2Lu8UnTlph2HNknN0
         6dqg==
X-Gm-Message-State: APzg51Bf5aPQ3f3vNfAsP2YPgaqiMAd0rzW5lIPJzuxiyxQxtJv7DR13
        z8wOfJNvZg1ry1Xou3Il2BtwyxV7TMw=
X-Google-Smtp-Source: ANB0VdaRIAPzcfFeH8iYnSqMADFJnaz3WfLjtwgrA2SWec6gr6IDX2YeN4kpQv0b2gQnXo7/F/HQKw==
X-Received: by 2002:a24:fac7:: with SMTP id v190-v6mr5928222ith.78.1537537245971;
        Fri, 21 Sep 2018 06:40:45 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id c12-v6sm9896298ioq.81.2018.09.21.06.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:40:45 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 10/26] nvmem: sunxi_sid: use devm_nvmem_register()
Date:   Fri, 21 Sep 2018 06:40:10 -0700
Message-Id: <20180921134026.4596-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
References: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the resource managed variant of nvmem_register().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sunxi_sid.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 4d0b7e72aa2e..1310f8af37f8 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -181,15 +181,13 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 	else
 		econfig.reg_read = sunxi_sid_read;
 	econfig.priv = sid;
-	nvmem = nvmem_register(&econfig);
+	nvmem = devm_nvmem_register(dev, &econfig);
 	if (IS_ERR(nvmem))
 		return PTR_ERR(nvmem);
 
 	randomness = kzalloc(size, GFP_KERNEL);
-	if (!randomness) {
-		ret = -ENOMEM;
-		goto err_unreg_nvmem;
-	}
+	if (!randomness)
+		return -ENOMEM;
 
 	for (i = 0; i < size; i++)
 		econfig.reg_read(sid, i, &randomness[i], 1);
@@ -200,17 +198,6 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, nvmem);
 
 	return 0;
-
-err_unreg_nvmem:
-	nvmem_unregister(nvmem);
-	return ret;
-}
-
-static int sunxi_sid_remove(struct platform_device *pdev)
-{
-	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(nvmem);
 }
 
 static const struct sunxi_sid_cfg sun4i_a10_cfg = {
@@ -243,7 +230,6 @@ MODULE_DEVICE_TABLE(of, sunxi_sid_of_match);
 
 static struct platform_driver sunxi_sid_driver = {
 	.probe = sunxi_sid_probe,
-	.remove = sunxi_sid_remove,
 	.driver = {
 		.name = "eeprom-sunxi-sid",
 		.of_match_table = sunxi_sid_of_match,
-- 
2.19.0

