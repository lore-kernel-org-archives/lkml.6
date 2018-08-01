Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15161C43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 02:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF13F20851
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 02:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SGcHMm7o";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MMbePQNv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF13F20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733045AbeHADni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 23:43:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55318 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732968AbeHADnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 23:43:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0DA9C60B13; Wed,  1 Aug 2018 02:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533088829;
        bh=5OinB3JrD+4NnJV7HtADm6/FB6swmj1w4nQtF7rlhI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SGcHMm7oizuzosR9E1bnHdg3L52R3nfJmwc/YQaV8wjJn1ViIPH8FnkgbjYgoXkb3
         SozsI8cRCeeP61a63qSg8FlxYlUcmIf6jLFMTCCz8DBCVyg+fxlwy/I2O9TnOfeVR/
         DXJL2koK0aI6yya7/1gga5tBz17B8wMZpqBGXV0Y=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6D32D6074D;
        Wed,  1 Aug 2018 02:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533088828;
        bh=5OinB3JrD+4NnJV7HtADm6/FB6swmj1w4nQtF7rlhI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MMbePQNvEo9p28iKiCYYSCle6uxMGe97MpbF6HeNMFuYPFC4dj+t90MrG8rMq3Ffm
         Ayxt64b2Tx2hpSeTERzCpnXt6ckc3DUCU4vRui4nIcvJCbFMQohk25tbB8+/mWpHo/
         SQ6YLRje4uubjG8qCJvAscz7r4Gmd4nglhztiUGQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6D32D6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     marc.zyngier@arm.com, swboyd@chromium.org, evgreen@chromium.org,
        linus.walleij@linaro.org, bjorn.andersson@linaro.org
Cc:     rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH RESEND RFC 2/4] drivers: pinctrl: qcom: add wakeup gpio map for sdm845
Date:   Tue, 31 Jul 2018 20:00:19 -0600
Message-Id: <20180801020021.9782-3-ilina@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801020021.9782-1-ilina@codeaurora.org>
References: <20180801020021.9782-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GPIO to PDC pin map for the SDM845 SoC.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/pinctrl/qcom/pinctrl-sdm845.c | 76 +++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
index 2ab7a8885757..e93660922dc2 100644
--- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
+++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
@@ -1277,6 +1277,80 @@ static const struct msm_pingroup sdm845_groups[] = {
 	UFS_RESET(ufs_reset, 0x99f000),
 };

+static struct msm_pinctrl_pdc_map sdm845_wakeup_gpios[] = {
+	{1, 30},
+	{3, 31},
+	{5, 32},
+	{10, 33},
+	{11, 34},
+	{20, 35},
+	{22, 36},
+	{24, 37},
+	{26, 38},
+	{30, 39},
+	{32, 41},
+	{34, 42},
+	{36, 43},
+	{37, 44},
+	{38, 45},
+	{39, 46},
+	{40, 47},
+	{43, 49},
+	{44, 50},
+	{46, 51},
+	{48, 52},
+	{52, 54},
+	{53, 55},
+	{54, 56},
+	{56, 57},
+	{57, 58},
+	{58, 59},
+	{59, 60},
+	{60, 61},
+	{61, 62},
+	{62, 63},
+	{63, 64},
+	{64, 65},
+	{66, 66},
+	{68, 67},
+	{71, 68},
+	{73, 69},
+	{77, 70},
+	{78, 71},
+	{79, 72},
+	{80, 73},
+	{84, 74},
+	{85, 75},
+	{86, 76},
+	{88, 77},
+	{91, 79},
+	{92, 80},
+	{95, 81},
+	{96, 82},
+	{97, 83},
+	{101, 84},
+	{103, 85},
+	{104, 86},
+	{115, 90},
+	{116, 91},
+	{117, 92},
+	{118, 93},
+	{119, 94},
+	{120, 95},
+	{121, 96},
+	{122, 97},
+	{123, 98},
+	{124, 99},
+	{125, 100},
+	{127, 102},
+	{128, 103},
+	{129, 104},
+	{130, 105},
+	{132, 106},
+	{133, 107},
+	{145, 108},
+};
+
 static const struct msm_pinctrl_soc_data sdm845_pinctrl = {
 	.pins = sdm845_pins,
 	.npins = ARRAY_SIZE(sdm845_pins),
@@ -1285,6 +1359,8 @@ static const struct msm_pinctrl_soc_data sdm845_pinctrl = {
 	.groups = sdm845_groups,
 	.ngroups = ARRAY_SIZE(sdm845_groups),
 	.ngpios = 150,
+	.pdc_map = sdm845_wakeup_gpios,
+	.npdc_pins = ARRAY_SIZE(sdm845_wakeup_gpios),
 };

 static int sdm845_pinctrl_probe(struct platform_device *pdev)
--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

