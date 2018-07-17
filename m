Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C23EECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351CA20BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W+DFtCW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351CA20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbeGQB1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 21:27:21 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40802 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729969AbeGQB1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 21:27:20 -0400
Received: by mail-it0-f66.google.com with SMTP id 188-v6so24235170ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 17:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7w4He294Db8sBsJjkxYxfpxcWdUbCc0Nd8VXXmtNjV4=;
        b=W+DFtCW061BMY6fpPPcDnvxnvzHnXooVQTcOciG8bR2bAXVWGsWTYEBjtxqt1O066G
         pHjZopuRJdTRguB/56aVkxf0T1GPUSadym54U5SW8zjQUE4F3siV0UhcRYjCcNfIprHl
         xAPBzSxYO2ZHWmN5PLXrZmkja2Xv25o3k0eTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7w4He294Db8sBsJjkxYxfpxcWdUbCc0Nd8VXXmtNjV4=;
        b=NlYx5zyKxz2zRmEilR7TCVCwVY4OnCKyoRfUUw/UaKLLNZAkteUgSDcT57p464bn1P
         sUTJ795MMvH6WGquPW9x6H2fhAakc1Wof15LhhbtnQk807ctqeHXn7G5b8/gAHA1OWbZ
         pMpRYmX1+DGqxORzT8PT33CvsnbNiRa0jTmTxGM6IzTNw0254m/iYMWURmwM0Je+s20m
         rNKgZZMRo5t2+o8e/rrfgmDc+GfUN6P2aDQcZleOyWnGMfPqt8nYeNWUlRx4a1JHvxZC
         PywH8Rx+hZ/ngFGKbWIVDv3klGCqewSeXIxg+WShiHtsmdw5yuo4ma/B3g8wZFU28BrM
         KXUQ==
X-Gm-Message-State: AOUpUlFkeqQzyKU6X92oRpxG+77hKU1ZhogJc5ToEtrGZykZMYXLalbt
        5kCK9EoSNHCyzM9nqIyE/ZRYzQ==
X-Google-Smtp-Source: AAOMgpcmcAVtwUy+sSQsPkOjzEkraPUsyIh08J+m57kskC1QzKFbDM/kcfq1/UXie5QYw0MHm/9Q+g==
X-Received: by 2002:a02:3b2c:: with SMTP id c44-v6mr16124302jaa.41.1531789044151;
        Mon, 16 Jul 2018 17:57:24 -0700 (PDT)
Received: from djkurtz2.bld.corp.google.com ([2620:15c:183:0:1cfd:61a5:7215:5f9c])
        by smtp.gmail.com with ESMTPSA id b1-v6sm3635486ioh.43.2018.07.16.17.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 17:57:23 -0700 (PDT)
From:   Daniel Kurtz <djkurtz@chromium.org>
Cc:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        Ken Xue <Ken.Xue@amd.com>, Daniel Drake <drake@endlessm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org (open list:PIN CONTROL SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] pinctrl/amd: use byte access to clear irq/wake status bits
Date:   Mon, 16 Jul 2018 18:57:19 -0600
Message-Id: <20180717005719.258905-2-djkurtz@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717005719.258905-1-djkurtz@chromium.org>
References: <20180717005719.258905-1-djkurtz@chromium.org>
To:     unlisted-recipients:; (no To-header on input)
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
 drivers/pinctrl/pinctrl-amd.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index b91db89eb9247c..52efe77ffb9991 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -558,15 +558,11 @@ static irqreturn_t amd_gpio_irq_handler(int irq, void *dev_id)
 			irq = irq_find_mapping(gc->irq.domain, irqnr + i);
 			generic_handle_irq(irq);
 
-			/* Clear interrupt.
-			 * We must read the pin register again, in case the
-			 * value was changed while executing
-			 * generic_handle_irq() above.
+			/*
+			 * Write-1-to-clear irq/wake status bits in MSByte.
+			 * All other bits in this byte are read-only.
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
2.18.0.203.gfac676dfb9-goog

