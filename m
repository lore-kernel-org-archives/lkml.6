Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72578ECDE5F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFAB20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VTr9miTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFAB20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731640AbeGYXmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:42:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41876 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbeGYXmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:42:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id z8-v6so6187935pgu.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GWZK7b9lm024T3/GSjJUtOLt5Sv+N+aSacDYyJvd2YQ=;
        b=VTr9miTTfbJ4sDN7muGudDUIwoiT5H1w/3UBMvlWD1K1g9tisuV60ZNlkQjOzEz0qa
         7ozj5gaxq3dFtZ1560Fg6x3ztcJRYnNzm/374ch27YCAMhGkW4w7/ePpAmB6QhLsa7g3
         VRjfZOk9mRcVEt2c5r1PxBP00XXyjcvcXPoLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GWZK7b9lm024T3/GSjJUtOLt5Sv+N+aSacDYyJvd2YQ=;
        b=Yr8ponACaWkkx4xo7WspaDd5lXHO/HHbOoU4086ioTQhvj4AzwUtaraELe/vnDnKCh
         HSWFOSdHmYv2OK7ae10JnFcWcR2kNIQ/b9cx6HtICXB7EGG3xylf2x4BvHLUOd7uLYxL
         BZY2g8BmImGGWJVQegM4MCa2PfE1wn4ZawwcrUb6dn+y/X3yCUmYCGhTqEiAFj61tZk+
         tBW9dVfMWgrFKlAD7xt+/JzTDNWjljhvr5t745ESrDVv+eKZ/erZSo1peebXLhZMYbaq
         WznN0ladB3vpcyjM5o/KOKV8cMMp1nfcdVnzSvMe6HzCJuLvQ9149tGqJGM83mAENmD1
         r6+w==
X-Gm-Message-State: AOUpUlG++cTtxVnUJt8f4uZhpxkWXdmGYP8c6a7HLEhFdRtdTRTiDLW4
        vJlp7gvXqBtD/9qMqI5Ha/rZVQ==
X-Google-Smtp-Source: AAOMgpdVI3/vwA1jwld8k23Nkq39S0/+Ft5EaeUHNQKq6G48WIWizq7P/ShbOYvWRgUQHhoLSJkayg==
X-Received: by 2002:a62:9cd7:: with SMTP id u84-v6mr24051324pfk.90.1532557745571;
        Wed, 25 Jul 2018 15:29:05 -0700 (PDT)
Received: from swboyd.mtv.corp.google.com ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id o21-v6sm23839234pfa.54.2018.07.25.15.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 15:29:05 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH v2 3/3] pinctrl: msm: Configure interrupts as input and gpio mode
Date:   Wed, 25 Jul 2018 15:29:00 -0700
Message-Id: <20180725222900.33231-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180725222900.33231-1-swboyd@chromium.org>
References: <20180725222900.33231-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When requesting a gpio as an interrupt, we should make sure to mux the
pin as the GPIO function and configure it to be an input so that various
functions or output signals don't affect the interrupt state of the pin.
So far, we've relied on pinmux configurations in DT to handle this, but
let's explicitly configure this in the code so that DT implementers
don't have to get this part right.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v1:
 * None

 drivers/pinctrl/qcom/pinctrl-msm.c | 37 ++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 1d7367149268..f2744092a4bf 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -827,6 +827,41 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 	return 0;
 }
 
+static int msm_gpio_irq_reqres(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
+	int ret;
+
+	if (!try_module_get(gc->owner))
+		return -ENODEV;
+
+	ret = msm_pinmux_request_gpio(pctrl->pctrl, NULL, d->hwirq);
+	if (ret)
+		goto out;
+	msm_gpio_direction_input(gc, d->hwirq);
+
+	if (gpiochip_lock_as_irq(gc, d->hwirq)) {
+		dev_err(gc->parent,
+			"unable to lock HW IRQ %lu for IRQ\n",
+			d->hwirq);
+		ret = -EINVAL;
+		goto out;
+	}
+	return 0;
+out:
+	module_put(gc->owner);
+	return ret;
+}
+
+static void msm_gpio_irq_relres(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+
+	gpiochip_unlock_as_irq(gc, d->hwirq);
+	module_put(gc->owner);
+}
+
 static void msm_gpio_irq_handler(struct irq_desc *desc)
 {
 	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
@@ -925,6 +960,8 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	pctrl->irq_chip.irq_ack = msm_gpio_irq_ack;
 	pctrl->irq_chip.irq_set_type = msm_gpio_irq_set_type;
 	pctrl->irq_chip.irq_set_wake = msm_gpio_irq_set_wake;
+	pctrl->irq_chip.irq_request_resources = msm_gpio_irq_reqres;
+	pctrl->irq_chip.irq_release_resources = msm_gpio_irq_relres;
 
 	ret = gpiochip_add_data(&pctrl->chip, pctrl);
 	if (ret) {
-- 
Sent by a computer through tubes

