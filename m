Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48C4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DC92082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cNnyFqmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DC92082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbeH3T1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:27:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36611 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbeH3T1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:27:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so4047472pfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 08:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2nCfGAEYg662uKFkRNSQGhytc709+nZ6xKaZn3HXieI=;
        b=cNnyFqmuwkGeBkME7G9FJHJtK7iTzwGGqAlNIyPBrFZdmHSr7FjvQU9JfvklfMSpH2
         LTFer7BF06/LWnuPzdpsdroxQKBR+GQDvPItXB9Z9kB0J32eLymElOKdHchylF+bIr3m
         thdpeHGxXVQTDWPVn+0D0BoFsnUK3ycj8pYo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2nCfGAEYg662uKFkRNSQGhytc709+nZ6xKaZn3HXieI=;
        b=a0twXkc6ytKcPnKnokfc8fAe9VFoMC4+CcM4qcTDzqzD6wUCbbo/HdnOXvg5wOJ6xO
         psJyV7C7l4ojILzqilXr/UhCGi8pz6hC1gkSvHGj7/3uUhgiruP2bGR6mZZpIZvUqahW
         4NAvyk4x9pKjD8/+OxcP6Uwt+oAnzmo7+1TT4XyJcldEeL44BQYM9VI+S/hAV9hXxKWz
         frpC9jHNQ9DpziKaCTQhw6Hac0R6jt155oZxrn2qeTlQVzTRQMFj+OZOxdBXv3Y4ClrJ
         46C+jzMn7N8f+tKAbBwmU7wZUu6G4P0UuwQLM8aab9JY4QG+B+4wi3vF2S+gJSxSbfpf
         Fjsg==
X-Gm-Message-State: APzg51CYaVZYUAEqmHUpiU04CmUpFC3Qfe3PWvKambqoVVkYKUZ+kpWQ
        oN+cvbQh/DulRmLLdTvRU3ZcnQ==
X-Google-Smtp-Source: ANB0VdbR7a40ZCk3tK8x72d7bjxEUcB/WwX2/a89Iu5pN3YvtcWhtKI6LpWnfjZIG1PywL01xoM6Tw==
X-Received: by 2002:a65:4384:: with SMTP id m4-v6mr10145903pgp.265.1535642664362;
        Thu, 30 Aug 2018 08:24:24 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id d9-v6sm24143920pfb.86.2018.08.30.08.24.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:24:23 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     "Ivan T . Ivanov" <iivanov@mm-sol.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [RFT PATCH 1/2] pinctrl: ssbi-gpio: Fix pm8xxx_pin_config_get() to be compliant
Date:   Thu, 30 Aug 2018 08:23:38 -0700
Message-Id: <20180830152340.242249-2-dianders@chromium.org>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
In-Reply-To: <20180830152340.242249-1-dianders@chromium.org>
References: <20180830152340.242249-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you look at "pinconf-groups" in debugfs for ssbi-gpio you'll notice
it looks like nonsense.

The problem is fairly well described in commit 1cf86bc21257 ("pinctrl:
qcom: spmi-gpio: Fix pmic_gpio_config_get() to be compliant") and
commit 05e0c828955c ("pinctrl: msm: Fix msm_config_group_get() to be
compliant"), but it was pointed out that ssbi-gpio has the same
problem.  Let's fix it there too.

Fixes: b4c45fe974bc ("pinctrl: qcom: ssbi: Family A gpio & mpp drivers")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c | 28 ++++++++++++++++++------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
index f53e32a9d8fc..0e153bae322e 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
@@ -260,22 +260,32 @@ static int pm8xxx_pin_config_get(struct pinctrl_dev *pctldev,
 
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
@@ -290,10 +300,14 @@ static int pm8xxx_pin_config_get(struct pinctrl_dev *pctldev,
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
2.19.0.rc0.228.g281dcd1b4d0-goog

