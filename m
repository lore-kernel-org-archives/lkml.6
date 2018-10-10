Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7801EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1328520870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IZ3VQmk3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="d9ojuZPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1328520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbeJKEp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:45:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37774 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeJKEp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:45:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E481B60B7A; Wed, 10 Oct 2018 21:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539206486;
        bh=Wgz+OIgHIlsxrkWgLNQ317LbpzFWiR/RC4D+psOfXOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IZ3VQmk3TOej6jV6n0cofbdgIg3lROOm5XS6wZC6PdYDX57VTH6k5c4RBXoO9S2nE
         PSqmWy7/HP40w4RAoz/3vFI4In+psnijEGQdnCLwPk6q+6iN85U1xWLeFVSy8axDSD
         ulBObwgreco8wHX+KCvqrvhB8+qfSmtGuvyB/z1A=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E68C260B7A;
        Wed, 10 Oct 2018 21:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539206485;
        bh=Wgz+OIgHIlsxrkWgLNQ317LbpzFWiR/RC4D+psOfXOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d9ojuZPbT7cBRMU55SSFE00kOdyYFNO3iSqaANYJa9QgFP25cmibY/D3LrU1u5hsU
         7B9TeIDVArDW/wG0lI2XAnMdiKGAUXHXgH4WG+Cq4KUndljgUE+0gX6ETwwzoWVoH8
         T3SYKENyyLF0zA7ll1qo3v4T8cETOUDTen/7xty0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E68C260B7A
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
Subject: [PATCH RFC v1 1/8] PM / Domains: Add helper functions to attach/detach CPUs to/from genpd
Date:   Thu, 11 Oct 2018 02:50:48 +0530
Message-Id: <1539206455-29342-2-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Introduce two new genpd helper functions, of_genpd_attach|detach_cpu(),
which takes the CPU-number as an in-parameter.

To attach a CPU to a genpd, of_genpd_attach_cpu() starts by fetching the
struct device belonging to the CPU. Then it calls genpd_dev_pm_attach(),
which via DT tries to hook up the CPU device to its corresponding PM
domain. If it succeeds, of_genpd_attach_cpu() continues to prepare/enable
runtime PM of the device.

To detach a CPU from its PM domain, of_genpd_attach_cpu() reverse the
operations made from of_genpd_attach_cpu(). However, first it checks that
the CPU device has a valid PM domain pointer assigned, as to make sure it
belongs to genpd.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[rplsssn@codeaurora.org: Fix compilation issue]
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
(am from https://patchwork.kernel.org/patch/10478167/)
---
 drivers/base/power/domain.c | 70 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  9 ++++++
 2 files changed, 79 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 4b57141..82973e3 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -6,6 +6,7 @@
  * This file is released under the GPLv2.
  */
 
+#include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
@@ -2398,6 +2399,75 @@ struct device *genpd_dev_pm_attach_by_name(struct device *dev, char *name)
 	return genpd_dev_pm_attach_by_id(dev, index);
 }
 
+/*
+ * of_genpd_attach_cpu() - Attach a CPU to its PM domain
+ * @cpu: The CPU to be attached.
+ *
+ * Parses the OF node of the CPU's device, to find a PM domain specifier. If
+ * such is found, attaches the CPU's device to the retrieved pm_domain ops and
+ * enables runtime PM for it. This to allow the CPU to be power managed through
+ * its PM domain.
+ *
+ * Returns zero when successfully attached the CPU's device to its PM domain,
+ * else a negative error code.
+ */
+int of_genpd_attach_cpu(int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
+	int ret;
+
+	if (!dev) {
+		pr_warn("genpd: no dev for cpu%d\n", cpu);
+		return -ENODEV;
+	}
+
+	ret = genpd_dev_pm_attach(dev);
+	if (ret != 1) {
+		dev_warn(dev, "genpd: attach cpu failed %d\n", ret);
+		return ret < 0 ? ret : -ENODEV;
+	}
+
+	pm_runtime_irq_safe(dev);
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	dev_info(dev, "genpd: attached cpu\n");
+	return 0;
+}
+EXPORT_SYMBOL(of_genpd_attach_cpu);
+
+/**
+ * of_genpd_detach_cpu() - Detach a CPU from its PM domain
+ * @cpu: The CPU to be detached.
+ *
+ * Detach the CPU's device from its corresponding PM domain. If detaching is
+ * completed successfully, disable runtime PM and restore the runtime PM usage
+ * count for the CPU's device.
+ */
+void of_genpd_detach_cpu(int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
+
+	if (!dev) {
+		pr_warn("genpd: no dev for cpu%d\n", cpu);
+		return;
+	}
+
+	/* Check that the device is attached to a genpd. */
+	if (!(dev->pm_domain && dev->pm_domain->detach == genpd_dev_pm_detach))
+		return;
+
+	genpd_dev_pm_detach(dev, true);
+
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
+	pm_runtime_reinit(dev);
+
+	dev_info(dev, "genpd: detached cpu\n");
+}
+EXPORT_SYMBOL(of_genpd_detach_cpu);
+
 static const struct of_device_id idle_state_match[] = {
 	{ .compatible = "domain-idle-state", },
 	{ }
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 776c546..48850af 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -241,6 +241,8 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 					 unsigned int index);
 struct device *genpd_dev_pm_attach_by_name(struct device *dev,
 					   char *name);
+int of_genpd_attach_cpu(int cpu);
+void of_genpd_detach_cpu(int cpu);
 #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
 static inline int of_genpd_add_provider_simple(struct device_node *np,
 					struct generic_pm_domain *genpd)
@@ -298,6 +300,13 @@ static inline struct device *genpd_dev_pm_attach_by_name(struct device *dev,
 	return NULL;
 }
 
+static inline int of_genpd_attach_cpu(int cpu)
+{
+	return -ENODEV;
+}
+
+static inline void of_genpd_detach_cpu(int cpu) {}
+
 static inline
 struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
 {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.

