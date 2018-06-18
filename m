Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21646C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0B620852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FHA8Gtn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0B620852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934731AbeFRON0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:13:26 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38421 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934599AbeFRONW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:13:22 -0400
Received: by mail-pf0-f196.google.com with SMTP id b74-v6so8242424pfl.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 07:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2jjJjgKXmdsO7Czd4wGiZl0sVCxbgmZGgWTvl3dKYiw=;
        b=FHA8Gtn8Gjl42AtmPbdjiqGRd2lRkLXqI9kDdM0kL+BiY8ATGKsHRNAOP93thuYH/R
         h169QlXOmSSLFw33AZxU4K3G2jp5aO3lD1E3v0LqZZPzGISKRnipAQiDHo5phjvkwfyA
         Sebr6+upjbE13j+tU0AityMC34kuBTCSQcZxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2jjJjgKXmdsO7Czd4wGiZl0sVCxbgmZGgWTvl3dKYiw=;
        b=ZDa5FrhwG1VYbYCqdTBdPS8Qor3omLM6HDvxrovZbDu3pRKVYr/+a1eWwFGhLujnFz
         4aMhhTJCleQaKnTrqO0w9wvdlQIgEr013yChpSnd5cKgBWkciFpDq7Kj0VZoPIT4MS5G
         bO5YK3zIY5ifkl7HjBEJf8kPHt9mapXD2b07cHj65gHBqDm8mNot1WZE4MX4UPdcAW7Y
         bIWTnhQlKG3egnXRjsESjPEeNGrfwFm/yUq1iRE1sCDoCJ2GEZ+rrLXzVn2i5h8Euxop
         FKOI32b7VWAToRPh7FZfpKWVPyVzBnUE0SJvWgXRBFHRmt3eVbUaPUGt6ui4shGvNXbX
         FfHw==
X-Gm-Message-State: APt69E1MKo5xtA+8KpYmxH+IINDg/0m32YHVnUZAJh58Y915Vavak46D
        2lfok38u3Az3p3fzjO6jO6OmcV1C/mw=
X-Google-Smtp-Source: ADUXVKJbg9mjFSFTI6MktxtnjwmQ5C51H8nnqyKXCvVR+av5eHRaPjWxY7VBv/pstizHOrMdGqXlZA==
X-Received: by 2002:a65:611a:: with SMTP id z26-v6mr11090251pgu.61.1529331202015;
        Mon, 18 Jun 2018 07:13:22 -0700 (PDT)
Received: from localhost.localdomain ([27.59.118.133])
        by smtp.gmail.com with ESMTPSA id t17-v6sm25813339pfj.75.2018.06.18.07.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 07:13:21 -0700 (PDT)
From:   Vinod Koul <vinod.koul@linaro.org>
X-Google-Original-From: Vinod Koul <vkoul@kernel.org>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 1/3] hwrng: msm - Move hwrng to a table
Date:   Mon, 18 Jun 2018 19:42:57 +0530
Message-Id: <20180618141259.23141-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180618141259.23141-1-vkoul@kernel.org>
References: <20180618141259.23141-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Future versions of msm-prng require bit differs callbacks so move
driver to use a table for hwrng.

No functional change.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/char/hw_random/msm-rng.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/char/hw_random/msm-rng.c b/drivers/char/hw_random/msm-rng.c
index 841fee845ec9..7644474035e5 100644
--- a/drivers/char/hw_random/msm-rng.c
+++ b/drivers/char/hw_random/msm-rng.c
@@ -38,14 +38,12 @@
 struct msm_rng {
 	void __iomem *base;
 	struct clk *clk;
-	struct hwrng hwrng;
+	struct hwrng *hwrng;
 };
 
-#define to_msm_rng(p)	container_of(p, struct msm_rng, hwrng)
-
 static int msm_rng_enable(struct hwrng *hwrng, int enable)
 {
-	struct msm_rng *rng = to_msm_rng(hwrng);
+	struct msm_rng *rng = (struct msm_rng *)hwrng->priv;
 	u32 val;
 	int ret;
 
@@ -80,7 +78,7 @@ static int msm_rng_enable(struct hwrng *hwrng, int enable)
 
 static int msm_rng_read(struct hwrng *hwrng, void *data, size_t max, bool wait)
 {
-	struct msm_rng *rng = to_msm_rng(hwrng);
+	struct msm_rng *rng = (struct msm_rng *)hwrng->priv;
 	size_t currsize = 0;
 	u32 *retdata = data;
 	size_t maxsize;
@@ -127,6 +125,13 @@ static void msm_rng_cleanup(struct hwrng *hwrng)
 	msm_rng_enable(hwrng, 0);
 }
 
+static struct hwrng msm_rng = {
+	.name = KBUILD_MODNAME,
+	.init = msm_rng_init,
+	.cleanup = msm_rng_cleanup,
+	.read = msm_rng_read,
+};
+
 static int msm_rng_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -148,12 +153,10 @@ static int msm_rng_probe(struct platform_device *pdev)
 	if (IS_ERR(rng->clk))
 		return PTR_ERR(rng->clk);
 
-	rng->hwrng.name = KBUILD_MODNAME,
-	rng->hwrng.init = msm_rng_init,
-	rng->hwrng.cleanup = msm_rng_cleanup,
-	rng->hwrng.read = msm_rng_read,
+	rng->hwrng = &msm_rng;
 
-	ret = devm_hwrng_register(&pdev->dev, &rng->hwrng);
+	rng->hwrng->priv = (unsigned long)rng;
+	ret = devm_hwrng_register(&pdev->dev, rng->hwrng);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register hwrng\n");
 		return ret;
-- 
2.14.4

