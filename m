Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F9DC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1352073D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EcuusKyh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oZfC8g66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1352073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeIEBpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 21:45:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50880 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbeIEBpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 21:45:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 888ED60AA2; Tue,  4 Sep 2018 21:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536095909;
        bh=JJLAku1WEJzIGgkft3WYFW22LPq0PqPXFU9Kz0wRJhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EcuusKyhzPpaEdnLIaYMUh1/DsgLJRY/sQoivGTbxBTQwh1f6zddhHMxPboe2K2GX
         Bsyhb4QxR573bunZPCPgIPhHAVlRAvhwBXxSCC0lOT6CAfjgbIXtHg+6F5VX9bVEUz
         mZXiFt/Kw768eBB46EARzf4rpRqNeWkQZIUlXEgU=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8D5F160997;
        Tue,  4 Sep 2018 21:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536095908;
        bh=JJLAku1WEJzIGgkft3WYFW22LPq0PqPXFU9Kz0wRJhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oZfC8g66pBlSZRvccsugIuDdDbBKD3TXKhrJi/8Zafo3nLSm4T2xMtsBb/wj9F5Fm
         Ua+ol989UrYzXud6NhBHljnso+1fLfX/n/L00HkOYN+5CeMniz0IDIFeNzfNxyMeiB
         I3LPwK3P4r+B5a7fzbWdWRyEwL7YiARa6ig0ebcs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8D5F160997
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     marc.zyngier@arm.com, bjorn.andersson@linaro.org, sboyd@kernel.org,
        evgreen@chromium.org, linus.walleij@linaro.org
Cc:     rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v3 4/5] drivers: pinctrl: qcom: sdm845: support GPIO wakeup from suspend
Date:   Tue,  4 Sep 2018 15:18:09 -0600
Message-Id: <20180904211810.5506-5-ilina@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904211810.5506-1-ilina@codeaurora.org>
References: <20180904211810.5506-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable TLMM IRQs to be sensed by PDC when we enter suspend. It is
possible that the TLMM may be powered off and not detect GPIOs that are
configured as wake up interrupts. By hooking into suspend callbacks, we
allow PDC IRQs to take over and wake up the system if wakeup interrupts
are triggered.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
Changes in v3:
	- Move the common suspend ops definition to pinctrl-msm.c
---
 drivers/pinctrl/qcom/pinctrl-msm.c    | 5 +++++
 drivers/pinctrl/qcom/pinctrl-msm.h    | 2 ++
 drivers/pinctrl/qcom/pinctrl-sdm845.c | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 01a455f86fcd..92887c075230 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1142,6 +1142,11 @@ int __maybe_unused msm_pinctrl_resume_late(struct device *dev)
 	return 0;
 }
 
+const struct dev_pm_ops msm_pinctrl_dev_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(msm_pinctrl_suspend_late,
+				     msm_pinctrl_resume_late)
+};
+
 int msm_pinctrl_probe(struct platform_device *pdev,
 		      const struct msm_pinctrl_soc_data *soc_data)
 {
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
index 21b56fb5dae9..9be1baa878a3 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.h
+++ b/drivers/pinctrl/qcom/pinctrl-msm.h
@@ -126,4 +126,6 @@ int msm_pinctrl_remove(struct platform_device *pdev);
 int msm_pinctrl_suspend_late(struct device *dev);
 int msm_pinctrl_resume_late(struct device *dev);
 
+extern const struct dev_pm_ops msm_pinctrl_dev_pm_ops;
+
 #endif
diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
index 2ab7a8885757..0c82dc403268 100644
--- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
+++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
@@ -1301,6 +1301,7 @@ static struct platform_driver sdm845_pinctrl_driver = {
 	.driver = {
 		.name = "sdm845-pinctrl",
 		.of_match_table = sdm845_pinctrl_of_match,
+		.pm = &msm_pinctrl_dev_pm_ops,
 	},
 	.probe = sdm845_pinctrl_probe,
 	.remove = msm_pinctrl_remove,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

