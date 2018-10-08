Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA7DC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8E22087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hp0/otqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8E22087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbeJIBt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:49:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbeJIBt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:49:56 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BD712064A;
        Mon,  8 Oct 2018 18:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023812;
        bh=OqqoSVfa8gdx3SKyGl79WrQNR8YrG8WBk0rrx98J6FM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hp0/otqJIgactjRfdziTE0+eaJryYZ8rHFoZreA/JkFZ8vqqkFRhpDwV3O0TJF+ys
         hYunWsxhgy+VXN1UTkKKorpNNivZYnfDeBIv6FNGS/fmqNnXzCVQpJKk0qviD3k8VQ
         WNQJzzqEYBt/wD4Xgv2mnDWUd/XcyUqkwwzZZSeI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 093/113] pinctrl: msm: Really mask level interrupts to prevent latching
Date:   Mon,  8 Oct 2018 20:31:34 +0200
Message-Id: <20181008175536.405502473@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Boyd <swboyd@chromium.org>

[ Upstream commit b55326dc969ea2d704a008d9a97583b128f54f4f ]

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

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -577,6 +577,29 @@ static void msm_gpio_irq_mask(struct irq
 	spin_lock_irqsave(&pctrl->lock, flags);
 
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
 
@@ -598,6 +621,7 @@ static void msm_gpio_irq_unmask(struct i
 	spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = readl(pctrl->regs + g->intr_cfg_reg);
+	val |= BIT(g->intr_raw_status_bit);
 	val |= BIT(g->intr_enable_bit);
 	writel(val, pctrl->regs + g->intr_cfg_reg);
 


