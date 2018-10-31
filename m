Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762D0C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BCF20854
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKTcDuSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38BCF20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbeKAI0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731043AbeKAIKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:10:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E3262084A;
        Wed, 31 Oct 2018 23:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027418;
        bh=iX8kmCH5qygupNzuPtqfHHUmFgw35uPXn0A23dRrCVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VKTcDuSqY9Um9FczPsiI4hb476kbpn7cLHCS+5GweAk7xgyg9RsKm2gmR5EqZlFZP
         WPUZQodNSdjBkp/Nhw5MGkynbSZmqtTJS5sVXLTs/YEgqg7bj51SASfInXedTpb4CA
         0etb6cpA6G+9nwHa2Nn+yv/mYBEbMqRWfaxhSAuU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 32/73] pinctrl: qcom: spmi-mpp: Fix drive strength setting
Date:   Wed, 31 Oct 2018 19:09:07 -0400
Message-Id: <20181031230948.29203-32-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230948.29203-1-sashal@kernel.org>
References: <20181031230948.29203-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

[ Upstream commit 89c68b102f13f123aaef22b292526d6b92501334 ]

It looks like we parse the drive strength setting here, but never
actually write it into the hardware to update it. Parse the setting and
then write it at the end of the pinconf setting function so that it
actually sticks in the hardware.

Fixes: 0e948042c420 ("pinctrl: qcom: spmi-mpp: Implement support for sink mode")
Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
index 418bc40df7ca..7577f133d326 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
@@ -457,7 +457,7 @@ static int pmic_mpp_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			pad->dtest = arg;
 			break;
 		case PIN_CONFIG_DRIVE_STRENGTH:
-			arg = pad->drive_strength;
+			pad->drive_strength = arg;
 			break;
 		case PMIC_MPP_CONF_AMUX_ROUTE:
 			if (arg >= PMIC_MPP_AMUX_ROUTE_ABUS4)
@@ -504,6 +504,10 @@ static int pmic_mpp_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
 	if (ret < 0)
 		return ret;
 
+	ret = pmic_mpp_write(state, pad, PMIC_MPP_REG_SINK_CTL, pad->drive_strength);
+	if (ret < 0)
+		return ret;
+
 	val = pad->is_enabled << PMIC_MPP_REG_MASTER_EN_SHIFT;
 
 	return pmic_mpp_write(state, pad, PMIC_MPP_REG_EN_CTL, val);
-- 
2.17.1

