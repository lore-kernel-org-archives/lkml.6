Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA58ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCE5208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCE5208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbeGPNZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 09:25:20 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44971 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728734AbeGPNZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 09:25:20 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6GCrs2b030830;
        Mon, 16 Jul 2018 14:57:42 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2k85recaae-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 16 Jul 2018 14:57:42 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C579131;
        Mon, 16 Jul 2018 12:57:41 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 903F1E25;
        Mon, 16 Jul 2018 12:57:41 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 16 Jul 2018 14:57:41
 +0200
From:   Alexandre Torgue <alexandre.torgue@st.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <amelie.delaunay@st.com>
Subject: [PATCH 2/2] pinctrl: stm32: check node status before new gpio bank registering
Date:   Mon, 16 Jul 2018 14:57:37 +0200
Message-ID: <1531745857-5561-3-git-send-email-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531745857-5561-1-git-send-email-alexandre.torgue@st.com>
References: <1531745857-5561-1-git-send-email-alexandre.torgue@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-16_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register a new GPIO bank only if GPIO bank node is enabled. This patch also
adds checks on ranges which are defined only if a bank is registered.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index eb6ae14..111225e 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -639,6 +639,11 @@ static int stm32_pmx_set_mux(struct pinctrl_dev *pctldev,
 	}
 
 	range = pinctrl_find_gpio_range_from_pin(pctldev, g->pin);
+	if (!range) {
+		dev_err(pctl->dev, "No gpio range defined.\n");
+		return -EINVAL;
+	}
+
 	bank = gpiochip_get_data(range->gc);
 	pin = stm32_gpio_pin(g->pin);
 
@@ -807,11 +812,17 @@ static int stm32_pconf_parse_conf(struct pinctrl_dev *pctldev,
 		unsigned int pin, enum pin_config_param param,
 		enum pin_config_param arg)
 {
+	struct stm32_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
 	struct pinctrl_gpio_range *range;
 	struct stm32_gpio_bank *bank;
 	int offset, ret = 0;
 
 	range = pinctrl_find_gpio_range_from_pin(pctldev, pin);
+	if (!range) {
+		dev_err(pctl->dev, "No gpio range defined.\n");
+		return -EINVAL;
+	}
+
 	bank = gpiochip_get_data(range->gc);
 	offset = stm32_gpio_pin(pin);
 
@@ -893,6 +904,9 @@ static void stm32_pconf_dbg_show(struct pinctrl_dev *pctldev,
 	bool val;
 
 	range = pinctrl_find_gpio_range_from_pin_nolock(pctldev, pin);
+	if (!range)
+		return;
+
 	bank = gpiochip_get_data(range->gc);
 	offset = stm32_gpio_pin(pin);
 
@@ -1173,7 +1187,7 @@ int stm32_pctl_probe(struct platform_device *pdev)
 		return PTR_ERR(pctl->pctl_dev);
 	}
 
-	for_each_child_of_node(np, child)
+	for_each_available_child_of_node(np, child)
 		if (of_property_read_bool(child, "gpio-controller"))
 			banks++;
 
@@ -1186,7 +1200,7 @@ int stm32_pctl_probe(struct platform_device *pdev)
 	if (!pctl->banks)
 		return -ENOMEM;
 
-	for_each_child_of_node(np, child) {
+	for_each_available_child_of_node(np, child) {
 		if (of_property_read_bool(child, "gpio-controller")) {
 			ret = stm32_gpiolib_register_bank(pctl, child);
 			if (ret)
-- 
2.7.4

