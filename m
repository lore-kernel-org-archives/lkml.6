Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1801FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19FB214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4HVrEsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfA2E6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 23:58:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36031 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfA2E6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 23:58:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id u4so20523216wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 20:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=q8zOwinb++dSY+a36ZLUxsOKoJRTDJm8Q+law10TDMs=;
        b=Z4HVrEsAJLZwLCWLjwhKeac6DiTO3NK15Ix6mCv8oaCWUMqLMOPX2ZXQSk/3MDXU/u
         d8EWT5UF9OUqAhBjgE6W91S+07pVgTlOWUd+OWeTF70aEEw1vdPTSVlLj/xdV1KOGPCm
         T+irIqzFGTBp4Rrz4A/n7Ko2BZDE0cvfWCLQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=q8zOwinb++dSY+a36ZLUxsOKoJRTDJm8Q+law10TDMs=;
        b=RjDHsPqPP1Z7kI2EuhNbpfc8ffIXrk/zC2JRx6QD0Uxlv4okSGFZf5NGjvjczn9XOv
         qaQ1gSu1UPahJbeTMv0UWu0+t2joXmk6k258JTdjiinYKaXxAKsvslCwJBerV/N69hN5
         gh5FoC1gjcvq1x6udNtmJdUXamgwUbrvNs+odKom6jOIxjaY3AUTLSjAyt4YyLNSbxLp
         eYYedyxuMPqyczB5iSawzJvoyK6xBdvXxRhEIX7WyzFcKn2IJmgP/MDSg9v6OdmSijYX
         T3kvKdw7dIr5QyZrQRRx86SEjC/37Lo9RArvpbVGroCZyMamH/xCxbCO8gHdTPpcdfpF
         Ngag==
X-Gm-Message-State: AJcUukeIo+4iljI+21NhkiC64PMlRznX1KWJ4EpXbl5TKCAkCAq1al2p
        tvVGMf9d70uu13ArrBEN9J85yLGjuD8=
X-Google-Smtp-Source: ALg8bN5+sCJyDD3U5tSJwjFysiND9QVXhp504ClglfbKlhPREFJkXVAAOR5EubBKMwk3msYX8rMBzg==
X-Received: by 2002:a5d:50c5:: with SMTP id f5mr23276547wrt.37.1548737882650;
        Mon, 28 Jan 2019 20:58:02 -0800 (PST)
Received: from localhost ([49.248.171.30])
        by smtp.gmail.com with ESMTPSA id n6sm1320957wmk.9.2019.01.28.20.58.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 20:58:02 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 5/9] cpufreq: cpufreq-dt: Use auto-registration of thermal cooling device
Date:   Tue, 29 Jan 2019 10:25:11 +0530
Message-Id: <4e19a2d9c5d929cdd87a984953c880c1e5a2e057.1548737236.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548737236.git.amit.kucheria@linaro.org>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548737236.git.amit.kucheria@linaro.org>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the CPUFREQ_IS_COOLING_DEV flag to allow cpufreq core to
automatically register as a thermal cooling device.

This allows removal of boiler plate code from the driver.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index e58bfcb1169e..7ba392911cd0 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -13,7 +13,6 @@
 
 #include <linux/clk.h>
 #include <linux/cpu.h>
-#include <linux/cpu_cooling.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/err.h>
@@ -30,7 +29,6 @@
 struct private_data {
 	struct opp_table *opp_table;
 	struct device *cpu_dev;
-	struct thermal_cooling_device *cdev;
 	const char *reg_name;
 	bool have_static_opps;
 };
@@ -301,7 +299,6 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct private_data *priv = policy->driver_data;
 
-	cpufreq_cooling_unregister(priv->cdev);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	if (priv->have_static_opps)
 		dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
@@ -314,21 +311,14 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void cpufreq_ready(struct cpufreq_policy *policy)
-{
-	struct private_data *priv = policy->driver_data;
-
-	priv->cdev = of_cpufreq_cooling_register(policy);
-}
-
 static struct cpufreq_driver dt_cpufreq_driver = {
-	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+		 CPUFREQ_IS_COOLING_DEV,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = set_target,
 	.get = cpufreq_generic_get,
 	.init = cpufreq_init,
 	.exit = cpufreq_exit,
-	.ready = cpufreq_ready,
 	.name = "cpufreq-dt",
 	.attr = cpufreq_dt_attr,
 	.suspend = cpufreq_generic_suspend,
-- 
2.17.1

