Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F22AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA8B21479
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h+Vhk2tE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA8B21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbeHPXHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:07:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32930 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeHPXHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:07:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id r64-v6so1369802pgr.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 13:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YbEgU6NoCTKY3cxZJBhRAPLasbYsKrPISCc9HR3/AbY=;
        b=h+Vhk2tEsYo3goR0+igWXENVwiGtm4Gs/UC2MQQBjDLZyCUWBgPNgkASxwrbXFN2iX
         JrRSYFqywZn9pXx1eMMDn87XJPC1tYb9NsxSep0bBOXuyICT20/lwzPcVh3op3UtzBUd
         giXD35ZtPGlyxvF+fqzwlWus+V2kJ1chErYkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YbEgU6NoCTKY3cxZJBhRAPLasbYsKrPISCc9HR3/AbY=;
        b=mYmGCC4JPgZzdA7xJn+1OtCfRDpyYPXGFrlHaX5BEcDDwT+06hyiFX7qvDSBf42zjc
         qb0yZAXjLawF/B+KhGDe8nAT+xbzsU/mKV9EsiXenqqlvbZ0MKNMx76VfQ8BCWskVmVy
         06czatH2NWz8jEYUht/pZUUGz6Zf7tLG66Ho2RpD3f8MUKOZcsweDHALdIiRxgojhmma
         vCFVSUtIGvvxTQCsSHhSkZyjl9cCJJoNZpqF2YcEWZHq748pddHeR+Wo2078V8LKGK9k
         19MidV6eRsOVCrVcOe5fYF6FT1TzcdYvjRHT/h5vsZ8E/HoRzxtE2t1lrTqguyjFfvKV
         GHMg==
X-Gm-Message-State: AOUpUlEecqJP6kI+nhmQdOFGUx2FBQzHFjdMVEOaUaZXsyMA0BnekOh6
        +5mBW0roRXysHTyf3XaXhKrJ3g==
X-Google-Smtp-Source: AA+uWPzVWDuyHXUKSv4m9HcK1zLjWV8ebyRpm5dzOU0VflYCFinfSKC/G2mukHkTY9ezO9EmqEGpNQ==
X-Received: by 2002:a65:6455:: with SMTP id s21-v6mr184200pgv.25.1534450010878;
        Thu, 16 Aug 2018 13:06:50 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id v6-v6sm234958pfa.28.2018.08.16.13.06.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 13:06:50 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH v3 1/3] pinctrl: msm: Really mask level interrupts to prevent latching
Date:   Thu, 16 Aug 2018 13:06:46 -0700
Message-Id: <20180816200648.90458-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
In-Reply-To: <20180816200648.90458-1-swboyd@chromium.org>
References: <20180816200648.90458-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 drivers/pinctrl/qcom/pinctrl-msm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 2155a30c282b..5d72ffad32c2 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -634,6 +634,29 @@ static void msm_gpio_irq_mask(struct irq_data *d)
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->intr_cfg_reg);
+	/*
+	 * There are two bits that control interrupt forwarding to the CPU. The
+	 * RAW_STATUS_EN bit causes the level or edge sensed on the line to be
+	 * latched into the interrupt status register when the hardware detects
+	 * an irq that it's configured for (either edge for edge type or level
+	 * for level type irq). The 'non-raw' status enable bit causes the
+	 * hardware to assert the summary interrupt to the CPU if the latched
+	 * status bit is set. There's a bug though, the edge detection logic
+	 * seems to have a problem where toggling the RAW_STATUS_EN bit may
+	 * cause the status bit to latch spuriously when there isn't any edge
+	 * so we can't touch that bit for edge type irqs and we have to keep
+	 * the bit set anyway so that edges are latched while the line is masked.
+	 *
+	 * To make matters more complicated, leaving the RAW_STATUS_EN bit
+	 * enabled all the time causes level interrupts to re-latch into the
+	 * status register because the level is still present on the line after
+	 * we ack it. We clear the raw status enable bit during mask here and
+	 * set the bit on unmask so the interrupt can't latch into the hardware
+	 * while it's masked.
+	 */
+	if (irqd_get_trigger_type(d) & IRQ_TYPE_LEVEL_MASK)
+		val &= ~BIT(g->intr_raw_status_bit);
+
 	val &= ~BIT(g->intr_enable_bit);
 	writel(val, pctrl->regs + g->intr_cfg_reg);
 
@@ -655,6 +678,7 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->intr_cfg_reg);
+	val |= BIT(g->intr_raw_status_bit);
 	val |= BIT(g->intr_enable_bit);
 	writel(val, pctrl->regs + g->intr_cfg_reg);
 
-- 
Sent by a computer through tubes

