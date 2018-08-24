Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A2AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41EF2150F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UPjo8tkz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mhNF0QDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41EF2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeHXXn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:43:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52592 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeHXXnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:43:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 784B96053D; Fri, 24 Aug 2018 20:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535141239;
        bh=80p+hVcHiozCeb8iIF+K72+zmyqyACym21JQWgbupek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UPjo8tkzXSBLQBfj+UjRqY2ponTuCuOSxC078H8Ep+O1XRZadrW1lB+P9uxddaQKs
         KW66Cs3jU92j30uTw7Mr2j301DdvXVNksaGn8NcNQnO5RBkXq/Hy/Ua6WMJ6TirvwN
         UaEQlelRJhv2EekLa2mQd0ZCS4PbLTTLjhcEaKZQ=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 88DBB60591;
        Fri, 24 Aug 2018 20:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535141236;
        bh=80p+hVcHiozCeb8iIF+K72+zmyqyACym21JQWgbupek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mhNF0QDHWKcLiSlJso50gNejM4/B9v6YGbIWCxQ22iMJ+9jmQgXloYUh0/0LqLchm
         rCmvFXo7JoHOOZCaXKn1MMvpqoZK5pgONMgHdTQoT3zmJ/nsTqcAhsFnb0vPIWfBdu
         JwoBpOO8GxGGbQgJlNEJlLQb7MIAwh3NqoSHv8t8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 88DBB60591
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
Subject: [PATCH RFC 3/6] drivers: qcom: system_pm: Add power management ops
Date:   Sat, 25 Aug 2018 01:36:25 +0530
Message-Id: <1535141188-29731-4-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535141188-29731-1-git-send-email-rplsssn@codeaurora.org>
References: <1535141188-29731-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suspend power management ops so that the sleep & wake resource
requests are flushed to corresponding TCS. The firmware would ensure
that the buffered requests in TCS are sent to Resource Power Manager
during entry to deepest low power modes.

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/Kconfig     |  2 +-
 drivers/soc/qcom/system_pm.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index a52abe9..ac0e413 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -88,7 +88,7 @@ config QCOM_RPMH
 
 config QCOM_SYSTEM_PM
 	bool "Qualcomm System PM"
-	depends on CPU_PM && QCOM_RPMH
+	depends on CPU_PM && PM_SLEEP && QCOM_RPMH
 	help
 	  Support for QCOM platform system power management to perform tasks
 	  necessary while application processor votes for deeper modes so that
diff --git a/drivers/soc/qcom/system_pm.c b/drivers/soc/qcom/system_pm.c
index 40e5aa7..8810b84 100644
--- a/drivers/soc/qcom/system_pm.c
+++ b/drivers/soc/qcom/system_pm.c
@@ -67,6 +67,23 @@ static int sys_pm_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int sys_pm_suspend(struct device *dev)
+{
+	if (rpmh_ctrlr_idle(dev)) {
+		/* Flush the sleep/wake sets in RSC controller */
+		rpmh_flush(dev);
+	} else {
+		pr_err("%s:rpmh controller is busy\n", __func__);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops sys_pm_dev_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(sys_pm_suspend, NULL)
+};
+
 static const struct of_device_id sys_pm_drv_match[] = {
 	{ .compatible = "qcom,system-pm", },
 	{ }
@@ -77,6 +94,7 @@ static int sys_pm_probe(struct platform_device *pdev)
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = sys_pm_drv_match,
+		.pm = &sys_pm_dev_pm_ops,
 	},
 };
 builtin_platform_driver(sys_pm_driver);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.

