Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A02BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48654218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UR7Sn3JK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OlkaJJe7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390220AbeLUMAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 07:00:48 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39592 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732607AbeLUMAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 07:00:46 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 318D1609C4; Fri, 21 Dec 2018 12:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545393645;
        bh=C2cgUDhNcCSdOqOs+pZCrHy3sHt4moe9OIisEtb/lVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UR7Sn3JKwzDPdXWv4TeI3rLwTjrrmmqi7UicZPou5hTEd4OguWTWCXs/C08EbPcvG
         jREEhRncGa/o2wp/VMKR6ZHY+R3dogb+uEbnMygiJE5PMqWBGEGOilw/6q0cIZB3d9
         OpO6pN2+JQ3tmlSCfhYoi+4AcHPk5fQ1mf355X2k=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 25599609C2;
        Fri, 21 Dec 2018 12:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545393642;
        bh=C2cgUDhNcCSdOqOs+pZCrHy3sHt4moe9OIisEtb/lVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OlkaJJe7z155K0Zm5AiG7WQ5lTXjN3bJVs6Rz8MMJWAhnAFhFkrtEMQAylsNg1ZoQ
         nSoq/how8Er4x/G5/2eei20INTwizGfgmp6kGwUbZ2glqedv7J8l01Z6KUpE2XZhU7
         IDWB5mcpHdvlq+fkZO4/fnuCVDCBhyP0bTVNqIaY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 25599609C2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org,
        mka@chromium.org, ilina@codeaurora.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC 4/5] drivers: qcom: rpmh-pdc-timer: Add power management ops
Date:   Fri, 21 Dec 2018 17:29:45 +0530
Message-Id: <20181221115946.10095-5-rplsssn@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181221115946.10095-1-rplsssn@codeaurora.org>
References: <20181221115946.10095-1-rplsssn@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suspend power management ops so that the PDC timer is programmed
to highest match value when system is suspended.

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/Kconfig          |  2 +-
 drivers/soc/qcom/rpmh-pdc-timer.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index d04724ea5490..c6ef41a06c97 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -105,7 +105,7 @@ config QCOM_RPMH
 
 config QCOM_RPMH_PDC_TIMER
 	bool "Qualcomm PDC Timer for RPM-Hardened based SoCs"
-	depends on CPU_PM
+	depends on CPU_PM && PM_SLEEP
 	help
 	  Support for QCOM platform next wakeup timer programming when
 	  application processor enters SoC level deepest low power mode.
diff --git a/drivers/soc/qcom/rpmh-pdc-timer.c b/drivers/soc/qcom/rpmh-pdc-timer.c
index 108ea4a2df89..ebb643924a3e 100644
--- a/drivers/soc/qcom/rpmh-pdc-timer.c
+++ b/drivers/soc/qcom/rpmh-pdc-timer.c
@@ -23,6 +23,7 @@ static resource_size_t cmd0_data_offset;
 static resource_size_t cmd1_data_offset;
 static uint64_t pdc_wakeup = ~0ULL;
 static raw_spinlock_t pdc_wakeup_lock;
+static int suspended;
 
 /* convert micro sec to ticks or clock cycles
  *
@@ -102,6 +103,9 @@ static int cpu_pm_notifier(struct notifier_block *b,
 {
 	uint64_t cpu_next_wakeup;
 
+	if (suspended)
+		return NOTIFY_DONE;
+
 	switch (cmd) {
 	case CPU_PM_ENTER:
 		cpu_next_wakeup = get_next_wakeup_cycles(smp_processor_id());
@@ -130,6 +134,25 @@ static struct notifier_block cpu_pm_notifier_block = {
 	.priority = -1, /* Should be last in the order of notifications */
 };
 
+static int pdc_timer_suspend(struct device *dev)
+{
+	suspended = true;
+	raw_spin_lock(&pdc_wakeup_lock);
+	pdc_wakeup = ~0ULL;
+	setup_pdc_wakeup_timer(pdc_wakeup);
+	raw_spin_unlock(&pdc_wakeup_lock);
+	return 0;
+}
+
+static int pdc_timer_resume(struct device *dev)
+{
+	suspended = false;
+	return 0;
+}
+static const struct dev_pm_ops pdc_timer_dev_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pdc_timer_suspend, pdc_timer_resume)
+};
+
 static int pdc_timer_probe(struct platform_device *pdev)
 {
 	struct device *pdc_timer_dev = &pdev->dev;
@@ -176,6 +199,7 @@ static struct platform_driver pdc_timer_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = pdc_timer_drv_match,
+		.pm = &pdc_timer_dev_pm_ops,
 	},
 };
 builtin_platform_driver(pdc_timer_driver);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.

