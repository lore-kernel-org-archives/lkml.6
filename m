Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9603CC46462
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E3120870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZQ/cGMdE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SAKDAh/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E3120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeJKEqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:46:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38780 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeJKEqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:46:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E71B360C60; Wed, 10 Oct 2018 21:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539206523;
        bh=+L/PdC0ly2ZAOfrfv1klqE9wrry6LuuB2CO0TvaBRSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQ/cGMdEFZOcJa49OQrfc2HSyUf16+KzQOnihvGfRQXz1pdNZb3SFXAjGVMfyjTN3
         OMtHRWfSJvoIcd6zuijJRwMKU9q5UPb/LuBGvNqQgKiu435OohoFooN+TiQgwijFNl
         FGBypHbKQp9SL3x/UKMvELJN/Bc3GOkPlptgzeZI=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6962160CE9;
        Wed, 10 Oct 2018 21:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539206520;
        bh=+L/PdC0ly2ZAOfrfv1klqE9wrry6LuuB2CO0TvaBRSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SAKDAh/nv8NV0+WReMVYT1Cw92Uau4qIjgC6GWZ3aiQodJ4IsPV6BlJGiPdSTPcQe
         allXt3lgbtdljfy3jPVUu0BdGkXcZm7kdBeoAqN9CUGoAQthyhEycE7xqOR4ufEWDm
         SyCN24LjK/03YdPKL3qYrImUTJSBngKKqWyHzNPQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6962160CE9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        ulf.hansson@linaro.org, khilman@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC v1 6/8] drivers: qcom: cpu_pd: program next wakeup to PDC timer
Date:   Thu, 11 Oct 2018 02:50:53 +0530
Message-Id: <1539206455-29342-7-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to sleep and wake request votes that need to be sent to
remote processor as part of low power mode entry, the next wake-up timer
value needs to be programmed to PDC (Power Domain Controller) which has
its own timer and is in an always on power domain. A specific control
register is provided in RSC address space for this purpose. PDC wakes-up
the RSC and sets up the resources back in active state before the
processor is woken up by a timer interrupt.

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/Kconfig  |  2 +-
 drivers/soc/qcom/cpu_pd.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 91e8b3b..9abaeab 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -105,7 +105,7 @@ config QCOM_RPMH
 
 config QCOM_CPU_PD
     bool "Qualcomm cpu power domain driver"
-    depends on QCOM_RPMH && PM_GENERIC_DOMAINS || COMPILE_TEST
+    depends on QCOM_RPMH && PM_GENERIC_DOMAINS && PM_SLEEP || COMPILE_TEST
     help
 	  Support for QCOM platform cpu power management to perform tasks
 	  necessary while application processor votes for deeper modes so that
diff --git a/drivers/soc/qcom/cpu_pd.c b/drivers/soc/qcom/cpu_pd.c
index 565c510..242eced 100644
--- a/drivers/soc/qcom/cpu_pd.c
+++ b/drivers/soc/qcom/cpu_pd.c
@@ -3,19 +3,80 @@
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/ktime.h>
 #include <linux/of_platform.h>
 #include <linux/pm_domain.h>
 #include <linux/slab.h>
+#include <linux/tick.h>
 
 #include <soc/qcom/rpmh.h>
 
+#define ARCH_TIMER_HZ (19200000)
+#define PDC_TIME_VALID_SHIFT	31
+#define PDC_TIME_UPPER_MASK	0xFFFFFF
 static struct device *cpu_pd_dev;
+static bool suspend;
+
+static uint64_t us_to_ticks(uint64_t time_us)
+{
+	uint64_t sec, nsec, time_cycles;
+
+	sec = time_us;
+	do_div(sec, USEC_PER_SEC);
+	nsec = time_us - sec * USEC_PER_SEC;
+
+	if (nsec > 0) {
+		nsec = nsec * NSEC_PER_USEC;
+		do_div(nsec, NSEC_PER_SEC);
+	}
+
+	sec += nsec;
+
+	time_cycles = (u64)sec * ARCH_TIMER_HZ;
+
+	return time_cycles;
+}
+
+static int setup_pdc_wakeup_timer(struct device *dev)
+{
+	int cpu;
+	struct tcs_cmd cmd[2] = { { 0 } };
+	ktime_t next_wakeup, cpu_wakeup;
+	uint64_t wakeup_cycles = ~0ULL;
+
+	if (!suspend) {
+		/*
+		 * Find the next wakeup for any of the online CPUs
+		 */
+		next_wakeup = ktime_set(KTIME_SEC_MAX, 0);
+		for_each_online_cpu(cpu) {
+			cpu_wakeup = tick_nohz_get_next_wakeup(cpu);
+			if (ktime_before(cpu_wakeup, next_wakeup))
+				next_wakeup = cpu_wakeup;
+		}
+		wakeup_cycles = us_to_ticks(ktime_to_us(next_wakeup));
+	}
+
+	cmd[0].data =  (wakeup_cycles >> 32) & PDC_TIME_UPPER_MASK;
+	cmd[0].data |= 1 << PDC_TIME_VALID_SHIFT;
+	cmd[1].data = (wakeup_cycles & 0xFFFFFFFF);
+
+	return rpmh_write_pdc_data(dev, cmd, ARRAY_SIZE(cmd));
+}
 
 static int cpu_pd_power_off(struct generic_pm_domain *domain)
 {
 	if (rpmh_ctrlr_idle(cpu_pd_dev)) {
 		/* Flush the sleep/wake sets */
 		rpmh_flush(cpu_pd_dev);
+		/*
+		 * The next wakeup value is converted to ticks
+		 * and copied to the Power Domain Controller
+		 * that has its own timer, which is in an
+		 * always-on power domain. The programming is
+		 * done through a separate register on the RSC
+		 */
+		setup_pdc_wakeup_timer(cpu_pd_dev);
 	} else {
 		pr_debug("rpmh controller is busy\n");
 		return -EBUSY;
@@ -89,6 +150,23 @@ static int cpu_pm_domain_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int cpu_pd_suspend(struct device *dev)
+{
+	suspend = true;
+	return 0;
+}
+
+static int cpu_pd_resume(struct device *dev)
+{
+	suspend = false;
+	return 0;
+}
+
+static const struct dev_pm_ops cpu_pd_dev_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(cpu_pd_suspend, cpu_pd_resume)
+};
+
+
 static const struct of_device_id cpu_pd_drv_match[] = {
 	{ .compatible = "qcom,cpu-pm-domain", },
 	{ }
@@ -99,6 +177,7 @@ static int cpu_pm_domain_probe(struct platform_device *pdev)
 	.driver	= {
 		.name = "cpu_pm_domain",
 		.of_match_table = cpu_pd_drv_match,
+		.pm = &cpu_pd_dev_pm_ops,
 	},
 };
 builtin_platform_driver(cpu_pm_domain_driver);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.

