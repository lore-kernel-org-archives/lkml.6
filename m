Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951E6C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 19:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B4B208DA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 19:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bFvKNG1U";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bFvKNG1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B4B208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbeHQWQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 18:16:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36682 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbeHQWPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 18:15:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B350B62586; Fri, 17 Aug 2018 19:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534533039;
        bh=6flkeC8VwR0A6QppwkUCI0AsDYsAguhrxydU1eExRqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bFvKNG1UBp4/e/uLf278mrDIYNZvMKBbFC9t4FpQctUk1MjuhCbsCbR61j+HoBDU2
         klMzAJ0uyYx35pnR/P9AtJnRyjrpfgTL5LY3sEgCOa0h0hn7oMHUK6tTHhqtG5L36M
         J54G3fHDnwLWtM4dbf8MIca4YSxfi1dcM/X2aDVo=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 25AD262586;
        Fri, 17 Aug 2018 19:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534533039;
        bh=6flkeC8VwR0A6QppwkUCI0AsDYsAguhrxydU1eExRqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bFvKNG1UBp4/e/uLf278mrDIYNZvMKBbFC9t4FpQctUk1MjuhCbsCbR61j+HoBDU2
         klMzAJ0uyYx35pnR/P9AtJnRyjrpfgTL5LY3sEgCOa0h0hn7oMHUK6tTHhqtG5L36M
         J54G3fHDnwLWtM4dbf8MIca4YSxfi1dcM/X2aDVo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 25AD262586
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     marc.zyngier@arm.com, bjorn.andersson@linaro.org, sboyd@kernel.org,
        evgreen@chromium.org, linus.walleij@linaro.org
Cc:     rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH RESEND v1 3/5] drivers: pinctrl: qcom: sdm845: support GPIO wakeup from suspend
Date:   Fri, 17 Aug 2018 13:10:24 -0600
Message-Id: <20180817191026.32245-4-ilina@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817191026.32245-1-ilina@codeaurora.org>
References: <20180817191026.32245-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/pinctrl/qcom/pinctrl-sdm845.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
index 2ab7a8885757..cc333b8afb99 100644
--- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
+++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
@@ -1297,10 +1297,16 @@ static const struct of_device_id sdm845_pinctrl_of_match[] = {
 	{ },
 };
 
+static const struct dev_pm_ops msm_pinctrl_dev_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(msm_pinctrl_suspend_late,
+				     msm_pinctrl_resume_late)
+};
+
 static struct platform_driver sdm845_pinctrl_driver = {
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

