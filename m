Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD13ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019DC2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzQBZnLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019DC2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbeIQUT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:19:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728158AbeIQUT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:19:59 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35C15214C5;
        Mon, 17 Sep 2018 14:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537195938;
        bh=P6HepijjpEuQQE9y1FS+n6pASHE7cVw/ImjTHPCcIDU=;
        h=From:To:Cc:Subject:Date:From;
        b=DzQBZnLD2gk+XBJN0anNCiJqHZvDe4zeST4pCNB5hgaLLyPGiEuWblhV2Ve5/95T5
         xeiXtVePOezNKx8MGX7wQ+IRkv+zzEDiKXI26dFTyy41DYsqCL5yGdQsiJb9TNNM8W
         6JgaBnS9QQsLKWCfkvFhCH+zG9G5ZpcYkVhbkmTc=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     daniel.lezcano@linaro.org
Cc:     dinguyen@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>
Subject: [PATCH] clocksource: dw_apb: add reset control
Date:   Mon, 17 Sep 2018 09:52:14 -0500
Message-Id: <1537195934-26035-1-git-send-email-dinguyen@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add code to retrieve the reset property for the dw-apb timers.

Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/clocksource/dw_apb_timer_of.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
index 69866cd..24bc073 100644
--- a/drivers/clocksource/dw_apb_timer_of.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -22,6 +22,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/clk.h>
+#include <linux/reset.h>
 #include <linux/sched_clock.h>
 
 static void __init timer_get_base_and_rate(struct device_node *np,
@@ -29,12 +30,20 @@ static void __init timer_get_base_and_rate(struct device_node *np,
 {
 	struct clk *timer_clk;
 	struct clk *pclk;
+	struct reset_control *rstc;
 
 	*base = of_iomap(np, 0);
 
 	if (!*base)
 		panic("Unable to map regs for %s", np->name);
 
+	/* Unreset the timer if applicable */
+	rstc = of_reset_control_get(np, NULL);
+	if (!IS_ERR(rstc)) {
+		reset_control_assert(rstc);
+		reset_control_deassert(rstc);
+	}
+
 	/*
 	 * Not all implementations use a periphal clock, so don't panic
 	 * if it's not present
-- 
2.7.4

