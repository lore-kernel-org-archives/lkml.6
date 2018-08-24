Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B0FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7063F2151C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WQpgWOdr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c+U0BbRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7063F2151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeHXXnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:43:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52216 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeHXXnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:43:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 04F07604BE; Fri, 24 Aug 2018 20:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535141226;
        bh=QB/G7Z5fAk6NmU5Bp9aKKrfZf8LlhU9wz1RH8eMTSrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WQpgWOdrkXzjXlIiXhkQgwhPGx0wypfy+Rpryb3JsOUDq5Rm5wDvYu+ozKLqtYtl3
         KKh23XdHsUv/7d5Z20uVsJlXJVEVBhPW68TbDotTYLCKcgraY/RWkttztyHTDgXPRb
         Lqyne0RSZ1bWO2PrR1aaBjdM2uuZM2FzdYx+9Ces=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C9DB36022B;
        Fri, 24 Aug 2018 20:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535141224;
        bh=QB/G7Z5fAk6NmU5Bp9aKKrfZf8LlhU9wz1RH8eMTSrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c+U0BbRKVXXQ0AkW8W6+QDn1P9aGn/RFfl8da0zFKVwFrODq48ytqoQaxRq7dgxkT
         7uo7cyold81K40SNZb1FI04Eilq2r40AP8a+ar7s2XicQ2kY5sMivnlugU1TyN0Aby
         YFD+j3ePz80mooAOJCp8zQQeQnEwzrEyE5F28cDc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C9DB36022B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com,
        rafael@kernel.org, drake@endlessm.com, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC 1/6] drivers: qcom: system_pm: add system PM client for RPMH based SoCs
Date:   Sat, 25 Aug 2018 01:36:23 +0530
Message-Id: <1535141188-29731-2-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535141188-29731-1-git-send-email-rplsssn@codeaurora.org>
References: <1535141188-29731-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RPMH based targets require that the sleep and wake state request votes
be sent during system low power mode entry. The votes help reduce the
power consumption when the AP is not using them. The votes sent by the
clients are cached in RPMH controller and needs to be flushed by a sleep
manager. So add system power manager client for RPMH client and invoke
RPMH flush when last core is being powered off by listening to
cpu_pm_notifications.

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/Kconfig     | 11 ++++++
 drivers/soc/qcom/Makefile    |  1 +
 drivers/soc/qcom/system_pm.c | 82 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 drivers/soc/qcom/system_pm.c

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 3223084..a52abe9 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -78,6 +78,7 @@ config QCOM_RMTFS_MEM
 config QCOM_RPMH
 	bool "Qualcomm RPM-Hardened (RPMH) Communication"
 	depends on ARCH_QCOM && ARM64 && OF || COMPILE_TEST
+	select QCOM_SYSTEM_PM
 	help
 	  Support for communication with the hardened-RPM blocks in
 	  Qualcomm Technologies Inc (QTI) SoCs. RPMH communication uses an
@@ -85,6 +86,16 @@ config QCOM_RPMH
 	  of hardware components aggregate requests for these resources and
 	  help apply the aggregated state on the resource.
 
+config QCOM_SYSTEM_PM
+	bool "Qualcomm System PM"
+	depends on CPU_PM && QCOM_RPMH
+	help
+	  Support for QCOM platform system power management to perform tasks
+	  necessary while application processor votes for deeper modes so that
+	  the firmware can enter SoC level low power modes to save power.
+	  Deeper low power modes can be voted during idle power management or
+	  pm suspend state.
+
 config QCOM_SMEM
 	tristate "Qualcomm Shared Memory Manager (SMEM)"
 	depends on ARCH_QCOM
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 03d4c83..27d79d2 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_QCOM_RMTFS_MEM)	+= rmtfs_mem.o
 obj-$(CONFIG_QCOM_RPMH)		+= qcom_rpmh.o
 qcom_rpmh-y			+= rpmh-rsc.o
 qcom_rpmh-y			+= rpmh.o
+obj-$(CONFIG_QCOM_SYSTEM_PM) += system_pm.o
 obj-$(CONFIG_QCOM_SMD_RPM)	+= smd-rpm.o
 obj-$(CONFIG_QCOM_SMEM) +=	smem.o
 obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
diff --git a/drivers/soc/qcom/system_pm.c b/drivers/soc/qcom/system_pm.c
new file mode 100644
index 0000000..40e5aa7
--- /dev/null
+++ b/drivers/soc/qcom/system_pm.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/cpu_pm.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+
+#include <soc/qcom/rpmh.h>
+
+static struct cpumask cpu_pm_state_mask;
+static raw_spinlock_t cpu_pm_state_lock;
+
+static struct device *sys_pm_dev;
+
+static int sys_pm_notifier(struct notifier_block *b,
+			       unsigned long cmd, void *v)
+{
+	switch (cmd) {
+	case CPU_PM_ENTER:
+		raw_spin_lock(&cpu_pm_state_lock);
+		cpumask_set_cpu(smp_processor_id(), &cpu_pm_state_mask);
+		if (cpumask_equal(&cpu_pm_state_mask, cpu_possible_mask)) {
+			if (rpmh_ctrlr_idle(sys_pm_dev)) {
+				/* Flush the sleep/wake sets */
+				rpmh_flush(sys_pm_dev);
+			} else {
+				pr_err("%s:rpmh controller is busy\n",
+						__func__);
+				raw_spin_unlock(&cpu_pm_state_lock);
+				return NOTIFY_BAD;
+			}
+		}
+		raw_spin_unlock(&cpu_pm_state_lock);
+		break;
+	case CPU_PM_EXIT:
+	case CPU_PM_ENTER_FAILED:
+		raw_spin_lock(&cpu_pm_state_lock);
+		cpumask_clear_cpu(smp_processor_id(), &cpu_pm_state_mask);
+		raw_spin_unlock(&cpu_pm_state_lock);
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block sys_pm_notifier_block = {
+	.notifier_call = sys_pm_notifier,
+	.priority = -1, /* Should be last in the order of notifications */
+};
+
+static int sys_pm_probe(struct platform_device *pdev)
+{
+	sys_pm_dev = &pdev->dev;
+
+	if (IS_ERR_OR_NULL(sys_pm_dev)) {
+		pr_err("%s fail\n", __func__);
+		return PTR_ERR(sys_pm_dev);
+	}
+
+	raw_spin_lock_init(&cpu_pm_state_lock);
+	cpu_pm_register_notifier(&sys_pm_notifier_block);
+
+	return 0;
+}
+
+static const struct of_device_id sys_pm_drv_match[] = {
+	{ .compatible = "qcom,system-pm", },
+	{ }
+};
+
+static struct platform_driver sys_pm_driver = {
+	.probe = sys_pm_probe,
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = sys_pm_drv_match,
+	},
+};
+builtin_platform_driver(sys_pm_driver);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.

