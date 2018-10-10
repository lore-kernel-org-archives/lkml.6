Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F055C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26E62087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Eh4YxjcK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lNZKmvbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26E62087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeJKEqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:46:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39010 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbeJKEqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:46:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A1DBC60C67; Wed, 10 Oct 2018 21:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539206532;
        bh=nB6tjERmIB6LKXCydOjn5KUzO9+SvPhRYlqci9k7jnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eh4YxjcKuRWmY+EzLMRaZlXEDLJtGx7qe5VaS+dHPRk6huJmsZEuKot7v+HC1vSAL
         2JpKhDp/Gg1XBoXItjDSWg/J9qjoZotsQn4bdgK+8vpA75sb97t0OUYt89CHfL11L1
         Trf9KqEMnV4QhRq2YrDIiRnj9AW8NIaztU373UpQ=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 457FB60C6A;
        Wed, 10 Oct 2018 21:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539206527;
        bh=nB6tjERmIB6LKXCydOjn5KUzO9+SvPhRYlqci9k7jnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lNZKmvbsHG2WMi3a0QX3OVYCKyeQeYrTZsPOYpL4uN4Jr0aqIaZbe649vIW1/D2BT
         npQRvof8ptxkFxDy3/JAd6s4ijhUSTrgSbCGXwCFcs2FD+PS1kHNjaTTgmBqjTAhbs
         6ZH0iOYX83qHgbvhV741EeI6d0HHGbFEP6mq0SGM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 457FB60C6A
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
Subject: [PATCH RFC v1 7/8] drivers: qcom: cpu_pd: Handle cpu hotplug in the domain
Date:   Thu, 11 Oct 2018 02:50:54 +0530
Message-Id: <1539206455-29342-8-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use cpu hotplug callback mechanism to attach/dettach the cpu in
the cpu power domain. During cpu hotplug callback registration,
the starting callback is invoked on all online cpus. So there is
no need to attach from device probe.

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/cpu_pd.c  | 33 +++++++++++++++++++++++++--------
 include/linux/cpuhotplug.h |  1 +
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/qcom/cpu_pd.c b/drivers/soc/qcom/cpu_pd.c
index 242eced..bf2d95d 100644
--- a/drivers/soc/qcom/cpu_pd.c
+++ b/drivers/soc/qcom/cpu_pd.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/cpuhotplug.h>
 #include <linux/ktime.h>
 #include <linux/of_platform.h>
 #include <linux/pm_domain.h>
@@ -85,12 +86,26 @@ static int cpu_pd_power_off(struct generic_pm_domain *domain)
 	return 0;
 }
 
+static int cpu_pd_starting(unsigned int cpu)
+{
+	if (!suspend && of_genpd_attach_cpu(cpu))
+		pr_err("%s: genpd_attach_cpu fail\n", __func__);
+	return 0;
+}
+
+static int cpu_pd_dying(unsigned int cpu)
+{
+	if (!suspend)
+		of_genpd_detach_cpu(cpu);
+	return 0;
+}
+
 static int cpu_pm_domain_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct generic_pm_domain *cpu_pd;
-	int ret = -EINVAL, cpu;
+	int ret = -EINVAL;
 
 	if (!np) {
 		dev_err(dev, "device tree node not found\n");
@@ -127,15 +142,17 @@ static int cpu_pm_domain_probe(struct platform_device *pdev)
 
 	pr_info("init PM domain %s\n", cpu_pd->name);
 
-	for_each_present_cpu(cpu) {
-		ret = of_genpd_attach_cpu(cpu);
-		if (ret)
-			goto detach_cpu;
-	}
+	/* Install hotplug callbacks */
+	ret = cpuhp_setup_state(CPUHP_AP_QCOM_SYS_PM_DOMAIN_STARTING,
+				"AP_QCOM_SYS_PM_DOMAIN_STARTING",
+				cpu_pd_starting, cpu_pd_dying);
+	if (ret)
+		goto remove_hotplug;
+
 	return 0;
 
-detach_cpu:
-	of_genpd_detach_cpu(cpu);
+remove_hotplug:
+	cpuhp_remove_state(CPUHP_AP_QCOM_SYS_PM_DOMAIN_STARTING);
 
 remove_pd:
 	pm_genpd_remove(cpu_pd);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index caf40ad..4bfe8e2 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -139,6 +139,7 @@ enum cpuhp_state {
 	CPUHP_AP_X86_TBOOT_DYING,
 	CPUHP_AP_ARM_CACHE_B15_RAC_DYING,
 	CPUHP_AP_ONLINE,
+	CPUHP_AP_QCOM_SYS_PM_DOMAIN_STARTING,
 	CPUHP_TEARDOWN_CPU,
 	CPUHP_AP_ONLINE_IDLE,
 	CPUHP_AP_SMPBOOT_THREADS,
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.

