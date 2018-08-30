Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0234C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89DF2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MbiXVEq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89DF2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeH3T1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:27:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42324 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbeH3T1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:27:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id g23-v6so3985076plq.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 08:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nfd4mgtcfrWuh22yEBdlW/suOzMsLpXBjQSAKha/OE8=;
        b=MbiXVEq+i13aoquXjjTGCZnWQHk1k32+UoTFmiQkG0SwvaoVTTFuy7iiMOO7QVZUvD
         tDHnN/Xv5apiKL3oV7GZUF+WhUw4AecOSzg7tatH05erHWPfcVyPN5Js8En9Sj2e3C3e
         jplxzgp5tf0Cug5BvhqzRhLVAgHBBhVcHIzXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nfd4mgtcfrWuh22yEBdlW/suOzMsLpXBjQSAKha/OE8=;
        b=uTUNS/qC3zqwCW20bn2qFA1Fk/gckqxOj4B/se69SugfsYPc0y/J+/Q0GHFQKeEbHB
         azcqMuEzmBAt2ybYuljfGvgppW+cn88s0qLULhZiPvu6cnllrXsqom7BntXjk6k/jWK9
         Ea5J/bKK/LzPn2aIQdd61ZsVSxmyd3RTmwCCIg5gOVFwON0MnI/xIrdhCOWByY3/yXF8
         xKBUdsCnvpA3zigeW5Gm58iJRYUxtz4UtB2esbHuLCKrjOifqLd2+lbSPv0YpdmDNK3M
         7CQ5nR+xe+C+wY0duOu4g2B3zZW160iSdC8Zv3917L0nsDfXeiEUcOnCB09RA9gh5qiX
         kEBA==
X-Gm-Message-State: APzg51AQ7qAw10g5Y42LA2qZxZwr+AfcTNTkGC+KPUEYA/TdB+PGmCC/
        h7SCzGyFwa+zduO/Qry9F618xQ==
X-Google-Smtp-Source: ANB0VdbjCrq5fggCLa8OR9CaTM/rlrtswX3LqIdx+rvk+VNm4xUeezY4xxgrfgKcS/gZnfWQyce03w==
X-Received: by 2002:a17:902:900c:: with SMTP id a12-v6mr10735370plp.61.1535642665656;
        Thu, 30 Aug 2018 08:24:25 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id d9-v6sm24143920pfb.86.2018.08.30.08.24.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:24:24 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     "Ivan T . Ivanov" <iivanov@mm-sol.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [RFT PATCH 2/2] pinctrl: spmi-mpp: Fix pmic_mpp_config_get() to be compliant
Date:   Thu, 30 Aug 2018 08:23:39 -0700
Message-Id: <20180830152340.242249-3-dianders@chromium.org>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
In-Reply-To: <20180830152340.242249-1-dianders@chromium.org>
References: <20180830152340.242249-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---

 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
index 6556dbeae65e..ce2950ffd525 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
@@ -343,13 +343,12 @@ static int pmic_mpp_config_get(struct pinctrl_dev *pctldev,
 
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
@@ -364,13 +363,17 @@ static int pmic_mpp_config_get(struct pinctrl_dev *pctldev,
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
@@ -382,7 +385,9 @@ static int pmic_mpp_config_get(struct pinctrl_dev *pctldev,
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
2.19.0.rc0.228.g281dcd1b4d0-goog

