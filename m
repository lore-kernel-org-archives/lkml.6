Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E984FECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8474621486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8474621486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732902AbeIXS1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:27:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56924 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729958AbeIXS1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:27:03 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B96CC108B;
        Mon, 24 Sep 2018 12:25:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 158/173] pinctrl: qcom: spmi-gpio: Fix pmic_gpio_config_get() to be compliant
Date:   Mon, 24 Sep 2018 13:53:12 +0200
Message-Id: <20180924113126.836339475@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 1cf86bc21257a330e3af51f2a4e885f1a705f6a5 ]

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

>From a quick sample of other pinctrl drivers, it appears to be
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
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c |   32 +++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -390,31 +390,47 @@ static int pmic_gpio_config_get(struct p
 
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


