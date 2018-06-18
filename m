Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFD9C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F6220852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KFYwkS0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F6220852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934888AbeFRONf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:13:35 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39456 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934733AbeFRONb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:13:31 -0400
Received: by mail-pf0-f195.google.com with SMTP id r11-v6so8242266pfl.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 07:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UUJzwfgpvKs1LpNf7zUfObyZZsWD9zUmBur3t7sFcAo=;
        b=KFYwkS0FV/wf8gCkPEVCMxGpBZ0srhTzLP4tAb4AqBl05Yw1otuuJK7WmbAQZKdTul
         gu47WCGk7DrNEyYKFrecjRhyohbJhA3yaG1a54MXC3H2lCvOh6lgwsrwZdodRMK7XDWO
         7EZwbPQZQs7w/hWsaEkEDZjmUIZWXYaf+8gqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UUJzwfgpvKs1LpNf7zUfObyZZsWD9zUmBur3t7sFcAo=;
        b=Psg5vsguO3ov3m1poaKDb8XGIq9Dg9uXNpmFQfGc+vmEo1tGzzqmeD52oHYgdPWT5H
         uQXGLDCOuioXnAPHCu5e6TPvRWD87HEv8vUZc2oXHAY33IUxGxsV9j4BdoRaI1xp+zNC
         aGFHYZHe3GCNJ7JQoSMMRVRCcmHZEOksROUZRu1ENILhSNAbD1nGXfgK/lOv0ltbXy6p
         a8BEGadNFvfnwOCNkgLXrlaEznYXCNBozw5yC2DvPab69Cl9/VYDNApbLqfuyA6irjG2
         l1KJSVIPwvV1wXjmAYcAvWny3kScJHfOSXZ03p41W1Oy3XdGjKBmdprg1YsTi9daVp1u
         gXiw==
X-Gm-Message-State: APt69E341Ect88P2iIRhMqRX7nLdIaM0Xi0Mr2LU3bI6Vmz81HiTMUoA
        OY8SsJLvwSeop1GcfgHHaLSzqQ==
X-Google-Smtp-Source: ADUXVKLma+ohpFmtuM805xz1PF6/l70VFA4Kbu4hKlssjmC/SegENUTf4IkzJvbU2eDYwX6vfMi1eQ==
X-Received: by 2002:a62:d09:: with SMTP id v9-v6mr13565715pfi.163.1529331211173;
        Mon, 18 Jun 2018 07:13:31 -0700 (PDT)
Received: from localhost.localdomain ([27.59.118.133])
        by smtp.gmail.com with ESMTPSA id t17-v6sm25813339pfj.75.2018.06.18.07.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 07:13:30 -0700 (PDT)
From:   Vinod Koul <vinod.koul@linaro.org>
X-Google-Original-From: Vinod Koul <vkoul@kernel.org>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 3/3] hwrng: msm - Add support for prng v2
Date:   Mon, 18 Jun 2018 19:42:59 +0530
Message-Id: <20180618141259.23141-4-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180618141259.23141-1-vkoul@kernel.org>
References: <20180618141259.23141-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qcom 8996 and later chips support prng v2 where we need to only
implement .read callback for hwrng.

Add a new table for v2 which supports this and get version required for
driver data.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/char/hw_random/msm-rng.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/msm-rng.c b/drivers/char/hw_random/msm-rng.c
index 7644474035e5..3f509072a6c6 100644
--- a/drivers/char/hw_random/msm-rng.c
+++ b/drivers/char/hw_random/msm-rng.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 
 /* Device specific register offsets */
@@ -132,10 +133,16 @@ static struct hwrng msm_rng = {
 	.read = msm_rng_read,
 };
 
+static struct hwrng msm_rng_v2 = {
+	.name = KBUILD_MODNAME,
+	.read = msm_rng_read,
+};
+
 static int msm_rng_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct msm_rng *rng;
+	unsigned int version;
 	int ret;
 
 	rng = devm_kzalloc(&pdev->dev, sizeof(*rng), GFP_KERNEL);
@@ -154,6 +161,9 @@ static int msm_rng_probe(struct platform_device *pdev)
 		return PTR_ERR(rng->clk);
 
 	rng->hwrng = &msm_rng;
+	version = (unsigned long)of_device_get_match_data(&pdev->dev);
+	if (version)
+		rng->hwrng = &msm_rng_v2;
 
 	rng->hwrng->priv = (unsigned long)rng;
 	ret = devm_hwrng_register(&pdev->dev, rng->hwrng);
@@ -166,7 +176,8 @@ static int msm_rng_probe(struct platform_device *pdev)
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

