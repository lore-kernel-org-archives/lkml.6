Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463C4C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FA720693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A9VyurzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FA720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964895AbeFRUxL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:53:11 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41567 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935873AbeFRUxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:53:01 -0400
Received: by mail-pl0-f65.google.com with SMTP id w8-v6so8164799ply.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I5NNAYMHsduvLua0t1KPV2TzqrN9EGfVyHKOZyN8nH8=;
        b=A9VyurzA78i143NmDkPBA100jiJma8fFOJZFK6py3Scmo1+NEiNv9SjUOgehex42CW
         apOMfimWu+4C6Mr4eru1wR/vj9nDdJkVbmh8r8V8HmMKQJOjjvNC9b5+apOJ5T9RLN1h
         zvNjFiVBisY4yGOGBlveI+B5dKIbeKlomWDaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I5NNAYMHsduvLua0t1KPV2TzqrN9EGfVyHKOZyN8nH8=;
        b=CBrPmRTGppDeRDIvlra/FUo3rHTTE+KxTXmp9FYALLmZRRw48aC3rf+jc7FKdREgrA
         OKEkiK0jR8dCwP8Rzvq2kxkufG0j4fjD9B7CVW4lgsdZIMbci3kzuBxJvixjx9BhwZOX
         lWpcpaPMkU2wipLgIy3SUExHLuEGH8V3JTqew7vhJsH1Pm8DZLgLgan8P7TIc3fFb+x7
         WR/eTahC5Y8A/tLkX1S11S5u14kBRndPP5ZQLDH8NpSPXllKxB2azaC4iCeYyIbBgjhy
         0cq6TIIVWhkjFHFqQiA8i7s0jIvelNKiIll4UfNsZN430xKNLuRvqbiVqK0eBSmkpxR3
         2d0g==
X-Gm-Message-State: APt69E0geIUkC21ysa8/VBs9s68R432PPTvgKtwCeU/FVG1qQuEjO265
        j+2o2HjtEqxluoMHR/QiJnYXLQ==
X-Google-Smtp-Source: ADUXVKK2Zk+I6N10AjwuRvyh91NEkg7UmcdXk3bXZQBxvSzlWFdyBOffWCrxckR3Eeiu4zUZbEm9xQ==
X-Received: by 2002:a17:902:43:: with SMTP id 61-v6mr15439953pla.112.1529355180679;
        Mon, 18 Jun 2018 13:53:00 -0700 (PDT)
Received: from swboyd.mtv.corp.google.com ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id a27-v6sm27052196pfc.18.2018.06.18.13.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 13:53:00 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH 3/3] pinctrl: msm: Configure interrupts as input and gpio mode
Date:   Mon, 18 Jun 2018 13:52:55 -0700
Message-Id: <20180618205255.246104-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180618205255.246104-1-swboyd@chromium.org>
References: <20180618205255.246104-1-swboyd@chromium.org>
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
index eacfc5b85f7f..d3c107d6c05e 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -822,6 +822,41 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
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
@@ -920,6 +955,8 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	pctrl->irq_chip.irq_ack = msm_gpio_irq_ack;
 	pctrl->irq_chip.irq_set_type = msm_gpio_irq_set_type;
 	pctrl->irq_chip.irq_set_wake = msm_gpio_irq_set_wake;
+	pctrl->irq_chip.irq_request_resources = msm_gpio_irq_reqres;
+	pctrl->irq_chip.irq_release_resources = msm_gpio_irq_relres;
 
 	ret = gpiochip_add_data(&pctrl->chip, pctrl);
 	if (ret) {
-- 
Sent by a computer through tubes

