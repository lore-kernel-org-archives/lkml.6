Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE6BC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6511B20833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d5waiVkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6511B20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbeGYXmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:42:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35502 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731576AbeGYXmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:42:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6-v6so6202652pgv.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ink+Zn8JKKzqrmjhPVKUxo0wTebG1Ak/9NW4SCv+NEs=;
        b=d5waiVktb7Skwo+wZNY5Gu3m9T6CTmlCMM1asro2WMbqNmst/sXeI5axBsr3BRpBFM
         7k4V4/j/7gIrAqRKTsFsnZaviZ/v2SY8CBSIOanvpeUNOka7HopjreorUONwHhx0BSRa
         V6nNctLVYwWXCi0h8ksFE1aF386LzWzz0fJro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ink+Zn8JKKzqrmjhPVKUxo0wTebG1Ak/9NW4SCv+NEs=;
        b=M2HV8pv4DQ+BO/GaZY/4Y70KZDelZEyn7b/fKDnUPgUORJCyJ6hF7yYtxuPA5lPS1D
         Ad+zF56zIDJJ9lnhX9QEvvrAk6jt50IZul6JqHa9XSQj6iYBh/v0K/AzK6hcPkZVwATY
         umJST7s3PDgVSCditMJwOmT66v7bu7Sj45Z8jHbH2FCDwL7rGsc6M28nAYXN7YH9DAYy
         8beiJCKfKSTYNeu7TSEBI/T+2bcApf9zIop90sp92CHyxn2x5T1jGD+g3Fd2eZku472J
         NgvHUjXF2FUxVp1aRrMfs3doPeA/LGjHGRTOyzA2tJpTSs32i4sKCKTdly59FawYNj8B
         oeVw==
X-Gm-Message-State: AOUpUlHUvF/kFnvK8bQe4+oWIhzcEeBxwiXQgm8WNFIqp4QW5badfjRB
        5XEv6Tf5JlNgx1e5z25effxWwHgV9zFCLw==
X-Google-Smtp-Source: AAOMgpfrezkXI2QKska/+IpXiR8SnBknmM6lpJPDhofAwAKPOJUysXllMOIDO48GEoEOj33pIPZogw==
X-Received: by 2002:a62:669b:: with SMTP id s27-v6mr21979355pfj.224.1532557744045;
        Wed, 25 Jul 2018 15:29:04 -0700 (PDT)
Received: from swboyd.mtv.corp.google.com ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id o21-v6sm23839234pfa.54.2018.07.25.15.29.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 15:29:03 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH v2 1/3] pinctrl: msm: Really mask level interrupts to prevent latching
Date:   Wed, 25 Jul 2018 15:28:58 -0700
Message-Id: <20180725222900.33231-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180725222900.33231-1-swboyd@chromium.org>
References: <20180725222900.33231-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt controller hardware in this pin controller has two status
enable bits. The first "normal" status enable bit enables or disables
the summary interrupt line being raised when a gpio interrupt triggers
and the "raw" status enable bit allows or prevents the hardware from
latching an interrupt into the status register for a gpio interrupt.
Currently we just toggle the "normal" status enable bit in the mask and
unmask ops so that the summary irq interrupt going to the CPU's
interrupt controller doesn't trigger for the masked gpio interrupt.

For a level triggered interrupt, the flow would be as follows: the pin
controller sees the interrupt, latches the status into the status
register, raises the summary irq to the CPU, summary irq handler runs
and calls handle_level_irq(), handle_level_irq() masks and acks the gpio
interrupt, the interrupt handler runs, and finally unmask the interrupt.
When the interrupt handler completes, we expect that the interrupt line
level will go back to the deasserted state so the genirq code can unmask
the interrupt without it triggering again.

If we only mask the interrupt by clearing the "normal" status enable bit
then we'll ack the interrupt but it will continue to show up as pending
in the status register because the raw status bit is enabled, the
hardware hasn't deasserted the line, and thus the asserted state latches
into the status register again. When the hardware deasserts the
interrupt the pin controller still thinks there is a pending unserviced
level interrupt because it latched it earlier. This behavior causes
software to see an extra interrupt for level type interrupts each time
the interrupt is handled.

Let's fix this by clearing the raw status enable bit for level type
interrupts so that the hardware stops latching the status of the
interrupt after we ack it. We don't do this for edge type interrupts
because it seems that toggling the raw status enable bit for edge type
interrupts causes spurious edge interrupts.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v1:
 - Squashed raw_status_bit write into same write on unmask (Doug
   Andersson)

 drivers/pinctrl/qcom/pinctrl-msm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 2155a30c282b..3970dc599092 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -634,6 +634,19 @@ static void msm_gpio_irq_mask(struct irq_data *d)
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->intr_cfg_reg);
+	/*
+	 * Leaving the RAW_STATUS_EN bit enabled causes level interrupts that
+	 * are still asserted to re-latch after we ack them. Clear the raw
+	 * status enable bit too so the interrupt can't even latch into the
+	 * hardware while it's masked, but only do this for level interrupts
+	 * because edge interrupts have a problem with the raw status bit
+	 * toggling and causing spurious interrupts.
+	 */
+	if (irqd_get_trigger_type(d) & IRQ_TYPE_LEVEL_MASK) {
+		val &= ~BIT(g->intr_raw_status_bit);
+		writel(val, pctrl->regs + g->intr_cfg_reg);
+	}
+
 	val &= ~BIT(g->intr_enable_bit);
 	writel(val, pctrl->regs + g->intr_cfg_reg);
 
@@ -655,6 +668,7 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->intr_cfg_reg);
+	val |= BIT(g->intr_raw_status_bit);
 	val |= BIT(g->intr_enable_bit);
 	writel(val, pctrl->regs + g->intr_cfg_reg);
 
-- 
Sent by a computer through tubes

