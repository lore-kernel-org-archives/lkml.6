Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D05FC43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEAC218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TM7PWvV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbeLRV31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:29:27 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42217 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeLRV3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:29:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so17403430wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JDGG/ePDW8fZY0txCpV8Qva5v2tCPJZst6J7AJgbbOs=;
        b=TM7PWvV5o0CR7i4LRPK9Tn3w4BQBKVhPkcTjFuo6ay1XVZzNlw6v6hcfZwQIg/WPUO
         Bobb5NomveaT0M+PIXYhDxdrQf8j1O9PmV23dOcQRMYXT0xnJG+AaesogEw8cftsl8PM
         jt7UZSVKfU20HhiWEKuhQUGuv6VzZeAwQYlGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JDGG/ePDW8fZY0txCpV8Qva5v2tCPJZst6J7AJgbbOs=;
        b=my9VfgMZPhmbKeDR7FiD69ioQPoWlmyoca88NXzGiXQJnHB4FcpNtgSwLdQPtEdWHx
         qIzi0bUD+tbScUQuDH3Rl6wziz1/iqCJXTgm3Jkzr/GZ1tA4lCv2kN/vzCg+ZGtVgol7
         1bJ4Z07QTbSopYud5O1mjFQU7pjUVZbiN6Y1AsIQeb7Eo4W1t6u/SGewa1cqVKmrGPfC
         o+j6OQD+Ftpz1Ft/Xx8Bdeyz//fipDng5dCcEElKkO/2P+zEj+sOUMkSix/6lp60wv60
         v0/V/esu4B26QSLioQkcBVXrQDKhQDtvltIp/KNgDTT06Osi4Bg20mMwlRyRLgK3FipK
         9WBw==
X-Gm-Message-State: AA+aEWaO5nHCO4Mrmk+0IblqszycHcE/oRdQ2mo5xFZhYZJiSPC7n/NX
        5FySLblOWUGUIwattUY/r1vF7oMjy5M=
X-Google-Smtp-Source: AFSGD/ViLOIMrASgWcUAz5HZW/GJiksUpzvaqT1HbtQYqLodZ0lPBAuqa4Ic+IO8vFV0QzrZjSfPcg==
X-Received: by 2002:a5d:6187:: with SMTP id j7mr16277202wru.300.1545168562867;
        Tue, 18 Dec 2018 13:29:22 -0800 (PST)
Received: from localhost.localdomain (105.50.92.92.rev.sfr.net. [92.92.50.105])
        by smtp.gmail.com with ESMTPSA id o4sm4153485wrq.66.2018.12.18.13.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:29:22 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 09/25] clocksource/drivers/imx-gpt: Remove unnecessary irq protection
Date:   Tue, 18 Dec 2018 22:28:27 +0100
Message-Id: <20181218212844.30445-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218212844.30445-1-daniel.lezcano@linaro.org>
References: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
 <20181218212844.30445-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clément Péron <peron.clem@gmail.com>

shutdown and oneshot are already protected against irq interruptions

Signed-off-by: Clément Péron <peron.clem@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-imx-gpt.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index a3d6ccbf4a16..706c0d0ff56c 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -202,15 +202,8 @@ static int v2_set_next_event(unsigned long evt,
 static int mxc_shutdown(struct clock_event_device *ced)
 {
 	struct imx_timer *imxtm = to_imx_timer(ced);
-	unsigned long flags;
 	u32 tcn;
 
-	/*
-	 * The timer interrupt generation is disabled at least
-	 * for enough time to call mxc_set_next_event()
-	 */
-	local_irq_save(flags);
-
 	/* Disable interrupt in GPT module */
 	imxtm->gpt->gpt_irq_disable(imxtm);
 
@@ -225,21 +218,12 @@ static int mxc_shutdown(struct clock_event_device *ced)
 	printk(KERN_INFO "%s: changing mode\n", __func__);
 #endif /* DEBUG */
 
-	local_irq_restore(flags);
-
 	return 0;
 }
 
 static int mxc_set_oneshot(struct clock_event_device *ced)
 {
 	struct imx_timer *imxtm = to_imx_timer(ced);
-	unsigned long flags;
-
-	/*
-	 * The timer interrupt generation is disabled at least
-	 * for enough time to call mxc_set_next_event()
-	 */
-	local_irq_save(flags);
 
 	/* Disable interrupt in GPT module */
 	imxtm->gpt->gpt_irq_disable(imxtm);
@@ -264,7 +248,6 @@ static int mxc_set_oneshot(struct clock_event_device *ced)
 	 * mode switching
 	 */
 	imxtm->gpt->gpt_irq_enable(imxtm);
-	local_irq_restore(flags);
 
 	return 0;
 }
-- 
2.17.1

