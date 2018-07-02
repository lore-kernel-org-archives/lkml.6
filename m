Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C230C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CF525187
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lPZqqXoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47CF525187
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932790AbeGBXAU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 19:00:20 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42909 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932703AbeGBXAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 19:00:06 -0400
Received: by mail-pl0-f67.google.com with SMTP id y15-v6so21411pll.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 16:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fb3Fbm94eGdLAvRXZKI+IDFsdV4vr4z71X0awRp6s3U=;
        b=lPZqqXoyf5BAcYF/S5JmRBSS47BvUis1KQmRFzveUWrxSaBk6xvA/C8IsUSM76U6m1
         BwLjLneXNNAgOblZAU3qQ2A0chTAl+kPWjbxYq89t9t0MqXV0JKQR1M/7/j6Smut/izs
         85eVFJxZIRumhAFy010jW9uV6AvsJQrG7IrNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fb3Fbm94eGdLAvRXZKI+IDFsdV4vr4z71X0awRp6s3U=;
        b=Rw4hFMIkXXYU7HObJpkHuqvTU9aRiUi2Ud/d62QIcNgpDPX9JqIZhFcJ0WBDt1Xlq1
         5AC9BdORYZNIVnoDIviBn+FXKfN7ocC6K6mS1m2uJQrfIqnr5EK5wt1C9ojRbksdAy2S
         Ez/Lr1q+sJBWB/BaeT3mL2bp8dPcf/c/KaIemC3FMdk71HYy1Q19CxQe+uXDVeVmyqva
         571Ajc6xlvbX2hvSWWQH9pTL+pr9bblyI3tM2836F0rWJXG98ZfEpD6ZwnodRwCyokTe
         UBsi+V0wcyuxTSldwJ7GGPTqn++h0Svs1vpfNYYQb7ukNTwERX9k7iS4QfCo9UQSPGqW
         sBGg==
X-Gm-Message-State: APt69E3YiwDUCZMurU4roLta+p6vWC7sbB+mQskfCse5r4oj5YXwT6jT
        F0KxzH7Zm+yaL+h+TqOq44BZCg==
X-Google-Smtp-Source: ADUXVKLoIaIUZH+A9Y0iVPP3FSKIX64a0DaSdlqNxgzL3qfURr6QlEbdC4TeDpg32Q99FCUDl9AAxw==
X-Received: by 2002:a17:902:1e4:: with SMTP id b91-v6mr27600297plb.155.1530572406178;
        Mon, 02 Jul 2018 16:00:06 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id v66-v6sm18878027pfb.84.2018.07.02.16.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 16:00:05 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     iivanov@mm-sol.com, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 3/3] pinctrl: qcom: spmi-gpio: Fix pmic_gpio_config_get() to be compliant
Date:   Mon,  2 Jul 2018 15:59:39 -0700
Message-Id: <20180702225939.109169-3-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
In-Reply-To: <20180702225939.109169-1-dianders@chromium.org>
References: <20180702225939.109169-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you do this on an sdm845 board:
  grep "" /sys/kernel/debug/pinctrl/*spmi:pmic*/pinconf-groups

...it looks like nonsense.  For every pin you see listed:
  input bias disabled, input bias high impedance, input bias pull down, input bias pull up, ...

That's because pmic_gpio_config_get() isn't complying with the rules
that pinconf_generic_dump_one() expects.  Specifically for boolean
parameters (anything with a "struct pin_config_item" where has_arg is
false) the function expects that the function should return its value
not through the "config" parameter but should return "0" if the value
is set and "-EINVAL" if the value isn't set.

Let's fix this.

From a quick sample of other pinctrl drivers, it appears to be
tradition to also return 1 through the config parameter for these
boolean parameters when they exist.  I'm not one to knock tradition,
so I'll follow tradition and return 1 in these cases.  While I'm at
it, I'll also continue searching for four leaf clovers, kocking on
wood three times, and trying not to break mirrors.

NOTE: This also fixes an apparent typo for reading
PIN_CONFIG_BIAS_DISABLE where the old driver was accidentally
using "=" instead of "==" and thus was setting some internal
state when you tried to query PIN_CONFIG_BIAS_DISABLE.  Oops.

Fixes: eadff3024472 ("pinctrl: Qualcomm SPMI PMIC GPIO pin controller driver")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 32 ++++++++++++++++++------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index 3e66e0d10010..cf82db78e69e 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -390,31 +390,47 @@ static int pmic_gpio_config_get(struct pinctrl_dev *pctldev,
 
 	switch (param) {
 	case PIN_CONFIG_DRIVE_PUSH_PULL:
-		arg = pad->buffer_type == PMIC_GPIO_OUT_BUF_CMOS;
+		if (pad->buffer_type != PMIC_GPIO_OUT_BUF_CMOS)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
-		arg = pad->buffer_type == PMIC_GPIO_OUT_BUF_OPEN_DRAIN_NMOS;
+		if (pad->buffer_type != PMIC_GPIO_OUT_BUF_OPEN_DRAIN_NMOS)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PIN_CONFIG_DRIVE_OPEN_SOURCE:
-		arg = pad->buffer_type == PMIC_GPIO_OUT_BUF_OPEN_DRAIN_PMOS;
+		if (pad->buffer_type != PMIC_GPIO_OUT_BUF_OPEN_DRAIN_PMOS)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		arg = pad->pullup == PMIC_GPIO_PULL_DOWN;
+		if (pad->pullup != PMIC_GPIO_PULL_DOWN)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PIN_CONFIG_BIAS_DISABLE:
-		arg = pad->pullup = PMIC_GPIO_PULL_DISABLE;
+		if (pad->pullup != PMIC_GPIO_PULL_DISABLE)
+			return -EINVAL;
+		arg = 1;
 		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
-		arg = pad->pullup == PMIC_GPIO_PULL_UP_30;
+		if (pad->pullup != PMIC_GPIO_PULL_UP_30)
+			return -EINVAL;
+		arg = 1;
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
-- 
2.18.0.399.gad0ab374a1-goog

