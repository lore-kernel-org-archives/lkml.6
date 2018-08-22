Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33549C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09CE208A6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WJj8ZFWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09CE208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbeHVUXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 16:23:39 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:46931 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbeHVUXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 16:23:38 -0400
Received: by mail-io0-f193.google.com with SMTP id y12-v6so1958957ioj.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 09:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JCs5Sx1fik6lGC0hcEC4hRDOKM55Vf7Nttmgh+3Tuag=;
        b=WJj8ZFWSsZb5/zLo5ToMMXHFJObIkWRqpKm3M8HXYCFpnKgmtB6uZ31iBSc2BgBCWe
         B0PPxga3556wNVqw8xd3eVx2+uLufW7REEmurwnC/PtQeOzx3z9m2DgDsLWGY393Z0zY
         K99MQ2ADXj5Tf5N3II7MKWUKvhjOsBPDogOR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JCs5Sx1fik6lGC0hcEC4hRDOKM55Vf7Nttmgh+3Tuag=;
        b=hMwkY89/8r+zhQuryHmHb+FaoU/neyu6f+CuguFebSzVdLWtway9OaZ/whywb13Th9
         qOZVcyUZvuDoIw0bq99DKCKcLbdBG8w2yefXKbmq7TcieQwhbi2rxGuy4RnOnA8UgjGj
         IuqFQ98rXSq2X4UjKCa5NSRqH/UTRk158aLPbayJSzVrBOH9MamWT1eZBV8qy5Z6WNYC
         FzxNbfcJOcg7HYAAvwHUjr30FuUGkzIuCzqBMWrJAgpj68edkj+Xa33OM8GrGLw5XiDc
         Kejb6Jj6p7r63mtmpaVHvrshpdqpSvX4zXINMkFNTGdQEYeJEh0roEhd7P8HTCf+CPNa
         GNIg==
X-Gm-Message-State: APzg51BHIaMDvsEQrf1jjsGa4/I+t9DS8cH+wkwBx1cM8MLSnl4wKEJh
        2ehqmWMjkjAUR4yh97dN6wpaAljKldg=
X-Google-Smtp-Source: ANB0VdYXoxS33Sgi2bPnzXLe7tAELWJyrkg4d507DfGU+FrNOFozilpy2QLkgD9uz7unvqHiwa1HMQ==
X-Received: by 2002:a5e:8f42:: with SMTP id x2-v6mr11264140iop.92.1534957078090;
        Wed, 22 Aug 2018 09:57:58 -0700 (PDT)
Received: from djkurtz2.bld.corp.google.com ([2620:15c:183:0:1cfd:61a5:7215:5f9c])
        by smtp.gmail.com with ESMTPSA id y21-v6sm678580ioa.54.2018.08.22.09.57.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 09:57:57 -0700 (PDT)
From:   Daniel Kurtz <djkurtz@chromium.org>
To:     Daniel Drake <drake@endlessm.com>
Cc:     Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        Ken.Xue@amd.com, Daniel Kurtz <djkurtz@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org (open list:PIN CONTROL SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] pinctrl/amd: use byte access to clear irq/wake status bits
Date:   Wed, 22 Aug 2018 10:57:54 -0600
Message-Id: <20180822165754.213402-1-djkurtz@chromium.org>
X-Mailer: git-send-email 2.18.0.1017.ga543ac7ca45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6afb10267c1692 ("pinctrl/amd: fix masking of GPIO interrupts")
changed to the clearing of interrupt status bits to a RMW in a critical
section.  This works, but is a bit overkill.

The relevant interrupt/wake status bits are in the Most Significant Byte
of a 32-bit word.  These two are the only write-able bits in this byte.

Therefore, it should be safe to just write these bits back as a byte
access without any additional locking.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/pinctrl/pinctrl-amd.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 41ccc759b8b886..7698bd9f6b687c 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -558,15 +558,14 @@ static irqreturn_t amd_gpio_irq_handler(int irq, void *dev_id)
 			irq = irq_find_mapping(gc->irq.domain, irqnr + i);
 			generic_handle_irq(irq);
 
-			/* Clear interrupt.
-			 * We must read the pin register again, in case the
+			/*
+			 * Write 1 to clear the irq/wake status bits in MSByte.
+			 * All other bits in this byte are read-only.  This
+			 * avoids modifying the lower 24-bits, in case their
 			 * value was changed while executing
 			 * generic_handle_irq() above.
 			 */
-			raw_spin_lock_irqsave(&gpio_dev->lock, flags);
-			regval = readl(regs + i);
-			writel(regval, regs + i);
-			raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
+			writeb((regval >> 24), (u8 *)(regs + i) + 3);
 			ret = IRQ_HANDLED;
 		}
 	}
-- 
2.18.0.1017.ga543ac7ca45-goog

