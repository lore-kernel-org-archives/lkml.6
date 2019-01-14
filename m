Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65F3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962FF206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CZRSEX9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfANQnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:43:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38321 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfANQnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:43:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so23674562wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 08:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=8jUWUXinqrIEk2wbCrHnyISvXX2O3vcX46RGBCRFza8=;
        b=CZRSEX9xhalKjgqG4U+P2MSdMyDo7y7Xr/ytxGZM78A+F/9DrRIo/KhQWHyj5c1d9U
         i7GpifF0VdNNm1c/Ky6ueBZzsUWSqv1swnoeLzzbJJIe6CwwmAHNO2t6g0/JRxI3QeEk
         0VHkhylq59Tre+6qsnnEjgjbSOedrDEZjKMFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=8jUWUXinqrIEk2wbCrHnyISvXX2O3vcX46RGBCRFza8=;
        b=tKQZqvQv51ryzE1shXw4oJdeXqOgObrBKAMXngiAyc7bFdb8oH622dC8+E01D9JZpr
         F+UkJIWm0UfCnzVz7Ul51GCi/PPodApnX8G2t0LNW5abftGAXsdPs1aueusG1Npc4SNa
         373UWES+l19Vhd6MzpFAZzsAUcsvblBLkj0uUxMjL9mQO/hbXt5TZN/Bwcz49FFXdUUn
         N3inJDMueKOmkeqxzNCeCzbxNZqINSATE+9mv1KCUZU4gsfFN6zI5KooDIQ/C8sYIoo1
         5VOkxjzZNMn8/mbYWOczx6nx+K2quGw/HeG1H3otLgb5gjv205RAbFzCsEooBVBq3f33
         xsEg==
X-Gm-Message-State: AJcUukcebymVIDmy9hGIZaFGpar6BvVORg1scTst0mjsyU24EB4rki75
        9eXW7am3P6hHcaNhVlU4AX2Kt/RCrsTRlQ==
X-Google-Smtp-Source: ALg8bN7gnnHsFpYDNmwBC+drqi83as5YoAeuieSwHayKGL0PkzLBbetQmfvTApWSP/zr++6WgEITyw==
X-Received: by 2002:adf:80cf:: with SMTP id 73mr25037001wrl.57.1547484208974;
        Mon, 14 Jan 2019 08:43:28 -0800 (PST)
Received: from localhost ([49.248.190.171])
        by smtp.gmail.com with ESMTPSA id f10sm7842762wmb.35.2019.01.14.08.43.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 08:43:28 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v1 10/10] cpufreq: scpi: Use auto-registration of thermal cooling device
Date:   Mon, 14 Jan 2019 22:05:02 +0530
Message-Id: <ddb8e8a94da197fa4b8d4d03450bcadef49c9820.1547481320.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547481320.git.amit.kucheria@linaro.org>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547481320.git.amit.kucheria@linaro.org>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the CPUFREQ_AUTO_REGISTER_COOLING_DEV flag to allow cpufreq core to
automatically register as a thermal cooling device.

This allows removal of boiler plate code from the driver.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/cpufreq/scpi-cpufreq.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 87a98ec77773..c01c63a342c9 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -22,7 +22,6 @@
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
-#include <linux/cpu_cooling.h>
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
@@ -34,7 +33,6 @@
 struct scpi_data {
 	struct clk *clk;
 	struct device *cpu_dev;
-	struct thermal_cooling_device *cdev;
 };
 
 static struct scpi_ops *scpi_ops;
@@ -186,7 +184,6 @@ static int scpi_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct scpi_data *priv = policy->driver_data;
 
-	cpufreq_cooling_unregister(priv->cdev);
 	clk_put(priv->clk);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	kfree(priv);
@@ -195,23 +192,16 @@ static int scpi_cpufreq_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void scpi_cpufreq_ready(struct cpufreq_policy *policy)
-{
-	struct scpi_data *priv = policy->driver_data;
-
-	priv->cdev = of_cpufreq_cooling_register(policy);
-}
-
 static struct cpufreq_driver scpi_cpufreq_driver = {
 	.name	= "scpi-cpufreq",
 	.flags	= CPUFREQ_STICKY | CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
-		  CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+		  CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+		  CPUFREQ_AUTO_REGISTER_COOLING_DEV,
 	.verify	= cpufreq_generic_frequency_table_verify,
 	.attr	= cpufreq_generic_attr,
 	.get	= scpi_cpufreq_get_rate,
 	.init	= scpi_cpufreq_init,
 	.exit	= scpi_cpufreq_exit,
-	.ready	= scpi_cpufreq_ready,
 	.target_index	= scpi_cpufreq_set_target,
 };
 
-- 
2.17.1

