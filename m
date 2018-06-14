Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9C3E8C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49514208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcTsC5n0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49514208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964904AbeFNUmz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 16:42:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51102 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935772AbeFNUmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 16:42:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id e16-v6so174892wmd.0;
        Thu, 14 Jun 2018 13:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lp60lfv7zvFBthiLSDhr6PcUy+ivnFNw+ysRH4VgsI4=;
        b=PcTsC5n0JMqLt0nGhu8NQ8AoC0JkfqIuayBr3wVFQZiv+BXxOa0Vjnnj4D/qtK/rbr
         XHvfmnz1DmtV9RoeA6tvE8oARK606Wi4vwR/5sdiFyF9YQeMVjf3YTgtleH21AZu8jWC
         LJ243Td8Z647W7amb+YsoKH30EjPF2Yq0TWzu8zmGROFkSf3d3oMDqtXyTeu40Jkekwi
         USJw43qx3rN5Q1Jpu9Sfixqaaida+9alYJnwSbaSFIo/GQmhpOucC9KhdPwMvkDKNN8j
         u1ZIXwgDSCXljfdkwM3nN/1/xPEgLwvoQzDRW2gE+puqXXhuQ4L60mEAoqTQ1O9gBdqF
         hQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lp60lfv7zvFBthiLSDhr6PcUy+ivnFNw+ysRH4VgsI4=;
        b=D8Yh7RkfqtVgq8y0zxF8KeZNYVwm6okyrmjqraTu0KSyuHBtiGLcsHlIG459QTvMbL
         FhjeAg/ggdc7+7pXvHfccNP5xRjA/R9oHbNDCMJwX0aZmFdp58U4Xeez8H4O6cBOFE+D
         O30guG0O1zGQvb/bt3k5cYdegm0h/lueTNlItC1r0CJdLxaHmIGabrIfiPc35vD+skOb
         6ArFlli2WyOcN1x+js4iOCrGEZzadH0Q6doW353Ta1CqC5s8JemOYtAWy/pGoRo3bhdC
         QfJ1JzRaJ+qTxN/aHqGc6/vaaWOwjM0cfuUqcXxsTT5f1dsV0emJlG7txgbg0xjHxpBA
         hYDQ==
X-Gm-Message-State: APt69E2ONcXImTrk+WPNYodakH5B4NoOQ6g4m1o6RQFixNFPCbijIodf
        McuZco+8nfPo9OZHVJEknIg=
X-Google-Smtp-Source: ADUXVKKvA/O0CbjFU57Zc8TA6fDv+IRYH5mrp89WPoVFGXg4ETN0+dzaDf4VN4DW93CtS+8ycf147w==
X-Received: by 2002:a1c:eccb:: with SMTP id h72-v6mr2873246wmi.157.1529008970362;
        Thu, 14 Jun 2018 13:42:50 -0700 (PDT)
Received: from gcc67.tetaneutral.net (gcc67.tetaneutral.net. [2a03:7220:8080:c00::1])
        by smtp.gmail.com with ESMTPSA id p10-v6sm43472wmc.17.2018.06.14.13.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 13:42:49 -0700 (PDT)
From:   ilia.lin@gmail.com
To:     Ilia Lin <ilia.lin@gmail.com>, Ilia Lin <ilialin@codeaurora.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] cpufreq: kryo: Add module remove and exit
Date:   Thu, 14 Jun 2018 22:42:12 +0200
Message-Id: <20180614204212.2028-1-ilia.lin@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180607205827.1588-1-ilia.lin@gmail.com>
References: <20180607205827.1588-1-ilia.lin@gmail.com>
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
 drivers/cpufreq/qcom-cpufreq-kryo.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
index 5e9511223ce9..01bddacf5c3b 100644
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
@@ -129,6 +130,7 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 		BUG();
 		break;
 	}
+	kfree(speedbin);
 
 	for_each_possible_cpu(cpu) {
 		cpu_dev = get_cpu_device(cpu);
@@ -164,8 +166,15 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
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
@@ -200,8 +209,9 @@ static int __init qcom_cpufreq_kryo_init(void)
 	if (unlikely(ret < 0))
 		return ret;
 
-	ret = PTR_ERR_OR_ZERO(platform_device_register_simple(
-		"qcom-cpufreq-kryo", -1, NULL, 0));
+	kryo_cpufreq_pdev = platform_device_register_simple(
+		"qcom-cpufreq-kryo", -1, NULL, 0);
+	ret = PTR_ERR_OR_ZERO(kryo_cpufreq_pdev);
 	if (0 == ret)
 		return 0;
 
@@ -210,5 +220,12 @@ static int __init qcom_cpufreq_kryo_init(void)
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

