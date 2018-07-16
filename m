Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A28DECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2407208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2407208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbeGPNZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 09:25:23 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:25073 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729422AbeGPNZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 09:25:22 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6GCs3Tg030866;
        Mon, 16 Jul 2018 14:57:41 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2k85recaab-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 16 Jul 2018 14:57:41 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B68CC31;
        Mon, 16 Jul 2018 12:57:40 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8CF3CE22;
        Mon, 16 Jul 2018 12:57:40 +0000 (GMT)
Received: from localhost (10.75.127.46) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 16 Jul 2018 14:57:40
 +0200
From:   Alexandre Torgue <alexandre.torgue@st.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <amelie.delaunay@st.com>
Subject: [PATCH 1/2] pinctrl: stm32: fix bank io port number
Date:   Mon, 16 Jul 2018 14:57:36 +0200
Message-ID: <1531745857-5561-2-git-send-email-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531745857-5561-1-git-send-email-alexandre.torgue@st.com>
References: <1531745857-5561-1-git-send-email-alexandre.torgue@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-16_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the exti line is not in line with the bank number (that is the case
when there is an hole between two banks, for example GPIOK and then GPIOZ),
use "st,bank-ioport" DT property to get the right exti line.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
index 9a06e1f..60c678a 100644
--- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
@@ -55,6 +55,8 @@ Optional properties:
    NOTE: If "gpio-ranges" is used for a gpio controller, all gpio-controller
    have to use a "gpio-ranges" entry.
    More details in Documentation/devicetree/bindings/gpio/gpio.txt.
+ - st,bank-ioport: should correspond to the EXTI IOport selection (EXTI line
+   used to select GPIOs as interrupts).
 
 Example 1:
 #include <dt-bindings/pinctrl/stm32f429-pinfunc.h>
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index dfed609..eb6ae14 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -73,6 +73,7 @@ struct stm32_gpio_bank {
 	struct fwnode_handle *fwnode;
 	struct irq_domain *domain;
 	u32 bank_nr;
+	u32 bank_ioport_nr;
 };
 
 struct stm32_pinctrl {
@@ -298,7 +299,7 @@ static int stm32_gpio_domain_activate(struct irq_domain *d,
 	struct stm32_gpio_bank *bank = d->host_data;
 	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
 
-	regmap_field_write(pctl->irqmux[irq_data->hwirq], bank->bank_nr);
+	regmap_field_write(pctl->irqmux[irq_data->hwirq], bank->bank_ioport_nr);
 	return 0;
 }
 
@@ -948,6 +949,7 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl,
 	struct device_node *np)
 {
 	struct stm32_gpio_bank *bank = &pctl->banks[pctl->nbanks];
+	int bank_ioport_nr;
 	struct pinctrl_gpio_range *range = &bank->range;
 	struct of_phandle_args args;
 	struct device *dev = pctl->dev;
@@ -998,12 +1000,17 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl,
 		pinctrl_add_gpio_range(pctl->pctl_dev,
 				       &pctl->banks[bank_nr].range);
 	}
+
+	if (of_property_read_u32(np, "st,bank-ioport", &bank_ioport_nr))
+		bank_ioport_nr = bank_nr;
+
 	bank->gpio_chip.base = bank_nr * STM32_GPIO_PINS_PER_BANK;
 
 	bank->gpio_chip.ngpio = npins;
 	bank->gpio_chip.of_node = np;
 	bank->gpio_chip.parent = dev;
 	bank->bank_nr = bank_nr;
+	bank->bank_ioport_nr = bank_ioport_nr;
 	spin_lock_init(&bank->lock);
 
 	/* create irq hierarchical domain */
-- 
2.7.4

