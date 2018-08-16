Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEC8C43615
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB8621477
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I9NIiuBd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB8621477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeHPXHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:07:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43077 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeHPXHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:07:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id j26-v6so2482715pfi.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 13:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iMKRdNeILqQLW5HhEx3LzFsQ/qoXER6KwX/yBEgkUV4=;
        b=I9NIiuBdiyT0I+OVxMX0AfxDxGCyzDOqLTMUfKmocO74LqkxshVEHhB0au3mLdwZCR
         sIr89wpFOPPYre36P2oDeoI+Uytin9uGCAZCN+k7T/CsCRxz2JGsp0stTmZH1BJ1qYD2
         FkflIQ2zWJ0EP4Tl9ibBcYen1QkKoSUTJ7IUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iMKRdNeILqQLW5HhEx3LzFsQ/qoXER6KwX/yBEgkUV4=;
        b=VwG6cYGy19CrjlRlpxHgH0QtjrlVmI3Y2q4DMidqFaMVo4BCQXCbIuTUiCLfE+rDmM
         rcNV4WmXTXud4JYnpacbNdT0/pFK4QdkvdkbcV6A3lIfMIHOL2a56EhxBOjoN6A1X3U8
         rovYfEsaRw/8/3J45tMUFMPIvNY3CTFrIvoIAkmd8tthzNjLuBzETXBW3AZ5zMKFzJE1
         jzvhdslNy3ydCSy+38K8yzfq2QOND0oB+v1tT653uc/3/+w8FOgeAkQsA0J9jasYEbPR
         sO5qaL5xfGL1NfrL7RM/LxIgu13w4fmOVMFXNwZ+arwkDp2cRCY/07H9949HTT5VBSHH
         odmw==
X-Gm-Message-State: AOUpUlFXQpWtBk9QwMoIH1+8TAJ+b9RITfQUu7UCBOdKxG961dm1kf/V
        cvBZIy9Y9LBgt3BgVK/jiltGV7xL4xD3NA==
X-Google-Smtp-Source: AA+uWPxNu4xiDO7E4q/qeSaIVrDmeyn1KulQm4yAErtJqJsDZFJ1kwl9jI7Vb2ACi6ufp7T0iRLeoA==
X-Received: by 2002:a63:e914:: with SMTP id i20-v6mr30144803pgh.10.1534450012425;
        Thu, 16 Aug 2018 13:06:52 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id v6-v6sm234958pfa.28.2018.08.16.13.06.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 13:06:52 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH v3 3/3] pinctrl: msm: Configure interrupts as input and gpio mode
Date:   Thu, 16 Aug 2018 13:06:48 -0700
Message-Id: <20180816200648.90458-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
In-Reply-To: <20180816200648.90458-1-swboyd@chromium.org>
References: <20180816200648.90458-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 drivers/pinctrl/qcom/pinctrl-msm.c | 37 ++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 793504057ad0..defed34d32b0 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -837,6 +837,41 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
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
@@ -935,6 +970,8 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	pctrl->irq_chip.irq_ack = msm_gpio_irq_ack;
 	pctrl->irq_chip.irq_set_type = msm_gpio_irq_set_type;
 	pctrl->irq_chip.irq_set_wake = msm_gpio_irq_set_wake;
+	pctrl->irq_chip.irq_request_resources = msm_gpio_irq_reqres;
+	pctrl->irq_chip.irq_release_resources = msm_gpio_irq_relres;
 
 	ret = gpiochip_add_data(&pctrl->chip, pctrl);
 	if (ret) {
-- 
Sent by a computer through tubes

