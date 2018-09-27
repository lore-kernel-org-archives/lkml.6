Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2811C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C48216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aIniA7DL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C48216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbeI0Ulc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:41:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38172 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbeI0Ulc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:41:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id z16-v6so6195196wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 07:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VhnOKWzkRDC+3They8IdOyuR0e/vVZiouL/bg+aJfrs=;
        b=aIniA7DLL3N5Lh2zqa4HydbpY58FMSsCRpGhmtwpXJ37VT9jMWh4l/+KC+quyCatdf
         H7zea1i1MX84Ck1NxtM8cqQ9cg1Av3vP3Mn0U8WGe5eSoe9dQoLl0iYbZb3obwCu3BP9
         //FgEDWfZUghxO8X6B8kXPr3DAwC5O+vNuDew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VhnOKWzkRDC+3They8IdOyuR0e/vVZiouL/bg+aJfrs=;
        b=inwEsqICF96vV8jujhahWhRxkJnl2VfaZDcoiqRCtLUeLcaH+7Rl/lcKBndHMEAKCf
         KK+1lIORSvca+MolABPAxpyLSOEOs/JrZXpqVQEDjnhpeZBE6TRzqRtI3Y4nQA2c7Ykz
         xrBnEwIWqNPG69w66ZZjLHzoLLE+cX+slANazGrtLMAp6821R/fA6JX0UAt7WEopS9UH
         AFddhGqzWEL0LLuEE3rfPVS4G9GBe9N9cJk/NWsoD1ea0dMztaDZxkqwd+/wyBVyMgms
         sI2XAp5xCxHDUYODLK5fCGzrVEoHKPPJdLUAVXshS7pSHV2hFWwMY3uN7eXNWFKUDt1B
         IKKw==
X-Gm-Message-State: ABuFfogzeTUW7IsdrBMW9mwZ2hqiP/7/eUOTVazHCUkJaiWZ2AAL84Qw
        UPpJq7pRapjbkYmVJdcRK3dq4w==
X-Google-Smtp-Source: ACcGV63oQy0ntojZRNsI++Mjl5/74JcUAFblXSf8ZWhXHIG4pRfUw06mjFqwXPSX7M3DZGAYoYb70Q==
X-Received: by 2002:a1c:6:: with SMTP id 6-v6mr1423292wma.126.1538058180561;
        Thu, 27 Sep 2018 07:23:00 -0700 (PDT)
Received: from localhost.localdomain (30.216.136.77.rev.sfr.net. [77.136.216.30])
        by smtp.gmail.com with ESMTPSA id f187-v6sm970452wmg.17.2018.09.27.07.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 07:22:59 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     dinguyen@kernel.org
Cc:     tglx@linutronix.de, marex@denx.de,
        linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS)
Subject: [PATCH] clocksource/drivers/dw_apb: Add reset control
Date:   Thu, 27 Sep 2018 16:22:51 +0200
Message-Id: <1538058172-6703-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <0873e89e-ea01-e8b6-ade8-01a24bf93cc8@linaro.org>
References: <0873e89e-ea01-e8b6-ade8-01a24bf93cc8@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinh Nguyen <dinguyen@kernel.org>

Add code to retrieve the reset property from the dw-apb timers and if
the property is available, the safe operation is to assert the timer
into reset, and followed by a deassert of the timer reset (brings the
timer out of reset).

This patch is needed for systems where the bootloader has left the timer
not used in reset.

 - Trivial conflict with commit a74bd1ad7a:
    "Convert to using %pOFn instead of device_node.name"

Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/dw_apb_timer_of.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
index fabaa29..db410ac 100644
--- a/drivers/clocksource/dw_apb_timer_of.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -22,6 +22,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/clk.h>
+#include <linux/reset.h>
 #include <linux/sched_clock.h>
 
 static void __init timer_get_base_and_rate(struct device_node *np,
@@ -29,6 +30,7 @@ static void __init timer_get_base_and_rate(struct device_node *np,
 {
 	struct clk *timer_clk;
 	struct clk *pclk;
+	struct reset_control *rstc;
 
 	*base = of_iomap(np, 0);
 
@@ -36,6 +38,16 @@ static void __init timer_get_base_and_rate(struct device_node *np,
 		panic("Unable to map regs for %pOFn", np);
 
 	/*
+	 * Reset the timer if the reset control is available, wiping
+	 * out the state the firmware may have left it
+	 */
+	rstc = of_reset_control_get(np, NULL);
+	if (!IS_ERR(rstc)) {
+		reset_control_assert(rstc);
+		reset_control_deassert(rstc);
+	}
+
+	/*
 	 * Not all implementations use a periphal clock, so don't panic
 	 * if it's not present
 	 */
-- 
2.7.4

