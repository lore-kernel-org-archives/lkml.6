Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7945FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147DC20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R4C3aQsa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147DC20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeHaFDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:03:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46140 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeHaFDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:03:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id b129-v6so4645872pga.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 17:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xiUYqLA8pwRZZ+8OgMWkETx5wfqrEJiqGUlOhx1CtX4=;
        b=R4C3aQsaa0CfGeboDyrGQHh0hreGPRhiqOYdjRIuGW3YRpUaW8NX8AnbPAe7UYzueu
         tbD9TMscgkbIB7b4W4ZaAGhXB56Rkt0t8LR7Y0+IVx4QtdtgGGkoAr/MmNZLOBZS8vZe
         KSqVaOP5XcpjmXknrKLn/eLN8uJvvmqcu1Fbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xiUYqLA8pwRZZ+8OgMWkETx5wfqrEJiqGUlOhx1CtX4=;
        b=HxypP2rf3pO8t9UZ2NHEZyGbMBoKukIuugH36AnV3NZZsNi0KbI5zx9BdW6ns6EIPA
         0cJlTf1IvNYrT20ISGsn7HdlDemNtiAlVyR57PANODxwFo7pPaisYjitIW8c5G5AXAmP
         8tmq6hMfA3syyP5nK9ctbMNFd6XnlYxTumK1DM4TAvP8B/Dz0zSUfLqlafFrwSm9gPkd
         lZ2SBmxY2nm+TZCcUbZ2HpCYE5aokRZRrXWB0OAIH05/8UHtls1H017P5F8LUCSNFv8e
         9JEFAM18XObMQFPJ8aKuXMGVEjGLwzLzpvgz40tFKi8NqKWCeugogVkQ4Te/H7KwnGAs
         Cdkg==
X-Gm-Message-State: APzg51DLZJZ7Uu+3lRrj5TgUmzpQXzCxOgoe1ZloTqDkzBloJGmBpZbu
        nxdjU26RsuwgDnXWvVpQAD6AvA==
X-Google-Smtp-Source: ANB0VdacGlOtTDLiMZegyPCyiJ5f2sTdSi4Eot/EhwLiHmHlS0i2wzaDC1UFfKP2eRCf6fBWF/WyGg==
X-Received: by 2002:a63:8442:: with SMTP id k63-v6mr12002531pgd.388.1535677133443;
        Thu, 30 Aug 2018 17:58:53 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id 83-v6sm17929914pft.40.2018.08.30.17.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 17:58:52 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH] pinctrl: qcom: spmi-mpp: Fix drive strength setting
Date:   Thu, 30 Aug 2018 17:58:52 -0700
Message-Id: <20180831005852.156465-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like we parse the drive strength setting here, but never
actually write it into the hardware to update it. Parse the setting and
then write it at the end of the pinconf setting function so that it
actually sticks in the hardware.

Fixes: 0e948042c420 ("pinctrl: qcom: spmi-mpp: Implement support for sink mode")
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
index 6556dbeae65e..1793a4d05e15 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
@@ -455,7 +455,7 @@ static int pmic_mpp_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			pad->dtest = arg;
 			break;
 		case PIN_CONFIG_DRIVE_STRENGTH:
-			arg = pad->drive_strength;
+			pad->drive_strength = arg;
 			break;
 		case PMIC_MPP_CONF_AMUX_ROUTE:
 			if (arg >= PMIC_MPP_AMUX_ROUTE_ABUS4)
@@ -502,6 +502,10 @@ static int pmic_mpp_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
 	if (ret < 0)
 		return ret;
 
+	ret = pmic_mpp_write(state, pad, PMIC_MPP_REG_SINK_CTL, pad->drive_strength);
+	if (ret < 0)
+		return ret;
+
 	val = pad->is_enabled << PMIC_MPP_REG_MASTER_EN_SHIFT;
 
 	return pmic_mpp_write(state, pad, PMIC_MPP_REG_EN_CTL, val);
-- 
Sent by a computer through tubes

