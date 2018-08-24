Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849EAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6B02150F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VA1X6fuJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jUATfI+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6B02150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbeHXXie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:38:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49728 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeHXXib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:38:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2FEA860712; Fri, 24 Aug 2018 20:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535140947;
        bh=ZXkLPLrX41Roj7lssuCvbjZNE8mkYqo8klJ56eMnlxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VA1X6fuJprgOlUUlBjE1TTSnTxSynSRd4PRuN4LgbTrUBBvoWUSsdyqcPQEsK924M
         sxn1irhaCmYrYajtvUmCKFVw1h7nrKhsA7A626lxU0DMAPA66KCChidjIyUNxKeJLF
         Fd8NkNIRx5YsO2UNwQOQahakmCZEp08hDwER6FCM=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 99D79605FF;
        Fri, 24 Aug 2018 20:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535140946;
        bh=ZXkLPLrX41Roj7lssuCvbjZNE8mkYqo8klJ56eMnlxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jUATfI+bstvoIeEosIGUilulVSTMqJ5wNeFM6BLLW9qUxSyy0W6OPEoed562ClDSm
         I6/87Xk9yRRR0Kc8YSpAJdTVKpv0+rlqERm1r63/OJsMYM+CcoMqttUU8+qxG5u9Un
         /Lrfn60JQQMxwW1eCc2lG+iVevZs6F2ZEEzMs4nI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 99D79605FF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     marc.zyngier@arm.com, bjorn.andersson@linaro.org, sboyd@kernel.org,
        evgreen@chromium.org, linus.walleij@linaro.org
Cc:     rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v2 4/5] drivers: pinctrl: qcom: sdm845: support GPIO wakeup from suspend
Date:   Fri, 24 Aug 2018 14:01:56 -0600
Message-Id: <20180824200157.9993-5-ilina@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824200157.9993-1-ilina@codeaurora.org>
References: <20180824200157.9993-1-ilina@codeaurora.org>
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

