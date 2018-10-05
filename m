Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863C4C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5E6206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IJhJWd6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5E6206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbeJEVfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:35:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35896 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729202AbeJEVfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:35:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id a8-v6so2155543wmf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 07:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VhnOKWzkRDC+3They8IdOyuR0e/vVZiouL/bg+aJfrs=;
        b=IJhJWd6DGVNVQtroYCFeX+Lkih9gdQDXW3oqwKdHYWrnLB7xS5fvZO4G/XluSgqL4F
         jCiYPcd4tikJe7EYb1CvfvOOQMebNK29/8V8zEm9mX9kcwvy7vFqYs/MULN9GaRaFFdU
         L2jRgKWg/9StPows4tqoPsPbupCI7EAhaLKW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VhnOKWzkRDC+3They8IdOyuR0e/vVZiouL/bg+aJfrs=;
        b=Zatjy15P4QaplXB8ExYM75o9XZiaPGsw1nMdCHmH2bTg3KKv/NZ6o++GKcgBqlVd4M
         0e4m3qYH5KDkVgL/xINgqBO3e/Dgsc6O8QaRFZs1KEuizLS5lmTA+hACRRCjUpSMO/C6
         Ju3o16iHCWwzmHk4pi79aVATSq5jG3xAY8GsMwZRleexQv/qFXcN6U4y9bKs6Td9NrZr
         o009SHaFoTxjYpzWkF+H0XXO87nksja0F7q1xyv8iFOoJfz7YmeVHHzMdjaooYhheqZ0
         8akskjMFmBoUiznk5kMb1rokRRZWr3LCTPBW5pUJvShNtBbmFXVAS4Dk6pwA/KRq7Ozf
         I9Qw==
X-Gm-Message-State: ABuFfoiIx4vlXUWOUJv+t62B8oV2VagrqI+VKX8FykaB8mNEx58/AnUy
        42tSawv1KBIO43bsoRC18Wbrbg==
X-Google-Smtp-Source: ACcGV637BvJCxvtDVWCJnO47yzoDCgScSo3715S78A5XtXvw0Kufib9d7O+fiJLo/1TKkP/3jpad/g==
X-Received: by 2002:a1c:6c09:: with SMTP id h9-v6mr7693290wmc.95.1538750201297;
        Fri, 05 Oct 2018 07:36:41 -0700 (PDT)
Received: from localhost.localdomain (151.240.136.77.rev.sfr.net. [77.136.240.151])
        by smtp.gmail.com with ESMTPSA id t24-v6sm14080377wra.5.2018.10.05.07.36.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Oct 2018 07:36:40 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        Marek Vasut <marex@denx.de>
Subject: [PATCH 13/13] clocksource/drivers/dw_apb: Add reset control
Date:   Fri,  5 Oct 2018 16:35:42 +0200
Message-Id: <1538750143-4282-13-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
References: <20181005143253.GE1881@mai>
 <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
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

