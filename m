Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81A0C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D78E2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HRp+Z6fb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D78E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937562AbeFSJzc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:55:32 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46665 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756933AbeFSJzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:55:13 -0400
Received: by mail-pl0-f66.google.com with SMTP id 30-v6so10658797pld.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 02:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SvxzFx5lR7oWAmcesNlMhyn68C9L3dvoVz2STn24eco=;
        b=HRp+Z6fbFzlbVCOGd+pJiG/RzypXJripitLnflqgBQ+nsq/FV4Jt4Bi/VahX/Ra2fk
         fAzI5SWlHg/8Adsb2y1Kl/Jv0d6gQOWsfJr5x8D0HmyiJcFbD10ZnqKXaNu5PBG2sE0P
         /AdeUZQnXTFRLwEhbgVmg+n4/HDdpeQOsCTW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SvxzFx5lR7oWAmcesNlMhyn68C9L3dvoVz2STn24eco=;
        b=M6lYTMdQU7GyLsx7SdXXS1Wq4Hmm99szokg2wFwCqkNTgF4sp6LWByfIM/KkRkI0AW
         DwYJq+e/OopFDd1glwSns3Hd71EtZ1TfoN9hCMj57Yy/fLz4Eq5pxV2PqsXayWC8CbhF
         vQlbPWnjbpX38MPQ3BHqoJxU9GMKLmncWHElBS8WZ6QUtjRwq3dNSyifMbwSgheKXwDV
         jh68vrx3oFTu5QcU3H2c7HSfHWUQITuAj/TUVPJtgj1rUzTqNZDSSbu6Ra51b/9X0SLE
         4Ru6vFM66Pq1JwHWXlQeO2EscKbSW8VzvbXi2iF7AdlYSVxi2oM19B/yQFtrV7EMt217
         zzAw==
X-Gm-Message-State: APt69E2tpX9efpITcqBQIoDCbKb0ScFgcpoNoCDh69xILUVYQisuq38G
        18Wh7zKF7iqNq8CpKIX5holm/sGojjQ=
X-Google-Smtp-Source: ADUXVKL7sjTtNyL/fkpNjFnEyMUHP864CET0wjgcADWZWw8jvb8Htr+l2y8Cy7fb3YSFjax6nTO4pA==
X-Received: by 2002:a17:902:8b8c:: with SMTP id ay12-v6mr18062984plb.74.1529402113129;
        Tue, 19 Jun 2018 02:55:13 -0700 (PDT)
Received: from localhost.localdomain ([106.200.222.147])
        by smtp.gmail.com with ESMTPSA id c17-v6sm21182034pgw.11.2018.06.19.02.55.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 02:55:12 -0700 (PDT)
From:   Vinod Koul <vinod.koul@linaro.org>
X-Google-Original-From: Vinod Koul <vkoul@kernel.org>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        vinod.koul@linaro.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 2/2] hwrng: msm - Add support for prng v2
Date:   Tue, 19 Jun 2018 15:24:30 +0530
Message-Id: <20180619095430.26358-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180619095430.26358-1-vkoul@kernel.org>
References: <20180619095430.26358-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qcom 8996 and later chips support prng v2 which requires to
implement only .read callback for hwrng.

This version of chip has multiple Execution Environments (EE) and
secure world is typically responsible for configuring the prng.

Add driver data for qcom,prng as 0 and qcom,prng-v2 as 1 and use
that to skip initialization and cleanup routines.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/char/hw_random/msm-rng.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/char/hw_random/msm-rng.c b/drivers/char/hw_random/msm-rng.c
index 841fee845ec9..4676520e1f16 100644
--- a/drivers/char/hw_random/msm-rng.c
+++ b/drivers/char/hw_random/msm-rng.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 
 /* Device specific register offsets */
@@ -131,6 +132,7 @@ static int msm_rng_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct msm_rng *rng;
+	unsigned int skip_init;
 	int ret;
 
 	rng = devm_kzalloc(&pdev->dev, sizeof(*rng), GFP_KERNEL);
@@ -149,9 +151,12 @@ static int msm_rng_probe(struct platform_device *pdev)
 		return PTR_ERR(rng->clk);
 
 	rng->hwrng.name = KBUILD_MODNAME,
-	rng->hwrng.init = msm_rng_init,
-	rng->hwrng.cleanup = msm_rng_cleanup,
-	rng->hwrng.read = msm_rng_read,
+	rng->hwrng.read = msm_rng_read;
+	skip_init = (unsigned long)of_device_get_match_data(&pdev->dev);
+	if (!skip_init) {
+		rng->hwrng.init = msm_rng_init;
+		rng->hwrng.cleanup = msm_rng_cleanup;
+	}
 
 	ret = devm_hwrng_register(&pdev->dev, &rng->hwrng);
 	if (ret) {
@@ -163,7 +168,8 @@ static int msm_rng_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id msm_rng_of_match[] = {
-	{ .compatible = "qcom,prng", },
+	{ .compatible = "qcom,prng", .data = (void *)0},
+	{ .compatible = "qcom,prng-v2", .data = (void *)1},
 	{}
 };
 MODULE_DEVICE_TABLE(of, msm_rng_of_match);
-- 
2.14.4

