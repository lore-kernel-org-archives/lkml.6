Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDB4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE1A218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gm3OnN61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbeLRV30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:29:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35585 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbeLRV3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:29:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so17436353wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NRONHF0HHvvIqlLpPf6sMlWUD+SdPWgYu2xk+QwdQD8=;
        b=Gm3OnN610Z6geTSnXr2qTihSQsp+9Y+iWPfoivAqs0Y7WsQLiXhctNCdyLdIWSF/gr
         DEeT5xV/TplPiiUPZByJpHFV/wzDKmUok1x9yjqDjmfIrMTe5WvuKBmRMLd7yjWQzSBJ
         7ydqkFCxSC0xxV4OVP66Ra+PIrLX6fZoMH3ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NRONHF0HHvvIqlLpPf6sMlWUD+SdPWgYu2xk+QwdQD8=;
        b=pBrf0p7lli6ekRh7numNpqfCzEF1dvirJnFGHSn42An72+6ngnWHpkm3mquNSBHKqo
         WDa+4KNAAmP3uoKn27aszZ2OBO6RI0KrvAAn6LugHjtQRPP4dSMgZhxrVe6XKgq19PvB
         nBeoUWqG126cQpPxsSC3Vd9JJBZZ4Y4hL97/HEF34WFZahBBwVjGy3BS4fAqQr86cj9C
         v6IBDtSENhr0Nk17Hq0maQ2YJYgkE7IbiNgtbGl8k1HFplWAJ0o5A60q0m8e1mLKmZ+s
         Kpk1U7HN0B0zTUhi2TmzG47whKOIWiAVQt7OF2jk8pxuEN9rlGMN0XMIHMrrvIob/RWP
         fl/g==
X-Gm-Message-State: AA+aEWaDsfgT9RKbxTQOasiyQUugeYOrWC54WckJ5q3vrPNO2/yKX3Tq
        nOLsAeVEPCfrnoI+9lWRNTrs8g==
X-Google-Smtp-Source: AFSGD/UxVaaXSOba53dZNjmbsksxmmcVoaJhI2UTlQXbHYHISIPn/h1g09XoLVR2Aw16ET2GtvcftA==
X-Received: by 2002:a5d:4250:: with SMTP id s16mr16452291wrr.253.1545168561390;
        Tue, 18 Dec 2018 13:29:21 -0800 (PST)
Received: from localhost.localdomain (105.50.92.92.rev.sfr.net. [92.92.50.105])
        by smtp.gmail.com with ESMTPSA id o4sm4153485wrq.66.2018.12.18.13.29.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:29:20 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Anson Huang <anson.huang@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH 08/25] clocksource/drivers/imx-gpt: Add support for ARM64
Date:   Tue, 18 Dec 2018 22:28:26 +0100
Message-Id: <20181218212844.30445-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218212844.30445-1-daniel.lezcano@linaro.org>
References: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
 <20181218212844.30445-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <anson.huang@nxp.com>

This patch allows building and compile-testing the i.MX GPT driver
also for ARM64. The delay_timer is only supported on ARMv7.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig         | 2 +-
 drivers/clocksource/timer-imx-gpt.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 64d5759ddf0e..8761a1c21b6c 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -567,7 +567,7 @@ config H8300_TPU
 
 config CLKSRC_IMX_GPT
 	bool "Clocksource using i.MX GPT" if COMPILE_TEST
-	depends on ARM && CLKDEV_LOOKUP
+	depends on (ARM || ARM64) && CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 
 config CLKSRC_IMX_TPM
diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index 165fbbb1c9a0..a3d6ccbf4a16 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -141,21 +141,25 @@ static u64 notrace mxc_read_sched_clock(void)
 	return sched_clock_reg ? readl_relaxed(sched_clock_reg) : 0;
 }
 
+#if defined(CONFIG_ARM)
 static struct delay_timer imx_delay_timer;
 
 static unsigned long imx_read_current_timer(void)
 {
 	return readl_relaxed(sched_clock_reg);
 }
+#endif
 
 static int __init mxc_clocksource_init(struct imx_timer *imxtm)
 {
 	unsigned int c = clk_get_rate(imxtm->clk_per);
 	void __iomem *reg = imxtm->base + imxtm->gpt->reg_tcn;
 
+#if defined(CONFIG_ARM)
 	imx_delay_timer.read_current_timer = &imx_read_current_timer;
 	imx_delay_timer.freq = c;
 	register_current_timer_delay(&imx_delay_timer);
+#endif
 
 	sched_clock_reg = reg;
 
-- 
2.17.1

