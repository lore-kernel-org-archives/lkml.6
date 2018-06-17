Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9B9C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 20:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A21D20874
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 20:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0Rr8kuZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A21D20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934190AbeFQUCI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 16:02:08 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39232 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933406AbeFQUCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 16:02:06 -0400
Received: by mail-wr0-f193.google.com with SMTP id w7-v6so14637882wrn.6;
        Sun, 17 Jun 2018 13:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d4zT/6YexChyiDRVTQtrztEwPasvSPv6qHjHtaZWTXY=;
        b=V0Rr8kuZs7pYgFcClIvLX52AEU6jJmgbLRDI0DHLp4J1HznEqpb7nLuXa/l5gHzPGb
         2kq8PYjplI0nNHxIJOEm5+xx2FmJNGmdXLMmhUAQZRvyrnMFyeH06vqPdN6+V/Enqv/b
         9ZLcu+m04vONY1DEnx21K0Jv/AUvXVrLS13+ynjmi9WSr9/51YH9OqbNuw2mzUJK6Pho
         /goGes1/MRWrwklFTTfv1e1xMypOLjAetiWjdiuesLp6yVBTClRTLLTY+DnT1ZXcC/Gp
         GVNp3ndeTQMXNOkZ6qAXda7tZBL2XCiaXTEbJqwD/bE2SRjafdJ6FKD+Nst6hGXW3qpw
         QtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d4zT/6YexChyiDRVTQtrztEwPasvSPv6qHjHtaZWTXY=;
        b=IlnFpVv5zEvLg6ax/AlR/IIDzX+GU1/+7hmFgixDSu9mKO+DEEsaWQMYAT8EyrH8Yu
         QWM0geOzq0ObPTjzx+XI33mkKWWTax1IIdAvlCk0+add3gTr49TcW/C/Q9bvYbe8CHqG
         dQnKR3XMz18J6Degax/uU1G5Q4Qqnrr+NZ9a1vEOwgiycqmOrZ/nOGnFhRrKf6bvjLDw
         UHTs04ZTFLVAGnJWCqgJ/rDuI/t5J5+Mztosjx5voAYeuUATnA2iMMfENxFTDzGwGdwh
         UHSffwtxB5BVLmOxWWmYMNHXdkzS1UDHi0tFAgAl8bJgoAMJ2gq8h4KTKrSxjLpzzu4l
         NWkw==
X-Gm-Message-State: APt69E1KT+l2hJp038A/cH3B0o5ma3kysubC3V1i0zqXS+/6KeJcBwXG
        n9nJSBt0ApJVnONA1AkerZE=
X-Google-Smtp-Source: ADUXVKI8HVa+LRahxd9RVVnvvqcY9eR5HHTcjjRXcjo8AI1rp7gO6gMaVEtnZIJem5SK6gszf03AXw==
X-Received: by 2002:adf:e392:: with SMTP id e18-v6mr8385966wrm.94.1529265725042;
        Sun, 17 Jun 2018 13:02:05 -0700 (PDT)
Received: from gcc67.tetaneutral.net (gcc67.tetaneutral.net. [2a03:7220:8080:c00::1])
        by smtp.gmail.com with ESMTPSA id j131-v6sm6917375wmb.35.2018.06.17.13.02.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 13:02:04 -0700 (PDT)
From:   ilia.lin@gmail.com
To:     ilia.lin@gmail.com
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] cpufreq: kryo: Add module remove and exit
Date:   Sun, 17 Jun 2018 22:01:46 +0200
Message-Id: <20180617200146.16425-1-ilia.lin@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180614204212.2028-1-ilia.lin@gmail.com>
References: <20180614204212.2028-1-ilia.lin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilia Lin <ilia.lin@gmail.com>

Add device remove and module exit code to make the driver
functioning as a loadable module.

Fixes: ac28927659be (cpufreq: kryo: allow building as a loadable module)
Signed-off-by: Ilia Lin <ilia.lin@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-kryo.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
index 74b9b93d511b..01bddacf5c3b 100644
--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -42,6 +42,8 @@ enum _msm8996_version {
 	NUM_OF_MSM8996_VERSIONS,
 };
 
+struct platform_device *cpufreq_dt_pdev, *kryo_cpufreq_pdev;
+
 static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
 {
 	size_t len;
@@ -74,7 +76,6 @@ static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
 static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 {
 	struct opp_table *opp_tables[NR_CPUS] = {0};
-	struct platform_device *cpufreq_dt_pdev;
 	enum _msm8996_version msm8996_version;
 	struct nvmem_cell *speedbin_nvmem;
 	struct device_node *np;
@@ -165,8 +166,15 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int qcom_cpufreq_kryo_remove(struct platform_device *pdev)
+{
+	platform_device_unregister(cpufreq_dt_pdev);
+	return 0;
+}
+
 static struct platform_driver qcom_cpufreq_kryo_driver = {
 	.probe = qcom_cpufreq_kryo_probe,
+	.remove = qcom_cpufreq_kryo_remove,
 	.driver = {
 		.name = "qcom-cpufreq-kryo",
 	},
@@ -201,8 +209,9 @@ static int __init qcom_cpufreq_kryo_init(void)
 	if (unlikely(ret < 0))
 		return ret;
 
-	ret = PTR_ERR_OR_ZERO(platform_device_register_simple(
-		"qcom-cpufreq-kryo", -1, NULL, 0));
+	kryo_cpufreq_pdev = platform_device_register_simple(
+		"qcom-cpufreq-kryo", -1, NULL, 0);
+	ret = PTR_ERR_OR_ZERO(kryo_cpufreq_pdev);
 	if (0 == ret)
 		return 0;
 
@@ -211,5 +220,12 @@ static int __init qcom_cpufreq_kryo_init(void)
 }
 module_init(qcom_cpufreq_kryo_init);
 
+static void __init qcom_cpufreq_kryo_exit(void)
+{
+	platform_device_unregister(kryo_cpufreq_pdev);
+	platform_driver_unregister(&qcom_cpufreq_kryo_driver);
+}
+module_exit(qcom_cpufreq_kryo_exit);
+
 MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Kryo CPUfreq driver");
 MODULE_LICENSE("GPL v2");
-- 
2.11.0

