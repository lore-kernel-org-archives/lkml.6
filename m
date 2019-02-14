Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CD6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB917222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502752AbfBNQyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:54:41 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53399 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407534AbfBNQyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:54:38 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EGplDe015219;
        Thu, 14 Feb 2019 17:54:30 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qmwsumk2t-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 14 Feb 2019 17:54:30 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1EF9C31;
        Thu, 14 Feb 2019 16:54:30 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E7BE9A472;
        Thu, 14 Feb 2019 16:54:29 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 14 Feb 2019 17:54:30
 +0100
From:   Alexandre Torgue <alexandre.torgue@st.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <alexandre.torgue@st.com>
Subject: [PATCH 2/2] pinctrl: stm32: return error upon hwspinlock failure
Date:   Thu, 14 Feb 2019 17:54:25 +0100
Message-ID: <1550163266-19975-3-git-send-email-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550163266-19975-1-git-send-email-alexandre.torgue@st.com>
References: <1550163266-19975-1-git-send-email-alexandre.torgue@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return error to the caller when the hwspinlock can't get locked.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index f6279c8..0b9ff5a 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -583,8 +583,8 @@ static int stm32_pmx_get_func_groups(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
-static void stm32_pmx_set_mode(struct stm32_gpio_bank *bank,
-		int pin, u32 mode, u32 alt)
+static int stm32_pmx_set_mode(struct stm32_gpio_bank *bank,
+			      int pin, u32 mode, u32 alt)
 {
 	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
 	u32 val;
@@ -620,6 +620,8 @@ static void stm32_pmx_set_mode(struct stm32_gpio_bank *bank,
 unlock:
 	spin_unlock_irqrestore(&bank->lock, flags);
 	clk_disable(bank->clk);
+
+	return err;
 }
 
 void stm32_pmx_get_mode(struct stm32_gpio_bank *bank, int pin, u32 *mode,
@@ -676,9 +678,7 @@ static int stm32_pmx_set_mux(struct pinctrl_dev *pctldev,
 	mode = stm32_gpio_get_mode(function);
 	alt = stm32_gpio_get_alt(function);
 
-	stm32_pmx_set_mode(bank, pin, mode, alt);
-
-	return 0;
+	return stm32_pmx_set_mode(bank, pin, mode, alt);
 }
 
 static int stm32_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
@@ -688,9 +688,7 @@ static int stm32_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 	struct stm32_gpio_bank *bank = gpiochip_get_data(range->gc);
 	int pin = stm32_gpio_pin(gpio);
 
-	stm32_pmx_set_mode(bank, pin, !input, 0);
-
-	return 0;
+	return stm32_pmx_set_mode(bank, pin, !input, 0);
 }
 
 static const struct pinmux_ops stm32_pmx_ops = {
@@ -704,8 +702,8 @@ static const struct pinmux_ops stm32_pmx_ops = {
 
 /* Pinconf functions */
 
-static void stm32_pconf_set_driving(struct stm32_gpio_bank *bank,
-	unsigned offset, u32 drive)
+static int stm32_pconf_set_driving(struct stm32_gpio_bank *bank,
+				   unsigned offset, u32 drive)
 {
 	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
 	unsigned long flags;
@@ -734,6 +732,8 @@ static void stm32_pconf_set_driving(struct stm32_gpio_bank *bank,
 unlock:
 	spin_unlock_irqrestore(&bank->lock, flags);
 	clk_disable(bank->clk);
+
+	return err;
 }
 
 static u32 stm32_pconf_get_driving(struct stm32_gpio_bank *bank,
@@ -754,8 +754,8 @@ static u32 stm32_pconf_get_driving(struct stm32_gpio_bank *bank,
 	return (val >> offset);
 }
 
-static void stm32_pconf_set_speed(struct stm32_gpio_bank *bank,
-	unsigned offset, u32 speed)
+static int stm32_pconf_set_speed(struct stm32_gpio_bank *bank,
+				 unsigned offset, u32 speed)
 {
 	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
 	unsigned long flags;
@@ -784,6 +784,8 @@ static void stm32_pconf_set_speed(struct stm32_gpio_bank *bank,
 unlock:
 	spin_unlock_irqrestore(&bank->lock, flags);
 	clk_disable(bank->clk);
+
+	return err;
 }
 
 static u32 stm32_pconf_get_speed(struct stm32_gpio_bank *bank,
@@ -804,8 +806,8 @@ static u32 stm32_pconf_get_speed(struct stm32_gpio_bank *bank,
 	return (val >> (offset * 2));
 }
 
-static void stm32_pconf_set_bias(struct stm32_gpio_bank *bank,
-	unsigned offset, u32 bias)
+static int stm32_pconf_set_bias(struct stm32_gpio_bank *bank,
+				unsigned offset, u32 bias)
 {
 	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
 	unsigned long flags;
@@ -834,6 +836,8 @@ static void stm32_pconf_set_bias(struct stm32_gpio_bank *bank,
 unlock:
 	spin_unlock_irqrestore(&bank->lock, flags);
 	clk_disable(bank->clk);
+
+	return err;
 }
 
 static u32 stm32_pconf_get_bias(struct stm32_gpio_bank *bank,
@@ -896,22 +900,22 @@ static int stm32_pconf_parse_conf(struct pinctrl_dev *pctldev,
 
 	switch (param) {
 	case PIN_CONFIG_DRIVE_PUSH_PULL:
-		stm32_pconf_set_driving(bank, offset, 0);
+		ret = stm32_pconf_set_driving(bank, offset, 0);
 		break;
 	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
-		stm32_pconf_set_driving(bank, offset, 1);
+		ret = stm32_pconf_set_driving(bank, offset, 1);
 		break;
 	case PIN_CONFIG_SLEW_RATE:
-		stm32_pconf_set_speed(bank, offset, arg);
+		ret = stm32_pconf_set_speed(bank, offset, arg);
 		break;
 	case PIN_CONFIG_BIAS_DISABLE:
-		stm32_pconf_set_bias(bank, offset, 0);
+		ret = stm32_pconf_set_bias(bank, offset, 0);
 		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
-		stm32_pconf_set_bias(bank, offset, 1);
+		ret = stm32_pconf_set_bias(bank, offset, 1);
 		break;
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		stm32_pconf_set_bias(bank, offset, 2);
+		ret = stm32_pconf_set_bias(bank, offset, 2);
 		break;
 	case PIN_CONFIG_OUTPUT:
 		__stm32_gpio_set(bank, offset, arg);
-- 
2.7.4

