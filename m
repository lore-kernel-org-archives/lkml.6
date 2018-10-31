Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29979C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A3B208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzB3Rits"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A3B208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732064AbeKAIMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:12:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730796AbeKAIMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:12:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC5EF204FD;
        Wed, 31 Oct 2018 23:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027514;
        bh=m4BGfWAE4ELVR2m+wMqwnCU1g3CRG48NoYaSxA+VoDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pzB3Rits+eFpFqmOLl0hvTRwfCRynk+LyU10JFFRylrVCsPOwGtH1SWBUZUW9RQIY
         VW6zH5WrTZzW6ogynHnQgvcavciWprd3Qmr3WcNrfd4lgiFrM+2s9ONGy0gWomkABz
         3Ot0jhiDdHoJylAAVEFwGq40aZJzNey8pMa6Zr3A=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 18/32] pinctrl: ssbi-gpio: Fix pm8xxx_pin_config_get() to be compliant
Date:   Wed, 31 Oct 2018 19:11:23 -0400
Message-Id: <20181031231137.29429-18-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231137.29429-1-sashal@kernel.org>
References: <20181031231137.29429-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit b432414b996d32a1bd9afe2bd595bd5729c1477f ]

If you look at "pinconf-groups" in debugfs for ssbi-gpio you'll notice
it looks like nonsense.

The problem is fairly well described in commit 1cf86bc21257 ("pinctrl:
qcom: spmi-gpio: Fix pmic_gpio_config_get() to be compliant") and
commit 05e0c828955c ("pinctrl: msm: Fix msm_config_group_get() to be
compliant"), but it was pointed out that ssbi-gpio has the same
problem.  Let's fix it there too.

Fixes: b4c45fe974bc ("pinctrl: qcom: ssbi: Family A gpio & mpp drivers")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c | 28 ++++++++++++++++++------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
index 19a3c3bc2f1f..b1e8a2d905ff 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
@@ -259,22 +259,32 @@ static int pm8xxx_pin_config_get(struct pinctrl_dev *pctldev,
 
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
-		arg = pin->bias == PM8XXX_GPIO_BIAS_NP;
+		if (pin->bias != PM8XXX_GPIO_BIAS_NP)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		arg = pin->bias == PM8XXX_GPIO_BIAS_PD;
+		if (pin->bias != PM8XXX_GPIO_BIAS_PD)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
-		arg = pin->bias <= PM8XXX_GPIO_BIAS_PU_1P5_30;
+		if (pin->bias > PM8XXX_GPIO_BIAS_PU_1P5_30)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PM8XXX_QCOM_PULL_UP_STRENGTH:
 		arg = pin->pull_up_strength;
 		break;
 	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
-		arg = pin->disable;
+		if (!pin->disable)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PIN_CONFIG_INPUT_ENABLE:
-		arg = pin->mode == PM8XXX_GPIO_MODE_INPUT;
+		if (pin->mode != PM8XXX_GPIO_MODE_INPUT)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PIN_CONFIG_OUTPUT:
 		if (pin->mode & PM8XXX_GPIO_MODE_OUTPUT)
@@ -289,10 +299,14 @@ static int pm8xxx_pin_config_get(struct pinctrl_dev *pctldev,
 		arg = pin->output_strength;
 		break;
 	case PIN_CONFIG_DRIVE_PUSH_PULL:
-		arg = !pin->open_drain;
+		if (pin->open_drain)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
-		arg = pin->open_drain;
+		if (!pin->open_drain)
+			return -EINVAL;
+		arg = 1;
 		break;
 	default:
 		return -EINVAL;
-- 
2.17.1

