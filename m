Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C748C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FA02145D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBLbzova"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6FA02145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbeKAIQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:16:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732009AbeKAIMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:12:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03E0520854;
        Wed, 31 Oct 2018 23:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027513;
        bh=cfYlc4bYnnCncqlJhXd8YMlRUJJ/2wpPo+5FnuGXmj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uBLbzova4EKfsyX0jNvA5qsmE6qXVk4WFdqFNrLbj2NfF34GmmyPBhpisWHVkYU/u
         z1RpIPPaA+0lEtx4QECfmUbfxhP3RYIBuFaG3HabYiZBSHZU9zVxC3eJbb4zaorUqV
         KLkEO+ddpRzqZ3Zx00KNlrNhTkegxUDSgbg88Mbk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 17/32] pinctrl: spmi-mpp: Fix pmic_mpp_config_get() to be compliant
Date:   Wed, 31 Oct 2018 19:11:22 -0400
Message-Id: <20181031231137.29429-17-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231137.29429-1-sashal@kernel.org>
References: <20181031231137.29429-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 0d5b476f8f57fcb06c45fe27681ac47254f63fd2 ]

If you look at "pinconf-groups" in debugfs for ssbi-mpp you'll notice
it looks like nonsense.

The problem is fairly well described in commit 1cf86bc21257 ("pinctrl:
qcom: spmi-gpio: Fix pmic_gpio_config_get() to be compliant") and
commit 05e0c828955c ("pinctrl: msm: Fix msm_config_group_get() to be
compliant"), but it was pointed out that ssbi-mpp has the same
problem.  Let's fix it there too.

NOTE: in case it's helpful to someone reading this, the way to tell
whether to do the -EINVAL or not is to look at the PCONFDUMP for a
given attribute.  If the last element (has_arg) is false then you need
to do the -EINVAL trick.

ALSO NOTE: it seems unlikely that the values returned when we try to
get PIN_CONFIG_BIAS_PULL_UP will actually be printed since "has_arg"
is false for that one, but I guess it's still fine to return different
values so I kept doing that.  It seems like another driver (ssbi-gpio)
uses a custom attribute (PM8XXX_QCOM_PULL_UP_STRENGTH) for something
similar so maybe a future change should do that here too.

Fixes: cfb24f6ebd38 ("pinctrl: Qualcomm SPMI PMIC MPP pin controller driver")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
index 8301e600e7a8..5cd9a81a6060 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
@@ -347,13 +347,12 @@ static int pmic_mpp_config_get(struct pinctrl_dev *pctldev,
 
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
-		arg = pad->pullup == PMIC_MPP_PULL_UP_OPEN;
+		if (pad->pullup != PMIC_MPP_PULL_UP_OPEN)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
 		switch (pad->pullup) {
-		case PMIC_MPP_PULL_UP_OPEN:
-			arg = 0;
-			break;
 		case PMIC_MPP_PULL_UP_0P6KOHM:
 			arg = 600;
 			break;
@@ -368,13 +367,17 @@ static int pmic_mpp_config_get(struct pinctrl_dev *pctldev,
 		}
 		break;
 	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
-		arg = !pad->is_enabled;
+		if (pad->is_enabled)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PIN_CONFIG_POWER_SOURCE:
 		arg = pad->power_source;
 		break;
 	case PIN_CONFIG_INPUT_ENABLE:
-		arg = pad->input_enabled;
+		if (!pad->input_enabled)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PIN_CONFIG_OUTPUT:
 		arg = pad->out_value;
@@ -386,7 +389,9 @@ static int pmic_mpp_config_get(struct pinctrl_dev *pctldev,
 		arg = pad->amux_input;
 		break;
 	case PMIC_MPP_CONF_PAIRED:
-		arg = pad->paired;
+		if (!pad->paired)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
 		arg = pad->drive_strength;
-- 
2.17.1

