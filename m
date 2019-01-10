Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E5FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858902173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZkBPYmqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfAJABi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 19:01:38 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46738 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfAJABh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 19:01:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so9408380wrt.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=90uAdP76GbEFesAg3EEdgboTHiHbKzIpz1LIUUCK07I=;
        b=ZkBPYmqjsKFIzsQXjpWY1Wnu7EovFBLBDDfslZ++FU7hV5yg7rmMfLvgqlg1Z+xByy
         2txi6kKKAwy59nB7kwgIfqvZpUlWM8+FbQB4QTFb9BuCo04EdmGEJ7qdYlNgzYd+U8Fh
         oV0xgi6jLnwahRIltAtaAQTCIqzz5toPUgzp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=90uAdP76GbEFesAg3EEdgboTHiHbKzIpz1LIUUCK07I=;
        b=JBZCvvQph9UT59NOvcglpfMQVjochi0nU2gQ0VGWy/9IHTJTcsLVUFeqYqvmJba+DQ
         VWQlamXwnKo28XK1GSp0+PFpthWsqijrHAWz7o+U1y5holZt5SaomuIT743MWGOkh+zz
         dQRIv+VKshvIUoZSFzPCtSUe9TfX5Mkd7SalyLpbRq3kMF3hr7h6K+qphxPU2pbFn7qj
         KQVmfU2tYeX+B7VfsPFpQlA80l7Zn9tjky6I9IoAGQWf60+9HIcYjTLb0esvS0VCFKtM
         vmlDzb+AVCcCoB2nGzAfxtCtRNIFF3pEFwmL5JNKTnsJew73uwwMdPalAle/dHspID7e
         1P8Q==
X-Gm-Message-State: AJcUukdIU2Q6w/L5Nwa/JTSRfnRTVytDghxQCOV5/XDJ5P0rsRFXflVs
        7HXQcgQWpNnQQ/NFzZncLb7XRgwtDSA=
X-Google-Smtp-Source: ALg8bN76mugbeaKFTbT27CH3H2EhGoAIgSpA1FnV3VhZ/tjjiPfOmGjwaXzc6O4gg8MdBcTU02sHmw==
X-Received: by 2002:a5d:454f:: with SMTP id p15mr7289952wrr.39.1547078494622;
        Wed, 09 Jan 2019 16:01:34 -0800 (PST)
Received: from localhost ([49.248.171.190])
        by smtp.gmail.com with ESMTPSA id s3sm12839428wmj.23.2019.01.09.16.01.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 16:01:34 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org,
        dianders@chromium.org, mka@chromium.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY DRIVERS)
Subject: [PATCH v1 5/7] cpufreq: qcom-hw: Register as a cpufreq cooling device
Date:   Thu, 10 Jan 2019 05:30:54 +0530
Message-Id: <3c7d0e4a8373e89d6922543ccf56749970de5567.1547078153.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547078153.git.amit.kucheria@linaro.org>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547078153.git.amit.kucheria@linaro.org>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 649dddd72749..1c01311e5927 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -5,6 +5,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/cpufreq.h>
+#include <linux/cpu_cooling.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -216,7 +217,10 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
 {
 	void __iomem *base = policy->driver_data - REG_PERF_STATE;
+	struct thermal_cooling_device *cdev = policy->cooldev;
 
+	if (cdev)
+		cpufreq_cooling_unregister(cdev);
 	kfree(policy->freq_table);
 	devm_iounmap(&global_pdev->dev, base);
 
@@ -238,6 +242,7 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
 	.init		= qcom_cpufreq_hw_cpu_init,
 	.exit		= qcom_cpufreq_hw_cpu_exit,
 	.fast_switch    = qcom_cpufreq_hw_fast_switch,
+	.ready		= generic_cpufreq_ready,
 	.name		= "qcom-cpufreq-hw",
 	.attr		= qcom_cpufreq_hw_attr,
 };
-- 
2.17.1

