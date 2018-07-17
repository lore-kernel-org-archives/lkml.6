Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70C0ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFF1208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KKWfBJH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AFF1208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbeGQB1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 21:27:19 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33154 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729983AbeGQB1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 21:27:19 -0400
Received: by mail-it0-f65.google.com with SMTP id y124-v6so13123803itc.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 17:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HOMDK29fJd2M035pCevcaH0e5d//9WNYEltj83IL54c=;
        b=KKWfBJH8HfRIkaio8Aw5WuUeUh3FviMTOaW7Nr/DRG0jvQJK+2mxGXxEVGAQQLAZje
         YF3vJ2xWXWgICSYThOs/NYgcRZTO/WgJQXWcyikcw90rWALw8KQRWZ+a4+IGZ4Ihe+rG
         W8daWKYmoMUyNZY79YYHWi3LAWjtp6mPC+QSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HOMDK29fJd2M035pCevcaH0e5d//9WNYEltj83IL54c=;
        b=YZXY9XS8kmuFjWSWAiwT8eiPbi9HIgoYcE3ywQr0D04DNEtHptDH4EiH6UCEALs3w+
         wNAXgP2RQkogZl7H9CPNJHELA+sdOjYTTu+jG+t6g8KVTSAqklny59rQV2QCw/jtSZsT
         SfRtlafDWVFWhAA7zN/XcZ3KaNhpHPxoerlFZWFshC/RY2D1K78RVgC8s5dYG74Xvbdl
         tFU6FyasObNfItmT0xnZyOj1pi1tBgjtZACnncZrD70VFlFnLrGTegVaTyRuDDhBRWCZ
         FGAdGLEo53WiR8P2hqiQ9AQa1QRMLQfPiKmqnyBnVQBoskfw8a1tpVEkofFJ280n6gTL
         fN9g==
X-Gm-Message-State: AOUpUlGrru7uL6/xuqKT89mXnaIKr4ADYC5HfU106TNogTOAGl0HK0l/
        OwGFJvRdxfuZhKoV+QsRW5ADjw==
X-Google-Smtp-Source: AAOMgpcDNMmeOFfXuaw0m6SMEAig4pFLtio/4dSFZEFIqq9D4c35Q+oqqD4TevhWFqsDK79rXVtv/g==
X-Received: by 2002:a02:5c07:: with SMTP id q7-v6mr15645422jab.124.1531789043194;
        Mon, 16 Jul 2018 17:57:23 -0700 (PDT)
Received: from djkurtz2.bld.corp.google.com ([2620:15c:183:0:1cfd:61a5:7215:5f9c])
        by smtp.gmail.com with ESMTPSA id b1-v6sm3635486ioh.43.2018.07.16.17.57.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 17:57:22 -0700 (PDT)
From:   Daniel Kurtz <djkurtz@chromium.org>
Cc:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        Ken Xue <Ken.Xue@amd.com>, Daniel Drake <drake@endlessm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org (open list:PIN CONTROL SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] pinctrl/amd: only handle irq if it is pending and unmasked
Date:   Mon, 16 Jul 2018 18:57:18 -0600
Message-Id: <20180717005719.258905-1-djkurtz@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD pinctrl driver demultiplexes GPIO interrupts and fires off their
individual handlers.

If one of these GPIO irqs is configured as a level interrupt, and its
downstream handler is a threaded ONESHOT interrupt, the GPIO interrupt
source is masked by handle_level_irq() until the eventual return of the
threaded irq handler.  During this time the level GPIO interrupt status
will still report as high until the actual gpio source is cleared - both
in the individual GPIO interrupt status bit (INTERRUPT_STS_OFF) and in
its corresponding "WAKE_INT_STATUS_REG" bit.

Thus, if another GPIO interrupt occurs during this time,
amd_gpio_irq_handler() will see that the (masked-and-not-yet-cleared)
level irq is still pending and incorrectly call its handler again.

To fix this, have amd_gpio_irq_handler() check for both interrupts status
and mask before calling generic_handle_irq().

Note: Is it possible that this bug was the source of the interrupt storm
on Ryzen when using chained interrupts before commit ba714a9c1dea85
("pinctrl/amd: Use regular interrupt instead of chained")?

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/pinctrl/pinctrl-amd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 04ae139671c8a8..b91db89eb9247c 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -552,7 +552,8 @@ static irqreturn_t amd_gpio_irq_handler(int irq, void *dev_id)
 		/* Each status bit covers four pins */
 		for (i = 0; i < 4; i++) {
 			regval = readl(regs + i);
-			if (!(regval & PIN_IRQ_PENDING))
+			if (!(regval & PIN_IRQ_PENDING) ||
+			    !(regval & BIT(INTERRUPT_MASK_OFF)))
 				continue;
 			irq = irq_find_mapping(gc->irq.domain, irqnr + i);
 			generic_handle_irq(irq);
-- 
2.18.0.203.gfac676dfb9-goog

